Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5F3128C8
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840689; cv=none; b=GtrbSjSikfJyR4C4bAp3FokZvmMhQLYGLISJz7QcsOZvSS1O4q5wJgOmSPBcpfjMdjIukRLWgw2fI/Juf1vPmMSbXk3g04rGAcW2u+5zp9KFiLqMdBuQNXSCEU41U7+zZJ9VchvKZhDLnoiHk9uGHXcbbPxOd9n6bqQ72bqrEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840689; c=relaxed/simple;
	bh=2f7fDB8/fXOpkeYbInUoJc/O7d5DeIDuDv+fD2ok0Eg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Pr+9K9J8susMQt8EAXAIb0RU9EqHJFSqvgx3gjX57qwBSRaw9fdkB6Bqp5k6NgXYmV2Q5avW8EbohkHzQHXOZzbE3uqcIIWJv56boeVXd8OceeTZFSxiwJCs3aO3RliocHwzNmTH9OoIhLmk080z3NpqizWZSWxtlRyAFuod51E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqOj+pHT; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqOj+pHT"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61cd6089262so9368636a12.3
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756840686; x=1757445486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XkdtUBpVoD8EuHhcrAQXuymPHrwjwe20fdS3Vs/fP5U=;
        b=MqOj+pHTaG23czNoOZQsxZvRAqThOUYHMy96QaU8P20fpzEkoL3VVjuYypRuIXrnbJ
         tqEkG85vzjfb/GlYDBx42d4IhYC6cnHoSdNTthMpG1/9MAGU8vvUEl2/xlIXE3SgOKKT
         IFIOUpx1dahbo/urUurmxsH39DrbJ4WnvHU8yg4JaaQm88DuKx8MkUrHxHhMGt3sIRfm
         20TS/eJc4dCJcaDzNAspwJS4RdXiYm2DAIfVOE2aC3mOCRPVYh2tYvS/Efc5O6aMbhx5
         hH0VhcJKlJOqZ4b5glCa271vy/VvQoldxvQJmlmSNg6xyzNJnRXyYjIk8mkTf/nYy1bI
         ESRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756840686; x=1757445486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkdtUBpVoD8EuHhcrAQXuymPHrwjwe20fdS3Vs/fP5U=;
        b=CuNfG50ShWi5BxcaUahk+r7kSEiw6kiSVzQPQg2o+Vxz4nXUyDJsImc0dIDWy3+bG1
         gZL9ht7XKsLOMe/SgPEXX4nLomDglp6qt4JEM6+9zEzNHu5qnS4Ui++3swn9DX1qBTZV
         vHXhxbDT5XA+ncJQmnBBt3G10JXLoB3B094AKuN+Z05+PFIk5AqCjm5cju5ZkDowW+2y
         xVOgmDVbz3enJnuPJRKI9QUgKZTZ7YYTFKDfd5QAiOeOJ1qtmGXl1t7k9xWgfT/d8m2k
         KCw3U+gt95Vnp+ez54ajZ1pOZ21cW0r6ZWL8LMlsy/bQc8/1eWyKS5f4nh3FcR5X3KaA
         agaw==
X-Gm-Message-State: AOJu0YwgBvy8XFWmvfUX/jtsMpMmVMTMPmYUe0wV0EsbLOXv9jIJBCjN
	xN8rn6M8Qxw5eIaVJk9WrhhPMgvyOdpB6YWS6rYWNj9S7jGVwLLaegZlfJF8qB6aQn/RZH3Chbt
	Rlpmoqa3QFaPk8xYNkDr46qFlN8Awh26KJS6C
X-Gm-Gg: ASbGnct35jWpMG0Qhhhx6q6Pg1ABHB7bejA6Wu1ZQ+qWrbLainCCxCNP4+jAcBJ1QOW
	PCTnR6WW4Sx3exBxK73HdlPlQAr6yQtta4nsgAb/KqEo52iA6FqChJc4iGT729o+662kSfDimN9
	HX9UoXN5Q/XcRe9qpzZ94EwD0F6TtoqpxRpa/mtsZbqJuTmYHbg2olxTurD2XeZiiwC4Brep2xF
	V/yVxnfOw==
X-Google-Smtp-Source: AGHT+IGgZk3G430HX3p7USwQ3+C9tDJC+cwj2h8Lvpsw/i0js/C4r62bNK195aJnjq63V8vdGlJT+ksX3paL3qUcYzg=
X-Received: by 2002:a05:6402:5c9:b0:61e:1636:af08 with SMTP id
 4fb4d7f45d1cf-61e1636b00cmr8583871a12.3.1756840685906; Tue, 02 Sep 2025
 12:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 2 Sep 2025 21:17:52 +0200
X-Gm-Features: Ac12FXyrDfA6wiG98wtlig0j44i7IcPyHJnYFCNZx9WITlYo7C-8rOEKZTDuqUU
Message-ID: <CAP8UFD1eaq28PGFdmtWt-am+ORERw3KeJbH4AHxT9FV-tscsQQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 126
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Bryan Lee <hi@looping.me>, 
	Lidong Yan <yldhome2d2@gmail.com>, Seyi Chamber <kuforiji98@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, Ben Knoble <ben.knoble@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Gerard Murphy <gjmurphy1@icloud.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 126th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2025/08/31/edition-126/

Thanks a lot to =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec, Gerard Murphy, Seyi Kufor=
iji and Bruno
Brito who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/797
