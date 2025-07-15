Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6E1E832A
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591772; cv=none; b=ctmO5GnyWWWF1ZdSWTy+Yl81NOJk5Fnzuh3wQeyLk8PvKqScPPXbszgPatFLLXYdecY7pxEVtqG948p7WeNF9DZTU6gNByYstxQAcn57UnNgGnoLmqFLbfaUbv0S6+ugO1QXjusuzo/nugkkYl9hUANANnroHu/N+QbnnGoTGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591772; c=relaxed/simple;
	bh=tVuJ/F95foXOzApv/9uR4f0YwV2gEJhs1+y29Tgs69I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UJs98t5i5aCuCX1KktvnYWXyoSV2J8C0RKXjRb/zFzL3JajoOy/LkHbLoohG4ge/zBufixtCiDz4ZgLlJ5QKx2uAA5k98ho33bWMSc8+qyjebAmst8FZL5c7dQtKsTpHvll98l4Ct8GNev2zcBC1LCDRv0IowrXMhHssQeKW6oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPbqgOaE; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPbqgOaE"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7426c44e014so5406799b3a.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752591769; x=1753196569; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVuJ/F95foXOzApv/9uR4f0YwV2gEJhs1+y29Tgs69I=;
        b=ZPbqgOaEjLtPdclGSJl9yfvbelEmYEj6UDefX8rdkfBVErTz/W6DQqRclPZAGMUE08
         Z5rWl1lBAixoaPn5vIzobPnJ2T/ZjMw7fvIJitBZwfafy3JiO1LcXYEnnq2lL8U5ksAb
         ZkrAdSTYlz+jYZ+fMZsy/DdPU4nz8XvqQqY7UA93CDsDUR+C8l4vNfw/Qr8GIvh9KqMj
         WAGcbhVWAG8N3EsrO3rTI6hRT4qTs/gV4HQiPr5eWuwzk8EKTCnRSO5i2NIPqAQfv5km
         RxK0Nx5c4pxjBSWpx+Ds0UfxjjzzExfoQImO15YIC+q50aRL4u6mqBD+uKf/+smlwXWC
         7OxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752591769; x=1753196569;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVuJ/F95foXOzApv/9uR4f0YwV2gEJhs1+y29Tgs69I=;
        b=OmWZEO02LqvM1cMfaMV/3VRKuqR1D8N4/5nLIPDTqBt8nR5/c9LtbJDSLbIrJAYXse
         Mhk9BZGviuccX8wV/x7bFH0Xi32y+JqXhvHdGncD0ooBzkh4b7Guxi/Yc3TzOE4X2t91
         ROc+L+CyHexB+hxhqB8WP7dX3YM92cLD7+CEzm4kMgkpceACDGNX9lmkhxYQ6/L+rOEj
         9IixaLgKhYqOcY7U4ZujwHYpkdFARxCRGxHamVSGh1ccIyUcBL+iQc4NsnTeNgZnaebS
         /FeAR5ZO+/kPxUFVKTWLTk/+bmptrdSPq7tu+z5LNmO4VHhwgqkq5dNx8l9ZXrADb5jJ
         ZMhw==
X-Gm-Message-State: AOJu0YwiTw2HchVytgezUcJupBfjT1k5Atncj4DI64PU1G8XMo+VunKj
	vbC3D5tXxh3KNsJk/HXQqgbrqoL3Rq+dpMvlaNMMi9q9K9dTXjm5zs5op/R+F322KsADtA==
X-Gm-Gg: ASbGncuhXYMry50RcE1d0WKNb/hZvopN6FckLKjg2q3XIF0scfhQVoH2yZXbBlprm/C
	kpjXKc1UbBjKahUXuygSgsNUsLJXweaohFjrfdnVsFjK0jrJ4Wqq8oYy1LJN3IouRkUbNfkr3R6
	0OTYj7SWSNceTBKZ4spvTXsl3LrIR1DzgDnIN5Jg4PDWDhOwNLM2KBF1SElPOqZuL7Eis0l2Niz
	6QkNOqxZjf7E2fWHfT8vU8XjFt6OpmvOxCWwk0VcHbBF0iZk4y+f+oQUroP+xyjzzFJGxgvy1KK
	lj/U1mdxtumGy98RVp8TTqBtbFGUQlM9zEeclX9ZFL80+T8ue4zquGZOyA5LZC99WTzUFPnw04E
	B8CJ1oDKOO7iG3bBH+pNtZ0F+LWGWcUb7zWAs9ONk/K9wP4e+5xpfUdMLU9RtrHMGWZqp0udZwy
	pXmGzGkWlO0rYWs+nukZPWOs/H
X-Google-Smtp-Source: AGHT+IGTmzCatoCPYbwrUAGqG+Tumrz6Jbrcb/fdHYWPqBiMJ+T4jfhnt+l4LDKTJG1VMHICIVgSzg==
X-Received: by 2002:a05:6a00:230a:b0:740:b394:3ebd with SMTP id d2e1a72fcca58-74f1c5de456mr23557759b3a.7.1752591768981;
        Tue, 15 Jul 2025 08:02:48 -0700 (PDT)
Received: from smtpclient.apple (n058152022194.netvigator.com. [58.152.22.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e069b7sm13243677b3a.55.2025.07.15.08.02.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:02:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [BUG] git pull ignores pull.autostash=true configuration when
 used with --git-dir and --work-tree flags on a bare repository
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <010001980c90be66-2401a0b0-5c86-4135-90e2-c325852ef168-000000@email.amazonses.com>
Date: Tue, 15 Jul 2025 23:02:36 +0800
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1AD9A170-8E17-411D-A13B-EA7780CF4D39@gmail.com>
References: <010001980c90be66-2401a0b0-5c86-4135-90e2-c325852ef168-000000@email.amazonses.com>
To: Bryan Lee <hi@looping.me>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Bryan Lee <hi@looping.me> wrote:
>=20
> Would it be worthwhile to:
> 1. Add a warning when users set non-existent configuration keys?
> 2. Or at least document common misconceptions like `pull.autostash` in
> the git-config man page?

I think adding a subcommand like =E2=80=98git config verify=E2=80=99 =
might be a way to
solve this problem.

- Lidong

