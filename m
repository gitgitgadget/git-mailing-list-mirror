Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E61046A61C
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987286; cv=none; b=V38HmO3xaxsdZnJ7sXIQs5uiRUF5R2yh8GVvDR3LVY890WQe8ccB73lvKX/37znfq4CKF9csBObTJKE3Q+qouHAjvo/cxH8/WveksepRrVgGcbqR3Yz02cGewGcU1r0TSrnE3tiRpbtZVSZ/6FRRfb1qw/B9qte8ZVsOd7alQW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987286; c=relaxed/simple;
	bh=yZGvovAnp3nqUaKGb+jOQrQ9rs/9K1zGbZQCtpdnYtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KPM/TqxITKunArnp7hSddQmQOCXRI7Zl8TfTy1vj3iwt6s43LIk5uHh5SUNIINuhZtl/bAMNDsHLUIxfT1wvcFLk8kR93cxjHE2AsxmwqAkZuz0VMjQRITGtvch0qpV623tm6S07Y5JxhlPppT86ZDJRfHyKjRMdo28YaXfjY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NYzCVR2E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E2GBgFwb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NYzCVR2E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E2GBgFwb"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B888AEC025F;
	Mon, 17 Aug 2026 13:21:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 17 Aug 2026 13:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786987283; x=1787073683; bh=A8Dfq7bo8E
	OQQ8qj97YUIM+9eHp4rSELfQ0LCFK+QkA=; b=NYzCVR2EWFbzqXqL5+fOdog3zo
	D9m05v4qjXO24YVRk+z3lwJCK8oZt/iB3gFKZZTAiCj8l8SCe6FjTH3DAvZOOcnA
	Muuo2nN0P6QVf9mzDDfPY7no+CMqAoKAPXEU/qNtO3Igs+lhxkDMIotPYRxi71QI
	6IP5JqaVoU1wamxApe7xFLP5GtuZNqRxaE6cCsi/C2NvwxCxYFbcqAqAEuoM8bwi
	D/Z4surYcQTebAl9excEBJ2GY7xRnME6qwphyLEmeP7NS32o1v6Fbd+LdwV2sp2Z
	S+McTTJbsYhsisMWeYaP2RRNDh4V/Uq0siuwgOHUIg7oEqNCga1Ld9WtD2vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786987283; x=1787073683; bh=A8Dfq7bo8EOQQ8qj97YUIM+9eHp4rSELfQ0
	LCFK+QkA=; b=E2GBgFwbCyAEE6pDAU3ZeuOnzsMGad2WSpEsnnw08iGSwzYmGAN
	NXVz3joeUXIpqa7REFh4THql3+KkgRI8Ha//ejHO2P3u+r89HflxtrsM5gwxngN4
	z7zCPit7hun4Y4uHe0FJSwKjip2My+wYVOENL0eUQSms8D9/9QA6p1PMcLQjpWvW
	/ijTY8lmGnwc0cylI6N3VJGw+r/jpjIjBtGTppTdHYZioLTTa6xGOCZjWJjfBETy
	EhedS3f+NqDsoxm3vWJ92md94/49KO5rytLVIuygOlkWzSNafQjz9V89khdEthp2
	hRASccnnsM2hQLP+96LNrt2W6qzyft4ZUag==
X-ME-Sender: <xms:E0ODaoeGNtigaGJYQPe5ToykMh6VHc4Yjm3kMUeaYKNysiWYDMPdIg>
    <xme:E0ODahNSt4VtFA5I19RFcPjS-AXY7dMkL0IdaBotMsmUxUz605o06SGNK_RvW89YU
    YG__KvqDK5J3H2SbKSfucNukpccZUQyu2ztD6V2556SItw-FeWJWwM>
