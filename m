Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92EB1DB95E
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169885; cv=none; b=AzCMLodbty2vaWSLR8z9vcG29kozZ+Kpp+vxU/SzfENqRCLfbHmB5cLjIeXJXVqMKXx12k2ievZ5U0yVDY1CTtJ/wymsLZ+MFoREmOYt/hxT6wKpdL2j6w9HMq4iXwQfiEJpH/LMGupFHxkOTtyqe0YMCt8yVLgZV6ijsflHauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169885; c=relaxed/simple;
	bh=+7Wx26JRLubrRKH1wuCFJsy29oBqAoFdvIEI2dJNY5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rh64uI8HaIUPBMfmozs7OsyitMp73cPIYsmZ6lHotum4sThdC14tXo6ZeiP7xMO3eNeRI8H9h5Kpn+/BgX3KBMfyYXoiyx3RIvOddaNfCGb1pahlOSv0PwelP2RgIb27NzGwvlJxm58yKkpc3jvCVFbIQxX1OmyPoEPqqYBEFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6iHfr84; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6iHfr84"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d34030ebb2so9141642a12.1
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 05:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736169882; x=1736774682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7Wx26JRLubrRKH1wuCFJsy29oBqAoFdvIEI2dJNY5w=;
        b=h6iHfr847nmu5y+17kORb06Q+0IGgfPLSaqXgm4Uib7nsoXY2cZ5UaIolU5XGiD9Xt
         IHTqGmWtt2IBjpR+AQsbWzpzf1BTD5HVZN7aLGmSIfeoXjfuM36MgviQCHuiYv2JD0QG
         w24iZrbXI6qSBALTxHJGgFdx3eNzLLolJkR19bJc0fpzQAYvG2Mfg6zUcpZc0z3GOd+F
         3UEOPzNEJCkiaX+sRyAmadEaCt/4ufhHoJ/06xfTbGos4mkKRpDuVbCYiCViAX+J7eET
         DMxL03YXFjZjj5JJt34rAuTfJ0Ct8W+M+AJr7KGK++XK1HphlwYM5QpldvWIgTOkplqt
         N5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169882; x=1736774682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7Wx26JRLubrRKH1wuCFJsy29oBqAoFdvIEI2dJNY5w=;
        b=w4HwREIUtSbEXvMByRDzFOoB9GwZX/ynElJLUFEJmZQfX8ce+S7OICr/yioS2popLu
         a2YqWl1YDCidjpUF+2Ei1c6lN9YZTx9kzWS6opCJSCQWv1Sfj7T/LyTA/4Db/RknhJCA
         4x/cvhAe8/94K8uHZUufCbuaoj/a/AOrjey6cfDVJutE2JoVcXHPLSXOhCFxMVdBI32m
         nJlDdbIQAuJtLRjqMeT30hMOja3Kpvh0WbATkKS3ubbWLHeoyA1/bha1k+/fpvrOGD9f
         z8hhuEj2inrxqwhVUn1sH3L2tAHnWlvWiDmHNyWJMMKwl5oX1n+tMaoKQYXBeFsk+Y3/
         V7Eg==
X-Gm-Message-State: AOJu0Yxr4p36pvyyqHvL6tj3uCSCsRIJQ+kEJ17bwMiIGJ5EX4iiw3/M
	XZZJZKYi52Y2M7yaqab9FXxUswH6mZxpqqTW2OvBLX+KsmLOUltJXMqTp3uwnalSNfFYNpBScOq
	sXqQgUqy+LdhJhd/9UJ//3O7oPDMX+lv1
X-Gm-Gg: ASbGncv/KnLZrdvuX6YG5OB9m8NGZzPwQVS3LNaqkQZuUJzwIWHH4tCA41kFHMoSkQ+
	X6v6GJ9h8XVJ0qycPl9jS1svuWsPKk8oNbMneblEC
X-Google-Smtp-Source: AGHT+IGuXPyK2NNIYSe/Abzgm7nPvTSUL6Q3PEvaR1gKQt7Au2/PdZ8j+gIUcacCi0T9lJcwtD02jatpOVtpG/UOPnM=
X-Received: by 2002:a50:cbc9:0:b0:5d9:b8b:e347 with SMTP id
 4fb4d7f45d1cf-5d90b8be375mr10403864a12.32.1736169881845; Mon, 06 Jan 2025
 05:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
 <20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
In-Reply-To: <20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 6 Jan 2025 14:24:30 +0100
X-Gm-Features: AbW1kvZtUe3IhheHm5__4moy1iEPSsLSK56pVqLTO_NfwORxnVrBTGr1PTn5Ux8
Message-ID: <CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] remote: announce removal of "branches/" and "remotes/"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 8:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Back when Git was in its infancy, remotes were configured via separate
> files in "branches/" (back in 2005). This mechanism was replaced later
> that year with the "remotes/" directory. These mechanism have eventually

s/mechanism/mechanisms/

> been replaced by config-based remotes, and it is very unlikely that
> anybody still uses these directories to configure their remotes.
>
> Both of these directories have been marked as deprecated, one in 2005
> and the other one in 2011. Follow through with the deprecation and
> finally announce the removal of these features in Git 3.0.

What I like about the removal of git-pack-redundant(1) in the previous
patch is that we started to emit a user-visible warning in 2020 and
now users even have to pass an `--i-still-use-this` option to be able
to use the command. This really makes sure users cannot ignore the
fact that the command is deprecated.

Accordingly I think it would be nice if we started to emit warnings
(that could possibly be disabled) when we find a repo still uses stuff
in "branches/" and "remotes/". These would be much more difficult to
miss or ignore than doc changes.
