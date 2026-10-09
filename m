Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2584446E1
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576743; cv=none; b=jKHFWlIDkr2iBCTaCsp/yHaUK7TU+nY3ezpYTB+syZhNGORErwPruxOQYXtDe1jh6zzE/6s09DEOv34nk35moLow7gzeLM/dcsPapxG0D9DjOY/VfSd2KZPQMWrByMVWeLjadRK2LsLT3qT0OdDPboGlenUP206xlEU/NAi/PX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576743; c=relaxed/simple;
	bh=xj62683PtWzRPVGwBAhL2bySVWTpOp/HJGFtmK8vwlY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DqWpj1A1xX+3F5DtDtNvMiirys5y8wDvnc2T4BmCJedqKdGN4YsZ6ci/NtyxixeAPbTRKOCJMCjDHIeZsFQvF1yKQzV7kRS5GWbpvDU0lgEAMsUAzBKF50TqDVzqYCVDmd4N6vMuqT1N6sd/eGdGVkbADTGf78BSXXyaXIXPYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=aFvpJ6FV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WfQFBgp8; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="aFvpJ6FV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WfQFBgp8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 624CCEC09F8
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 16:12:21 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 09 Oct 2026 16:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791576741;
	 x=1791663141; bh=8ggNNMAUcG5ZYfxxuNd0trbm7p6M07/74V/XUC8CKGY=; b=
	aFvpJ6FVYw6yRSh5JvAGMOoFv7XWDfu3zECBBp7LfWMpN6eVcc1MTEhuzEIVYxni
	8L+xHpf3gf68RPEpm5P9xQAJ/R0bjb0yjM4wgxU+yp+Ju2f+JhddZmkfnkvrcC56
	TAebAHGXc+idXVtBS9o7T8rsOGCgpyTipD3EcFSKBXeP3lIvPOLB97vcmaygaIGB
	hQQygplYNGeb9oEWzWr0C39qmjCv/98yfU3eC1mI70vltvr8kXpRkOZXlffqXTg7
	OpFs9XE/1U5PrqkMTMxX9sV4o8Mp7S1p/vkFCdyH4siiUsmANCq3YWigPw+265+S
	hlgyqi5Jrwt9ITAlWGirYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791576741; x=
	1791663141; bh=8ggNNMAUcG5ZYfxxuNd0trbm7p6M07/74V/XUC8CKGY=; b=W
	fQFBgp8Mjj2t3jt2X8+tAvoO3F2k2SiNt/Yq4jZX+BjBzC3M0ZSlEDqNXSizWW81
	eaj3zRtFkqp/FhrEij79KPSSRrCU4SKNUY887lc6VjGZOHv/TCfUGJ0TC/ULIKIJ
	MRuwt2yUU9UjbkjbIKF6LYvKPDSwBSwVdE7/QOU8dhrBsQvf977bo7mSmItD1k9T
	qQe35xpr+VEXp1j8EZpHNh/ESEDlgoH9cv5kHXBChZEbDle7NLJ0IhGjwKWIIb42
	O7rbGDdzwLpp/84dlcpb0yTXQBMwPMrwnZz6lhlpbGm9lrNJYdMIzk73PWfWhx+u
	ZKrv27DmmtXWDC9dSCArA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791576741; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XwsbjiUNJ2/mFSo5v4t7azZMFenarZ3G0GzZ+zEVqB0nNIT
	QUsa9hmFsS9jC8nypdM9r8A3ljpawOa3x3GgZW779iZGnmCXJkQndk9kzI+MJG2G
	24gUauP1sgRYMEUtF5+IXoJlgnsfrDCd4cxMT8uGnXnuQ9zoEnDIBLYOk3uG7rjW
	RYUTHfR8F91KicdJIji6C1XSfDrMQtW0hRLaida+Twspoj1ypKdGeGTpYXUxJO4r
	iFltv3RpFQYKV7ttwFazirzgBkmYpoi2hG99vMc7oN2spbFLbV9WSRWZ0yjD8/sv
	WsoDUjItg+NfNrGeW+Itq026C8/nlfaj17GNyng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:74kda3UNVzU1K28ym6VAmXcsGTqPlVi46HyK7AvPYa8=:xj62683PtWzRPVGwBAhL2bySVWTpOp/HJGFtmK8vwlY=;
X-ME-Sender: <xms:pErJai1hdD5jovQSFF5hIPbvCA5GsvIBt5e8x85xLoPpHGju6erXQA>
    <xme:pErJav6h5p0WAYlZs0jPJnjKd0hLBafbNeGEx2DupHGmV874Wx70Oq4KRiUR5y2Gh
    wbb7bwN_LAJqBbIcd0F--kYVAHK4xpm2W_SoYzEWV5lMQ7_9np3lvE>
