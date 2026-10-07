Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525E14DDB4F
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401415; cv=none; b=mcNGzDgc7HtFyPfG0NCOi4ZVKpeap957Ee6wf7j8lNLVROV4etWuP1OeS1WuzkRO7J6xYHagu484MvmuZ5hFhj5mJsLdU4iceLM32T98X4qUVV7cYDFXTKElONedNBsIsL4W4+fVJ4agVXiM3K9jrDilh2+3CJamAknhohj4PYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401415; c=relaxed/simple;
	bh=yPI1HAiDvvcpbUFIIQIdbtnH+hwZo/JIW8tSPqQkCMM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fnjv8M0ptxQAZvYS5GDiE5W8z58LZulaPip3pa6Qj6HRb0m278TkG0uyqlqr9rDME/iVX91T16wEZkBw8xvi8f17VlEDOLbr0ul0SUUQi1/Sqw0Ql8W+/kXWn9w46X2HSpxWLTFPvfxm2l0YW4fJuXaRVtder4djN7pG6RYJ4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=WWtrikwf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t2GBmKdA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="WWtrikwf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t2GBmKdA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 553BEEC045B
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 15:30:12 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 07 Oct 2026 15:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791401412;
	 x=1791487812; bh=8uGe33KiyBfvoSXUJzPfz6eh728ud08hJTHZT4VfQGI=; b=
	WWtrikwf8DPCKZz/OsWJIReyJVx8WA+jA5BY7z35I7QxCxdf2emylsBpbvES+z9a
	cyaA5hti+K2JaBQTlF65XJjNBYvrYsmmXCQ0sciDsh2In9o6p62HCSAWUDz4Z3mT
	lyEVt2KUQS7Cv92ofGXGaoBZ1e4+/nVMzLk8h7QULWxCF1sv7KSTG3J8IMfZdHgy
	swCd9OCUjcMk+V9P8N8FJausI/aBOt1qWkwpnoWem1Ux2ShJAZjJf0zJ0yroXyve
	8fIyNQknvY/GUmtGDJDvip6N1Qhj8UMmKVdNeI0iLCJyOd+wNle+onjCGAKAd5q+
	/+AgV7IClKnv1uGzSXh6ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791401412; x=
	1791487812; bh=8uGe33KiyBfvoSXUJzPfz6eh728ud08hJTHZT4VfQGI=; b=t
	2GBmKdA/hnTxHpbPHLyPJ2Zj24p4pg87Hjrg6Ns1WCvfZU4y29In+QvYmM/XNzyY
	9ETBVXj/DKO9Axz9ZB5dpvud+PFHdJyQjQI5YgSnUSiRtQ+zxujmcHHqOl4h9dh/
	SOQKjquvLFf4OkbFTnVaiOI1TgT57hiJHhL1kwLa8A4L+0/gVehyBoznmyoiDgdm
	TOpNP7a0zDCEBsTS6b3axm97u/nL3Zs5ionOnZwnLrUg9D7llyWcJbwF04jK9GzZ
	c1ypoh6S8HVWZ/KSencQw3X0u4KjZE/D6ShCkcX4lSSwj4Fn9ASEi2kaC+aQJl2v
	ErzWjkTqzKjsZU1HigL3g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791401412; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aypTaKgtUV7pLIVa4xL40hlB9Oj5dWHLJYhtSmwXG8mqqJ1
	89TnL4H5SwIoxRnsyWJoN3oYqM8SSBZh2WChXTxgfACYy5TLCishyXmCRZwMlfZF
	RPef0O82j43Ov413PAjh3cwi+v0op7aTFs88rqguB2HzaTpJFdUAD8+ecULJwzvM
	P1WnOUBhNe/s2fQ0UIDtU48nSpgJ/ks39496OBZceWplYfbgY5+NB8hKfjxSL0OE
	TrDUlkvLs76+JOTRSEzJNyH8nPI2u6eBt3cgK7CvmYTrGy4jyFYSB85cKQ0YXf5k
	RYOQvy3qypRruJEl4XgcnXRvjLxP3i0bLgChJLQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kUN78a3894pMyEFNCzc4VQuFKEGnW4VEX7d4hO29p0Y=:yPI1HAiDvvcpbUFIIQIdbtnH+hwZo/JIW8tSPqQkCMM=;
X-ME-Sender: <xms:xJ3Gahk_R6hbvxLFC9epA79vwTF0G6EsWglOrnnhLoWYNIub7TRvRA>
    <xme:xJ3GanonoV2DQpmJBflL9Zt7SORQDaPrs32ydhCIKxrdQgBsejvKSbAhhzDEBxooF
    d-OA7WMj_G6DHcSh90H_iQW2O55uhX5jzqUiStmAcGB0aOp1hSRwsgvog>
