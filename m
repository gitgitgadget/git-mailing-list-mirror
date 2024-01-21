Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D2F3611B
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 04:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705810154; cv=none; b=hAtGZyU8d2xHBLRGOqkdsW976+WJ2Hz7GCinHc36C9Z+u2YRaMYakMN1I7ttQ5y5J34tZQn78xjBAVy+dh7iDXv4Q7ePRT9dPuTqT64KFpLpVkoZl/U/f4etVvelzlnQVtfJM4FYInnyKURpmFKv3LyoTPLZIPPIVQrvBhoZnFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705810154; c=relaxed/simple;
	bh=Jv87m7e/BT+lYBvI0C7tGcm98+sc+l2mp9n5XZSK/Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2373WEVWEbOleDQN+dwAQyelvYA6ZPSMc3wV71e+zTd7CA9+7tdRujjjW4qiu96lutY+QXOmmohEyu7urbeCCAcED59pHTaa2zHd//6Me3XUVLQH6h6+jkQt0jSz6MLcfx9EWnWgFojBkIbmLIaOVZmsNb5ztVZj26kmA/mCmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFfhe0BZ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFfhe0BZ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5ff828b93f0so16092397b3.3
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705810152; x=1706414952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv87m7e/BT+lYBvI0C7tGcm98+sc+l2mp9n5XZSK/Sc=;
        b=cFfhe0BZop/ai/Mh1bTO0aoAiyQB04CGPn0X2YAfn8Yds6U8un/rThQIMWH8AWG29H
         4sxQbWsDySSSuQmH7dXusWDGO4G78aX8UjgepIFgvyN+WPSmSLS8M3WmDPkrj4gTlhZp
         ihF+T9UQK5yfJr2gKqYPDHDKnKSMkKjKsDmlkfu6/zPbWaGQKNp6KMjNNSkNFCGE0SBK
         x51j3qf0sfnH9AGbYrZeeuve06i9QfOJFf67OlTnMIslSvBO2XS738WWazmUn5rb274L
         ikO2v0AQS4A0T+rb+R6O2aY9cT6XcUG90fZmy5btRxNfmImpgFgoW4QZExGecG7yTZXX
         ZSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705810152; x=1706414952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv87m7e/BT+lYBvI0C7tGcm98+sc+l2mp9n5XZSK/Sc=;
        b=UnYFGWRV2ijdsSuusbA6J2kqU6XluZgYjNGRwamWboNsKcEBUby7ecQ7IDf0QP25iY
         6BHYP3OSEFsOr3NQZjgn/meQDYWzylJKW/GRCsk751kSE1F/BX9oJKxGFBwtQJEAsxxO
         xTXK5ZxiduNi5nTVK+pbex44rQexupWMUNvpdlX1EwDTirMBPK1Fiq+SEymrs0yC8sb0
         I9NSAoYPUXZpRFN6WI7rc9/eFw8DWIhFRjTMQP6StlOZo0HLDj/ADecbgZ3acZy0Rl9a
         8LslgZFinN9j+fhcBgJni4qG35rQiC4HXS6jx2KuSao/fQnRUf23YxroZxy4sFqF+hwd
         Ze2g==
X-Gm-Message-State: AOJu0YxfY0KpCaQkKT3LX2Urp1kaO+lTGeKrUHu/hZX+C7TbLe23I4wU
	jCN9ny68cY+amqjJZ4ayzNx6dgU/HcGN6z/NH3lRAOSfCd9M+6uVlGUfkNF5lAptHM5MrZ4dv1D
	Gy6hK2hr4JZaCZA5InbQ0CcMLedk=
X-Google-Smtp-Source: AGHT+IGdI3bsG7MRP77zd4tHev7sdpFTfREgvwN4bCHAxIBd4GCX1IfkqjdR5S9rWTsZHJzm9+RGavygb2nRUs2VMLU=
X-Received: by 2002:a0d:ea93:0:b0:5ff:e1fe:d083 with SMTP id
 t141-20020a0dea93000000b005ffe1fed083mr64321ywe.81.1705810152201; Sat, 20 Jan
 2024 20:09:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
 <cover.1705411391.git.zhiyou.jx@alibaba-inc.com> <owly1qabhh19.fsf@fine.c.googlers.com>
In-Reply-To: <owly1qabhh19.fsf@fine.c.googlers.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Sun, 21 Jan 2024 12:09:00 +0800
Message-ID: <CANYiYbF63Nc=ehHmp0c3K=Xa9qrzzV+K-5u5KR50pDy3AuDS3A@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] support remote archive via stateless transport
To: Linus Arver <linusa@google.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 4:43=E2=80=AFAM Linus Arver <linusa@google.com> wro=
te:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> This v5 looks good code-wise. I've made small suggestions to make the
> commit messages better, but they are just nits and you are free to
> ignore them.

Thanks for helping me refine commit messages. I will update them based
on your suggestions in next reroll.

> If you choose to reroll one more time, one additional thing you could do
> is to use the word "protocol_v2" in all commit messages because that's
> how that term looks like in the code (unless the "protocol-v2" string is
> already the standard term used elsewhere).

Will s/protocol_v2/protocol v2/