X-ME-Proxy-Cause: dmFkZTEtpLCyqd0sGLUeAlCvgHN9QqcZUoAA10/7EeigX6/ke7CZdHWE8xwqIoNH8dSk39
    mD2id1h1rfYPbUuNsj3RFs8OY5ynBuSQ54+lPbmxBlB+OPVyLL9X3NMjXQNHfM3bypWZc0
    Gh0NUVnVQIuHCdmE3ffkEQmJpAI1p4G4fdPpbtysswkpzez9b3ZfQfAnQnD2lLc/L1QqUn
    Zx56kqwP5TUl+J0FCW7O55GEZe78FmTbo265LWOcqnRg3Z99ApQkkLPgULZPPAh9xMmxRx
    izrtqqEyaVaAUfr0WDwcMAS83VQXMpORd+8dV9OxSzjuUiebdJUXcVNuhINTSuUG5lArqa
    yhHiqDcWP9VPPloINSnLXs3Q44rvwGbQbvocseReJ5lu+NT6RvBw7uO0KevLyAuMZGcVF+
    iu7HxF9FKBWEaYMwOyk0FfyiVgcyoHHJdDTDL8umjzEwbD1WRiFFMKaMwMFQIawgny6E5L
    r7lD5jnZI0oBHoK80dbYeXBAVVNuEe9od4esU706UA0AA3Ncl/tWxtAslw9ytCgLm6fsGP
    zzPz+cufvt41LvjNdNXUVn8MdntUdZ3kLXGVfhfwNfecX6hb8Bk8bIggAnOgP1wvKQWydB
    5DI99KwXvROXOf/C/LcYU5ZmSZLnFOsklSHC71Bel6SrTyiTXgaCzZfSF3JQ
X-ME-Proxy: <xmx:pErJaggJgjAccxT5Gog2qTV9B6qV9fBkVvFDgcMkd15f1XU9SRhidw>
    <xmx:pUrJaiV4yKKH-QTxt_xAWeakPaGvUcL7NYG0DOjy49bHM6orLGHwKA>
    <xmx:pUrJavU03qmumz7XyDGxBuJCPKAt2jLLxOmr4h-WVJd4K99hYs65QA>
    <xmx:pUrJaijJPM5RbBkeszdo0EO_-nOO6kD9DUP9L6vjuzh53ndeq1iOog>
    <xmx:pUrJakcwIPqMSAWNgkicz8Uz1k8xLiDAknlBBhMxOA5Kwf89kld-MeOK>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E40FE780070; Fri,  9 Oct 2026 16:12:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ3yMKGvzUL-
Date: Fri, 09 Oct 2026 16:12:00 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 "Jeff King" <peff@peff.net>, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <c206ae13-a815-41fe-9cf9-95445b4f98e7@app.fastmail.com>
In-Reply-To: <xmqqse2epw6x.fsf@gitster.g>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
 <62b70e9a02dfc9c5b5c980b71bb0507fa20cc0b9.1791547213.git.gitgitgadget@gmail.com>
 <xmqqse2epw6x.fsf@gitster.g>
Subject: Re: [PATCH v2 5/6] doc: git-cherry-pick: link to new merge conflicts guide
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Oct 9, 2026, at 2:26 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> -When it is not obvious how to apply a change, the following
>> -happens:
>> +When it is not obvious how to apply a change, there may
>> +be a merge conflict. See linkgit:gitmergeconflicts[7]
>> +(or `git help mergeconflicts`) for a guide to handling merge conflicts.
>
> "Obvious to whom" was the first thing that came to my mind, even
> though the blame largely lies on the original.  Can't we get rid of
> the above pragraph altogether, and "See new one" at the end where
> you replaced "See git-merge" reference below?

Sounds good to me. Same for the language around revert.

>> +When a merge conflict happens:
>>  
>>  1. The current branch and `HEAD` pointer stay at the last commit
>>     successfully made.
>> @@ -36,9 +39,6 @@ happens:
>>     conflict markers `<<<<<<<` and `>>>>>>>`.
>>  5. No other modifications are made.
>>  
>> -See linkgit:git-merge[1] for some hints on resolving such
>> -conflicts.
>> -
>>  OPTIONS
>>  -------
>>  <commit>...::
>> @@ -259,6 +259,7 @@ $ git cherry-pick -Xpatience topic^  <4>
>>  SEE ALSO
>>  --------
>>  linkgit:git-revert[1]
>> +linkgit:gitmergeconflicts[7]
>>  
>>  GIT
>>  ---
