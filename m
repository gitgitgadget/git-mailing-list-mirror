Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA71F8738
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021214; cv=none; b=alOM+vth2gKJQoq4Fmz6+DG/3kB236InjqunDjrvrcBwbjIWqd9FSo4dOHCEmKgFTATnrgzQ+hQFiKvhAtESADwTiFIRnoPMP6MCLpdbCM56dL91LxuQGldwlDQ7npFDMTvUECmMkgIAUjzSEtcs/J7kp/GDRRpn5s9l4rCNbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021214; c=relaxed/simple;
	bh=Ux5iBRuH3oOZGdpv7ZfsBAowmoc0R61PYORYPeAvoVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEfjfYGXrFjJPJS5f6apwM0IPRgagQmU8v7H9ZvZsn5bpPODdSq9oPEVB+ycfKzS5OsQTEpM5SxN2Mof/JOehqwIDVtnVM21e2D9O+JR833lO4vH1COma5rVs7QvDzJVVSX/F1ZQr87erBoDSNN3PtAKyxGpPa4Otz0IjkMEhvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kPV1uHik; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kPV1uHik"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ecfc2cb1aaso1874046d6.3
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1743021210; x=1743626010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JecVRmMwODrKK5w6/uSsAN7ywvL2i+OCzlFw1M91mmY=;
        b=kPV1uHikKHh1K/pSu7LAdXFKV6BcrxB6+MrnYa1Kd57MuTjBsCGdI74qbQ34Vkk901
         aY/qT6x5+CyaETWBELYx/B5RC46Q99Wl2blfRisd7/FJlx6q/mdHcHCxTH0oplrYjM/h
         hiaymXgk1x0S2tL6/Kohx1172jQIXD/SAIeqLEx+KCzaU2W6wAWYQWwlE1do2SkGtFHb
         eNPw7dl6C7/Rk18e196gp7Ktl6UdtJzg4oP0+eEXqloU7ri8N0DGVDe+np4owwb5SXZ1
         e3E+L7lnBLcfIumBuS+Z8sK05RMXR8J1OcVlHLQFo8BtzjdKU3VlLT2Xcs5n9/AVc3lx
         0nJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743021210; x=1743626010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JecVRmMwODrKK5w6/uSsAN7ywvL2i+OCzlFw1M91mmY=;
        b=Xi7WKDoeKwwxOAABL3YvHnmJn6nSnhe3212PdUFGLiKmTI5yi5LAneWN9RRhXZxfDB
         XzM8+yFISqukdsWI2g58c1JCvtyGnlo048HU3YaTG0C/K4f76nRchQ0JQZTy+iHOKP59
         gOCHAjta5qflsf6mWtm6HdXE748+U3eu0y65V+ZcvFYt5K1m9BuKyPPJDdOdpopCiWcw
         MR/DQ3O+VilPhjOp4D4NmHK5jnk4F5H5V9Cx/v4b/YEK+O4W2jbh3Svw+J/ip8tU9DgB
         GpImVHWpYnuhSXnqi5i7Nl0VBV4zlIkWK8dyaZOjvH+rHX9NKnPuAgmwwW4BZ9CftAE7
         HrGg==
X-Forwarded-Encrypted: i=1; AJvYcCU0OVvGHRmW0wc8cgDtCmfuotfvE2y6WM+hOjyD60G9uRn0/8XMGijOXZ/sFYHlILl713Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2/f70jejpS+swBa2xibP76I+TgwYkP1Yc3e7yHfsV70gb5F1
	t3HCi0Nke+rrDwH8JqZHQn5LKkZFHO3mJGjyUgvewAOgKN/bXuX4SAzok7XbUbo=
X-Gm-Gg: ASbGncuBoq2Eh/HNO40ATCZGylx0QB+JKSQD3wYSsuYqQxqOG/ys31aHZayIH4MWyAr
	3Jln1PrAmOAazLJib4K7XUC1ujODUl6zEgjjipAgZEOC6SEVMIsgwt1xGV1cKmjAbLyK39PUCU2
	5ssyJEygcofs1gtsCb744GJhWe5wCO0x9OUQqX6mI88oQ3aUCFjGX2CxS7DI/gtcsxFLtD/Ddca
	cYpoLYqHEUXlwFtE59yp0zSrBHCOU1z6bbDAXJvk8GbscAwSUdA80AuAHxf4BxKLNB219NeunFM
	LG3syr0citxV4egzE5InIkYZnaUMdn7Xx/qokVlV2s/fDSGXQBqIcCwl8x27gzlKjJ6TL9zTwsp
	nSocddWTPbQBQBMPW
