Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A511185
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452507; cv=none; b=O+4q/5nyr1kThPFV7wrekS1l7eA8v1BGlP5W/4/eMtr0z0uImmIcHNGpGF0q/4JnHTi8gOJTbA1VrxS29HIInSdfKJl0ozhlkWXv+hwwo68NryqpDnaUlJXb/ONe6yAsRDZEBZbUrsFBqRYSE5uj4etmnIn2T1vwqmoUgP6rzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452507; c=relaxed/simple;
	bh=jzm8olxh/4wKhBOP7FWhwTJUJ+PRY7/Ef5jkAKg59YM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kCz5pDxWCMs99e75H5BuhSf0XP/hwDa4fcO3a/eAFr25wKOpveovskN0AhUe3DwtbwcHuTuiSbnhW+qb56Akk1/T0GGUAMZEI6Pk4NAjxWQTMEBUym2upReacWFiP8/WoLSkN2aM8gqLvhNZVL0D7hzR4YoyTrEoS1EgdlN46fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeiKR5+e; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeiKR5+e"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607247169c0so758541a12.0
        for <git@vger.kernel.org>; Mon, 09 Jun 2025 00:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749452504; x=1750057304; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F72De2X9W4412LSoWUosEF4YliySuHbRUbCTf60nTlc=;
        b=BeiKR5+e7Eh086QFG7J7rKpI/6b5wQqCkbW83zH5fHsRwkREXXJIzfNc96L814ncQW
         KquoA3NlOO+O9vLcHIsIzf7zpMClDa8/nWWt/3rtb9YJLyvOMsmg/YZ1AS8XrodaW9pH
         Atku8G0LYbU284nGZVAEP5geRFAda3kAf9by4eHmVLLKbs8Khy++QsHXqqRgT/Ckw6r1
         Hp8aulmXHMZGlrlzuDeJuCyTEfQYSoVLZPMLm2WLgFHKcJtRGPD2NvZc5xMUMrnUFw2b
         nxgQ6Q6oqO3EecPplidaSfcRHAgfCV4R7Go179HSXBdZroLvEMH5BvDG7l+ncuzzfCKl
         RNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749452504; x=1750057304;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F72De2X9W4412LSoWUosEF4YliySuHbRUbCTf60nTlc=;
        b=Atp7wWB0QDH0FDrDcFU0nuJHBEONs7M3kSmpcRvqpSjq11APbBcmtEkVpB0WtA/zyO
         1F3NZGqpFSpmlp1p3T8wQtos9CjbWjpsa+XYYXOaK6CjAoS0EAbbN5y0HXAjDQmdMM1G
         z1cJHwF+0Ps9Q9roFNvqFnacI4kX+JqPCzcEaq5VYeM3qYLWf9Hy/XT3U/ujo+fq+MwT
         AwfBsPKMtsCBlaCjr9YgM72bgbQbe4gsrSTftznsbTiIVWaxfcQMM5+Zauiru7Z1qtyx
         JYxnIh03uACSpdR9ak1U1yNlRdvX1MnONtKcye6G7QDJm8NXgTGohCOiJvTDF8V0OXVq
         zMfQ==
X-Gm-Message-State: AOJu0Yw+6r91ZHT2I1M0pCHXcHlMZ8Duum/rBWJMJNzkr/W7VbYv/G50
	NYzjLJkaA0TI64a5ypGd8vOAvLdpGh5KAPMg6vKtR8IX2rLi/ZO/IDYhj2iJIoTKLoHQCFVyKjn
	0QQ3QOw7tye/RAfKd3/0XnD93MlTCvHzcMSIh3n4=
X-Gm-Gg: ASbGncusRCNdnK5pvuSH8P3IW+4NGzuqrrFTMkvY/Th7rg+tc6VvatlZ6lxb51zi33Y
	VgTp7avOdEik68g+jdqghydCoFoVeO/KnLDYSG8pQNQAOVj+URM4csundlbxpTO5MNB2AugmPTE
	BqThTAEkapGHNRQxMiJ5D2wtzVClqJbGAkwwH/6JeXOiScoQl6GfBjQ/PxY7iIDQxe9KCYT1+K
X-Google-Smtp-Source: AGHT+IE1G6aceXGKZFe4v6qT65ZGLZfvrbwjSawxGlH6zIqyBOg9IIkIv6wEymiO5wtnwelajuy0GHO5NDJ1VAvV/x4=
X-Received: by 2002:a17:906:7312:b0:ad8:9207:b436 with SMTP id
 a640c23a62f3a-ade1aa6707cmr385363066b.5.1749452503456; Mon, 09 Jun 2025
 00:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: M Hickford <mirth.hickford@gmail.com>
Date: Mon, 9 Jun 2025 08:00:00 +0100
X-Gm-Features: AX0GCFtHYlK_ltp1rmoUWjEDcdpICWtLdHhf4PEZunoZF9PEL1yq32W7ZqmWRfw
Message-ID: <CAGJzqsnvTnp3k8Ab2exaBAw5pszQRz00UcucnK=ECtY5vhG+1A@mail.gmail.com>
Subject: Suggestion: error "tag ... already exists" should distinguish between
 tagging different or same commit:
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi. Presently, the error "tag ... already exists" doesn't distinguish
between tagging the same commit or a different commit:

     >git tag hello v1.9.5

     >git tag hello v1.9.5
     fatal: tag 'hello' already exists

     >git tag hello v2.0.0
     fatal: tag 'hello' already exists

To inform the user, it would be nice to distinguish these cases, perhaps:

     >git tag hello v1.9.5
     fatal: tag 'hello' already exists pointing at
d4e6038a068d0aecd5ec28c83afbfc6d4903092f

     >git tag hello v2.0.0
     fatal: tag 'hello' already exists but points at
18a07354e33f86c8349ffdc300d9087876658264

The second error is typically more concerning than the first.

What do you think?