X-ME-Received: <xmr:E0ODaugROTTzUoX8Rf4EqioulUonH4FKSEAV6GWOjmrXHMX2sX8BXNePzqyHm8F0-oL5E5xEtRVmZyrgRC-bLjNvY5lSYdqKLg>
X-ME-Proxy-Cause: dmFkZTErR7mw4vZmu/5U+D3okxFxuBYruoWDu6pUEkLU4bDV/gV4IztpGR0oMYxs6oUmSC
    LXtHIr3TCCEqfIwU+yso3JJMePCy76CPG0jyr4IHKljOXaO3EM5x8IlrfdXGU6sqZRKRet
    3JO/lAoCZBBHWpbH6MvkElLq1telDn09YlBUcmbnOBOxWASdwjaEuhrEXmxfHTk4h/pkmR
    1mZH1ugogT4Ck1UWxG3Ou05DonFxchaIXS2AUKcozTHJUc0yLd6i5fuRdE2Xorpn/KVNZI
    LEa5R0QRVc1wQ2OExCJ+3fAAhvsn3b/Pp3GNDC7sXZf7Olc3XHoIWlBD06IqNH2XRldHiT
    LGbAUwSLW6Fc2gwS+ENCYPS/Dgw+BGA6yTDUB2wtTz6JzSZiivmk0cOLLs/2UG5yvHY0ih
    Go5JTmbU1Zq+0wgNuSctslqr8GO8NXtLSMg+lffZNdwf+aNcCRODaV4q3CaHII0hBXih4Z
    4CF5oh/93LqzbD9UoCPNm1+i9rSttOj4MsOZZxTmRAaD7rB5rtlHek5DySzgsPsRlLpyqQ
    MiGck+hNFV1RFlJpJybPnFQQC20FLyTp3P9M6QPnWb09FvtssqVljQRwlhVWul2ogjE8EF
    7s4tBDqbBXRiY66ZFymmYV7Na0SU+jun36huO8yCYVxB30rfGPmlgf1jyNaA
X-ME-Proxy: <xmx:E0ODas0dYw0Pdj8B3sOsjblFTHQvquygulsXfGm1Yjuxb47_l-o8iQ>
    <xmx:E0ODaggUN6xBqqFg7cFofKXVIyPH8WwwEDAitgQCvNnTEdNIKmH1-Q>
    <xmx:E0ODakcFaYW9v8UQFqIxvvVQwr45XFjYCgPiZBbww7lG7A5BcrI2DQ>
    <xmx:E0ODarkc1B9PcQNoX2W54QEeBUXbc5eUolWIC_sQqCEd2Ht6r804rw>
    <xmx:E0ODatetp7en78LnNslcj52FgAYnDd0i6dAj74aWOs4i6ZVzc4in2VvH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 13:21:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH] worktree repair: detect relative path in .git file
 correctly
In-Reply-To: <pull.2205.git.1786799480344.gitgitgadget@gmail.com> (Yoichi
	NAKAYAMA via GitGitGadget's message of "Sat, 15 Aug 2026 13:11:19
	+0000")
References: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
Date: Mon, 17 Aug 2026 10:21:21 -0700
Message-ID: <xmqqwlto4q9a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> Since read_gitfile_gently() always returns an absolute path, the
> conversion from a relative path to an absolute path was not
> functioning and dead code existed.

This is ugly.  What problem is this really fixing?  What "conversion
from a relative path to an absolute path" does the above refer to?
What "dead code"?  Where in what file and what function?  Why does
the caller even care if it is absolute or relative?  Shouldn't they
work equally well as long as they point at the right location?

The proposed log message hides so many details to evaluate the claim
that this is a good change, and raises many unanswered questions.

Yes, read_gitfile_gently() always turns the gitfile it reads into an
absolute form.  Is there a caller A that wants the underlying
relative form, and if so why?  Is it to compare with some other path
that is relative?  How did the code B obtained the other path to be
compared that is relative?  If that code B used the helper that is
different from read_gitfile_gently() to obtain the other path that
is relative, perhaps the caller A can be changed to call it instead
of calling read_gitfile_gently() and the fix can be done without
churning so many existing call sites?

Stepping back a bit, why does "repair" even care if it is relative?
Is it considered a semi-error when a gitfile records its target as a
relative path?  If so, I wonder if a cleaner way may be to add a new
READ_GITFILE_ERR_RELATIVE_PATH constant that is treated as non-fatal
error by the read_gitfile_error_die() function?  If that approach
works, that may be the cleanest, as I suspect that "was it recorded
as an absolute path?" will not stay to be the only special case in
niche applications like "repair", but we need to audit callers of
the _gently() function and make sure they do not barf with the new
return code.

If not, perhaps introduce a separate function that returns the path
it read without any conversion, i.e.,

    char *read_raw_gitfile(const char *path);

that "repair" thing can use, and have it do the relateve-to-absolute
converaion itself, perhaps?  That function would be created by moving
most of the code from read_gitfile_gently() and read_gitfile_gently()
would become a very thin wrapper around that function.  Wouldn't that
be the least invasive and cleanest solution, if it works?

Thanks.
