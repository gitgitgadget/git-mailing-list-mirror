Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD7523A
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758325047; cv=none; b=J9NxfOLY23D3sxUdrTiQRHyOWYIyNbkza+0R29krHD/PAFU3G+MqE3pS8tP+3LFqiddk1KE98uCrBlWEJtGW26Q37NRkNpeGq05AUQswJfRrHCHrb4kFL761Yg+qzlW/+9pFNc/sbwn10/j0+CosootUJew5Cny4iVKNdDQFq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758325047; c=relaxed/simple;
	bh=2/dovq+SXXdXo4w6SOKH4HMuCyhZQB9wYggbEm7yBYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmFhvZ2eI5rDIO3klczVrIhs7J6eGn9CGmRN2iDCsekLtK4x6ptzhZhZ9wvMrlmlejXcRkOkZAby20nDDSDJ7SNXPjmAWm5joUOy5hNoDToge1AegAtstCEa3zhnLLe5MMMVBCKqB5KLiDdirWDUo4PIRxFnFULxy7668mTpg9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI04k5H6; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI04k5H6"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-351c164936eso24865911fa.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 16:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758325044; x=1758929844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UYpx1kB2fe2MsnYFvsp2Wxau2kC/VylYSCaEWBT7bg=;
        b=CI04k5H6W8ihiMQZunK5+s358ucnWslw2q3KxA9ati69ZF34Bp4b8QSRsK2N3RycGe
         O1LvMzNwWOT7C4NXbMtc9JmsDuf18u3Zru7/R1t+QHARos8+dpS4p8oqbiasUWaCN1ht
         f5nXb0eWsttzz1o/3VvqK1fczJkyHngs3OCME6oYBdSD2Z3smkxVylQYU6hSi/sSuE3t
         XH1A2VqejwVc0kKcFbAFasuvs2TIlOh6qwFD4BEXFDBzGwT5M73yzgNqLwUwt80syT6v
         4N0DRNL98JqXYiIyvxr9WaDFwTOlZsk1BJF88xmltibnJGxBx8pyKUM8JI236YCfcKqR
         qz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758325044; x=1758929844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UYpx1kB2fe2MsnYFvsp2Wxau2kC/VylYSCaEWBT7bg=;
        b=WVuxkOTUr6ftNhUx43TXcn45lyVXc4Q653d2rdl9lrgl9+rzQvb52LaqJjPutGRXpw
         cJJU+Rp9Tk3PMH5zxwlg/OLMftpSo8TIi0YzLZpjSXUZGUTMZdL3pFnVMLipq6zMGAgC
         qIe0ZwjLOTTyEIFc+199m2wUvfUQIZLZ1Oii0uNDugcJbK359lB/I+Kmmrh45NRRA8GS
         7BarIs598a+ESbdn2t9rcvpvS3AUsjfneEu+Vzz3h35K97K1O0tbLvbmEDNfklMKis8B
         ENG8USlGpBLRtbaDCItK6wg+AhOp5xZ0QIPubmrx3OSsJpZtRlYP0zvaQHYMo5MhTiN4
         jMKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRoO5uYCFxBivttzmDw9d8ILUT9rUVRUojoTb8Xv8rM6zno8Ymv8YFc+dWsP1TgaQJKc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwDSEwm21JCC862jdmpLPfGWzP+B6sc4Dq7e/50b9QuNl10jdk
	MlZRN3j8/sIBQG3W/YeaTLdPf9Xyb8EZgoMXS0Yj2THcMyYJXeo7v2WJ3h+OoOuTnUD87V5HcY2
	46L5KJqYGPykSGM35OkARnHMesthkGyo=
X-Gm-Gg: ASbGncsKP0FvIq8frXRNQjil/JEwVMbn6nZAsCRW1Fl82Wi3vDhj1GIwGXV7jMvsMxZ
	E8LKQ1LtmLFUoUMCqGV615lmwm7dKI7pXYoH7HgKsDGIduBIswViM12pdTKkyZtEv+6aeDHRPtv
	ctFml2muhyux1fwCHSjwryy/s4ie+voVnVP52Eat2XjIw95a+/Uhgv+jOWeba0nWMXQj6SYOaIl
	aPiZiuJ
X-Google-Smtp-Source: AGHT+IFcujMJlruGlVyTL1lwwTXdFdGAXhVjAxximiQpbzsAPn+Q/hFJ14gXNi//a8nf5smeiQBM6BoUT761RHm2q/s=
X-Received: by 2002:a2e:be13:0:b0:336:91c7:535d with SMTP id
 38308e7fff4ca-3641cd06e1bmr15762601fa.45.1758325043701; Fri, 19 Sep 2025
 16:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com> <CABPp-BEjX6Nw90P=sgaSVrKLJX9HW6A8P0fyadBD0snURc10fg@mail.gmail.com>
In-Reply-To: <CABPp-BEjX6Nw90P=sgaSVrKLJX9HW6A8P0fyadBD0snURc10fg@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 17:37:12 -0600
X-Gm-Features: AS18NWA0LGQvXeCQZy2ylg0l-yglZZLu9y3A7pIr9yhJkdEv1qdWgUywE4n4nXY
Message-ID: <CAH=ZcbAnkrVTB3yi203t9-yq3LM+ucbvtu6Hh0Sp20YU3FeQZQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Cleanup xdfile_t and xrecord_t in xdiff.
To: Elijah Newren <newren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 5:31=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
> I read over this latest round and it addresses all my feedback from
> v1.  On top of all the nice code cleanups that this series provides, I
> appreciate the new detailed performance comparisons in the commit
> message in patch 8; while this series as a whole doesn't make the code
> appreciably faster yet, it's really cool that you've highlighted
> another potential performance optimization (beyond the hashing one you
> already highlighted elsewhere on the list) that we'll likely be able
> to realize once you get some further preparatory refactoring done.
> Looking forward to it.

Thanks for the positive feedback.

> I think this round is ready to merge to next.

I agree.
