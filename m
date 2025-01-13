Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26C1C242C
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792803; cv=none; b=dWoGFuHTfxMl9ndn+W+hevykW9CUjTQUTE1v5ZS5YH8aC+sqnFwhVmeccpLu8j+0ZErNA0IMErZ8SAnWACYdSaOnX/W0RMkjr8qYZYFzqNZtS1SI5BpE1eELsgbWtVzTn4HMYrwfqo2m9YDZ29TFOFgJx9zUBD714tlw0jsYUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792803; c=relaxed/simple;
	bh=cipAfFyWnPBT3ailCaqkqpQeuwCx+jcwy6r8uhFzPVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfQr30fLuH8pmGn0z7eVRWXU2aKWvfwDnZq31yEwjVlSacAK7MiHl0vU1vsmK50modW653TxdLxrr5KkFEt4WCGknZE/+i1GnMgzujbKEZJe/D6l3leF18Lnd8hlnUt1ZZCz/koElUNg7sB53cDDvRgWdsET1v2FTt/doHXS3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csXcLuKW; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csXcLuKW"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4b24bc0cc65so2932540137.2
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 10:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736792800; x=1737397600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A60UxtKgDfY/1rALVOQO19vg9z91FtnzTwNnTW9I0dQ=;
        b=csXcLuKW5q38N15oQenUGONPtuIbSWJdVZOWjcB65Oty/t/fcl4SB91KY7jLlBlxIZ
         qKP9leuNyrW5q/idnRM+utu966WygXE6AB00EtjF0s8sxMWHGzQJ+izl3uvBAfh9J93b
         EoFJOFV8DCB8a34S7rscGc5OvcLpvDUDq/1lEFSDZT3PljZ95DL/b/Ty2XA9xKkBP239
         SYxF7iiIT1IRMIYXtnAVAMGOrUpGM++LIClTZuQ2KYStaC1MSKN0CokWU9g+aTBBm8qC
         0BDnbd5HAXtUXKPcfUklcJk+FHVl4sxz9aoKcLd1QzUjzcnuomNDquYGFQPCV2oXcshI
         niCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736792800; x=1737397600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A60UxtKgDfY/1rALVOQO19vg9z91FtnzTwNnTW9I0dQ=;
        b=ptQDnIEsLI7ODWSwLGFHFJftj1X3c0Fvu9RYjDKnDu4bhei1FnZDOQk75ngm4iDIpo
         BgZSVGa4OT+6H+4aWDiwZPJo1DolEn4g8kmVLOX1QNmSF9xzHiIIHyrJJ7tS/y+bvgcv
         6lBmgon6dna2zEt+7ckk9aYfEddGth9h9i1KOKh+fEj1FAhvopnWSiGvyogCkPYHgPds
         3Owhsz4yOBQ6kkvclVeMZWHwLUqdF4AHBDfHZokFAajb21a0v+YWmThdmrHg9Cne+jU5
         w9M+Zv88TqlRqu1ClXDlD/uVWnAY2zOyyAKXr7SrFnbmelITKtnjqZPVCyI1vLuQGP6n
         0kwg==
X-Gm-Message-State: AOJu0Yx3U6E07XRpO7Dnz6EavqsQmVyvdujZRNLj8trglVFN0jdSd8Dy
	57b7BAI7eiuPdcOtczpjoOk+cBywUC6wxOc7WES1i1mA0Q6eWRXKaaAc0Darw+QONjEeM+n6bSl
	lEFDlQqjSoTgID+lnmt/KQ3B7RpI=
X-Gm-Gg: ASbGncuSZj4h7ge6KmR6FQAwy9k6stWHglUPoFVKjWuif2WoNxfHxT2hmlF/JKMnKw5
	hwg3Deejv7KthrcyP8SKtpQN900IeydXvHoKtqw==
X-Google-Smtp-Source: AGHT+IHLhJRCHv6vWba29ymBrj47RQS4r2iFdm5enHYhHnb/u0Q2RGVX9HxdGAtR4w40d2q6+L0rZyHmYpZMpMS13fw=
X-Received: by 2002:a05:6102:3a0d:b0:4b1:102a:5834 with SMTP id
 ada2fe7eead31-4b3d0e650bemr18584173137.21.1736792800454; Mon, 13 Jan 2025
 10:26:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250106103713.1452035-4-usmanakinyemi202@gmail.com> <xmqqfrlvzzcd.fsf@gitster.g>
 <CAPSxiM_0h7OyQO-Of8YhcOt4KbtuoKXe111ZCvsLf5y+OgCHaw@mail.gmail.com>
 <xmqq1pxdnuxo.fsf@gitster.g> <CAPSxiM93qVjoDGBRaGAv1-o3oiKkEE0mtH9ERTN9dVxvZpCczw@mail.gmail.com>
 <xmqq5xmokn0z.fsf@gitster.g> <CAPSxiM8KYpmoSYaWciF_KrtHhUTPj543q9mgio+qdeB-FHeDUQ@mail.gmail.com>
 <xmqqldvi5v5v.fsf@gitster.g> <CAPSxiM8kWoAXEvAVtp0C9NUQaas3KN=TMBA-p9o6+8KDQbmBUA@mail.gmail.com>
 <xmqqmsfubtt8.fsf@gitster.g>
In-Reply-To: <xmqqmsfubtt8.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 13 Jan 2025 23:56:29 +0530
X-Gm-Features: AbW1kvZ1DGkSfTjt_JfBkfA1iPQUphiV5CNXMv0mZtZtXzUjkXDwzLtgNiaHgIw
Message-ID: <CAPSxiM93asot47GgfK3ExNWd9M-4fjbWzRWQ=koCFdA8rNwD7g@mail.gmail.com>
Subject: Re: [PATCH 3/4] connect: advertise OS version
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 9:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > Actually, in this patch series, there is a config option called
> > `osVersion.command`
> > The specified command will be run and the output will be used as the
> > value for `os-version`
> > capability.
>
> That is essentially a "you can throw at us any arbitrary string".
> So my recommendation would not change.  .format would not give us
> much _additional_ value in such a case.
Hi Junio,

Thanks for this.  So, from what I understand, the feature and config
option introduced by
this patch series is enough, no need to introduce another .format
config. Right ?

Thanks.
