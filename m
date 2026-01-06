Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45452877FA
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726107; cv=none; b=N3pLn/6PheuT44KW3XHqyteDRI0man9ER+Z4K32PysXqhpLxSsExsHAlqRqpXldusLUvRK4yeL8UvqVm04tdZnsagQtXeayb5wdjKcQnPZRAUoyKOh70YMFQBE+wQOnBme46oMNasioh5RnV9dHZg3Nn7oVRjFOkYrLV1bCCISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726107; c=relaxed/simple;
	bh=B9hDa6XGPQTrowOE5zjn/dSFaggDLyJ+6f6vi52buW8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=arXZKOSUTO08FetTCXRBqkwziyLzse7/rQaZhGYgCGy+NifECZaiENhQSNNH8mJh9xISNgH0eivWvuWUVyYCuF6/iKmme15jMmyAlQY4rKmfXqIYMvbsX3A15h2//R0zHEPHDYAPvCZnwopey1EJp9An8RQtG6fLq0TzdzV56z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+fVBgMm; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+fVBgMm"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78e7ba9fc29so15040437b3.2
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 11:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767726103; x=1768330903; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9hDa6XGPQTrowOE5zjn/dSFaggDLyJ+6f6vi52buW8=;
        b=j+fVBgMmZqG4RkCQk7ySjN8CPGy2c4B1pE5znA4midLFK0ye/3ya9zrylk1ib1VMBp
         ix5NCtjFwTSldP7DBNX7c9U26iIdQahD/L1ES1GfvYe1JmZ3gJw6iluVaamjcBRsLku0
         N4Ou9+I8U6YcHu+K4qqCRO4mgi+RNPhKsIlwJrQWZhOZpyQFAZd6vZiQs5VhWWb7HLcK
         Ocdcwz1b38s4gQ6r/BwmdmJByFfO7ZJ3lIoLPicDrvSGdqWumXXmww2jd5yoKZ72K6zM
         7EdRIoPwh0Aly6WJf/K1sMXcs9DlVyaUrmI3pWZEbxtWFGmWjQPjq/6hEz32SXzAWdFs
         14Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767726103; x=1768330903;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B9hDa6XGPQTrowOE5zjn/dSFaggDLyJ+6f6vi52buW8=;
        b=WYW8o79hgF+PbsMujBiizPQHzcOdUqqk+JytNvy9Df2WYLQVVlQ7fokMYRI8X+eVgb
         teJfBeH9dWtVQZCCLQIbM+cew1EsopvQmWeIUZBfSF2tV7gzEoArKs2P/5SLsce7tR/u
         3TmCou1opVCZQdwLcPn3+b5al3WYbe3ihjj/0i8Rd6j5qBDnwzJAofu6d7ze6PNg9Bu/
         0baELlnz5G5qT3jBzMk2+e5M1xsxQozKnIwJ1l3iwnyTcPAR0NTQDV6TY1CpxOdkRGXe
         J9d+8MqthDctABFPfbkX3lkZF8qNZoFMdsp7IBXAMVEBdYBfIa/zVwvDAlyGRI/jrFOW
         Szfg==
X-Forwarded-Encrypted: i=1; AJvYcCU370N9DeqhQaOuh8W8UJ//GL5sVNs6xY1bJoFe+IOw8HMj6YolK1FPwuISO+sRS5Ryek8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyop9V2E0tqkn3aHkuEyhLs1tD8DMATaTpYX/p07EnA5JBxn4Fp
	LkHXht5nl5Vx2rH1UveffymhpuQ2y84Agq5Qx24jG5e/spf7pNyVL1ye
X-Gm-Gg: AY/fxX6OpOovDyYhw3VdAETAKUGGSOJVBFTgINAfmZFrlU4F31933ShgTKElZGMvKR/
	g8huHhNaJSeY2Q20Hmmh4dpL5PboJXkwGuJuI+y/lmVk3dxfhf2ri2LAMuX6rs0Y/+uYxYxSnBC
	5ULGF4vccJLCKS/5Ic3/oJIL8JzRx3/ExxhjCOFrGLVzsE1s29on/QMVStObAEBxh4zX6PpV2dY
	ERBFaYCQwdQlWK0quEMKHdJcvzOj8UDapjtgFef6IeOLDH9PG06/OEYKFe6n2mIbpdjFN4AiZHO
	mP1DouL5ZdOUnBG4rIh8hCa/rLjVkGbLjOJOC1rZM6DJrUXvCyo+oBrRTqQBjNEdU5mtA2+nUIR
	uFVkz3kUEMRnHxXNuW12N1GJr2Ztxlx3F24JdS//bUtNqRULrSLD2s6sfm2OmgnFH/jcyIvWTUT
	82TEJ8CGUwdoUk/mnO7m/OfW+Ed/3qR8kWPsSjEhFODZ7gOLOyoA==
X-Google-Smtp-Source: AGHT+IH5Krri6Ei56jCwKQ6YNbjV31jvHd01RYWpQ5WR6z/Eg/w1KFgW1ZiQV3Im5c6IyZQzKlyUQw==
X-Received: by 2002:a05:690e:42ce:b0:644:45ca:7bfd with SMTP id 956f58d0204a3-64716bdb953mr31610d50.36.1767726103149;
        Tue, 06 Jan 2026 11:01:43 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:75f6:76cb:303b:9f73])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8c4fcdsm1156201d50.24.2026.01.06.11.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 11:01:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [GSoC PATCH v6] add -p: show user's hunk decision when selecting hunks
Date: Tue, 6 Jan 2026 14:01:31 -0500
Message-Id: <ADCF604A-A3F1-48B9-B29E-777CE7026EAA@gmail.com>
References: <54e48ac4-7151-4378-b95f-8f22279d6761@gmail.com>
Cc: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>,
 =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
In-Reply-To: <54e48ac4-7151-4378-b95f-8f22279d6761@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: iPhone Mail (21F90)


> Le 6 janv. 2026 =C3=A0 11:13, Phillip Wood <phillip.wood123@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFHi Abraham
>=20
>> On 06/01/2026 12:01, Abraham Samuel Adekunle wrote:
>> When a user is interactively deciding which hunks to use or skip for
>> staging, unstaging, stashing etc, there is no way to know the
>> decision previously chosen for a hunk when navigating through the
>> previous and next hunks using K/J respectively.
>> Improve the UI to explicitly show if a user has previously decided to
>> use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
>> This will improve clarity and aid the navigation process for the
>> user.
>=20
> I like the idea of telling the user if the hunk is currently selected but s=
ay "(previous decision: use)" makes the prompt rather long (some of the prom=
pts in the tests below are 80 characters long). I wonder if we can find a mo=
re compact notation. "(currently selected)" is a bit shorter and takes us un=
der 80 characters but is still longer than I'd like - maybe someone reading t=
his will have a better suggestion.

I haven=E2=80=99t looked carefully, so apologies if this is nonsense.

What if the marker of current state were on a separate line before the promp=
t? That would allow more room, right?=
