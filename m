Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A743C4555
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790980338; cv=none; b=eByvEqI/GL31Sijkut+LCdLd4MAE/iLYCrzAmvvOnzud3FuoCT1cFsgoap+MSmf4erlu89JRlDSjwO+RLSDwlJaiUz/WgnUwF168WCyiRVtF1rUJh8uEYSJD4d4R2Lhnl7WLnBBFBBaV3qqf2+jzkBgK7bSoOMl6jOPlHvceWEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790980338; c=relaxed/simple;
	bh=7Wfmc0C9wpfcfNOjA29uMRz+/nAS5POqYEJJ1w78FH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PbHuh7/e+qQ9lQ1UgyqollZxHPxrliC5yBp260q/sqrvYNrCPaxHgTBRiQBZQwqteIScOQ7MdCIN/CIWnINrkVkaf8noBLN/r8ge4i+suPjzN2c79TOAma9QWh9aTTC1hFYUynjsTdlbPDom11h62AFO5aN44XcxhQpHs9Lpsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cUZNq1R4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wMsc/eS6; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cUZNq1R4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wMsc/eS6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D2B1C1D000F9
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 18:32:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 18:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790980335; x=1791066735; bh=invf/oQGZI
	959DE61rxzTOOFAT+ZdtlhQOdxyvbvCus=; b=cUZNq1R4GO8JvpXByGqHhPlIbp
	W0N29r7ZsbLgfdhG5DUBnACD0ajN3j4XwVvC1zRsVvXpmU5tLdEx6EAZn2Je1FCU
	gcA0RfhZCYDAFVxBWVHk5G+25QXRmKiEtzW/VBQk/PHmzZD9MuTxoyui5atctjXs
	usdi/P7jKj444GAHgdXJtoE7k+ZlqC6wrPJ/VoX1KukLs6925M9Xe+e6gax9NJTB
	4Gn5ZmlwzI6U2vT5uxPiYiDOGjjWwUrm869VKYunXFsFBr8pxe243Sgnt8zrDadX
	EsbdoBLbWRm4t0h3DIDsXsak41JeyVTw6R1Z74gIun3wRoVLAupM+HT/Nxww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790980335; x=1791066735; bh=invf/oQGZI959DE61rxzTOOFAT+ZdtlhQOd
	xyvbvCus=; b=wMsc/eS6B9HReEDr/KM9d3QHlJhuDvVKj9y6eBSLGmoMYnBptnp
	YV6tSluKcedf9mRxAJ3MpBUuvC/gDBFhnpZ6spbpUBDkX78kPC0BfQEPi0QkX6IQ
	kgmOelKQAiuvGLtO4r6Grc2CupS7I0NqoYuWQSqewCqCKjE1r8tqgv6iwNaex2qU
	TtYiJ1vvVNA7B9vDPTB0nP01cvmcF47N1nMJQcDKrS0TL8n3/Xa9GcFs74iibp5R
	yVecR/cCQTUeNm9z0Iu/his2k8hv9IK12uuyNcC7L1KyQc6CVRmt8hLzrO9tsrq7
	LJLvq0XoiL2ppWZmEHVxZ5/baWzDGIxrAnA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790980335; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:bcAGMOUBkXNKLwW3LLIRFozHUbZMqdX46jfNnPxt32EC/1p
	i7M888n8kgcM9DQVtJB4Sc4eHYdbfLeSOwVnKgLW0jvvhNyq0y+hR2kBZbulRaoh
	WCY/WPowmM7fx2gOdVoia3qkbKdwDaJ3gUPSAgupPnhZ+v1KqDEF51F/66dI1k86
	60wtgZcoGrSfN3+Y0VpeRtSUl3qFbesa0FIvUy23h7rB+mUGel0vqGVRosqxqBmz
	YfrtqheIG68aDQNh6OGBLxc5xpQ0D26awnCSnNg7bxGsoFBkAWGEbsJ3EIoLBhiC
	9Qrd0P86KbBpYWUNzGwZGvIhnP4MYhYRgRn+OOw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:e69/XQIRSrwGd86E6Opw845kgD2Dh07Tx2zVDG235jg=:7Wfmc0C9wpfcfNOjA29uMRz+/nAS5POqYEJJ1w78FH4=;
X-ME-Sender: <xms:7zDAaiAY61IRloftNNZxc8R4Dd5G6nL8s-GeH9WBf6dhodLtI6w8vQ>
    <xme:7zDAajjGdOYFvz1V1vYIRrv7vZzyEPsue59hGwQC6jI3qYM5M2DZATH0B57_A0-B5
    zF8VuXThwc8khJHYjl5gVcngtBC3_tPkRfYpSgQyrWPImPFgDd4u-8>
