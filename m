Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605B346FB5
	for <git@vger.kernel.org>; Thu, 28 May 2026 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000585; cv=none; b=Qr4mjeaT8craFpD+tZddLWm9wxeQwjySYO4PurQRtF7XCHjs193CyUXfWxSZ70VRiOzeAv4+Qgd69UPY2mPBxS9q7NPwZRKKtMG1+of/XfHpfcBEr/gqT4AjxoSIM31JehgicA+5X4zzm87vYwHcrY6kfiNgHrslYhPnuAl/K0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000585; c=relaxed/simple;
	bh=SHopSATEte5idLGNM6D/vKDgPo5LrcDiJ/w3WhQ11OA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E/rXnMPcpYCq4qRk6qgVUv0zDI6nQwZFefjfawoVHcswRTdloTaT+dkvsh23qRzttKnB3kNGxfGjivWIvFqlbJWXNUUHCeM6T31UGV2r8G3sNWJOgJncOrLGq19PTFkjLJ0zzstKeK0yuwsnBEDnMcQrLqprDwxnsmfZ9mQz8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kVo5Yjjl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DpkFrGFb; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kVo5Yjjl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DpkFrGFb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 31B6B140011C;
	Thu, 28 May 2026 16:36:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 28 May 2026 16:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780000583;
	 x=1780086983; bh=xAmnY8V3p70P18HxINCIEK39jhCdEk/KFwSStRgky8o=; b=
	kVo5Yjjl9mrYjrA7vR8sK/XoF0k3x5qsOHAT73CQXOeG8CI8445RSW3aEHTP+ReQ
	8Yz4FbQtUMnAn3/TM/nD9u2xMQh33NSdSqkpo/rrDJzIP4ZyXSij3Kpr8UtEdArr
	E+j2atqEReJL/ehmUcuDjkOrPR8pZWYFlIRcya0+Q0QnXgn4a1ix6BT3+zvK3uTc
	2z6Hs9sL9kKYpmj6IcdXSI2g9cuv3+4r7lIYzRz86Ha4Fdw8y0mR7qPvRqfbJi06
	p+4ktzFvdn6jWD2BGGX/ez4VS51VD9xH/hL50h4yDflMJVJ2YEeKh7ZFNUnCdEEh
	XRiPPwgxZ78Ku/uZ64+q5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780000583; x=
	1780086983; bh=xAmnY8V3p70P18HxINCIEK39jhCdEk/KFwSStRgky8o=; b=D
	pkFrGFbEhbBzfF/jvZoQe9S35VFHKqw43vM37H4HLinj5uXuAjT7LRfrZm1t8baa
	RNA3/ytLXkIO++LImcJJaron6/mD/g/4REVnFP+fzVzd2d4c865ZhbDyAbgposFw
	I70RschacH+N0e8VZEfU8SreqaFH5hYyhkAQ8OxNCijEWHZM8ioqr26LIjvHPmgh
	YBSm1c/QbBYeyL8W4Xd4pr2MmzEUBrt+NoK0dRBkVYSVDVH0Gb+DNmSXJfZllZvu
	VQvlz6k5+6c1cxhQnpVe7qT4xcbParOtlDBwEeaulAVM7Vp/A+OJx2K/iJKPCLD7
	ISZ0Hr5DFWF6b/X3mDkFw==
X-ME-Sender: <xms:R6cYavnvgbeI2tkGuPG4b6P0Jl9pIq6uvaMBLiGqE-gnK-hqfw7-bA>
    <xme:R6cYapvJpSKcJFNQW5_mdxts7QcL5fHcs9Jp_uyNF7vhCmyH3gX704sAcf8oITkHD
    CSR1s5anZBC7gXpgyJIAYw7CS73M-5u5OqPvxKxaSFLW52MCfsF>
X-ME-Received: <xmr:R6cYat-rrpuvprnMPrau_rQd3NIJG1Ky56h_00TZjilsdH_JDc7lT58IVIuuUfmdIcHVw11m2LaacMqinjqMy_UuWW_taq1Pm6D4>
X-ME-Proxy-Cause: dmFkZTGEBoV5PLU7Qjd00v6aeXKXhKTsSzygDHDUem3ykvpiSHXlYnDG4Enzm4wt7UYZ2d
    ZCTaJWucgdqTotr8+gxSillx08CHEtjZRAFBa/FsaIDGfkRnuVF4Fl2A3IWzRqUaorhj4S
    yw8dxqMdv4+re1ZEcNBsGfftokTzQ9+NY+ksEMmP/YPHhyps/QWLpdpLYQWQKQzsAfXeNr
    1UGV2u4hAVL/PFZVJgQtkclEcCRvq0dHDN3Yiz0/MH4bPmEDa0I4MHzIYmMcikZ1HhANai
    wY52akYdAJ1oNP4LUJDcaYP2E30nPlU0C58pmLMhtRvlRpuzctJnebhwA6M38QI9BDlgoR
    8maBnSWz9qRHiRGL8dNfLJKYMpIUPypPbYpNtuyY/6BvW3Y7ddI4EPpq2UxXrMBBamQZj6
    SBCWoUsrwICHI5vZAmyWX8EzYNE7BwDgOkr60HHmXEAVZZtHZpmMvGYfeKiBikJzZbzkdl
    sKGjPF095PcDQwULBUowfwjVWxlyDsweVnqlLHsWx+BQSX7gHthitzM1XUy8VmMb/kGH6T
    u0KP1t5niJW6xb1nH8dKgo9Wkw9TOVlJIr3YFWea24dVtsWuzfdqSmDeY7pOtgWIGpzWKA
    1o9jUkoavhu8MyZfvoligW2gHc460/+IuRi2H/wj5aj1cZZD2Z9Acetj4R9w
