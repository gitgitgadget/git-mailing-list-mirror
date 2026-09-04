Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE3038F25C
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540215; cv=none; b=NHZ3RnFCr9CuscPRipfwZegHgTKFcv34+hC49QBK2BGYKzbeOssFxm45jW/LdpIG9hiqzWtJcVdbBADQ/1XPuQPDQyWY1zRWsS7PVCn4VY2hqaNg2YEBBf5j9aVoSrLhioZAE5HYELktr69NAXTiDbW07N+BiWTL3aird0IvK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540215; c=relaxed/simple;
	bh=Zt/DJS93VkuGThRepsr2Stnrw+WgGMXsafchl3JLicU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kv+TJDk8Ak7mVxCuywRW3Vdjl0e7BUce8La59KH84DQ1WE+ab+j21WvoiGbDnPbkDclK1gH0kT52XZtRfUNZlEbqcWMau/2vIlIEMkQZUkwsoLKQw5FcivPwXHumigNfq/C5clHDJCzp+79u2YHEBeoJHLkbrRK8qhyjDZO4G+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c/8X/Z68; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p9csB7UK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c/8X/Z68";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9csB7UK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFE691400108;
	Fri,  4 Sep 2026 12:43:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 04 Sep 2026 12:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788540212; x=1788626612; bh=lFev4N/dAT
	3vGE7fil2VDCVggzlHtXWxaPaVQdDc5yY=; b=c/8X/Z68vAxV0m22m4bO/ytXM5
	GkRDFX5Md1rhjZsnK8rid97+ydx0OmYcLHldY25pdoTAbD4aLPNu22+VpSLn87Lb
	Mx9TcxauHBn9ae3neq9KDyQteCijN3fVAOqH1lrsQi0otF0UI36T8OjGSEPJn79j
	uuTJfUmiy0VhQ93lWstc3ScvTmPErfe46cIdHXEDmCyoRYjijnpHbzXLCpcRQmQP
	4VnyNXhX8P0tVxpt+df+u01eT4jnmmJSTCHN05BqX3gq/HTBdqVRuq2s0fKm32Qp
	Xyjn/F8bGXec3/LxQyyXqY4PPj81Zusm/cYcGRdAIYDMN1t6AEuqttfE05eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788540212; x=1788626612; bh=lFev4N/dAT3vGE7fil2VDCVggzlHtXWxaPa
	VQdDc5yY=; b=p9csB7UKUafp2ZBJT859kZnNzVWDMJOs1BC+AcsMIV6aO0edQCv
	eZDeDJ1gddKtO5NLD/N/A2HaIhrJzTNKLdc5uVQGVbHigXSXjZmPJcAFiVSaAI0S
	RlaFkCYsJZJipIICOJ86hNQeS0uCousfvZDhmilV2iNA+B6+HfOnce6dRQ/C15Gu
	R9MT9wfNKNXCI/iGOKDCS6Z0HDNbP8ONYUJ8TsUEjnWFpGuKYthg4z52wjnroH7B
	JBaK+R+wJhbGcYErI/rwgBb1hJ1HDq1TtdlTQ5FTGe3cKUL2mlV1RkICXHOt6Pli
	I+iHkkK2wQly9eJC5Ji3yNVGcrgiwbUTclg==
X-ME-Sender: <xms:NPWaaqwwlQcIFZkxyHLsg_21RFTDmen9agVWPEIQb6iInnE8GbXtbQ>
    <xme:NPWaatQB_61bpsowj6CA71fARlZAvvn4IQKmgJbJ46pDOyxWS8al1BRgTUFnjiY-c
    DEMV_TR8rAmvsEQR_FrekyL0DlQo22R8e2JpWu8JkCpZb65BwwV3x0>
X-ME-Received: <xmr:NPWaahVNkibUOj8TaMbR_NCFCLhFK2GUv3wY0tSoFUQGDXnixCfeujyU7JJR40YXgxQTd035C0dI4eCpCG07mXE7fQCTymS2Hw>
X-ME-Proxy-Cause: dmFkZTGDlh3b3HlrCiNg0oDdZHCAYZmwfdbNnKh33loFsmElz2IK1u0s5ZwDtbF+3Uuu6s
    l0i8gv3FE7LRNViMuXXf6zMN1fgl3esEInwqHyWach7Zh2sb0MVDJQBjQyg/tBVNCT5QSR
    Tn2bgCNrWKLLqZQJUCQRm3g+X95I9P7dqYIVLTgA0iGTtMnxk/NfrM2z8vOToAss8cwqI7
    CtDAtG9EoEghY1GAt4O60MrX0BhZz1mv09c1eMHvB/C+/m6Gp5hoYus42ZOqMhCJaWp70O
    rstQtHqFILyhdinywL+iZGYftYkc9qGN4Iwc+jhpE9RjpT+6H5YSvvD0zayplNL4VpFZVZ
    IxTtTvLgOrjF5SQX9DOnwgYc1cvhHkUypBb4l5V1/wOu3hw6LFwCmACN9vD3MPlyA20Anu
    Me6bkqn4wE1jbjjyNTBYFWr7acMNiaZ6VMXP2fRp5yGF4d41AcouM39sUVnTdXA27twqbh
    VqT8Bz94AuS52dv58sJlXOmXoq4/9KbnviktlGnptAG0IrqotyGi3056I06LDvGc+7JKAU
    f+3XaWW39xJQp/Z9Me4LwWBlLV+jajBxrKK24noO5rWm1Rb+Q2QvGDFztnXuxyu6x4DCJ4
    GRCBA6eL4a+zzOfrBaoSQ5RKtBUJIqg5uC6ypX1OXGPnjq12O6Ho2skokomg