X-Google-Smtp-Source: AGHT+IE0TXSb4MQMMcF8NQoomb5nzoy+Sz/Na72R855Ux7mxBHeeLzqJNo2H+G57pdejWz81a4Zv4Q==
X-Received: by 2002:ad4:4eac:0:b0:6e8:fb7e:d33b with SMTP id 6a1803df08f44-6ed2390f5c5mr12862766d6.33.1743021209734;
        Wed, 26 Mar 2025 13:33:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3ef1f5e3sm71178816d6.43.2025.03.26.13.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:33:29 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:33:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: phillip.wood@dunelm.org.uk
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 06/10] diff-delta: explicitly mark intentional use of
 the comma operator
Message-ID: <Z+RkmLzciwT6ubIE@nand.local>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <5e0e8325620395196608a0851f1f6fc9408f6090.1742945534.git.gitgitgadget@gmail.com>
 <Z-OWoK-DlvnxXPkO@pks.im>
 <050f5d65-32eb-fd26-1461-579b06018dc6@gmx.de>
 <ad57203b-8925-4f88-add6-763c2d80afac@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad57203b-8925-4f88-add6-763c2d80afac@gmail.com>

On Wed, Mar 26, 2025 at 10:17:50AM +0000, Phillip Wood wrote:
> Hi Johannes
>
> On 26/03/2025 07:20, Johannes Schindelin wrote:
> > Hi Patrick,
> > On Wed, 26 Mar 2025, Patrick Steinhardt wrote:
> > > Hm. I think the end result is even more confusing than before. Why don't
> > > we introduce curly braces here, same as in preceding commits?
> >
> > The interleaved -/+ lines make it admittedly hard to see what I meant.
> > I'll unwind it a bit (presenting only the `moff` part, the same
> > consideration applies to `msize`):
> >
> > 		if (moff & 0x000000ff)
> > 			(void)(out[outpos++] = moff >> 0),  i |= 0x01;
> > 		if (moff & 0x0000ff00)
> > 			(void)(out[outpos++] = moff >> 8),  i |= 0x02;
> > 		if (moff & 0x00ff0000)
> > 			(void)(out[outpos++] = moff >> 16), i |= 0x04;
> > 		if (moff & 0xff000000)
> > 			(void)(out[outpos++] = moff >> 24), i |= 0x08;
> >
> > In this form, it is very obvious (from comparing the right-side half of
> > the lines) that a shifted version of `moff` is appended to `out` and `i`
> > gets a bit set, and the correlation between shift width and the set bit
> > is relatively easy to see and validate (at least my brain has an easy time
> > here, thanks to the alignment and thanks to visual similarity between the
> > non-blank parts).
> >
> > It is admittedly quite a bit harder not to be distracted by the repetitive
> > `(void)(out[...` parts to understand and validate the `if` conditions on
> > the left-hand side,
>
> That makes it pretty unreadable for me. If you're worried about the vertical
> space we could perhaps keep both statements on a single line so that we're
> only adding a single newline for the closing brace rather than two.

My $.02 here would be that the form:

    if (moff & 0x000000ff) {
        out[outpos++] = moff >> 0;
        i |= 0x01;
    }

is the most readable, and fits within the conventions of our
CodingGuidelines. I don't really love the idea of writing:

    if (moff & 0x000000ff) {
        out[outpos++] = moff >> 0); i |= 0x01;
    }

, since it looks like a single-line if-statement and is thus tempting to
drop the braces, which would make the code incorrect, as 'i |= 0x01'
would be executed unconditionally. I suppose you could write

    if (moff & 0x000000ff) {
        out[outpos++] = moff >> 0); i |= 0x01; }

, but that feels even uglier to me ;-).

Thanks,
Taylor