X-ME-Proxy: <xmx:R6cYajOy_pAPWrfm74Lme5qyx6eCZ4ILJkvSfhdwFv-hsfLktYQ2Yg>
    <xmx:R6cYarFupUZhdLTNcnXHazndFedUClUwKR_T0D6VbIu3AQT7BZsPXQ>
    <xmx:R6cYahSBC0N5TKsjGz5nMSXBa8U_upoF2KggyOsyMtyo0Z4SHYbb5Q>
    <xmx:R6cYaos1h46WpjuZm7MqrlaXIMbdnWHJyIQc7mi3MXUF4kHEoEvUTg>
    <xmx:R6cYau_vM88RktmsjrmTTHgGEAdKlJeaT945jGvEVjkcrYBBv3J5dIru>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 16:36:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Chris Torek <chris.torek@gmail.com>,  Frieder Hannenheim
 <mail@fhannenheim.net>,  git@vger.kernel.org
Subject: Re: git mv after the fact
In-Reply-To: <1FEDBC47-5DDB-4C42-A7C7-695630D330BF@gmail.com> (Ben Knoble's
	message of "Thu, 28 May 2026 10:28:51 -0400")
References: <877bootp3l.fsf@gitster.g>
	<1FEDBC47-5DDB-4C42-A7C7-695630D330BF@gmail.com>
Date: Fri, 29 May 2026 05:36:21 +0900
Message-ID: <xmqq5x47jmpm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 27 mai 2026 à 19:24, Junio C Hamano <gitster@pobox.com> a écrit :
>> 
>> ﻿Chris Torek <chris.torek@gmail.com> writes:
>> 
>>>> Chris Torek <chris.torek@gmail.com> writes:
>>>>> A flag for "git mv" would be convenient (and slightly moreefficient ...
>>>> 
>>> 
>>> On Tue, May 26, 2026 at 8:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>> May be convenient, but I do not get the "efficient" part.
>>> 
>>> A normal `git mv` renames the index entry and the file in the working
>>> tree without running `git add` on the *contents*, so there's no new hash
>>> computation.  Presumably a `git mv --after foo bar` would do the same: verify
>>> that there is no existing `bar` in the index, that there is an existing `foo` in
>>> the index, and that there is no `foo` but there is a `bar` in the working tree,
>>> and then it would rename (add-and-remove, really, because of sorting)
>>> the index entry, without scanning the working tree contents.
>>> 
>>> In other words, we skip reading the 3 terabyte file, or whatever.
>> 
>> Yup, that matches what I wrote.  We do not rehash and we only write
>> the index just once.
>
> One thing I wondered: if we don’t have an exact move but assume (by not hashing), doesn’t that mean the index would differ from what’s on disk? I originally thought that might be a problem, but the more I thought the more I realized that’s a fairly typical state anyway.
>
> Just seemed like a potential footgun to me, but perhaps not worth worrying about. 

Good point.  Actually with or without --after/--cached, we do not
have to rehash, and more importantly, we should not rehash.

As you can do this already

    $ date >old.txt
    $ git add old.txt
    $ date >>old.txt
    ... now old.txt is _dirty_
    $ git mv old.txt new.txt

I do not think it is unusual to have the contents you have in your
working tree files diverge from the contents you last 'git add'ed to
the index.  You do *not* want to rehash.  The index entry for new.txt
must be left not-up-to-date, which is achieved in the above sequence
by retaining the file timestamp of old.txt at the "git add" time
even after "git mv" (i.e. new.txt has the timestamp and size of the
old.txt after it got the second "date" output, the index entry
records one generation old one, and would not match).  If we do the
"index-entry only" move, i.e.

    $ date >old.txt
    $ git add old.txt
    $ date >>old.txt
    ... now old.txt is _dirty_
    $ mv old.txt new.txt
    ... oops, we forgot to tell git
    $ git mv --cached old.txt new.txt

we need to make sure that we leave the cache entry dirty for
new.txt in the index.

