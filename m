Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F033AEF2A
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503550; cv=none; b=qFfseVCre5jAbXZzTIcK2E2t3Sto9XVHQjDaQAo+XFLqs6SjydNQriRz0NeICWTBa3cpKvsF0c2D+mt45F71eqqN0jtwMfj00tP9QmkQWYgMCWzz+N65eupCxl3COpMeExJjd6HPYn+J322ElKzstLNNqyoEDsGegSCYHA5IJwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503550; c=relaxed/simple;
	bh=yxlKmVx8RYoROhWq22FSICqELCfnN5ZnqhSTEaDP0gc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uhohnmpHDzg9+hyhwhgNGNVjlT/Ttz5rTxKPAY7YHblhkenZsUbByAcCQceJ20q6pB0quy35cg9ztJ5OydEWh7QVwh2qnDXI2MUiK1NAjWSxHefhv8ps2uJUiWpZ2KEbt0KstdRHtLdxZvM/mWH1yAx7TpdnTqdLW4+2M4JHFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lXPLXMbY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nWW3V81V; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lXPLXMbY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nWW3V81V"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 52A6A7A01AE;
	Tue, 15 Sep 2026 16:19:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 15 Sep 2026 16:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789503543; x=1789589943; bh=wzlXantpj2
	fBWPL2WgQ3PsGwPce+xDLO0vi77H0TH30=; b=lXPLXMbYCmbAzxQfKhA7fkf+z9
	xTl7TU19y27OcNP8sgkNK7cL5QkPAf8l80mMTKGLeobNr+40D+7LwoPqIiiZ7u6w
	b793xlnWWZZyq6FduZAh3yosyv797coTR3NVDYOHdevyEa09JsA0Z7aPyuXhUkJ6
	M4/1AOb3s9oy2Q3fo3G/XwclflP0H/zu6w7tWnC2U1kXJPsgBpF7DKdcMV1/494T
	akGOurxsf4C3v8utB/3QtGD6hg6yRRfdpZKi+hhp49b0gGobnznV86ZYPUZP8RGf
	AVPjqyK8q8Fhsoqn8hEGbg3UVXeOv8s7iuuw2VAENJzj1A+95odkQbgs1KTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789503543; x=1789589943; bh=wzlXantpj2fBWPL2WgQ3PsGwPce+xDLO0vi
	77H0TH30=; b=nWW3V81VXa0br+1h1gAH66J8HKfsrLA/SlPJRJ9ziVx0aVAsf3I
	IOvgNQPraMFiyfeH3JT4OiS+fkbkmmjIcisNM7WWockWNs0YGiJQP3S3WBQ+dYKY
	DCq6054aMDLsIj+RIx/JcfkaLQ/J6u6Snleg33Sdhum20/D8i+Lnikyjv0t1ci4m
	mkVuZJUV6uSYPrFdMp7je9WNfTqPDyArGFQT8q5MGFkRhnTo7Q3+4WEAmVnaVGNR
	lljMZZyE8K7gkatwb6BN+NmL3dtTvm2A8Bw9NT3H70TCwF+NIOl1fPPqjrYRC/1b
	F/gfTgqRtxtMReDTYm/hGLOww87HaCvhaMA==
X-ME-Sender: <xms:N6ipai9LYsDs4Nd-ye92sw7aIWfHibOrZyjfWJ0qe0OMffMWyTdNNA>
    <xme:N6ipaqI0jPwpc8iBd3-xGJkINObHejlg7GswDvoAQsJtS-PFL416n2us1waK3dPDy
    JRJQ7LHuZpBCZjUWuKERk-jcDpllb42P3V0Pfifxa7H9VXUVQcv3Q>
