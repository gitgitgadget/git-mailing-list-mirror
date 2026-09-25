Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBBE4E1C80
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364173; cv=none; b=nGymfG/obiZXImKmNOFeM9MP7ALv+fBfYbVRcOQaFDlRJu2yItc+UyLVHVwSNDh/Pl6hJbxLKxtETV1OnflLnDjnhzhv/608YJDf05WkW+Xsze9MqccgiqigdKJt9fOhNZLMFeP7o/GzyOcp9YUVFGa+cWmjfTxi0jCc2Q9MIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364173; c=relaxed/simple;
	bh=fsdCy0NOQwIAEyP30Ce6QOHH3MiWltGOC/lM+aYXUF8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LG5Mf+IFLnTmAsgxSAw7hdnMKqzr4OmPjVo3fuWCen9R6UTKgvqXen1EUyANU27yV+Vd4hsZYuQx2zaM4BPRKL6mUU0jnCb2/Ug+6gPRGlSXjOgGa+F2m0x9bs+ymLAbS/C6MSfOLB8GYtcZwuVaA7CEH2ALs1kD7cEt7N8jh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=6I0037Vy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vHP0tawM; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="6I0037Vy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vHP0tawM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F9A27A0082;
	Fri, 25 Sep 2026 15:22:50 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 25 Sep 2026 15:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790364170;
	 x=1790450570; bh=96peo4Vei+lfGlsDGSDOsn14deSntS1Gb3z0aKUsqlw=; b=
	6I0037VyvKYHvOcdLoScyWyoOtQRuDcwsmOwYevgkXQCJ8w5nDRNcenpE9ZV4B+I
	QsNSyWSd3n3+tFhTBoljD34MiOLB0rtVqn22gT7xFX4hbIze8XUcpFV7OmBEhOpF
	stkRUwgQ1qwUz7MkbsR3gINc/LAo38FhbF4Cihn/6Q1XV3Z3apCFLmkZl9AE+VWQ
	DSf21QoXElbLzDOlxm4I0KGJrprlMVT4lyGOyRm6nQCMd0c9Dazh7Qw/+dPSEF85
	H52o+yaPTPHVEzPtFNqHtEi6smgPs4uNVCgauFLiVPUso9I6OTwX5E5nH5BGrV/+
	RcYt91eckE6XHZAml6usrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790364170; x=
	1790450570; bh=96peo4Vei+lfGlsDGSDOsn14deSntS1Gb3z0aKUsqlw=; b=v
	HP0tawM6Yh0oRoez5DnVP3ZtOA4420CqawJ/0rw4GQI1WKuq9KmHHi3Zry0hMMq5
	Mle/ReCQWpKzinQHfIqWuZQDU9vKcA/hBOlc7Zeyj3Vfff8cqpsRmxJQCWwAPeIo
	ZEXB1QQWSe+/xjaaJD+iEcQEpzwpBSDzya5fSwcA7Cj6/ePkJgoamu2tkK9ou1Uc
	eY4arodzT0ARyISNXjTAvREgJKoH7rylHbKparmZBb5RlML7X3QZWaNCytA2bkqd
	E9MUAAdxt7LWykWUmWr4IBCwqqRuudIj3xnq8qNtHdD80p8650eRkmaP3rec7uQW
	mI8LK515257z4V+I9BO8A==
X-ME-Sender: <xms:Ccq2amrOt1XhOHwr8L6APKBVv_rt6Z2b7kSqiGRWFad_P_0oBv4GcQ>
    <xme:Ccq2avfy_LPTSYvbwx9SfkUIDx-8E2c7dv8gFRdCSyogWexXX7u-wd-u8SdJgP-8j
    t4LMfsEzOoGQS3kQwerMBeroCvC5i2a-yZDzincoPtASrF9a2InExdp>
