Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D3427B50F
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386463; cv=none; b=hqY8JFiCYDufbAnxh4yq6qdlsNaFVk4JCGcuGKXQRFYofPG0ZCnShASX5nDOgarMkoj3C7VeAz0q9myM8Sf8o7uVSLePsQnDGoTT+bUYNTUW5IIiAD6imZ9cdLDwgNV2HSr4p+yLxuFcamYkutamL1wQS3236rHP6aix9UYQDu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386463; c=relaxed/simple;
	bh=W5B8kk4OOquednH5LPUqZkypvbNhF5uWE6K29nqntmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o8kq1+Rw5cXGsBVLMB3rB3DLKflfe1nxqyv/0KCbUvUFpGnWfnwtXj6JIL0WZ8dG66NUhexcROvPsGLhe4JoSzdK3vIsZ1FWZNxFIIja23C1YeO9ZiUikZLPh/LxnU01fhB8hGpfg+M+VQfuFMsLXq8vQt+mkJAY65itvumovno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1bx6oWl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1bx6oWl"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234c5b57557so33501935ad.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751386461; x=1751991261; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sc53KnypyYLgWzZTrOWeoEwgxLJlMu/B3oycX/sEVEY=;
        b=F1bx6oWlDD683wllLbLZ8D0T9xUIC+VvNBiDWQ2f3xAjRbBckV9muHUkdWEMsSRAvt
         fAxUvjfIkF3mAB/lCY3p726zkhvsuFTbhYfGwAvHW24YLsvOopi6z7FHfEOi827W2vYT
         Lz9ey9VS1vPOz+EVWvWU+MtAZiHsKeoSay2+iusv98EVSsnHBidkZ4ePA9ctNVIQqjHY
         arC9IdaWDVGNMXr1zAmlN9ChV2fQCLCZqVopDpN8CSR292N7ZEtA4GXvK+12B+zff/CD
         0+F9yREyqKAHH5RcmrhSzCVjlyOy+LAJbaAEmZ1rctxt+oQZ9O0/onnugyVjZ6d1hzKE
         pYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751386461; x=1751991261;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sc53KnypyYLgWzZTrOWeoEwgxLJlMu/B3oycX/sEVEY=;
        b=YvHSjY76XshlkHaeD7jselSjgDql+AQf4TD8HYHhaVRzXBhTXF8pZLrTHMqC6FWw1F
         4N77jXHdFBJuTevZdn6HLuoKDOrrYU4kbrnR4mxW/aiM6bT1e6PRGOFlf3kuapjH4cm/
         zgj6We9AaUH+pPCw33tw3Fc4y0raeFBznvlKQfT7UJzSE9vMjw3b+YAKJuVgcw45joG1
         72c4jjWV+INl5SD4eCWOyjPkU5TTus2yVB8H5AZt3RFpDXr90peTbuadwN7/PwVy2TwF
         S2+ymqsItU1lxYYERQBcAT/ESGNJ5UZsY31LyK3ufQ31uvzoSeUXWQou3xiFuBt1cLcp
         gJOg==
X-Forwarded-Encrypted: i=1; AJvYcCV7iAiCf9kILVCL+Xv/3LJpYsTpS/PFlrsLs3XgvswCz1iUkZsyTqUJCrSBz6jqiyxU+ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdvsOnyjZB6Sw+m3DOV25QvJnQOOKW285GjCz4kbaZ/V3b5hlV
	BjDa8NligTciQzrSFwRQJFpg+diHYENXcrEgO29wuF2JCGRPV0FFkqxz
X-Gm-Gg: ASbGncuPGzTJL5XlNNOvOQokYRdZKxiGK9Nk9OpXoUdI7WgsvljiaxI5AtsZ0219vLt
	scFg/aqQSSh7i3R7SHOrxTNRoQG07eVOnONcMjY2iy1m3xnZtIXAonDUJnmbOcTAsqYUaqDWrJe
	ONtF/2nEOILem/sYeJnAa5g9TG6oQQKfOVQGGgdiONNaX4gnqpH6BJtb4M738VaJL5yDSWZiYMw
	yETBbw2RzlUZrM0HMDqlnXXNFgMwbNNsJLqzMEKugB3e7hHVQiyL1pB8dgnAJr2Co9YbTG3Viqo
	Over0bkeHhh/NXoIr2uXYNyFkl+IfnEMsFm+zCwaurvDglbPYD97MLWdN66glWUg1JXfPHRpoUA
	vNBmWxCVrynke5MMCEEf4h8STVAo=
X-Google-Smtp-Source: AGHT+IFvNrfL1VVv5BijmTAArZUm8uEoNqNyMo+wLW/cESEA+GIca9sy/dZDkyOr+5SueegLnFa7Vw==
X-Received: by 2002:a17:902:f686:b0:234:d292:be8f with SMTP id d9443c01a7336-23ac3817377mr270100305ad.1.1751386460522;
        Tue, 01 Jul 2025 09:14:20 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2e2465sm109878555ad.45.2025.07.01.09.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:14:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Karthik Nayak
 <karthik.188@gmail.com>,  K Jayatheerth
 <jayatheerthkulkarni2005@gmail.com>,  ryenus@gmail.com,
  git@vger.kernel.org
Subject: Re: Re [bug] pull --prune could not delete references due to lock
 file already exists error
In-Reply-To: <aGO46urHzZTZvDve@pks.im> (Patrick Steinhardt's message of "Tue,
	1 Jul 2025 12:31:06 +0200")
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
	<20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
	<CAOLa=ZSA273KGPnwZ2aRBU_ybcCTYogBHvUwpa+5CfDOc2bEWg@mail.gmail.com>
	<aGKdICvmKlumU0ru@fruit.crustytoothpaste.net>
	<xmqq1pr1lyur.fsf@gitster.g> <aGO46urHzZTZvDve@pks.im>
Date: Tue, 01 Jul 2025 09:14:19 -0700
Message-ID: <xmqqtt3vkhwk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I'd really like to start thinking about reftables as the default
> backend. They fix filesystem-specific issues, compress better, are more
> efficient in most (not all) use cases, sometimes significantly so, have
> better properties when it comes to repository maintenance. We could for
> example make "features.experimental" enable the reftable backend by
> default and add a note to the Git 3.0 breaking changes in that spirit.

I am a bit surprised that there is no reference to reftable in the
breaking changes document ;-)

I am all for allowing users to opt into it dynamically, and
feature.experimental is the ideal mechanism to do so.  Currently it
sets four configuration variables, and making it five would not make
it too scary for adventurous users.

> I bet there's also tons of scripts out there that just reach into the
> filesystem to do stuff, but that's something that we cannot really help
> with.

I thought you've done enough to make sure that common things people
would want to do by direct access to the .git/refs/ hierarchy can be
easily done with plumbing commands instead, so it would probably be
a matter of writing and publicizing the "how to migrate to the world
where you cannot write into files under .git/refs/ directory"
document?

Thanks.
