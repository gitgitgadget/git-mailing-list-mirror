Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A61B6CFA
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020162; cv=none; b=NVHtgW27sc+0O3kt9eLN9/5q2ao9gnHCFBLHYH7Wv3TB6cO6//uWpQ7cWn8QoNofgix+R6l3wUkX5oXlB2vHYC/zDrEFL3QjyMGn8nDfojdjMDUs95ugRIsIxASDh2Q1idj0csvKsZ8TMGzYNeOM75BuBHYA7ZQgcWnc19edrUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020162; c=relaxed/simple;
	bh=EaGTPonfiGfnwSftOdjeta5Vd8vBvqaUa4sFncaC3so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFd0kB1hOnD0ZYJGbLWdhN/d8M5N6e8tbqxLG1/zlWGjU6vH+OCVlRyDvQtUu7nh1uvpZiXLxPIoxcMEd1wLojlnsd9Vx6Yf99M6Us5X8E7wpsqq6ppJID+nyCzqSCLTULlAV+wgx9gKADeMigNAyVdDL2GHW8Vdw+tlrGOe0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kaxp1m8u; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kaxp1m8u"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4603f64ef17so1728951cf.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729020159; x=1729624959; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EaGTPonfiGfnwSftOdjeta5Vd8vBvqaUa4sFncaC3so=;
        b=kaxp1m8u/gMsfjm4GaR9soVpO/BwwNhFwS8TqCtLFxQKp0ZbEe6GOn9UTtMrOtZtU9
         oyjdIsX5KzhRvb5cIIZFvpDT0hvvLsdagbjYP+Uyi1EqssTVhs/CpHbyVwHILSqnYtl0
         wzhUCSU4YuTFsBZ6hZkK1qBJwdv8ZNsyZ8D9YkSFtzQPNFk/RptJ3kR6SJTN2SAHXBwt
         Sh3kxbuhwe3I/x1rAXxVyU2mDFAUiSUm4pGMASMQMZmbMWa89mXzkeNQd4cthpE1QEb/
         xfI0i2Ywkt8LPdXEDOalHd9IXLQQ7OW+WJkkuc3UkhSVmA70ZnrjncCEr7kkEUoLjAg8
         pjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729020159; x=1729624959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaGTPonfiGfnwSftOdjeta5Vd8vBvqaUa4sFncaC3so=;
        b=E8JRvE2Iic5ukTrWsQdszeMKuMFDt9Ont/Jad/gOM2gxrMCqEokJEFx3kNFwjsbs3p
         MV60hy09nSGofzJYoMrs7A+37WyLM0EN5/0iPn9IG3PU/01UPqpHXFvYemIIpHYq3P7c
         U8T+AGtSgqyAjP7nXwg9fIgiaq00zdlId+VfDHdzAOP8zJQoaOZ5as5lqJ10793j70kn
         dPW2i/38Gx2Lz4OAsrN1uuyQ9aMG8ubOykCgsxTPX2sHbJjK0iBR8HgMNTu509oKBHUJ
         UXUYQHoRwry3zUC9dMGsq3sKnm5SLtcTVRYwR9ILkGacipMnqAdy5uvGG+0G0Zeh+x56
         X8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXzOI2+yyGk3WzbVHsrE3bsMReWvZxA8CFvancnB9Ade/hLvyjNXVYE2tEplBIICUsXbMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52NKLo+FUZGM43F/wloC0vh+QwXVNnc5Hvpfit5nOctLEO49L
	3Y/q62p0KJvJYWmOUAXncwCVzlDK50hFDvRQehefDY1g/jBAxoN2dz38112xFuI=
X-Google-Smtp-Source: AGHT+IE2/Ue9VH/zsKqRyl0VzD9vx+lRdDRPY4q7w4h1E8xqawIS1P+g/yZ/xZ2cbppCpOI05sxfFQ==
X-Received: by 2002:ac8:5851:0:b0:45d:793f:e18b with SMTP id d75a77b69052e-4604b32127bmr283546471cf.27.1729020159362;
        Tue, 15 Oct 2024 12:22:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0e4152sm9760911cf.36.2024.10.15.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:22:39 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:22:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	git@vger.kernel.org, sandals@crustytoothpaste.net,
	asedeno@google.com
Subject: Re: [PATCH 0/2] Restore support for older libcurl and fix some typos
Message-ID: <Zw7A/UASAFNsfmPF@nand.local>
References: <20241014131346.3556163-1-asedeno@mit.edu>
 <Zw23K4zPN9e+JyNA@nand.local>
 <CAOO-Oz3eQ+fpWU3qLHtF5oCxj2ieoc6P4R+iKJTG3DoWrb6W3g@mail.gmail.com>
 <CAPig+cRENnd9cV5yFfVVwbuux84k10_vcht-TTtKGJmRNYEttA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRENnd9cV5yFfVVwbuux84k10_vcht-TTtKGJmRNYEttA@mail.gmail.com>

On Tue, Oct 15, 2024 at 02:29:33AM -0400, Eric Sunshine wrote:
> On Mon, Oct 14, 2024 at 8:51 PM Alejandro R. Sedeño <asedeno@mit.edu> wrote:
> > On Mon, Oct 14, 2024 at 8:28 PM Taylor Blau <me@ttaylorr.com> wrote:
> > > On Mon, Oct 14, 2024 at 09:13:44AM -0400, Alejandro R. Sedeño wrote:
> > > > This is presented as an alternative to the patch series from
> > > > brian m. carlson that bumps the minimum version of libcurl
> > > > to 7.61.0 [3].
> > >
> > > This conflicts with brian's series as you mention, so I haven't picked
> > > this one up in 'seen' yet.
> > >
> > > Could you summarize why you think this series is a better approach than
> > > what brian has posted? On its own, I do not understand the motivation.
> >
> > It's a question of preserving compatibility vs ratcheting up minimum
> > requirements. Both have their merits. I sent in this patch set after
> > seeing some mild pushback to brian's series, just to present an
> > alternative. Maintaining compatibility with older versions can be a
> > burden to the project, though I think given this patch series, it's
> > not a very big one. Ratcheting up the minimum requirements can be a
> > burden to users stuck on (or choosing to try and support) older
> > platforms. At some point the burden on the project outweighs the
> > desire to support those older platforms. Where that tipping point is
> > is for the community to decide.
>
> For reference, I'm the one who pushed back on brian's series. The
> "push-back" subthread starts at [1].
>
> [1]: https://lore.kernel.org/git/20241014132856.3558224-1-asedeno@mit.edu/T/#mc1180f00cf52de4e9bae334c2cd5abd9a160dbbe

OK. Junio had brian's series in 'seen' when I picked up the integration
branches on Friday evening. Let's keep it that way for now while we wait
to see what approach between the two is preferred.

Thanks,
Taylor