X-ME-Proxy-Cause: dmFkZTEf5pNip+8NZA+VEungstSwsK0VcaUbTEWT0+/T9Ap614CTrPySjFZ+Vb9htIFbK8
    QN2LkgZh0Zfg3HbogFIjqwFHRdg1fgShVvXmm1JEQb9p4JwvcR160F1x9SqDSS4oUR5T5R
    NXUCM8lQYFC2JWWj97raA2d7VYDaJnIwKrmSqStsL2KTOzpXMJmkuc/zyeVZqPUbc55HTZ
    JMh136Dk+kGKnqCWi/qP3wgzMluG9tnMA1WbgSGJLik9nBUDJ4uO4Dxf3hfC+qaGktLJAa
    ZEJbjiE/J1w/6MXq3meGOUXxJWx25+AaGqtxsho0hgPPQXmmeF2H1ElPpnpnVlZwm0SjWd
    bodKMVBEiZ+/FhOTwGObcyVJ37kyNL4kZwuuD7IxMG3CO/mQkfyvgWu9qTOUgigh6HP74A
    NlYqrFHsp1r95W/Sc1mwSbeDktWh6eLXc22nSzRtTUvQe0+IbwurrYddz74QefAiGqNfHg
    ZuMXFQqjfZLXkvIUyYsTQRdPJW+uuUv1C+1QxNkpQdiMgdP+Dga7faG2Z64hGv8ef30JWd
    iuCrup8cil90dC4xoDLLu7TqGbKacHQ3fc92bH0CoT0s3Z0n8pdiB8KTH2FNwBBoRUmDw5
    7RDeXnGmJai5Z/zjWVAy2wfzMddsMSkKejSlUIGNVOZ/ZLsqtpFmDK47nV7A
X-ME-Proxy: <xmx:Ccq2ahWkmna8AamE_5ojn8AUf4h8Q1IHqosSNqANuYg0TrVn2Z0qcg>
    <xmx:Ccq2avgDeRBcY2j1BQOjsluMc-FBQ0GJogpAwkBbUFOd3wr6-tK75w>
    <xmx:Ccq2ak_-fV-a_fMcAzJRqfmEWS_v0TY9y2mJDD2Z1HDPr7XpcJHzCQ>
    <xmx:Ccq2ahAtjGthbfI6YHv57sSAefaxI7DOLjUA7etcOj_mDiU1M2SqWA>
    <xmx:Csq2aiNjinqxhYWE8iP3G04p8hGHopPmBfEJKKwi4dNUm3l2FoFN1qUn>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D95F2780070; Fri, 25 Sep 2026 15:22:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGBSJuH7AubZ
Date: Fri, 25 Sep 2026 15:22:29 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <17c46e4e-a4f6-433e-8eea-c1e4eb28fdfd@app.fastmail.com>
In-Reply-To: <xmqqh5jdur4c.fsf@gitster.g>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
 <pull.2416.v2.git.git.1790297546771.gitgitgadget@gmail.com>
 <20260925082723.GB1493716@coredump.intra.peff.net>
 <bd5d9451-ac5a-4274-9a7a-57ae99864fe9@app.fastmail.com>
 <xmqq7bk9wa4y.fsf@gitster.g>
 <4c9f0480-768a-48ba-9753-b4d34188b1a1@app.fastmail.com>
 <xmqqh5jdur4c.fsf@gitster.g>
Subject: Re: Rewriting the Git tutorial to cover less content
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Sep 25, 2026, at 2:23 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>>> See gittutorial(7) to get started, then see giteveryday(7) for
>>> a useful minimum set of commands.
>>
>> This is a nice friendly statement, but in my opinion `gittutorial` and
>> `giteveryday` really do not live up to what it promises, ...
>
> Yes, it outlived its time and the world has moved on.
>
>> I see a couple of possible strategies.
>>
>> * We can write new guides which are clearer
>> * We can link to outside resources (via https://git-scm.com/learn)
>>   which we think do a good job. Right now that page is pretty
>>   out of date and it would be very easy to improve.
>>
>> I think a mix of both is probably most realistic right now.
>
> Whatever we do, it is not enough that new guides are more clear than
> the current one.  The goal should be that it also is sufficient to
> replace the current one. 

I don't understand what you mean by "replace the current one". 
Some interpretations I can imagine:

1. The documentation remains internally consistent, like if it says
   "see <page> for <information>", then the information is in fact on that page
2. Any information explained in a guide must always be explained a
    in some guide in the future
3. We should aim to make guides more _useful_ over time: on average,
    a user reading the new version of the guide should come away having
    learned more relevant-to-them information about Git than with the
    old guide.
4. The original intent of a guide needs to be maintained.

I imagine everyone agrees that #1 is important. I spend most of my
time thinking about how to do a good job of #3.

> I do not know if we have bandwidth to keep external links fresh, and
> having a set of links to stale pages ourselves may hurt more than
> help.

We've had a list of links like this since 2013, at https://git-scm.com/doc/ext. 
It definitely has broken links and it would be pretty easy to update
some of them once, which would help in the short term.