X-ME-Received: <xmr:7zDAaqnDWMNb6uBixNAnLVnDLQhrnwMDqAbwd5l2ywkVmvmsp6wCc-6i-koWSbtTznUftuJT1WUe4JWd63H9lermVUJTpGkj0DqV>
X-ME-Proxy-Cause: dmFkZTFQ0vAtDNfosBo1ADqxuGZae73jlQK/yRFfvK5MXHonnLPDMzT7Ja5JkBza5AIJD/
    krk0+X5iQ/00IUDe+S01J5IJo/SNZEWuJUxI+RBNzsXXr9xTei5lLLOD9fw8tXV8YJ8AOP
    z0+MCZTeSB8k4793b8+GNJJFENe2PsnQdRkXjbGgPWcVfOtmATBG5Rwnk4/958ybFcHqTd
    FEomkaaUfCJsTYHlR7kLfmuPua0pJzr5F4Dk+Mt90EnXpQqRKkKUYrK0HQOihQP3iRxTJ8
    EOUgICwHBOxxDfIbSV6e9fyHvXPdfD5NI6GpdbxPG3BQsGj4bHXIDsxzplx9xYUwJSnwrQ
    r09wLumm2PLzgX6S0Fb8Cwj6Es580DOCTluqz3oZix+Nwv3D0lCx2Xpvo3nn0y0gG3x4w8
    iXZnI0XteX5z5Yq5M2lvGR4TrJVWQH3i6h6Vd1pNtdMAyNs/iIi2N2H+L9+Z81kjAR0lag
    yjOP0pG0SkcPWGRMJlbzj9vOCRmKiq4usNbOm9DSSGE6eeMFyVKRJzE1XiGf64xkwWQIUz
    pL547moDZpO9TCuS3aZA+KzxejH2t2esFlBd84Zw9J8UdoOINyK7TK6cNxyfjG8u97aL0Q
    tNosOtoMjV5Fsg7JpAdTtFmAFZWcCOY3B+stIoUxzmz2KLQ/Z612MYe4s0/w
X-ME-Proxy: <xmx:7zDAavoygbNB8wf8j22nSpqutlpfF-ntWBN7yEupGhQlUizrtZZlmw>
    <xmx:7zDAajGGiPlz3Omkn33kNHn6SPO04a8-yRgBu8KqCB7Z7we55-j8HA>
    <xmx:7zDAarx2c2lRiGrS-sJLyub-WLb43zzW9_FCbQHV4OpxhkQY4a9QHw>
    <xmx:7zDAaoqJEaibV9rDLDQDw5RhSqk7D0hO81M14XPoHrVmTRlWQ--GNg>
    <xmx:7zDAaoMfEU2ZKUQOoxTzolHvwPT7hMyKkak5hyzXqFXzmnD8ElHoDzz_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 18:32:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Alejandro Colomar <alx@kernel.org>,  git@vger.kernel.org
Subject: Re: git-bisect(1) next after finding the commit
In-Reply-To: <20261002221154.GA833115@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 2 Oct 2026 18:11:54 -0400")
References: <asAbOSQ4BkuCTPY5@debian>
	<20261002221154.GA833115@coredump.intra.peff.net>
Date: Fri, 02 Oct 2026 15:32:13 -0700
Message-ID: <xmqqece7vimq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Oct 02, 2026 at 11:49:01PM +0200, Alejandro Colomar wrote:
>
>> Is there a plumbing command for retrieving the bisected commit after
>> a git-bisect(1) session has successfully found it (and of course before
>> resetting the session)?
>> 
>> I expected `git bisect next` would bring me to it, and then I'd rev-list
>> HEAD -1, but it doesn't bring me to it.
>
> I'm not 100% sure, but I think "git show bisect/bad" should work.
>
> As the bisection progresses, we advance a single refs/bisect/bad from
> the bottom of the range (the top is multiple refs/bisect/good-* refs).
> So at the end, it should point to the blamed commit.

The only code that gives "is the first .* commit" message is this bit
in bisect.c:

	if (oideq(bisect_rev, current_bad_oid)) {
		res = error_if_skipped_commits(tried, current_bad_oid);
		if (res)
			goto cleanup;
		printf("%s is the first '%s' commit\n", oid_to_hex(bisect_rev),
			term_bad);

it is fed bisect_rev only when it is the same as current_bad_oid,
which was read from "refs/bisect/bad".  So I think you are right.


[Footnote]

There is a last-step optimization that made me double check the
code, but the optimization is about not bothering to move HEAD and
not moving refs/bisect/bad pointer.

We have a three-topic branch X, X is at the tip, X~1 at the middle
and X-2 at the bottom.  X~3 is on the mainline.

----- X~3 ---- X~2 ---- X~1 ---- X

We found X~2 to be good. X is bad.

  $ git bisect start X X~2

We are asked to test X~1.

 * It turns out to be bad.  We move bisect/bad to X~1.  And then we
   report that X~1 is the first bad commit.

 * Or it turns out to be good.  Then we report that X is the first
   bad commit.  But we do not move HEAD and checkout X.
