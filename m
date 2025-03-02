Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18D1C5D4B
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740917341; cv=none; b=ie8V90dij7/0jncfoQc6yvCIyyn8pN0nx7HNTp0XnE/2nNpy9kTElwy3g0WvIFWdYmSmNkwmwkJcDXRHf/WQZCYV8ZpJXJfwb42ozl6n8ijQxm3RguAGQbzLsUWmH1vcq/lmy9kvEWQLClgAKwWmhp9gXCOxtez5YNeMdrpMYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740917341; c=relaxed/simple;
	bh=S1vBiLtzQshlRAtY808rW3lZmlr2nIyKgj0woxQtLYM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oI7gTH0fh8eeCceqJsp6YX2k57Q3FnKmIgiKYg3tzTxVvK/gqWsN0xuv8aSRtO2ARRcdFx8BueGXy68wqBtY9JSGfGA84vEk9tj57TOp2r3drBMkRTn4H30vu/Y739Rf9ibVZ3zz0oyAIE5EBagHyqZzzvc4DiIMxAdF6jnPZ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQETZYEX; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQETZYEX"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abbb12bea54so656569566b.0
        for <git@vger.kernel.org>; Sun, 02 Mar 2025 04:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740917337; x=1741522137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J2LvDBJJDJfhRnw5kvc2snx3JiGoPh2XznsCFL+TYCc=;
        b=AQETZYEX/NrEtiIl0SgGWBr5ILlrZH/dvDe3rVDnnsslDig+rUAL2alR9KeWk1qO8s
         iuirY5Ly6nT9QvHTcMXJnkI8esEIOuJwlFQtPFdRjIRIYB/tK3g8J9uni9DjkYcblIeT
         hctmhvmk6VdiNFssO6rNumM/zWPRQbGcymqvU98yy6iCOCzOCJo7pg883jFqoaLcP1gY
         TD+rhMrwQrFVCj3rvigYZmYbb/gTu5nyFlNhdTsUS5QwQQKJWjrzlTb2ztJ8osbEGKZZ
         S4q4k3lrCGAbD/6Uju0to1bim4BQHbuagjyOoHvpb1rSjEx/tDq3Te/fSZ/cx4uzAPnp
         2DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740917337; x=1741522137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2LvDBJJDJfhRnw5kvc2snx3JiGoPh2XznsCFL+TYCc=;
        b=HX8+L2fMMhu4NkrMGnIs3tVIsxY6nNBF3P0jYkO6z5oGXxstptK1nOAZ2ljlMBqC27
         zabEstKYRC7pGm65KBh2VDszPaSkY4+eBLbl1NbKiIEvoFr8ogIEwbSzbhzQAKb0LzUg
         1Mrxh+T5qzlDb66FVOUYKzaWC0JBOm+/j/JC7RQp/99cfcMM+X43VFnSsZxNf4aRQFPf
         bP206aSuBjbloYtcigGZuWbLVkqM1P3FPOl0ovcLnbif9Ow9hx76MsUXx//rDBwxTWnF
         AfdZKBlcyZ+/V2Rl73tyH0CjTqvbTD2VvAJvOsyYFARLDqXaTMy8nQJb8m6jwE/2ue6N
         +law==
X-Gm-Message-State: AOJu0YxuwPqLAVFds9Ma8w+YFXSMg4PbI5zY0tbVxG0se8WaNm3H+QX6
	ZCr62DznZnkdbRovD/icRYFhsPuhF5mgwJJQGAI73a7WDb+r/XVLIiiIWI7y1qat9WLppAUKq1g
	JSYX96PHfsI4oD26IsUZGEgwRXyuw0J4j
X-Gm-Gg: ASbGncs3wTPgMltL8cMbuD8PWp3XEyDRW1Q9dv7yWZ2SKtTBAomts4RSH5BtXANobkZ
	zcrIX0r6rWGr5aMD64v89nnxAasr5nAHDpBmRTbXE4QG6xcsiiz4lnVjL99b7yXF4B8RaRh0Alu
	T5tW69pr9n+idHPZ9M7kaU/zaADFKo
X-Google-Smtp-Source: AGHT+IEoRn7QwFU1NcBW2B0E7MbO10MkG8QTdzAucvK9ofA7rXcaHz1hjrnuwZG5mTEvC5ZIduGCidrX8+QlFCu3dkU=
X-Received: by 2002:a17:907:96ac:b0:abb:db78:a24e with SMTP id
 a640c23a62f3a-abf25fdc715mr1235746566b.23.1740917337303; Sun, 02 Mar 2025
 04:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 2 Mar 2025 13:08:44 +0100
X-Gm-Features: AQ5f1Jo9V8EcDHdK1B6Sb4pE-vpuIADedoxhQyG6vK6Dzquh2gLIisX_NRxkMsM
Message-ID: <CAP8UFD08323p2kb2KkCk9V7PZNWCHdBQRbuzSH-jj6Rb9y7MXA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 120
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Olga Pilipenco <olga.pilipenco@shopify.com>, Chris Torek <chris.torek@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, lwn@lwn.net, Brandon Pugh <bp@brandonpugh.com>, 
	Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 120th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2025/02/28/edition-120/

Thanks a lot to  Chris Torek, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec, Bruno Brito=
 and Brandon
Pugh who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/753
