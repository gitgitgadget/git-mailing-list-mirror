Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE33019C8
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168048; cv=none; b=LP4RwDtpswAt5nEn0TmPCQ0F7yFcYF9Gej975Ah+p916pWhweSNvowX3mEBhsEXx4mIynrNG+YqMxYUPUzEYw94GNG64bSPFP2HrrXhbUzlqrGesn8MP+vQ3FwGayKLxeI98khXc58orTKlR1DKOZW+tWmj2Kb1jdBMRC+2UmVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168048; c=relaxed/simple;
	bh=6uYDgvdPqlUTUMvxqaNtjxzjEKQ9oTYceVxem4Vgnf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcxJomBO/q5j1j/M/Es3DHrLeo8t2il8jOjVU0q6+sWY2GZtkAZVp1ysRumYl8gNZRbTFdimtkYYs4ZuNivpz8g9/RpamjpWbFf5Jhe+aZ/zaSK/fMHam4xO4gs8TYYEF5D/Vsmci9946CX6cUwj5WIKsHo5B41uSpTqQqDhms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNH2HcRv; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNH2HcRv"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430c97cbe0eso1326715ab.2
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 14:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761168045; x=1761772845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uYDgvdPqlUTUMvxqaNtjxzjEKQ9oTYceVxem4Vgnf4=;
        b=mNH2HcRvWtnyCpqWj6pbmRdCuQ099Bq5dvjX8mBo9+sFnX1rTtDYEXb649z2JmAcK0
         /1sL4dUIu0Kd1xLVRggpwefg7XDezBZB1FORf2b+p41NZbwXp4OEB4FJ8hRoN6lgYpIW
         qAtSxJ/MGFFeh8XgxjDD2yy09N8Dy4eXr2gVcsqiVcakEqPoE/xEXRi6GcsaELBOM328
         zFVtRqwRbTeHI/bUHk/jz9CehyYAhZo5bBdwB0jvVJc4eAIxbmjaOWQBcHDX9Ochzpgw
         3Z0Ac5Bm5g4/l6pIP4ZQbEQ2GHAzEmOGU+p5g6O3MlvkMM/aBVEt6VlYHUaY+xRKPA2A
         nBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761168045; x=1761772845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uYDgvdPqlUTUMvxqaNtjxzjEKQ9oTYceVxem4Vgnf4=;
        b=cslGQxiqAAsmx4bZSWXZQDGtqBvVjWcJjqHqb51yAWJZS0UMJB+hNLSPAcDIyNlwGE
         d2l0kRDGa0+vyt+qN2ba/KlQPruEf5VS0erpuBooUTn3UbdoixD5dZ9Cwzv79CdD+Ruy
         jJ4DU39PnmgwafLxAQTTwlgAU0tYwTrslAmJwTCnJLk+gCvsyjmex8+jJYHAFKYbmqut
         VRaTbEklR4QGZSXolZcTNSZ8RFSmOV45VordBy646MbmKFm5CADocP3OhXJbFvo6JSWg
         22JZ7l8JZ159iAtFTxr7zPHo6zJF+BqbCj1O+52q5HScKaWtc4VOQDXyvr6NeOH6BBE5
         WH9A==
X-Forwarded-Encrypted: i=1; AJvYcCU3b1DgMMR2PE+LwpeIj0FNihKq7VyU45T6hN0YWRPZnC1vKWvvdnoviL7qERgoQP+5UwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyux24zyb6g1URHEjzU1VLtA+VxA8FBMk9lXPYV0j+uXsrxeskX
	X/DmguQwg5l6qV6Yk1KB9USyWvII8vgx4KmO//SLWEoJNInr+Im9g/SApNq7IoaG6LRjvTdrXiE
	ln+J9tOu+YH/XDaJCuLbruggYlAXJmRV0eQ==
X-Gm-Gg: ASbGncuBRhdU1fUglyTLD0VAoBN+ymqt8vXvALUOlH+57Q7McQUtX88ikBaDLZrafhQ
	Xyhn7Q6WrKCdtTtkEHx6WIc6SxLJrp8gQq2hCMEeN0sFkWF48FXItkAEXUhLpclSZzpW6oBbasa
	KuidHsZ0/UlT5CMpxIlErQYN1ghya7Kg1X9Xbp4zMVVhQpM4IM2He9Ew7q2dejLWEyAg0rQrZAC
	OJDaXjUf0n00hJoA+Uj7i6XVxpvvbxbuQ8bYV7v18D2Hmqj3amhfB5MSfbnmav+F9Ta3LZi
X-Google-Smtp-Source: AGHT+IEkPPCsEH67fwwqwF7M7dqEXLSkuM9gqKhKjAOB6Tr8wpn8Uxep9e9gbKWQ8mUUvSE5IBicq5W889C5vFBk+8c=
X-Received: by 2002:a05:6e02:23c6:b0:430:c600:64b9 with SMTP id
 e9e14a558f8ab-431dc20f667mr3287765ab.24.1761168045630; Wed, 22 Oct 2025
 14:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <7fcd83c99076404960302b64a4f0c8fa1c13feba.1760563101.git.gitgitgadget@gmail.com>
 <aPdFbPN-60MVo3cv@pks.im>
In-Reply-To: <aPdFbPN-60MVo3cv@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 22 Oct 2025 15:20:32 -0600
X-Gm-Features: AS18NWBJD2_X10A36BgEnI5vNanynNXwb0OngWfN9l2nUPegQ-0-Uu86yjfCHhw
Message-ID: <CAH=ZcbBeDNqW6PqhhzU75wttND86RfMRuNS2ga6KP1fN7AhFnw@mail.gmail.com>
Subject: Re: [PATCH 4/9] xdiff: use unambiguous types in xdl_hash_record()
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 2:33=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Oct 15, 2025 at 09:18:16PM +0000, Ezekiel Newren via GitGitGadget=
 wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> This should have a commit message explaining what exactly you're doing
> here.

I thought I did have a commit message justifying my changes. Maybe it
got deleted through a rebase. How about a message like:

Convert the function signature and body to use unambiguous types. char
is changed to uint8_t because this function processes bytes in memory.
unsigned long to uint64_t so that the hash output is consistent across
platforms. `flags` was changed from long to uint64_t to ensure the
high order bits are not dropped on platforms that treat long as 32
bits.
