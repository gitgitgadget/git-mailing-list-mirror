Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA77E163
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742742355; cv=none; b=YAIhcqYnF3l3CD0cuQTy0Pczl1ieDgze9VEbo0GtcJ0l2L2J2GASKaDEvjkY8EMcNIPrkZG1wot+QEU6Ks6aGZkuI7i6r5fJJNpX41Z0bbeR/5UMFY+hSixUb23XQ5v5aSsBdN8049Ietw0fRuLKQkAfI+7wehHKQqoBJIFBC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742742355; c=relaxed/simple;
	bh=akc0069l0LrhHaURhcXpXcYqB+hFbMvyGbp+AADfBnE=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IZKBhzACC1XpGWTxWqyFFslM+auBtdDvQghKwNNnRmC+MjDX6unx0Joyjwb3hAsu8d/mOy5EzQOPPK8jHo/pDDRB9pe/GzSpyLA4LmH5jH6SYP//6lF5FRjFFOO5DhEWTQDfCpH8bYIKVNnr40aVpp/xzR6/YpaSElMC3JSHyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwnWe+5Q; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwnWe+5Q"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso567232a12.0
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742742352; x=1743347152; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxxD+eX7wFMaMxVR9BqOaaqJrpAWdquYiKPYzQ6rm1E=;
        b=jwnWe+5QdZ47JsqXHgtOgX9cnEce95DPLmnFQve2vO2QOgkHhJV972s7befMBKfjpO
         gZXbDPs5OLr1dcQ006aJTCXQWFjt1spvuTVXUrEEpOi5MwtYmWvCTlq0VHf8X4KfkKiU
         P2fixJoiQlzrdvW3i2nyWEP4vNboqxeJcFIysk9ZSW1VsJLl0HHvWXA8WSuLnpbagc+w
         0ZNERLgHEi1VaFVJUn69K7gMYkTKc//Q9MF9UCTcLj08iiscnju/FguGhNg3D41L+CaL
         6FB895khsWk9/R+2tl2toEU3UPyg++Zterwjh7vv36cQSpKAhl3amdm32FvtYfxWz0Gb
         BMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742742352; x=1743347152;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxxD+eX7wFMaMxVR9BqOaaqJrpAWdquYiKPYzQ6rm1E=;
        b=ISRGwSw7ajhpM8PR9mazGJfr1AdaJXHhP8ulikQHfX2MqbY6r7vo4+YJPUUhsciHth
         0kqUFXKpIa/PsuBbIcVdeHPcTPwCyF4yvg4KLR07Y90FpYcl8uKCFF3FmyEoKLepEKJN
         sLXaJKbBJYJK34J9yW1DddA2Z5Hp9dDfNKf2Hd6PXgsJo619Yo/U/pMGk1r01OYw4xGW
         l2Hc07XGInx2eS7e+Pk83gfbVwSoyk3PlAygPWgTVGOJ09JB0BVcsBxs1hHCTi+dYnBA
         Y/YVzBKQD++QXzaGgn1OJI7G9jerMTEG1UndSz93NIqnyjBSiwPe4ixIV8detqfv5SoM
         e/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWTo90ZsW/TGdoG7cTF7sOZRTVvT9Mti3FqSoYm/dAZX9B8qP3laJE9zuFfAPBvykTyRF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzB+Bm0pwRfzL3OQnFABNv9OOAaZqdLFaJCJ8kbKQIeqdQaQS
	1qxgLpO7K8yUYNTpTtCKIXSR6CX4CCc4Jw+YouTV8QBKV05maCLV5FdTUoPAkQ==
X-Gm-Gg: ASbGncv00WF3kvGKqqwI+Ej8KtjjGOZ851y6GvYN81XVFFVvf8sdHJhiCl9mA11y6ZQ
	0cXZamSigFpDZxno+TH8xjLUBabty53ie7Vbgebtd5o3iAJ1Y/fQuhf1u/ZWwEd1vi5W5z7HaiG
	Ev4KslP3y0sXSHQDAjzMq4NFatYuPAN+LVROavO5REJRw9o1qiRAx6vsy4E00JEcwgpjxHnOY8f
	9yZXqm2+4VVtsGC9ft5m5XiqwcrINIB4XNhF6jlM6W/Od0kpI2zcqNOTio90Xj/KC1EWapHVsXI
	TnxNT20A4ey1khDyO5Y5icMpOVhA4vgVvmIjfk1KUuVyqbIGn3nZ+8ueyv8nX/cX7TOwsVy9jQ=
	=
X-Google-Smtp-Source: AGHT+IHcWkO7w8ma4EAFmIdwAHatmC5l8kLIPFw3QWLv665epPZO06xFqbe6gz3EvuL8cR5A+6mwQg==
X-Received: by 2002:a50:d586:0:b0:5e4:d52b:78a2 with SMTP id 4fb4d7f45d1cf-5eb9a310491mr9455833a12.15.1742742351667;
        Sun, 23 Mar 2025 08:05:51 -0700 (PDT)
Received: from smtpclient.apple ([31.167.7.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfae189sm4587809a12.37.2025.03.23.08.05.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Mar 2025 08:05:51 -0700 (PDT)
From: Ayman Bagabas <ayman.bagabas@gmail.com>
X-Google-Original-From: Ayman Bagabas <Ayman.Bagabas@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v2] shell: allow overriding built-in commands
In-Reply-To: <CAPx1Gvd+0XBVm6N6Vrogczhqy8hARajoQ+zDgaaeKMTcSskmeA@mail.gmail.com>
Date: Sun, 23 Mar 2025 18:05:38 +0300
Cc: Ayman Bagabas via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Elijah Newren <newren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11DFC309-0D48-42C8-A683-F5D0C30810D3@gmail.com>
References: <pull.1930.git.git.1742637713157.gitgitgadget@gmail.com>
 <pull.1930.v2.git.git.1742688740650.gitgitgadget@gmail.com>
 <CAPx1Gvd+0XBVm6N6Vrogczhqy8hARajoQ+zDgaaeKMTcSskmeA@mail.gmail.com>
To: Chris Torek <chris.torek@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On Mar 23, 2025, at 4:11=E2=80=AFAM, Chris Torek =
<chris.torek@gmail.com> wrote:
>=20
> I'm not at all sure about any security implications, but aside from =
that, I
> suspect this:
>=20
> On Sat, Mar 22, 2025 at 5:13=E2=80=AFPM Ayman Bagabas via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +               if (!access(full_cmd, F_OK)) {
>=20
> should use X_OK rather than F_OK.

Good catch!

Shouldn't we also check for both F_OK?

>=20
> Chris

