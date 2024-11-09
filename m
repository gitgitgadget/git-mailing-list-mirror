Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D813DDA7
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731151661; cv=none; b=dTo6uxwMpiBWHI87GYP01NzwBfZcBbjkrlUfNhjUXoWA/qNO3hH3ZIHlZe/+Q84InxC0/JqHyV6OX1lFqUKDJAouNFqjoIwtwdW09JYNBHvX5pUNiW1nYXe2Q4dQwXLqQL6goP6Ask1zW3Gv0Y3r1FZT2fZa3fHNyPUVvUJGgkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731151661; c=relaxed/simple;
	bh=Vgff7M67TXr9TMuj27hrHBoICzECqTmmJ7x0t7xPoZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cu2e+R+BN3aVA0EHgg+JZr6w/eCj4D/lmRDBa+q5RNjOc7QVD6dBEQ9r+AAim7ohs8dnkbACSZ/iIhsQIycPEcOkN3X2gH6PMrvRk6chO4dbR87/PLhJtL0Ik9SvmpRJEdxRo66DfEEq/Lf8wOVpg7QA/vouFuT9Gu0KZAIErPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V59KP/37; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V59KP/37"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a273e421fso59550466b.0
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 03:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731151659; x=1731756459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IJnXfOCb/BalE/0rjKS3mRWsUlKBHOfrY04dOBI4vUg=;
        b=V59KP/37xXAxNlCv9+ypD2ZzjWBWrXxCYeRXzpxR71o2gotPxmuNFFbkbUun2ELhas
         Ci6t3Ask4SPyGShAntPxDrCwjKCzboBkcYDIQ18gsnDhzEJwAxNfxO+822kqZ/NX2jwa
         W2w4jz2cFTQUNnUzvnzUQ4mhxdTEerVXLXVyQNVNRE/4tORa/eb08H9FsMyscQ2BZDim
         7Y8NX/hP/zrIRiP4nkVzJPB3ImnvGvWLQ6fDKitg1lvrc1AxZvj/GjZtOgk9r2nJJtGW
         SXfI6l/dURlJnOY5I/N+iaYswY+eS/D61TZUhT/6BdAOczAQASNG5ktI96C91zS+ccbV
         GdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731151659; x=1731756459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJnXfOCb/BalE/0rjKS3mRWsUlKBHOfrY04dOBI4vUg=;
        b=bDfwxhvDuimrk7CkYqP0l0jEz28BMXHrYBeARkMKTXT065Esv3HW3sbrny1SkzabPI
         qoEyOd/D7nh0mXxd/G7A87NxMV5qYk74IAM3Li68Bn/++yud/Cbs9wlj6dZYnUqSbeEA
         0wIy/t4Gw8BtmC42enhc9MEGH36t44tPKpL4INoSwiszNdVppkIKhxlY7xxGPjFHnhXx
         LIEjWXPgZi/EuYRc6+TD8TXUXKLAFGUA9k+lRIUIwsQym+CmUmMDNJa+syApGs8gkE+A
         DeDHpf66/wIlqKldQn1xjstVvRpw12S4hZpyx9aigU6Y+nHnR/FRczwNKyiLH/CGbUZv
         PHyA==
X-Gm-Message-State: AOJu0YyPb3Lhmfdzuux1Dmq66Zv6jBulZgP/kRZILYB5cAjehSzHoH4b
	31fAmA6DUXRuRc4RgTVX6JgLzLSui57vJ3XazskW8eChAjVUJ9Xxmv/oSMYekeK8N7jOnGhumZq
	5wgBt1lzErvl/I/azOKh7DQrWgls=
X-Google-Smtp-Source: AGHT+IFtw1jp17d4Ux17EFQEnEsfSQe49NPpPk8hw7b4Rjw9Q/Zm5WszkT+HhqwT1vYnHTfY8Od2ANF0gZXOKeuYF/k=
X-Received: by 2002:a17:907:2d0a:b0:a9a:1c7e:12bb with SMTP id
 a640c23a62f3a-a9ef00085a2mr229607466b.12.1731151658430; Sat, 09 Nov 2024
 03:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqsmOu-2kcOOAoXWkk3W=RQkdTE_AgZiY6Cj10_DdEnUVGQ@mail.gmail.com>
In-Reply-To: <CAGJzqsmOu-2kcOOAoXWkk3W=RQkdTE_AgZiY6Cj10_DdEnUVGQ@mail.gmail.com>
From: M Hickford <mirth.hickford@gmail.com>
Date: Sat, 9 Nov 2024 11:26:00 +0000
Message-ID: <CAGJzqsmF7DVHw81z-eKTTtMc62YWeG4OgQ-R3k-bwV-8nmETHQ@mail.gmail.com>
Subject: Re: Debian packaging for git-credential-libsecret
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, jrnieder@gmail.com, 
	Anders Kaseorg <andersk@mit.edu>, debian-devel@lists.debian.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Apr 2024 at 21:42, M Hickford <mirth.hickford@gmail.com> wrote:
>
> Hi. It'd be great to package Git credential helper
> git-credential-libsecret in Debian. There's a patch prepared, but it
> needs the attention of a Debian developer. Is anyone here able to
> help?  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=878599

Hi. Is any Debian developer able to please look at patch to package
Git credential helper git-credential-libsecret?

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=878599
