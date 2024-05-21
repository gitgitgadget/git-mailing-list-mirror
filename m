Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55791149C55
	for <git@vger.kernel.org>; Tue, 21 May 2024 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330445; cv=none; b=n/r2Su5obMZWeUxMCAWA+44Wy3l5dvSUVc6coKdv3oLwBoRENW71cZjCQUM8CgD/2r55x0SpLA30ZA1JUkRweYExJovHArW7zVrIBQ/FDD0QGZnY40pvVTlabaXasHe4CgG4wF01MLk0goyLg6xTJsb269ef+djjpz1UPiClgNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330445; c=relaxed/simple;
	bh=KzfiXD7gUqNWpN4vSaTTascedDnvADbev7+Yny1k9lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2IWdN8q55FD4eHUk9LLdSjGn67WxZW1ft2eBpfbVs5V5wwRDutQO5NRi8lynHnpaajw4jpxDkXrWV90zp+Yaj7/lwQltTGsFCflQzkYPRrDfJDOkX+IDKQ8p4sH5uG7bruy1bDVKCwzMdcdhaYRpc+LuMjBRMUQbKLGEkUmHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WKidkrR1; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WKidkrR1"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c9995562fcso2312909b6e.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716330443; x=1716935243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvsjhP/wpBO0ygb/CoKy29gUQnbPNgLvJ7POeUqf5tc=;
        b=WKidkrR1Q2NeHKaY5JAk6nmP7RwekwauH0lkkQRdFFOOfVMDPFZvttQZC+MqBEAgo1
         /RLHWsniRiL4LfA5xe/BRtJ4UK12aRw350TVRHbF6DAQcHz7I3WfBxnK0qPEMvMLkwOX
         YhhGRqK0CAsri1yGD2W4aPyPO0cwNNC1guTPPWn81cTUik29phzOUt/gOJcnfB2Xew/S
         Pr9tyVQ9cFkODZXJrn2If1OojUFn9AMST5Gmii2ad8ztONhb5h4j0UYJqDDnJViPHHsz
         CBHq46Tl2tBoIN1WVYVVk+bQSLQB+3s2jsOLJ6UT5rlnQFIJA3QeoRRdgAhUwzo+TaeX
         gmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716330443; x=1716935243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvsjhP/wpBO0ygb/CoKy29gUQnbPNgLvJ7POeUqf5tc=;
        b=fOooVO0pg8t/MwoSnQvRAN1APWKb8YA9bJRSZUMSrNUxkSJp86hJ2SvedZSReJXVjE
         0g58teClvZqRFZ8smEpUaCWaYVv3Ui+TuKWaIFPtY4poWOcylvGGw2PBwdzvLLKC6cW0
         7kjKPyCR1pJg8Xb6T1vL8k6aquz8u995J1kYgcs9w2WwEPpsi/1+II5TbShJ+13986KI
         VUedb25NUl4D8bNUQOLqLedphJG+FzQJKPi2/2Gmiyb8GBjnYIhcZ/TSvZamYgI+zBv1
         lKJsZW8ym0dH4bmJZK+RlP/TPbnUf9AWGLoCimqU9Osaelxdyu5kaWcDpGBG/IbnsoTi
         fORw==
X-Forwarded-Encrypted: i=1; AJvYcCWE3gbnhZ/X4BCuXVuqOrz1cRsO4Gm/vNtEG2uNEsNELasC2suTHDe6Qw/aPjrO2itW97DNzOzPBPofyJ+4NgrsewDd
X-Gm-Message-State: AOJu0YzF68g3h8j5bZiywLqQ/r+Nl/YPbZlhRtzUPPDoX9ObWmfrayjw
	Jiq+uSNIBsRt+UhSAPGUPrd/0qFfO9+Q60OWNZpTl/MUUd9+fkY9R7BPGao0vno=
X-Google-Smtp-Source: AGHT+IEzYEBuZTWrdwc7oVJPLgvOvtNGiFV3Hf+QDOm47PefX1W7QxK5NzzlxM/ulWbV/jw2eruftQ==
X-Received: by 2002:a05:6808:1115:b0:3c9:6bc8:227e with SMTP id 5614622812f47-3cdb32e4477mr395131b6e.10.1716330443253;
        Tue, 21 May 2024 15:27:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e074719d1sm144938301cf.35.2024.05.21.15.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:27:22 -0700 (PDT)
Date: Tue, 21 May 2024 18:27:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: Re* [PATCH] add-patch: response to unknown command
Message-ID: <Zk0fvOpOapsAkWSd@nand.local>
References: <1dbe4c61-d75f-45d9-95d2-ac8acae22c56@gmail.com>
 <ZkxHLE_8OpYvmViY@tanuki>
 <xmqqr0dvb1sh.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0dvb1sh.fsf_-_@gitster.g>

On Tue, May 21, 2024 at 08:52:14AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > I'm a bit on the edge here. Is it really less confusing if we confront
> > the user with a command that they have never even provided in the first
> > place? They implicitly specified the first letter, only, but the user
> > first needs to be aware that we discard everything but the first letter
> > in the first place.
>
> I share your doubt.  If what the user said (e.g. "ues") when they
> wanted to say "yes", I find "You said 'u', which I do not understand"
> more confusiong than "You said 'ues', which I do not understand".

Same here. The below patch provides compelling reasoning and has my:

  Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
