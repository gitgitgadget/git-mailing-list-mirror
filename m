Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B6F38E12D
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270592; cv=none; b=EDaewe5NVpr0/TPLh0GKj3yp8AqoEieO3QsEMJSoK9LQHER7liQzTXmWglSxiKF8wli0q0VxQrT1K5IFrRO53xR8UOrJ/7Qr7FEr3/TgNeqIZ6K+5DI6sWxZdSUSXIw4iKxRmOViEnTZwNw1H96yV7FBAXKA7qM5VQBP83OlApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270592; c=relaxed/simple;
	bh=dKf9S7EWhUFcHAZwMsSK3+fxAG/1SQlhzuGjAikYyeU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dWQgKoBuItOFJcDzqVUKe2nZ0EfUj4gkVX5ReTzVzrSj3vfXVNWmHo4jdIxFYJNMBQaufFlifLCC35BejA+pEkbxcHbDOiZyiTv0fPq1/bvxyDMjsZkzqJE30t/qIbbdFZU7hxPzXd5sK1ZMNwMO2pg3LGwekmk0puG1jpAv2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=RJdHfzIW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fZ/twCiF; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="RJdHfzIW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZ/twCiF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B68D0EC00D4;
	Thu, 24 Sep 2026 13:23:09 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Thu, 24 Sep 2026 13:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790270589;
	 x=1790356989; bh=pPmztmeOFC+LbxAlH089FkW6mbn/UaXB+1hkhkIPzho=; b=
	RJdHfzIWAAkD0SoyjBwuuC9rUx6QEFV6iMajZbzONTZeSzyB7qDrov/BOYRctkIR
	L02LGIa15l/t/9WjYH8McPWuxHLTjvgURlj6iG701lj+uS2Hi3x8Fa+e0XPNGPZn
	ahdNXMMDdYR+eA1MPAoR8BVNKY7JWL5JXZdXOm8qU5ULMawBBxBtsGlu5iIuNlmD
	6JEsG2VcWk8iCUnTnH54PKx8Qn/qvhAbJ4uPuAuakiYJlLgQKpO5PcY7sgJr4uRe
	LVCaQUZVoZSbMpeEvV/EWsfZsEV7Xj2BQfKzr98RpiTAAzBZhUb6NtJ+TGhVRoQt
	kn74G5N+JXwa0qDEnMMT7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790270589; x=
	1790356989; bh=pPmztmeOFC+LbxAlH089FkW6mbn/UaXB+1hkhkIPzho=; b=f
	Z/twCiFN3N7n8GlIme8+Udeh6VgxZjy1Bkc7AuSYfGmMXrNuDWyNHCkBXVEVF8FO
	ZldHRpwIc1Mkd7SeFP53USqfdCjCq0PDlr8tbt9JDw132663b15fjnVvbuDa9sBh
	47jhV9bpEOcx7BJh7SqjFq2/nddZSZZCbg3ACiE899W9KRPBMZauzNjeaJpcr2er
	N/cp/GYnJkC5Dwee/QhzNANp5K3j3n6ELN7V/i/2qzvXIFyGDSsI65qEjQj8FHUS
	n3CIdsPgW0zxPiK77mjOMeXZhyCB4QmorYOG+VyjnA61cGIl4O4QgOQ2M3raz+94
	sNrVR7bPbA2uidWsbqC2w==
X-ME-Sender: <xms:fVy1agq5hQQEhxv5w5IBDGgTZYJ4lJ41Wn92iHfoZICd2trx1AOOFQ>
    <xme:fVy1aheZ9S1ouNv7W1tigF2yPYZ8EIw132cfenSgdsUJuOrAecQzhsWzQGptlaP-T
    E6BFwV3N6i1B6h7u0z66Ggg7jvOP4rv1OdvTXWQMwCXSJfmh1t78B0f>
