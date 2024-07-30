Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C69190042
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332088; cv=none; b=jUj/Iz0rtJx3iIJTeemtk7+mUotPZQP25rx53hAR0gLlCipT+3metS53eyn0Idrnej9MAWatretTiIHDkLq9BrqUvdtPY++6dPodikdueOfa49wPpu3dJEgRewTlJcPe+yIT4aHJIGSoJ0IDpPdN53ar7fbe038kgMPra7Yl5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332088; c=relaxed/simple;
	bh=biXDfDroab2Qd7CC8jmBCa7MPxVkqgyKUjTtJX/m5Cc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=EN/Br6r6WbcRZsWPHmf/WmzV3LxGQ0G9Jy682mn5B4+yuR3cPHETkDevJTu9ZHAfN0FA2wrr6gMBEVVI8Ot0rycFWc+cig7i9qOxLDFqss/HselZv6RHlXu3B+cM0BpFX4a+vICt1kmTaMwGLkGz8ar1XutHkPkWJ/dZ41f9e28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4RIMC6h; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4RIMC6h"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-261112c303bso3086530fac.1
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722332086; x=1722936886; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=biXDfDroab2Qd7CC8jmBCa7MPxVkqgyKUjTtJX/m5Cc=;
        b=c4RIMC6h6qKL+ckxhUyNKtXYKFD2RRDneOFjk2qw7h06mHn2fw/KeSY/0y8YHJJxsz
         pgTbbnpdCjy9mZKVqfFDEa+HysegPoc413a1TtK3J7sINr1sGiXVCs4O/0lfKAtR8Ql/
         Gs8yLoiSk1qV5wRKMFx2bqRWjV9KW9Y95l/jm+8QgrQC9jlWGKeuVr7FmM4zRRLMhl5d
         CjixV3qso1jC2DmRnExmn1L9xWXJtaDAcNEXYo5KRyimGIwgSdAQ2C37fYkvioXaWN8D
         hvxoakwO/6ZzIfb2UQzkacsyeum+2mD07ONzibpT5U7u9BqrQmCSqqB4yxuZjZwFBMJC
         W3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332086; x=1722936886;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biXDfDroab2Qd7CC8jmBCa7MPxVkqgyKUjTtJX/m5Cc=;
        b=vYHPfuLXzFS17EF5HKm6lVzTTpK8rS60pXoa38g3ZJQi0yCYII24LqDxMIMtBW12+M
         IPCLQmKjc0y17aBu8wDD5VJiW62+Lo3WZQd+yOj+qZ2OvbfdyHkP9nN9fQJe9Yc10LlD
         9/MqGS11PNNpTzx+VRE2VWSlqy76tDIw44jHZBRBK2seKjXTFENysGRhMOBATVMtTW9n
         q/ZLjENPzNri1fabaRg5yqyXDA8Z8N7XyrdeTC8uGL3dQU713yMqIrh4DDlRiRy4AC00
         3foEx3zXEKafyvTGrOc0eGCb3mZtG+7dpm6h7h6mRn+3o7/q53Whz4H9QhFDFcX+vBDL
         k2hw==
X-Forwarded-Encrypted: i=1; AJvYcCW7UitFPOkP54hE0GNLYWFGorn0d5MJ8EpDlcC9SCUtMoBmt1cuI/khMdLaJrDoXyfOll+UHqd1fbJUPrBfj0i6KnmS
X-Gm-Message-State: AOJu0YxCInFXHPdu1/nedZUxDspYjtnJltDM5ETwB5xrPfdoA8urQ9e0
	zBYYfZZXR33vKkjAeckKfGU+lSkJ+vDJbMb48AsX+z9xCO5Br/fbjXe4qwD7zsrVjyINVUU1Dxo
	byF1R8kTidJqdCx9H1DMQFU0HPobyag==
X-Google-Smtp-Source: AGHT+IFcLGuLp6dVMjIJuvg3+UZRrU69xHaeAVE+IV3bccjv8bpEwvoTEIvuT/H+N348kU90mA8K61nOCSUbap/9zMo=
X-Received: by 2002:a05:6870:b52c:b0:261:e19:4587 with SMTP id
 586e51a60fabf-267d4caf5a9mr12795492fac.6.1722332086078; Tue, 30 Jul 2024
 02:34:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jul 2024 02:34:45 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <e8d86c01cf1316fabcec7dfacad55e1dc98baa7d.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im> <e8d86c01cf1316fabcec7dfacad55e1dc98baa7d.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 02:34:45 -0700
Message-ID: <CAOLa=ZRJs4USrE2XbPQtqHU4Q7dAWqOkJtJ=OFisMc9Hy3vECw@mail.gmail.com>
Subject: Re: [PATCH 04/23] builtin/describe: fix leaking array when running diff-index
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002d387e061e73b0cd"

--0000000000002d387e061e73b0cd
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When running git-describe(1) with `--dirty`, we will set up a `struct
> rev_info` with arguments for git-diff-index(1). The way we assmble the

s/assmble/assemble

[snip]

--0000000000002d387e061e73b0cd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 58130093bdf51c6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hb3M3TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUdHQy85VGNscEp0emJEOHdsOXI1bFMyVGdreWZmZgowdy9NbUMzYUZw
ODFQQ3pWdVFIUTBsd3AvNGVwTnkwc0NCRlZ5cnlwaFRlbkp3dW5LYW5RSnFyTURaTzNZOERwClE0
R1pxMldpZjVKN3hNZ3d6bWcvY2NZdkxXMGp3WG9leTBZMmMzSHQ5MTc4cVkwdTlyNU5sdVNmenpx
SmVreWIKQ29YWk1PUVRVY1FoWVQySXJJL1pmUm9Vb2hQNW9tVWpuajdqZjdIWDFkcDVSWi9kMTVO
d1ZtYmNlTEJOZUlWTAowejcyMFBxVEVnLzJRWXM1VG5SSXRoZW10OEtGM0pqRWdjTVphVyszTll3
TjlIOUFTdTIwS2JzNkh1SGdERUZKCk1YYXRFV1ppR1Ywc3BmakhIUGNwL1REbzEvQk1XZkwrbTdl
b1c2QUtzSEh0T2Y3TklVYnZad0sxT0RQYjZzMDUKWllHRCtvcVhoekUwdHk5UEVPbEVtNFVYRjRD
blZ4bVdHMUVIL2NyUnJWaUpuZmZUOVQ0SVVmeS9hR0d4Si9rMQo5TU5sNHdaSU1jejdsY3ZyNjZ6
dlk4S0syeUdrK2JzNkZjb3ZFbTgzMXl1YkhmeUw4U1dpRDgvbFFUQlJJd1pXCjM0bGcvZ3ZGV0VB
YTJWQ2VPeWE1K21MaSsvcnhMekVDcFVieWs1TT0KPVlLUGoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002d387e061e73b0cd--
