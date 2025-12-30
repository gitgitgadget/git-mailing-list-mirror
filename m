Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1B248F6F
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767135203; cv=none; b=FhgRPzq8GmLDyZvTfGLJR45B+ITW6iAxn8om/cavvKhqx5VLqVXgorxIdtjtJtp+HQx/WkUvW6zi9nmhqDu9q98ldFkNvQL+gLNglsAA1QVuSDANe7PZxakdNglsBBj431VOuxk38p43vuh+gk/RzWRQ9oxCW1QoODiZZEkBY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767135203; c=relaxed/simple;
	bh=q7pffPFvYKIQx+yjZ1SlFsVn51J0rOhYUX0sPNw9wOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKKrHX52ijfSohWvig4QVOcOWF3PHgen8aFOCO+vnSOxiGzZtvpTdrmfixLoK+pTcyppxeAlNXERAo30K7WjopAGLfyVQlL1aqZ3+6yfMa2nHaqRdsYnkWeLm0bXkInIVc+rfvvbVxa1aj2xkvXb4/1fJZPabPyakimwwzk/Ldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGw7+Mxg; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGw7+Mxg"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-65749fe614bso2916770eaf.1
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 14:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767135200; x=1767740000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7pffPFvYKIQx+yjZ1SlFsVn51J0rOhYUX0sPNw9wOo=;
        b=MGw7+Mxg7h2iXoHhsmppqymfoe2ZBaZ7pigScD8Ac682HDMAFMHtFCxO00kwB0r/3v
         +RbH2ROfEbnAi4atUZIYIpEDAIwY+qwG+V5JNYlu+BOvT8kkchR84zEgVhRPZtHrYAT9
         FfuEn1D5qfQyDZz8jdXtM1+v/ogQDeReEoFB81DJIPySUThZf+L6ze2IcvjfuibOmA5Z
         I2RKOlW0/S4IFWqYyIoy0Ynu8/hsPK7g8bp45y1EInTRV7FtJ2jdat683M+5no/aknvE
         u0YrMF60ReAWyAjpdIyuEVxkUH15AEP6l9sRea1kwdGBTYrC54MOQMS1/mgEmZigNTrb
         YgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767135200; x=1767740000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q7pffPFvYKIQx+yjZ1SlFsVn51J0rOhYUX0sPNw9wOo=;
        b=s7p8ecgrhu66PqvU/yh5o80l8AQfa90pwX4BdiqdkxL2RD0iIuRrrVMLA896oDo1s5
         FAEvI8mtia6k58PgVCwz7kh/Qthyic4oV0BSKTrBY8GAWOGPDx9Xi2vqrIBiEwSr+gA8
         hhSnt/086KOoLVFUrmgq3l92EVD093XDOVWCTQ/E1SVmHKFlsKIW+71epUQhA0y/KJqs
         d2IzV273PYXFj7T8iQhXN30U6IUuwZFiH4AFxK8ShUF8drv0j9ufd4Aqi9BEDso+mcAQ
         1xPnRe47wz/trbkqroYDfjOenKk6jFLM5Vwdvch6e/Uk0I6UWuCCItU5eTxTPvsekiWB
         p8eg==
X-Gm-Message-State: AOJu0YylLRgDk//degOIwR5VUiydonFdfWNxRpOWXdVUulw+N3C03V5o
	xO/U/QTur0BleNQDkaJPGWHzxj/fwJXN2PcBkuINE5UyCzQlh/KeR4Lf9MtOtkWxZY62lIXaZKX
	feLwexW3ruIhdn2ZJqPN2P7FTOdpe97WcMg==
X-Gm-Gg: AY/fxX7+JbVU/iX+rKFAaazZgJGfczzPJdyhxI0K2FIWN0xEPLF42nDYYaHXyj2DqY4
	K/8+zbzCV9dreUH5Xo1QblUWu1I9pGMkBqXeNEIH0Zr1uH81DL9e240UiUdXWenjEGprczj51I8
	UV6uI85iRtJkK0Re10D8WQ00C2upIMcI1dDDAmCG1x9kixHpmFo2EgPMuAdGqFwL+Kb3vH0/VvI
	sWxMLH9B/84scP7pj7PNFdDjTW+TuwFrxM2zNgEcCjNR+YF6K2zQjw20axjHLaFoF3ohWh1jxAX
	UxeeZKb/5fLg+yDVCFxsZrT7BUNm
X-Google-Smtp-Source: AGHT+IFJGIgbNyCy99JOYfsUKFRg5kWXjYTU0vOaOs2ZM2bewMyaC7vFRg0b+OOFH2aYHFU1WMws+J+he7SAibo+4z4=
X-Received: by 2002:a05:6820:6dc9:b0:659:9a49:8e83 with SMTP id
 006d021491bc7-65d0eb56b45mr11636508eaf.83.1767135200477; Tue, 30 Dec 2025
 14:53:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_replay_die_descr.13f@msgid.xyz> <V2_CV_replay_die_descr.17b@msgid.xyz>
In-Reply-To: <V2_CV_replay_die_descr.17b@msgid.xyz>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 30 Dec 2025 14:53:09 -0800
X-Gm-Features: AQt7F2qv9cChl0Mp9W00bIXOys2n3CEUbJyEy21_IRuGM_liuFBGwD9TRzZLSeQ
Message-ID: <CABPp-BFgYzZX8jza_Ch0_KOC61iuM_WBikzXyLJuWF69yHqgNw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] replay: die descriptively when invalid commit-ish
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 7:02=E2=80=AFAM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
[...]
> =C2=A7 Changes in v2
>
> In this version we remove some dead code (see previous section), improve
> tests and add a couple more, and improve the main =E2=80=9Cdie descriptiv=
ely=E2=80=9D
> part, with two additional patches/commits to that end:
>
> =E2=80=A2 replay: find *onto only after testing for ref name
> =E2=80=A2 replay: die if we cannot parse object
>
> See the notes on each patch/commit for change details.

I had a few minor comments on a few of the patches, but otherwise it
looked good to me.