X-ME-Proxy-Cause: dmFkZTEcPFqta4I3Mfts1FXEOj1qyfVXu/ybbg76taIKS7WByDJlr3klICOSQvwkmC485R
    diXMngkq20mntfmKqwd8vYLYNLP6A6eNSIMm7wujq9a9OMfLB7SS1vbZKTblpWq9HwDXRL
    7PMKOs9a1qpBrTbSPANt3mubOl4Zj6pPg7WmTLBU+gzbf+wTpjFCM3xD/RGsp6hifFrB+a
    X2Zv97QCmmK9VUD4wDsusgfo+Whpds4+9mlCW63mMv5QX3+45EMk6DPtEQkDOTdlyP77yZ
    ecOkLeEy5R+fA0r2mr9Mao4AIop4Pk8jwi12CIUJOBdkhlTk4EzVFujO1AeFbgtsFju+J0
    h6vOxH4T4LyGCEFwyPLkPSlPa4/XsjHEc/LaxZFbC84GIcmD5OLILckjU6OyF0ZC1re4p0
    i5CMWOlkKly+WwNa8VeVzbThnwEqm1qPM4WCWQu6nQM8fJwogSjXdft2hey9EdwXzD2UES
    GeGLl4Ad2ePjZXBBw2p3WWLancJMnuRcAcZ3LuQsTryWynQtmJcMDUKvEk9b8NUIhqr4x5
    rH8p/w8soZy2fPYA4ElGMG3qxY/LZ//IChCYfa8Y9YHbv+dQIkGdih5HrIqtg5seNzT9yL
    g+ed7BDdQ70wcF9B1y/ICQyE5ZPgep2us9tNCWSAgo/qQmzgVvDjaX8dZUUA
X-ME-Proxy: <xmx:fVy1ahTvZJ4I5BrNyYxXxlc9b2H8svXDcxZtd6pn5MlBXfNc7pIAXw>
    <xmx:fVy1aonRVbeABGGuKDiEX0B6QXiH8E4puqCN5EDpIJao1FZhDjJEmA>
    <xmx:fVy1ahSDWM-ICRKqH8mjX3SOZlSp-4H8kJAAbhx1OzUB7VmwrVsZaQ>
    <xmx:fVy1amMVekv_ptd2H1WPtFUm-jYf7g1hCzD25DZJc35hVYY_8U9TMQ>
    <xmx:fVy1asNm_mwGFe2XuvcAFV-K4Tp5WuhDc5spbFKKXaNGRtjG2SOtwIl2>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8DF73780075; Thu, 24 Sep 2026 13:23:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFcAV8VPp38k
Date: Thu, 24 Sep 2026 13:22:49 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Jeff King" <peff@peff.net>, "Julia Evans" <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Message-Id: <31577b6f-79b6-456f-9ecd-d1a3df6209e2@app.fastmail.com>
In-Reply-To: <xmqqse2y371a.fsf@gitster.g>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
 <xmqq4ifhdon2.fsf@gitster.g>
 <665e8f8d-7bde-449b-a390-10875135cba2@app.fastmail.com>
 <20260923214038.GA49087@coredump.intra.peff.net>
 <63520573-c8a7-41bd-aaeb-bfc2b5e43856@app.fastmail.com>
 <xmqqse2y371a.fsf@gitster.g>
Subject: Re: [PATCH] doc: add more AsciiDoc cross-references
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> To see if I understand correctly, let me rephrase the second
> paragraph a bit (not as an attempt to offer an improvement; by
> restating the above differently while expressing what I take to be
> the same thing, we will see whether I misunderstood what you wrote
> if my version ends up saying what you did not intend), as I found it
> somewhat puzzling.
>
>     The short form <<EXAMPLES>> uses EXAMPLES as both the link
>     target (which is not shown to the end user except in the
>     browser's location bar when the link is visited) and the
>     clickable text.  In different parts of the document, however,
>     the text in HTML may need to be rendered as "EXAMPLES" or
>     [EXAMPLES], which can be achieved by using the
>     <<EXAMPLES,"EXAMPLES">> or <<EXAMPLES,[EXAMPLES]>> form.  For
>     consistency, always use the longer form, even when there are no
>     such typesetting constraints.

I meant something different, let me try again (with Peff's corrections as well):

    The reason for using the more verbose <<EXAMPLES,EXAMPLES>>
    (instead of <<EXAMPLES>>) is that in some cases, <<EXAMPLES>> is
    rendered as `the section called "EXAMPLES"` or `[EXAMPLES]`.
    <<EXAMPLES,EXAMPLES>> is rendered as just `EXAMPLES`, which gives us
    more control over the output.

("in some cases" is code for "I still don't fully understand
exactly when each one happens and why")

> I'll mark the topic as Expecting a reroll in my working copy of the
> "What's cooking" report of the next issue.
>
> Thanks.
