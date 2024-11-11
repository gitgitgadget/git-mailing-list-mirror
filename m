Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F61C28E
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321022; cv=none; b=OE3eCaqrZpKYP7DFwl38deyVMhmgjCTaaY7PYoxFubfic0V30rEMZycaZdNFa0y9/oq6B+3Lj9UdEh0hjLLbPB61YjzAlK6eg81VO/U0lc4rHIXVbhOwFQpZz4ZqanUmreiKwlHr7Tpdm/k8oJIZcq8pwL0954mi4QWEs+MfeiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321022; c=relaxed/simple;
	bh=mG+i2bEhnh5XhLT3ydZjselr7oNfWE6bIf3unlKt6bA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=C0kTimiwXpmHbKvMzhK3zWDHsZRKoc/Po/tIbrxhmS7VTfQ4aagqkFoyuL//Y6SFZ8P5v9GZ6dJKMd6hNsgfivdX+UtEkguRg8kYye9Ze9a6r0sTSE9EgnkIFmAZ5DB77Mn62sau0D/+Aouom/QAXuPF+3OvR0xKrfj5YcrszE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aM6+LF9R; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM6+LF9R"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5139cd01814so1485884e0c.0
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 02:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731321019; x=1731925819; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mG+i2bEhnh5XhLT3ydZjselr7oNfWE6bIf3unlKt6bA=;
        b=aM6+LF9RJQ7WcAl6qnha6KrVZfR62VzYVSCgm+rLtPIeLxK7BsJGqMUZr7uBgR5Gc3
         /ak7iY0NRrrPSsxbo78oRs9LO6ONSAzfAkadGrItqcuGhbQlwtNZJz6lRnkVkMekKh0O
         UBg2y769OIVQgWmF04Iyg4CSKGLUC0EyIe6rTSxaelboi3Zy9VvOfRXT7yC7GVjcVAcY
         NuvE7Pp9INAiaH9uZ3pi/gRGEelEVOEjjn4oDovURFNNIi7B18MBq6KToeH5yxehnI+S
         xqT0LoULPWB5gHr7iZhShhpwXFkP42AGXNpRPg8+S1lPsOEe1ACpHZCBTc147gW1ym57
         vyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731321019; x=1731925819;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mG+i2bEhnh5XhLT3ydZjselr7oNfWE6bIf3unlKt6bA=;
        b=QEqUcKl+Hx17Mk65g4wjVofJrujzqYWD58yXKZ1EZSEafwGP+Hs3+r9aSLUs0Pcceb
         8xDXJg5oYpd4k7QRtcVahK8AG9fCnMIuANHJNry4WGLTrPVHSFTx9y8zx5T8sHUe5YWD
         YiHhrDTfjNv8QRBahCyfYtiDKkc94ktTQy6crvI5vzfOCxSnJw/1AxqOFl/aZoj4u4WS
         A6kCiRCS5noRN1FjakYzVeVfO+dLgpPpZ8wLX3J5HMZ0qPSCueJtK9qeCdRMHdc9M4IM
         EToVkXbXGzx2F5VvO4wkp3spEIUaKovJ0GoBEiS2C5VjTctf7owjEur2K30eFXYazliX
         oDYg==
X-Forwarded-Encrypted: i=1; AJvYcCW3onxnhonGMOfRi3KOxKqP7tuSMISPDsViHBEJm7QXfUD1sS+A7Y/d9rda24uXqmcbDbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQYp5QExnMkt7fDE20R3EF/EB2iwGgFWvAKJjlAqschlMcb0m
	WGKxFawFqmz37xYWIe5p2rYtMVMTHVmriYxjux8/9VjzEfCkgH65msNzS4GhzXbZuXAl8aaUL+x
	0Glmzjmf8Ki0zsrK+Za0LT1sPgDQvSn12
X-Google-Smtp-Source: AGHT+IHQOigye7bT+xVtJwfMizieXI4l6x8cTNDXZkgyYQpgHUzHevM9mSFKy5d+Pd+LR61n9jAREAMFsBQVdjnGoWk=
X-Received: by 2002:a05:6122:2010:b0:4fc:e3c2:2c71 with SMTP id
 71dfb90a1353d-51401ba19bcmr8729040e0c.2.1731321019005; Mon, 11 Nov 2024
 02:30:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Nov 2024 05:30:18 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-1-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im> <20241108-pks-refs-optimize-migrations-v1-1-7fd37fa80e35@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Nov 2024 05:30:18 -0500
Message-ID: <CAOLa=ZQKJ3Twdze-08t3kh=kiuy6h9GfNSO25PkinjTwF5oG+w@mail.gmail.com>
Subject: Re: [PATCH 01/10] refs: allow passing flags when setting up a transaction
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000054af1a0626a09615"

--00000000000054af1a0626a09615
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Allow passing flags when setting up a transaction such that the
> behaviour of the transaction itself can be altered. Adapt callers
> accordingly.
>

Maybe it is self-explanatory with the upcoming patches, but it'd be nice
to know _why_ this change is being made.

The patch itself looks good.

[snip]

--00000000000054af1a0626a09615
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b25de2cf08b578cc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jeDNMa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNE1FQy8wU1J6aEorUTRBU2UzM0hTRTRabm9NRnF5TAp6NnBJa1lXWFo0
NmRxb01GZXUyejVCTVFUT01wWW93TEhpVU4rWE43UHA5THBhRzRCSnQ0anVBWldnQnZpeFpJCkNq
SkYwanJ1bW9sSEU1R0RwSktEQ09SRldRNkhJZVBkajBXd2lYM3NkdFFydWd0aTk1am81YTBhTFo5
aHdGS3gKUklIQ1owMGZXQmQ2QkFTVnBtdFd5QXNxaFJwaG52OUppcVZ0eTZOeExwOWw4TXdEQ2J3
b3BqdFEyUkthbkdqbApUTWpnY01OMjJMbEd4WFhmeklieDQ0QXRHQmtlbzc1ZE8vQUZjbUcyVjdJ
dUpqcURqTCtDd09ZM0hNT0NOa09FCnlXdjh0MldMamNwcmRmY3ZWS2ltd0E0QmNFNHZZRloxcWVQ
UU5qalV4UkwzVlgrMXdkMUlUMzFvSk4rN2RHc1EKd3NPNjJqL0ZwL1NYNDlKd2FKcnVNTW8zK3Jp
U3Y4TU5PMmx5bHZtTHpBckRQR2g1dy91ZGc1QTRtaHhTYkt3dApFYWdjRDFvQm5laUhUWkQzN0Vp
MW1vV0lrTCsramJYL3VyRlV0QXduZVl1NEc4R3lkU2swOEIrQnZwdlQ3a3BFCmhjUDl1N3h1S3Zs
Vld4N1QwbWd5OUJOVm44R0puTzRDdVB1TnhORT0KPUJEeHoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000054af1a0626a09615--