X-ME-Proxy-Cause: dmFkZTGRleCN1W9dtcmc73S0/EuFdf/gKTFm0jNSiUT8ov94hVP+2M1n2mTMZdA/kM2RAb
    iqnuOEKkD8usGcnfdlD0PHp0Cg1wgEdOA8Wmf+oc1Ik3W4wEhW2q2o6QdqYwqORMpTVb6H
    oHyJJLx04UkJ8dELbgC4N7VB2EV86+U1VF8MYn+dWHvu39h+SopgvpavjeViwJpxacdshZ
    ZjNXr12vzeAW1pH3NwFE+MNeNUoY9GrhoJEMvwD2mTTkVZZOa+Yn5tPmudx1S0hz90UT3a
    Z+9bAw9F+BDYA8j59EH9+FpjwjMQW9EysL/byVEubnwulySBhjj2I6YKYOPWiNQwVIbQe1
    hH6Hpi0WvZiOkUiNAa72FEN1qCssW0ZJAbsMBewiQUmgNfgiFTvy7eDQDG+l24M7zrGJtK
    EGiOv/VoMTxQpRzlKmSJV+Xwi7nltCxK5v8XDRA3yQx2q2kaURdYw+RkfX8KSLU23K2CJS
    MW6NWHpUfM0qRZiT9oq9ZH3GajovKIQs9eAzZ0S6uNzAVnYqFQIdabrTIXINNVkPeF4BDW
    R0C03jXvgWaqe9A9bmA2Wkb647/xUu3JxggMa55d0TyLMFr+CLCG7E2vPMDf1mvKPcA3jG
    12yOEKleMRLdoQx29LeZd+M0q59eWyxdcDJg69QNffk8p4yuo/NKq3pBLrSQ
X-ME-Proxy: <xmx:xJ3GahIMrMPSWCnNYa72qXqNuv1oc0fQIhEudl1B_GFacD06grQhow>
    <xmx:xJ3Gaup5UiVTUW9AiwQy4j6hV6Rg164lv7sBG7Oscw7QUHrX6uloiw>
    <xmx:xJ3Gapzhc4KC5VZTrMI0lrNuvXtPY8uAF_etOwCj8-rhH0CA2uj9aQ>
    <xmx:xJ3GaiOR1e9C3ly-FhRt48YEd9R89DUXGWyp3EDnNBR-AZGDDbW1hw>
    <xmx:xJ3Gahd4vXYu8JfMIio8cgqyutVQolMVxUoquzdCpj_c_qRkcYlQw5i6>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 207DD780070; Wed,  7 Oct 2026 15:30:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKh1_XIvpk3w
Date: Wed, 07 Oct 2026 15:29:51 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <3a665230-b221-410b-9a58-96c01210aea0@app.fastmail.com>
In-Reply-To: <xmqqfqyh728j.fsf@gitster.g>
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
 <pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
 <xmqqfqyh728j.fsf@gitster.g>
Subject: Re: [PATCH v2] doc: use `man git` to teach users how to navigate the docs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Oct 7, 2026, at 3:13 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Julia Evans <julia@jvns.ca>
>>
>> Many existing users of Git don't know how Git's documentation is
>> structured, and a lot of folks have expressed frustration that `man git`
>> doesn't make it easy to find out how to get help with using Git.
>>
>> Explain how Git's help system works in `man git`
>> (`git push -h` gives a short help, `git push --help` is the full docs),
>> since it's a slightly unusual approach.
>>
>> Remove the references to gittutorial and giteveryday since they're
>> unlikely to help new users learn Git. Currently they feel very
>> aspirational (it would be nice to have a tutorial and a guide to
>> everyday Git commands!), but we should give users a realistic view of
>> what the documentation actually provides.
>
> The text mentions removing 'tutorial' and 'everyday', but does
> not explain why we no longer reference 'user-manual', 'datamodel',
> and 'cli'.  The third iteration should justify this.  At least,
> I recall that adding a reference to 'cli' early in the document was
> a deliberate decision, and we should explain why it is no longer
> relevant.  It would not be surprising if it has become obsolete
> over the last decade, but we still need to spell out why it is no
> longer appropriate to reference here.

Thanks, can do. Here's my thought process:

- Removed 'cli' because (from my perspective as a user) it seems like
  something that's written for Git developers and not users, like
  with "Commands that support the enhanced option parser",
  how is a user supposed to know which commands support
  the enhanced parser? I think it makes sense as a guide to
  scripting Git but not for interactive use. Some of the bits on `diff`
  feel like they might belong in the `git diff` man page, not sure.
- Removed "user-manual" because it's outdated. The chapter on
  "Sharing development with others" explains how to use
  `git format-patch` which is not how most people collaborate with
  git.
- Once all the others were removed it seemed a bit out of place
  to mention `gitdatamodel`.