X-ME-Proxy: <xmx:NPWaava9B_wdufThk6m7qcOQWBYnNOh6Qx0jSTx36OfobArwPbdqDA>
    <xmx:NPWaan0bAGTIVzAAGkjxeN5VEzuAK42vMqC5PmBe6t6Va5MNm2IrbA>
    <xmx:NPWaahhQkLiV_srY7WuIOEHrtELUgXjWOUk7EUG820FMd_3b1sSBWQ>
    <xmx:NPWaara9cmsowj3E2bIZ2cH0aXEssE7APSn54EXQeYyjRRTjmw87fQ>
    <xmx:NPWaaqqnksF0FM7PhAbPY5tPQSTWSDMneyRmJDNAM6ySGnwDhhH-8hqK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 12:43:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Yannik Tausch <dev@ytausch.de>,  git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dir: find common prefix among non-exclude
 pathspec items
In-Reply-To: <CABPp-BF6hps9DibSV4ghbowkOD-NfEsHYFdLoKab0hCfEi9rgw@mail.gmail.com>
	(Elijah Newren's message of "Thu, 3 Sep 2026 22:02:06 -0700")
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
	<xmqqecfbk2eb.fsf@gitster.g>
	<81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
	<886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
	<27FF785F-F5D5-44EC-93C2-5BD67BD99147@ytausch.de>
	<CABPp-BF6hps9DibSV4ghbowkOD-NfEsHYFdLoKab0hCfEi9rgw@mail.gmail.com>
Date: Fri, 04 Sep 2026 09:43:31 -0700
Message-ID: <xmqqy0dh3r2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> This to me looked more like what you are changing, and I had a hard
> time figuring out why you were changing it.

While I share this assessment,...

>
> Does the following alternative correctly capture your intent and change here? :
>
>
> dir: preserve pathspec prefix optimization with leading excludes
>
> Directory walks use the common directory prefix of non-exclude
> pathspec items to avoid scanning unrelated portions of the working
> tree or index.  Exclude items only remove paths from that candidate
> set, so they do not need to widen the traversal.
>
> When an exclude item is the first pathspec item,
> common_prefix_len() fails to establish a comparison base and returns
> a zero-length prefix.  The result is correct, but git unnecessarily
> traverses from a broader starting point even when all non-exclude
> items share a directory.

... I do not think this is true.

What happens inside dir.c::fill_directory() is driven only with the
return value of common_prefix_len(), which already ignores and has
always ignored the negative pathspec elements.

What this [2/2] changes is what string common_prefix() returns.  If
you have "!x/b" "a/b" "a/c", common_prefix_len() goes over the two
positive ones "a/b" and "a/c" and correctly notices that "a/" is
common among the positive ones and its length is 2.

The problem this patch fixes is that common_prefix() used to always
grab the first two bytes of the element that happens to be at the
beginning of pathspec, so a pathspec ("!x/b" "a/b" "a/c") would have
given you "!x" as the common prefix string, which obviously is
bogus.  The common_prefix() is only used in two code paths that are
quite distant from here.  It is clear there is a bug (i.e., the code
that wants to be passed "a/" in such a case cannot be happy to see
"!x" instead), but it is totally unclear what the end-user visible
effect of that bug (i.e. what happens when overlay_tree_on_index()
passes an incorrectly computed common_prefix() when "git ls-files"
is run with "--with-tree=<treeish>" option?).

> Use the first non-exclude item as the comparison base and return its
> string together with the prefix length, allowing callers to start
> from the recovered directory prefix.  Exclude matching continues to
> use full paths, so this restores the optimization without changing
> which paths are selected.  Add a unit test covering an exclude item
> before two non-exclude items with a common directory.

I do not think this is what this patch does.  What you are
describing is this bit:

>> -static size_t common_prefix_len(const struct pathspec *pathspec)
>> ...
>>                 size_t i = 0, len = 0, item_len;
>>                 if (pathspec->items[n].magic & PATHSPEC_EXCLUDE)
>>                         continue;

which dates back to the very beginning of negative pathspec elements
support introduced at ef79b1f870 (Support pathspec magic :(exclude)
and its short form :!, 2013-12-06), I think.
