Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9C1607AB
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754159342; cv=none; b=kR8iNfj0lOuYD0CqCc1aJz1/a2rdHbWNQx9N+yau3WhtQyXnuGbtPcs4F8HbkCFoE1HJSsPOOStlevjGCXIbX7SG2m3968qwEMtuNNOrMAJF5wk0LeqapL8y4U0GFPZladdeQMODM5/D4N0DzJmgqB4fxKlcukYhkYaHirVEYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754159342; c=relaxed/simple;
	bh=iToluMJ+vajcKmzcQXHNX6gAFwi27VV/4kbRzyeJMXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4PMEroOrSbuHmzR5SI4Os0fsQgOaV6QDq1fV7q0th4ZvUpu/AgdFXaaLVYQLt8bHluMndVyKx44yZ6dzgy77DrM11M9idRIPkpR0WS7pZrucyc2DdlEGsr5EfenzxwoVcP4Im3wxQdam/aK65WWH/SWspvXrBdVdvHQ39Jfj4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBkJbm3j; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBkJbm3j"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24014cd385bso24342645ad.0
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754159340; x=1754764140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iToluMJ+vajcKmzcQXHNX6gAFwi27VV/4kbRzyeJMXQ=;
        b=dBkJbm3jGsDXWgXdOGodcJL33BWxaJnIkU6KTCMmIsIZTMrgQMqpWO1HXF50gPgcH0
         YAVAimp+iy1057S+ep4qMWyu2rJAMiGea4fHQrE6e1GZLNduDtqyKFRAeIwVIhlJslLK
         HQlcl+z3dDaJ0pyhJqPvneVDbMTHgXWi1mmeesLuaH8vO+f/Qu56fCKu6r9y/J2f/z+U
         y4HLW+m4evmR4TST63b3D1ZId4uxPvk0v8oDD+1/lTzUz6sNnOP0gzG6WUttt7UTyI6W
         LBbiYWcPQRRY+VAlNCCRzIIPeqpHomqSf6i/VzW/N/f5Tj5TmVE42fFvL0AxP/bijuj1
         6MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754159340; x=1754764140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iToluMJ+vajcKmzcQXHNX6gAFwi27VV/4kbRzyeJMXQ=;
        b=qCdhtV+iJoMEXb/Amnd5cgOLxnbswMVBQobhGbg0X/jbVRfwPYuY4Ein7b4WomIMTe
         I2aGZ1in36bsNUiz6kilKxTWA9aIYW2xa8TCSrwfRml+UcTY+2+l/n+oWiP9NdeWnV+U
         6qVnmS4BrIEBDUZZX483iX/8+mkUtRXweZl1Dtpw4EuR2sL8Ba056a07QjCT12Fvia9K
         u4Lg/mfnhSTPTlgJQbamXnKdRiiZ1Cu0vd9kdVvdn1pIuGv/Xbi7T/HbnXet56XifMOL
         mxfsUltiQ1YFAYBBR+GZMHXB5IVYlzhCPIQdNqSWzORoeCPWfwSPP+VmJg9mrv2W+buD
         bVnA==
X-Gm-Message-State: AOJu0YzrK7ZXfUlAmecKDP9gQlRcdxhVK6sq1pG2kHU8j7e2wyXATJm5
	HnqA66e0dlTE8VSWOsZFjnk3hWdnS1+uQvNm4UBbfvzjWYE/5D3zKj1jXyE7tWUUA0j6OQMujzN
	9m8aL/Yu1XgbaMHLodpewSjydh9Z/9w==
X-Gm-Gg: ASbGnctA9OMjcwy82OF69w05Z1IB5SeePSeq+jAM2rIL9w8Ln+giAWn5H6x4X2DL5ov
	rCQfHDWKUr52GuRxXovbm0pVcG4m6Hrq2j4IR0t/Sukxrr53uLanN2P0SvgYjc/2nJBsPOAEKOD
	GWEiGGj3hUxGRtSx8XdOh4/Wh+U1h+g7kLUqyhFi0hokFcUfliH/gRf9jr6A/etHisWCr+A2aeI
	zZf8FLT9usq7sEaDjhfOY15ev54PQ73xIxRfihy
X-Google-Smtp-Source: AGHT+IEAPTsqdxWsIpVB8IgezxpAr+trcFLQ05P8g8TXs/BOFx+mHwuSLtHII7Olwv2sE08N1kZI6nqCtlxa/fSB4qg=
X-Received: by 2002:a17:902:f705:b0:240:80f:228e with SMTP id
 d9443c01a7336-2424705d7c1mr46720075ad.52.1754159340159; Sat, 02 Aug 2025
 11:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=S_8+LMsSpnRWQZwK2Dj63WdcPy1vp+aJ=erDbf_aaPoU3cA@mail.gmail.com>
 <20250802093226.GF3711639@coredump.intra.peff.net> <CAB=S_8JYbFHJ6WQSyzGO5ns8Fe-NPCdyKjWLmRrsZ1UiZJsReg@mail.gmail.com>
In-Reply-To: <CAB=S_8JYbFHJ6WQSyzGO5ns8Fe-NPCdyKjWLmRrsZ1UiZJsReg@mail.gmail.com>
From: Justin Su <injustsu@gmail.com>
Date: Sat, 2 Aug 2025 14:28:24 -0400
X-Gm-Features: Ac12FXxj_un5HAD4S7gM5kQUFP6q8Keo29bmecjB_wXUC5nuNOyoTU1qPRcXHdo
Message-ID: <CAB=S_8+aDwMNQkawY-Mod35EDm20mi_=xmmwfngU6As799ppqw@mail.gmail.com>
Subject: Re: Fetching upstream remote fails if repo was a blobless clone
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Turns out this was because I had `transfer.fsckObjects =3D true` in my
global config.

I think you should be able to repro if you change the last command to
`git -c fetch.fsckObjects=3Dtrue fetch upstream`.


On Sat, Aug 2, 2025 at 2:02=E2=80=AFPM Justin Su <injustsu@gmail.com> wrote=
:
>
> On Sat, Aug 2, 2025 at 5:32=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> > Is it still happening for you?
>
> Yes, I can still reproduce with that sequence of commands.
