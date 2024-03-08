Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE558AC5
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925101; cv=none; b=Sbcz4qp88cg4clYIpPeciQTNG13J9LWItFbds7nnHFbDpdotYTRXax7oZZqDtppR7aVhCmraUqCU8i8rKdJt4hLv0Gx8mPvTin/VpU2HSCLHc2BCEu0WbmcPw0Fgc4k65ym92cYXnaef0kh4kt+ljtOZBUBfaqruyilHVeq2zgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925101; c=relaxed/simple;
	bh=98HkI2eOKIlxPiu2OunBWAFwth6Bf655wRuixty/Ets=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G7sc+/WFBZcsh6hyFIq2HfDGs91ONtF+KbUZkOAkEApA7cvnEgcP6+pTqpjuy3lyj7by18AplTIyMCvcRsi8ZkO0eoXrFkc4SCnMZcdVngOJQMwPbDp0bSzx6YLfgxQyCT1zeFZ0g7RMvhAVPPynxwvz+U1T94xrmRDwmlQ7V+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4esVYoV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4esVYoV"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so4528553276.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 11:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709925099; x=1710529899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJgvZcMuDiIYDocNRbK9GZ4HK6/VSXcPBf6QKI/ptZg=;
        b=I4esVYoVHpIs2VWCOsWExXN31R+2uFcrcCOiPq/OAuApWF7/a+RIcZt78v6+SUQRIh
         YUg3KcpJQcswJWsg8H+6Cd61NYZHSanVxFlpPLiWcPMXRVLuOHt4pK3Ua27c7tDoCWup
         Mo4oYEUehRtvUUx0Kp7ayP+2t+Tejk9vCylOkflyOCZAqLzlq9LObqvygl0A55shiM7E
         Qu3wOqCjIWWXihzno4WK+kdVB48Kk3JELintjdfgVivk04VpshCRBNoJlohhNB4aqm0N
         Ow8cIcDyK2YgXfPAHK8NRMcWaYSDVqYuoN9EwQd4hKoMd1FG43XjVdcA/c8Dd4PxpTMF
         Rzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709925099; x=1710529899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJgvZcMuDiIYDocNRbK9GZ4HK6/VSXcPBf6QKI/ptZg=;
        b=BNb4tjUwcO+BZ/hKPdVjPuu0khraE9EvWXZ4xYzdU0kzSV4QhKLFUepG/qQqnlaZKn
         iaPYNfxGttytCYU+aO1Xi0KSn2wtTDgW/czROLb7nrDtPB8XyUt2CtQDgEWe+o/wH++o
         BU5Weyc0T6QbdXyq3MJejLgkVZWLTprPjxjDUXZ9qxZEX+EZlYxJTgPDjF9L9uQB2/vB
         19hpYfu/FksdcyHks/gmJQCkVLQYdZfbLagtuyIj9TNqzYCyLxSOslj60wA9G8UOCRwI
         JLsSNbKoVLZc1/KTmKSLOwHOWTi3OHMKkpvgLWaL4ZXDArNU4Q6APJwb9LTAja8lvvxn
         /5Mw==
X-Gm-Message-State: AOJu0YxjjdJY2x/KxHtUR5InRsYMBF0dDP6WmJRDu42rC/SibM7Eie2W
	Vhh9cmWAmAgOnSBa0bA/iDSSnOBjSfx5MJwvnzJqxUyxL6nccVT4CQvnve49Q0hA6N+B4Y90MQp
	BoQ==
X-Google-Smtp-Source: AGHT+IHhQyIspBTHft7q/D2855+EOqe9RA3xTs1ahAH7pJtEkYU+PjTXr6wOUIZTE/L86vZhN5lhl1l0xyY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:154d:b0:dcf:411d:67b9 with SMTP id
 r13-20020a056902154d00b00dcf411d67b9mr5571687ybu.5.1709925099066; Fri, 08 Mar
 2024 11:11:39 -0800 (PST)
Date: Fri, 08 Mar 2024 11:11:37 -0800
In-Reply-To: <xmqqsf1a7wse.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqqjzmpm9b8.fsf@gitster.g> <owlyil264yew.fsf@fine.c.googlers.com>
 <xmqq1q8ubtg6.fsf@gitster.g> <xmqqsf1a7wse.fsf@gitster.g>
Message-ID: <owlycys44jyu.fsf@fine.c.googlers.com>
Subject: Re: What's cooking in git.git (Feb 2024, #09; Tue, 27)
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Doh, please wait for my v6 reroll (will send to the list in the next
>>> half hour) to clean up the commit messages. Thanks.
>>
>> If we had communication gap and the topic was prematurely merged and
>> was caught within a day or two, I would be a bit more sympathetic,
>> but given that this was merged more than a week ago,

Doh, I didn't realize this when I posted my message in this thread.

>> that's totally
>> unacceptable.

Completely understandable. In the future I will check "how long has the
topic been in 'next'?" before asking to replace it with a newer
revision.

>> If you have improvements, please do so as incremental patches on
>> top.  I'll hold the topic in 'next' until we are ready.
>
> Well, I changed my mind.  As we haven't rewound the tip of 'next'
> post release, let's eject what is in 'next' and queue the latest,
> pretending that the earlier round weren't in 'next' at all.
>
> Thanks.

Ah I see --- thanks for stating for the record (and not leaving any room
for me to get confused). Much appreciated.
