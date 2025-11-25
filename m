Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B52F7ADC
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764053364; cv=none; b=KFixmfjU6MDSBOO23mvfEzngE17dpYTxQsxBfd3JpofW8wbMgj2auSq+H0JhA3BUD6jq8T5Ei1RZ3MwsAJshiwZkZKh7iMzw7hS8IspmErnzMl8eFTu0lpSaexiJFQvDs363qtmVpgcRhD5yLtCpUD/SXYEFERytre+XezojzjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764053364; c=relaxed/simple;
	bh=q8a17dUXr0HMl6dlodL8PTsphyZXC41EFckKv1m1Roo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJbtAOGvo51Iu9INGhZMnTfVtGTpYiEHiEuZ5+2iFGh8d99zowiutatvqQPCNzMz//vHFLh8OWF3jw07fHPYYAjdX7hsBfrolBGWHp7JYJRYjdBaeWHK8TkcYjrqvgefidQvv+IW4IwwfwMutdcLbVTM6pjzHMeDLNa7iEDQMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oj/+fcpq; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj/+fcpq"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-949031532f9so222802039f.0
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 22:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764053362; x=1764658162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcuAyD1QAwELU8ilgmJVp0KMiWvlFbrv+ScWbdw2GXA=;
        b=Oj/+fcpqtcSVxR1el8s0OLV6hHMc5DFIzoqt5Nk6cBww7fv+4PZpQameoY9pC1BuDE
         Ub61Z65sHT1WopWiWtgThan5UNXRFr1es1x71VKuxjNIKUfCYfi7m//UEMUPnfRjch1v
         UzaFC9NfHPHARVPOri3FM/p+BgkCE2nVJDdgetHNaTTTKo63RufXg9QYFWVu4D2Doh/a
         /ibUIoVQ0n9u2cSy8d7Zn2Z6jVZ0a3JmSZCtAQHcA82vs13OrHPnN302ahzGxD4yiDs6
         Yn2S5PNtfvFib2lpZe2CShf4KkWRcKnuspltSYOECs/nS9FcMdcQ6B4M5rHsv2Hb3Ze/
         Wrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764053362; x=1764658162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZcuAyD1QAwELU8ilgmJVp0KMiWvlFbrv+ScWbdw2GXA=;
        b=ry9R0II4vbD4x1TCEkMPpiUlqtCum/ULbFVZvdZONvuXTJ75y9/0mF4LA/Bos0Ptlp
         tf/f5pOqCMZqVLmwST//qcFp/9GF3QV/LQ6jVAHZO3Ddm2j+NTLdD4Lz5PpaEBvL563h
         +KZ4LXCNb6K8nE/mb76ho7D5lf39z3dNEn+/vOJVS/9zmFLVTbNn/lmuH5+Tx2Z+Ex0q
         nUSHFfKaqHuKwn74ZHvcvupmGQWoDGyHBrXvIzGaQ1kPydUBiHdxthuVC9CoweZNsTC4
         1W4woHauvfV8opYFcUkXJofT1T1JjPCkU9l8nOj5eawXOqimioy8gkhC+Zcz7ieUTEFE
         kUxA==
X-Gm-Message-State: AOJu0Yx+GYFXdFn1/6rd5n0fzdNOmHeY4G9um7Auoq42a49faXa2c6AV
	MRSQB2mYgtWlvU7guHH9jRC5cJNauQFkS4U65JHyWT6s2x17EZExpyiChtBBNTYFnAUX2GWwTDG
	zbvVH9kJ6zUQrU/2sDg1Mt1Wn5WcHkkM=
X-Gm-Gg: ASbGncuR1ztzk2e/9txsN1d59+fz/imVEo66ZHzxKsqLBrirxnZ1LR/6GgSLfFZzlti
	1sDpglnysklY1N8aKzOAdBezqqB7RwBcYanXz3RNcOe7AjhxHJFFaZirU1HnXyZrwRkpyZ6VqPM
	LSV/6S4KLHBkRa4PAi65VKQ2l6S38Xo7z5SxPoot/IOdgpdIuo+QkGaNJ0gOwEoTyetB7nmqlxY
	+bV88AXIIQddaIaU7TPkY0mxJOf+LfQ8Uf9mZ6K0uNhcNc9vl+mp3CYmwNmxuayc+/ZHGK0r95Z
	Dh/cxY+0b+STFa4pj2EU61J42PolfLeAtwK4Bg==
X-Google-Smtp-Source: AGHT+IHJlqJx8xKPg5uxyr3Ztkrk/CnisaVtR4zHGtxpGqX15LRiWq8YEWaha8VUrtY67XURqjVM0VGivTjcs7yZ3yc=
X-Received: by 2002:a05:6638:8721:b0:5b7:10ea:e2a7 with SMTP id
 8926c6da1cb9f-5b965b1af7bmr12026558173.8.1764053362009; Mon, 24 Nov 2025
 22:49:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqv7jacvdq.fsf@gitster.g>
In-Reply-To: <xmqqv7jacvdq.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Nov 2025 22:49:10 -0800
X-Gm-Features: AWmQ_bmK2whb4efX7IgaCtTdWLoq6sDZembtwxCX0QkneuyFaJV2p_8d16xtsTA
Message-ID: <CABPp-BES6HBGxXKC9sfBHu_5oBEDYD+aDquHtoDSZtZdaqOMBQ@mail.gmail.com>
Subject: Re: [PATCH] submodule add: sanity check existing .gitmodules
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 11:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "git submodule add" tries to find if a submodule with the same name
> already exists at a different path, by looking up an entry in the
> .gitmodules file.  If the entry in the file is incomplete, e.g.,
> when the submodule.<name>.something variable is defined but there is
> no definition of submodule.<name>.path variable, it accessing the

accessing =3D> tries to access
  (or accessing =3D> accesses)

> missing .path member of the submodule structure and triggers a
> segfault.
>
> A brief audit was done to make sure that the code does not assume
> members other than those that are absolutely certain to exist: a
> submodule obtained by submodule_from_name() should have .name
> member, while a submodule obtained by submodule_from_path() should
> also have .path as well as .name member, and we cannot assume
> anything else.  Luckily, the module_add() codepath was the only
> problematic one.  It is fairly recent code that comes from 1fa06ced
> (submodule: prevent overwriting .gitmodules on path reuse,
> 2025-07-24).
>
> A helper used by update_submodule() seems to assume that its call to
> submodule_from_path() always yields a submodule object without a
> failure, which seems to rely on the caller's making sure it is the

caller's =3D> caller ?

> case.  Leave an assert() with a NEEDSWORK comment there for future
> developers to make sure the assumption actually holds.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
