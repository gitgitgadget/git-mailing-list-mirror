Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E6DBE6C
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952816; cv=none; b=Oe3C/QPFa8m4eQ6sIIDyavrhHnJ0hwQVAr0l9u7zp2Ppu3aRzakaFMP3kzQnnTIBQgcmRYcLlZRMnLdWMKNGFO8UYD+S+X3vB4jYE2O4S83Up2PAFlN1dcDXRZuSTvZe3eZL7mkdNQYh2A1PP2/56a6LnEHFM3cv+Hha91L6b+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952816; c=relaxed/simple;
	bh=TBXjiIQ4pTqkC6ZNJhDEuaouEWogIi5BMfJEYbF+V9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qa8GU7ZyQCnTdoeuxjFsKhK73cvxtlrvfD7ZzpwPA58BGurtVRR+Bz+8QJiuqFWxh2ax87y+USyksHA8iHI9cfo1dA9UEs9mJzDyEyD6pHk2VdwBTGaUGMvuByZ0xfhNtzhUFP6dXE7lfhuCp4+zQvxQJc6TvwyG4uDPDR8hnV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UVcrnhcY; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UVcrnhcY"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e390d9ad1dso14610577b3.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728952814; x=1729557614; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBXjiIQ4pTqkC6ZNJhDEuaouEWogIi5BMfJEYbF+V9E=;
        b=UVcrnhcYbDG5RVw/5hKJ3KmDirkH/0vObnG8tSwY3rbv1exUT+795fUuRxYOd+79Qa
         Rtlcq0oWAorU8w+WcMZER1c0hms88U+QC1wu91xAmM4tuE1Z5mgwP5P2v9t/Y9LHRxai
         XaTrweXUNcmpADzcrkHK2375R/JlAiSklp90K/XTonDf4uk2bQWV/TZvAXFttzu7GZDe
         0KmzxXM0j5ZV5m2hSQo5bxYZ1aIhEkJK8bs0qLrYtNCBA1841suLbf0rXJKAxc115OVJ
         37c3M87oAITet3Psm8/9A5fLHs3+Mxc+kHl8jVpEFC9uG2ztjO6HxrevaSBU4OfrWMYX
         o/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952814; x=1729557614;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBXjiIQ4pTqkC6ZNJhDEuaouEWogIi5BMfJEYbF+V9E=;
        b=kgxvY9b9DTLUjcKp4/vbq6s4tNRk4erztoff7yPNsTuIBYwTZ1XEVK5sgufCirl3V3
         W7s/cYiGVVDjjKS81FMhtgA4Z8h8+NVYVhIv0GtHTK5+YH73s4SAtpuRh3k60m2LRUdI
         C+J+ypA9hwacNLUYJO9/xnNIKj1WRixTM5NTE9/9cX2+8GAv0vTn4bCO7FjoLojXkDtS
         BOczkprC67PqpfuooS99Y/rNlBRHKFAv8PDewouTjYTHRKyViC3Z6hMAIxpegBFcVQZ5
         YIU6Htj5LRqVzZapz2s0zvgMHWTAfLsx5jQKEI8Q27UByP9IpQL0y/8k6cdhQ76sU6QX
         sNpA==
X-Forwarded-Encrypted: i=1; AJvYcCUOYlIG5r13acj4/xeqiElf2YglwerZJvNm9Myg7p9TxBq1qVbfe1JaRT+Fj9r4xB9Ohhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KYbd+IDL2t40tRk+avUojLWKSNLVuaO9zkB3xCYx71C1VrMN
	bgJGUUXQ+F0isQb4aWbt+IphWEvgH1Me+urcdyVSkWh4oF9er0BuaBq7QCG88IzayAOlkjRDavB
	z
X-Google-Smtp-Source: AGHT+IEgb8rLV1Iyezxl3amEpmQevPDVdpP+TaC/Gv+U/1YMEX1CbGlNGbXPIjnAa8vP8lSApi9fSQ==
X-Received: by 2002:a05:690c:4487:b0:6dd:ba9b:2ca7 with SMTP id 00721157ae682-6e347c6e752mr66485417b3.46.1728952813764;
        Mon, 14 Oct 2024 17:40:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d1f3c0sm523467b3.106.2024.10.14.17.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:40:13 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:40:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?5ZC05YWD5a6I?= <wu.yuanshou@foxmail.com>,
	git <git@vger.kernel.org>
Subject: Re: Bug Report
Message-ID: <Zw257L4gPDdeW8us@nand.local>
References: <tencent_D0324DD61B7E04E0B4686FD8761E1CDDE108@qq.com>
 <CAOTNsDw58poRNMpKiCOTouH84ah7+jvMfM0OPj-Y02Bo2O4kXg@mail.gmail.com>
 <9d2d6e7b-9691-4c9f-9b13-f1019cd1c491@gmx.de>
 <CAOTNsDz7Q=KrRgeV2EN6Y4WmSNdn7kF-4Xury8dbxEcbcoxBbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOTNsDz7Q=KrRgeV2EN6Y4WmSNdn7kF-4Xury8dbxEcbcoxBbQ@mail.gmail.com>

On Mon, Oct 14, 2024 at 03:22:13PM +0900, Koji Nakamaru wrote:
> On Mon, Oct 14, 2024 at 3:02 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > This bug has been reported at
> > https://github.com/git-for-windows/git/issues/5199 and has been addressed
> > in the latest snapshot at
> > https://wingit.blob.core.windows.net/files/index.html
>
> Thank you. I tried the latest snapshot and it worked perfectly.

Thanks, both.

Thanks,
Taylor