X-ME-Received: <xmr:N6ipalb90bS_UBXiBm8vTP_RFMLfrwSgLEVqEQ4HvE1i2fesQCEsDmNfewDUx70OeFHjIEXUDiLyNnCoGrvZmgGxA2rgHsL5gZg6>
X-ME-Proxy-Cause: dmFkZTEeJBZJbTUgCtxdOKfQjKXH2mKr9XTCTfLMPXwUvKFQSajsgqMYJ6Mfrz6+1s78zn
    IPc9aENweEUOLQ0/4ckUp7Q+SPA4xWaYfyPN8zBo99QXwhIP1FIsCpGgulGN4jVrDVakyY
    vXRJNnRJKbfPQcajS8RWJ7sXZNoXRqImmhW/ezKsZJNTjW2oRmPtH27Ap/uD9mCM1ATX/T
    BAiX6AUyMrI9IIpybYnkO1dVICcf2z4WbH2rkuRauN41ApabxPaLD0qmguS9A2mwBuKeYn
    6lvU56rrIhQiIhUJ4JQVdlLIB2O8gUZE7rY/+ytSwO//UUk4GCJFAcTLBjXNvOZ41LCGfE
    BK9ISYwxc9oavO+XrGLEJ38CSivJ9g2QP1mnL6CDMWKDo+QhL1bIcQUNNIR9anRnu22fY0
    qLr8Ium1xm9ECrac9HTYIewg2nK0yF0WGGeuZkuLkkPwFlHusXSfgkvi4YdC3LXqtzSF2Q
    3u0QKSNGr5hL9MPYya+MGTTHKqLAofBPsBjDhCsLFFoy+FZAt88DTKvzgYXoW7S/JMzmZx
    0V5vdTSLXyDRxbhbCXL71kr4u+lmIi90p3fh+65hPR7T3Q1j4BC3ANrQXVjgII+295E2hH
    AXqJbpTR2m4aXBBKatZNW97NajQJ5wU1Kmj5wzEIvPhapS1baGpZF9Z3W5Mw
X-ME-Proxy: <xmx:N6ipakKlFq-TvF0zqAGnCYgqpvx4cPEbtZed01OU_kfC8glv_NVYqg>
    <xmx:N6iparAkV-Tj_HcNG7vqLsFYNIYfmal40X24Lj2_WC1t0GlaSaYZuA>
    <xmx:N6ipahpA4gC--CzMDG8yj9TfEky_Ay5vwek6bjW3TFF18kYbj3xOtQ>
    <xmx:N6ipauiwt7eOO2gScZT2wBANE3myKy_sHoCVE-ceTTtpfyqgCowpeg>
    <xmx:N6ipamI9a0bk9eZh6lyxZw9KZxArwi_RF8lDBzkiMsIpfTfvjqkYzFg_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 16:19:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Royce Remer <royceremer@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [PATCH] Fix upload_pack_v2 response ordering for
 shallow fetch when server has uploadpack.allowRefInWant=true
In-Reply-To: <xmqqa4piz3pn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	15 Sep 2026 12:58:44 -0700")
References: <20260915193009.222678-1-royceremer@gmail.com>
	<xmqqa4piz3pn.fsf@gitster.g>
Date: Tue, 15 Sep 2026 13:19:01 -0700
Message-ID: <xmqq1pauz2ru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/upload-pack.c b/upload-pack.c
>> index a52856d869..a70d237ad3 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -1812,8 +1812,8 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
>>  				state = UPLOAD_DONE;
>>  			break;
>>  		case UPLOAD_SEND_PACK:
>> -			send_wanted_ref_info(&data);
>>  			send_shallow_info(&data);
>> +			send_wanted_ref_info(&data);
>>  
>>  			if (data.uri_protocols.nr) {
>>  				create_pack_file(&data, &data.uri_protocols);

I am merely guessing what your reasoning is, but is this meant to
match this part of the code on the other side of the connection?

		case FETCH_GET_PACK:
			trace2_region_leave("fetch-pack",
					    "negotiation_v2",
					    the_repository);
			trace2_data_intmax("negotiation_v2", the_repository,
					   "total_rounds", negotiation_round);
			/* Check for shallow-info section */
			if (process_section_header(&reader, "shallow-info", 1))
				receive_shallow_info(args, &reader, shallows, si);

			if (process_section_header(&reader, "wanted-refs", 1))
				receive_wanted_refs(&reader, sought, nr_sought);


These process_section_header() calls are made with the peek bit set,
signaling that it is OK if the packet we are about to receive is not
the one that is being checked, so what may happen is

 - upload-pack gives wanted-ref info and then shallow-info.

 - fetch-pack sees wanted-refs, notices that it is not shallow-info,
   ignores it, and the next process_section_header() call does
   notice it is wanted-refs and processes it.

But then, who consumes the shallow-info?  Does fetch-pack notices
shallow-info that it did not expect to see and crashes?  If so, that
is a very noteworthy thing to say in the proposed log message.  If
it does not crash and goes on but without utilizing what was carried
in the shallow-info packet, the resulting behaviour of fetch-pack
would be different from what we would expect, and if that is the
case, that difference is a noteworthy thing to decribe in the
proposed log message.

Thanks.

