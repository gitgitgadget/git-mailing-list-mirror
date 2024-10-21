Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E57F1C8FD6
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545009; cv=none; b=SEzWpvD1On4ugyZiPNJun6q06ltGHizu+aeaRD0CmBKhYpx1tzNmXxnyIx0xMp0NXsLrNhXnBIo9B1V4WcQmhnRP+pqzaN/Rh9AiXTl+5lslyDOD1j2aIVlmB5gIyId19ZIjcjCkoXzEqOO9tPLMIOt+kdIWU2kQ7QY36YyIV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545009; c=relaxed/simple;
	bh=dqj4444rliG/7oU9bM0cvGgRcee6ulAmooLgrPfFx/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ht7GGf8B7h4wahPPcnDY/DkERUjnpysajqMVrFnZTJXTPSSmHGOHJVaMDQCGezIYOQPUPzxHzYXIcFaKhB6j3ApyLbbL3YhS+H7GkHjHYOv0UPhKj1X4LwMB+Bo1Qlo7yrsjk7X7aTmg9tnFYtqLScWg0wMd6VSpd1JnqZxiFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PBuAmzjZ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PBuAmzjZ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e5a5a59094so46836407b3.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729545007; x=1730149807; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l8xXBXm/Ob/kil2cJWJUSWmH3g/KLdPNwYRlZRKOSJ4=;
        b=PBuAmzjZxRT1tZZKuLe1r4abnIhDuwGtIi1ZI6AmkeEEK0l1BPsSiM2HGW6WTxUYSa
         cpWeXYSkUxktUyKNy9tSnZPXqDUgN9vsZamlnir6s0ErE2gIH/zuNurj4LXawVw85m/2
         hwh2CkX+0x+Qcr4htH0EWNoxLN6b+ffW3sTdyGFcYNoG0F+hk52QV92MRTz4fo7GnL3R
         MO5/+sDJ/5OTFGCzcJWSjkQtYC3ncQrcFWAZP1MLT4sRU+OoqObIYmk1TuQh52F8/8zk
         ADF+Z4vOv++HwItiBosIkdLOXEAkxqU+tOmF7A/4u7xYD1AvGZOr2Ndt9Ki1NPEo+gor
         Cz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729545007; x=1730149807;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8xXBXm/Ob/kil2cJWJUSWmH3g/KLdPNwYRlZRKOSJ4=;
        b=nVE/Q8Ww+0IDHkVAjezbszWesXoc4seGxhs4PNfU1UF1gEw9FNPvpxOGVwj7/vA8q4
         t3tqgSuQFSYfUgzOueLLhFYfdCIWEJ69rkB9z5c60+VEoNkIpOXbvjpEjciCFD46IkIW
         C8Hg/Lo6AZobblKt7MdTtn+zIu8uuH3r3veVKwK1VlAPPG2Z+9zcaPRZR9Du8MSdz9dy
         0rkPyCwEmSr1XXmzKA70YZKVkclbfVoxvlXkVBUNdi0CXWPi4qTup+YrNsJHzac8qq4M
         24pRvz1ccygPdAPRmgCcS20rgDSZaFJLDIf194AtfdCgo4ZES1Wj6AVkZBrkGyDxpC4r
         l7ww==
X-Forwarded-Encrypted: i=1; AJvYcCVMdBTWDtlq+7DxRbq0Y2zZYqc64hwS1Zd9Rj5znMz/OdXd55WkTYLDawhqwwCTG23YiHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcXGlZR/p52IL6fKs3jtaTmpWK7CPggfsSnlpDKNiF2X0u3vHk
	qvTLOV/BzkCO3k8Kb8cvAZA/34iaKPNWMPDlmIpV7ZHyhGe4/3ZLL/P10WIRrZjLMF5Q7FtWGPv
	t
X-Google-Smtp-Source: AGHT+IH31gsMeKk4A9XV2/ItyHrp5r3XorS+Tw5tjrHQnxw9/xtStmC7DLXxAzOIzfTypKWx0r24hQ==
X-Received: by 2002:a05:690c:6706:b0:6e2:446f:422c with SMTP id 00721157ae682-6e5bf9ff55cmr127090297b3.21.1729545007357;
        Mon, 21 Oct 2024 14:10:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a4d22fsm8215447b3.43.2024.10.21.14.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:10:06 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:10:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] t1400: fix --no-create-reflog test and description
Message-ID: <ZxbDLZaiiuSR4muv@nand.local>
References: <ab7d4c8d89c075de05bf04f1f9dc195145455964.1729439476.git.code@khaugsbakk.name>
 <ZxZETN7WjbNiSRyF@pks.im>
 <d66936b8-d12b-4035-b563-328ae9fc4824@app.fastmail.com>
 <ZxalTgct8WhEmO0w@nand.local>
 <36959987-5695-48fc-9b4e-2fecfe9f5b88@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36959987-5695-48fc-9b4e-2fecfe9f5b88@app.fastmail.com>

On Mon, Oct 21, 2024 at 11:02:48PM +0200, Kristoffer Haugsbakk wrote:
> On Mon, Oct 21, 2024, at 21:02, Taylor Blau wrote:
> >> […]
> >> > Overall I'm rather leaning into the direction of making this work
> >> > properly. But that would of course be a backwards-incompatible change.
> >>
> >> Good point.  It does feel inconsistent.  I agree that the conventional
> >> pattern (to my knowledge) is to have options override config when the
> >> options are given.
>
> Agreed, to be clear. ;)

;-).

> Now git-tag(1) and git-branch(1) seem decently clear on this point[1]
> but update-ref is lagging behind IMO.  I will be looking at that one as
> well.

Thanks very much.

Thanks,
Taylor
