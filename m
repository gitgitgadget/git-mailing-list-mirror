Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F4F510
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367962; cv=none; b=o+xnEGPO5yV5A0XJIhCKINySIYEld8mzXx15/pqbyZoani+u+VhGYxSLd+/tZocytMEansxjoM6OhAds8mSTiutZZZ/5+2y2HfvOPIpm9y5RdPJUC3U4AU2oggfXJUpwby62eoqT4Bcn59ZYLt5R0+MRMCuG7cUbsbGVxo2kbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367962; c=relaxed/simple;
	bh=6H7wL/cVN8mzQ7c8RrLIUcKgR+iDcTzV5MzztD8lOVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tu8bB7Aasew5mAtxlszO+EtZ3ctZobUM1g8Dl7HzQKsCDCWfOWpm924Ps0Iodjor/2WiebEz+VMi/K0gbW9RXfKWcN947pYz+oZfd8M0Gno+0etWGGU1qTrrasG23X5ZoWWLBSRVWyrR3Iee/n371GrQloNMLRi9IFkE13S6i7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY+po5o4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY+po5o4"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7179069d029so905777b3a.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727367960; x=1727972760; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6H7wL/cVN8mzQ7c8RrLIUcKgR+iDcTzV5MzztD8lOVc=;
        b=cY+po5o42SqF9QbZXf6rfSfrjDd6luI+O4QfmLANWkEHHpCwnnnaz45BCXAGjXJnu2
         e8Qe6+XFjVrqmDjE7spQJQVZBnQcA1se4gjs3mc4rg0zauM51BUEC1aUB9odZcOikpFl
         8Ux1TaSIHYb8wC64muSl3tjrrUtMQdS3ILwFCxuyCbvbQfYYN7DXwQ31cDbMPLek3qyD
         p5dlPzR5BJJrMHwrdVRwxv82moT2SYCDQxzgO86HY1dnbljlUAwItaCf0uurkx8nLhJO
         ch+KyB/x27ChPV7BxDUo4BxKBWtc2JkQlAO+J1IB3ay4Yg7pg3GTXBXBqh+NyRH3lE3G
         jh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367960; x=1727972760;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6H7wL/cVN8mzQ7c8RrLIUcKgR+iDcTzV5MzztD8lOVc=;
        b=F4G4ZASs3byf/0Shkv2O6gwi6je8K3TfenYoHXEoZn6i5qi63zlX6OP1HTX5VEXmEA
         6EMXhCxrf6DePxHrd8w90g6oEEL+gb+/g3j7hJqVkFhKTV5nF3aixLvDcVwmgG4T132Y
         jsveLUaCtcp5FYCLMWPoTN7jSvWghKh4YijRFINzfPmzMRaPAoD4d/1l9nMBpYLvbs2I
         I9ouGYMH8bOn8EySTstn+QwXDswK8QkagJBj10yOeR/SCTB4ArXzjAu8uyiAUtOqBgkb
         5kPfaA5j31Zg9zVdEQ4t+smHfbB2GnHxVaz59cS5ofonpU4LonutI0/Ww4YyzbxTD3Mq
         ej9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWw3wCQmMutMGBwIEZTX9NU1Kxun+VTYtR4khqGYGdGXtxOCcZRSIZXdr1b7F/3Opk7rao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCEhAQJD9BIOtfzeQ4vimlYtE4g6HEcNdlA8UmqdwgHYtAaE9
	32irv9q4MLshul2MHmbOMkfU4q5kfMo92n1+ogCfMAWv0B9H/0Qe
X-Google-Smtp-Source: AGHT+IFXFM6WGzy7xqPoBMF5OAgppAdt3cAF8ptzFeDefnQXe1vAy+Anc2x+A8LIWiOhb1DBip/cxg==
X-Received: by 2002:a05:6a21:10a:b0:1cf:6c87:873e with SMTP id adf61e73a8af0-1d4fa815f0amr358134637.50.1727367960522;
        Thu, 26 Sep 2024 09:26:00 -0700 (PDT)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1e09f0sm3737718a91.31.2024.09.26.09.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:26:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>,  Jonathan Nieder <jrnieder@gmail.com>,  Emily Shaffer
 <nasamuffin@google.com>
Subject: Re: [PATCH] BreakingChanges: early adopter option
In-Reply-To: <02d7b805-f006-43ca-906e-fe9398b8ec35@gmail.com> (Phillip Wood's
	message of "Thu, 26 Sep 2024 15:16:09 +0100")
References: <xmqq7cb77810.fsf@gitster.g> <xmqqploydn7j.fsf@gitster.g>
	<xmqqtte77f0n.fsf@gitster.g> <ZvVMNMiyjd4xfHzY@pks.im>
	<02d7b805-f006-43ca-906e-fe9398b8ec35@gmail.com>
Date: Thu, 26 Sep 2024 09:25:59 -0700
Message-ID: <xmqqldzel6ug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> One problem with runtime toggles are commands that go away
>> entirely. We
>> can of course hide them away in various different places and make it
>> impossible to call them. But one of the downsides is that it is not
>> "true" to the actual removal, as for example the dashed builtins may
>> still exist.
>
> We should be able to make sure those dashed builtins fail though,
> while that isn't exactly the same as the command not existing it would
> signal that the command does not work in git3.

Yes, that is what Patrick means by "we can of course hide" and what
I meant by "it is more costly for developers to do it at runtime".

> Yes, it's hard to see many people doing that, though if we're lucky
> some companies that build their own git will test the git3 build. It's
> also hard to judge how many people would turn on the config option -
> if we go with that route we could be doing (a lot?) of extra work for
> not much benefit.

That is certainly a thing worth considering.

