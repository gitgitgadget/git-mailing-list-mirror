Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB31EB49
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339135; cv=none; b=t5e0x4M1ITnaFfbXB1YA9cV0RLrs4EXLu4tcxBNu6Cy62jalShmeu49Yow4kdS4uFAjYXTZ893HOF3o77aWR0pRvzogoLVzSUvftQvL3JdeMSz505YU74CJE+LqUaEEErb0fi5G2Ww5hVwPvNnCRnIipvXD8XErO2nRo/u+cyoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339135; c=relaxed/simple;
	bh=8n6AMWgOFaiIi6u3f10dGnpCGTyFKIUKIfpLcO8Xl88=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sJLZi/qSJjAURNWj4d6U9NZ7BHKmtAb8R4IsNHALlF2GdTDMAl8LQ+Q+7XhDNkZCHbLbfLA2EoX3BcKA6zXxbmq06hamLTcWYtze+GdSAONo0o0qPhI5Nk1eDcZhZCYgG+w2RzT2q0PmjMwVnoAKtuvrNaeI5wjaOQ9w8Z+exa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt2r5bIO; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt2r5bIO"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5116ba772dcso531944e87.3
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 12:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707339132; x=1707943932; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8n6AMWgOFaiIi6u3f10dGnpCGTyFKIUKIfpLcO8Xl88=;
        b=Dt2r5bIOPkoJ4xDgYas/lOut+qQnAXuMnXNXEO2YSmlB2Z4JrsSTbLZ97aHE8hO0Pw
         ArWZ5waAB3/x1vITrwS1epL8s5xu9ITnaYI+rDCCiTFkAfElsLOpmpI1qnwftNsYXeLL
         dxwokznbUrhji3qsGvpNnXhBF2nBDLZ3Ff2Uvsm2ubn9DLr3IJBNwXu5x9yJiEsr9Av3
         73CdLH/iflCNxEaxfTdDHQGsc6GCypSVMBnOX2BaWn23vgtebJaNDRa4XqGn2Bq4Ze/P
         UMRcjpR5cNKB1zNUhs3A5fLQLKc3mdCYWXrgYZjMMi+++Q0zgrs990cEz6Y/Hl6YJWMb
         P5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707339132; x=1707943932;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8n6AMWgOFaiIi6u3f10dGnpCGTyFKIUKIfpLcO8Xl88=;
        b=vElEQrdxUTj/t8NV8rH6EF+uRG2hCzFIZ44UvH4rI08plA/Ur/ghL0zSrHM0PlyPit
         DHhyh2ZetOlnF59H0oH+Td7IElUMTae+9U05+JxH8Gxn4rgBMJVoiJsSU1icLC/uqrwo
         sK6Vh3hekpNMDdxvgYyFsUAJUuOoPKQb/J+aUt5X+lpl1pQTXwbXIID6gUoVep3H+3LC
         p0OoF5a/jEou+yGkauqWe6UJ9pkXpDIJEGCEUaN5C9sDxxUMLeOwsorr7m7sK2tLv8N9
         5Q2vAzgLlaWKxNlY3b3SCUiyT2r+6W7LCpGcMuLBTiISzIFuEj2IR3JRJxQh+HHTpQWO
         hTRQ==
X-Gm-Message-State: AOJu0YxG0MGjqhFifbpKYowEN+LlN2wLPmN5PkBlQw6lN2vM3/cmCqiW
	0n4ebDDnhxeiDy2SZf6ZNa/Ij1f6ElS/Wgx53C7bUqHFZmDiKv1lBPTZ2zdNoTjMLS2HW6NZcNb
	PK0XmGj09LwQG29N2MXaSgNOQgwBtbXk/hQA=
X-Google-Smtp-Source: AGHT+IECUycZQwjL08EfqLgt+cwkYvm9mktQM8bmj1G0YKj0y9VR2TeWLHJjojX+MoW7vXs0w0sRY3GpfqJTCbeUD4M=
X-Received: by 2002:a2e:9dc7:0:b0:2d0:c833:1a32 with SMTP id
 x7-20020a2e9dc7000000b002d0c8331a32mr1939348ljj.45.1707339131334; Wed, 07 Feb
 2024 12:52:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Orgad Shaneh <orgads@gmail.com>
Date: Wed, 7 Feb 2024 22:52:00 +0200
Message-ID: <CAGHpTBKpYp370QTw93wK_RP+X2S+44jd-8kjodiUj4k0BoAEqA@mail.gmail.com>
Subject: git gc destroys autostash
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Running git gc --prune=now during rebase with autostash deletes the
autostash object, and it cannot be recovered when the rebase ends.

Example:

#!/bin/sh

git init
echo 1 > foo; git add foo; git commit -m 'Initial commit'
echo 2 > foo; git add foo; git commit -m 'Second commit'
echo 3 > foo; git rebase -i --autostash HEAD^
# Choose edit
git gc --prune=now
git rebase --continue
# fatal: '3b88163a1bff3859a005554c168d94e5357ee45b' is not a stash-like commit
# error: cannot store 3b88163a1bff3859a005554c168d94e5357ee45b
# Successfully rebased and updated refs/heads/master.

Thanks,
- Orgad
