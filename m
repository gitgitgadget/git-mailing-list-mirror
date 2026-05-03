Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4791428725F
	for <git@vger.kernel.org>; Sun,  3 May 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777819765; cv=none; b=cfjGFDF7sNellHiTk0LJ81IR/GWc+0BHJWrf4xsaIRE+XuG/O9S5JOWVPMBeNPYEYAufwyTse1PQxVnXL9YxnxBcmchcxwotbmRgCgZ/8hUTrLxbge+7KVC7kd3WiszmC6krF37zGwFcDANkfpNp5xILVEo1cckVVIOiH5XMoTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777819765; c=relaxed/simple;
	bh=4hFfV2+kIwGR6xKMB1JUD6PjFtS4nJI1XNBjVYcyq6g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Uchc1wWGsGdrLVit4M4h0B1qY8sKoZUtlkYuJvyfahrd9R5qf3q2Fn4QJpfwbBW5Ca7ZA81ZOOw6UY4FtM2wy4zp5QT401u8PrCiX/7oiEH8ZGtaM4HovQzuLxGM03CA2y8XnMc6D7cslbM0f7syNNu05BNdpB9peLg5P8MVQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=lBDFlACP; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="lBDFlACP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777819761; x=1778424561;
	i=johannes.schindelin@gmx.de;
	bh=P2yzaI18FCgN2Cm4QSfpNTytU9yrvqog4cIYEJJhU48=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lBDFlACP/9vJGogseuFiD8DDXSGJX5/7AF08XKaWCHAD9NP/n9mFluYiyOHK5XX+
	 Ga/qLyAJVbo2dY6EOD0/7VIaamDjR48VtSy75NCVbuill4b5n624G1NhpzZTPg8cK
	 yLOsg3NOO6G9Mv+da/tokoz9Tq40DkN2+O1c5pIbXB+6kzRnqdJGaaWgZMwITeZWf
	 kxoCkJIWvVg81D9gdOtBLYWjWZ37ojfF9P2MRra1znueaS3CBGgGY+So/PlJN2Gkc
	 1/Si7vTBtF8O83MiO12jPPpk3LRe4Tx3uslvQqrNmDkGwo9LC46i2Lr94e256xAq7
	 s3D/yHCgtOv2mGKF1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwbz-1wCeN73jVB-003kJn; Sun, 03
 May 2026 16:49:20 +0200
Date: Sun, 3 May 2026 16:49:19 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Derrick Stolee <stolee@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 4/6] delta, packfile: use size_t for delta header sizes
In-Reply-To: <1b2ce8fe-7c99-4dde-ae07-1443d03cf523@gmail.com>
Message-ID: <d40c5d8a-9f03-43fd-f6bf-0b7516d21804@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com> <3274cba862ae42a6813710410274a692ec0f5d29.1777393580.git.gitgitgadget@gmail.com> <1b2ce8fe-7c99-4dde-ae07-1443d03cf523@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pMg5o+u+HZviPJy2mm2GtZ/tBpCR7C738T2Cw7oXSSgxM7/7gr/
 BM8tKGcNPeva54JgTduDEd+HguTQdn88DuAtBvvLvpKijiAbzaqijlruPdg+NoPO8zSpCA5
 ZfPRJ0RhM0ynNrvMWSEj5WXoshIMSlJ3GIA+yCHjylN8NoVQDio91zGVwoheAPXDM+hRs4X
 LFjxctSYea9EaL2WlcthA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:47HoKArQkew=;7ADNbQZhy+w5qp4pC+fOT8S6aI4
 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
 wp9NKEAPEVTAanQ==
Content-Transfer-Encoding: quoted-printable

Hi Stolee,

On Sun, 3 May 2026, Derrick Stolee wrote:

> On 4/28/26 12:26 PM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > The delta header decoding functions return unsigned long, which
> > truncates on Windows for objects larger than 4GB. Introduce size_t
> > variants get_delta_hdr_size_sz() and get_size_from_delta_sz() that
> > preserve the full 64-bit size, and use them in packed_object_info()
> > where the size is needed for streaming decisions.
>=20
> > + * Size_t variant that doesn't truncate - use for >4GB objects on Win=
dows.
> > + */
> > +static inline size_t get_delta_hdr_size_sz(const unsigned char **data=
p,
> > +					   const unsigned char *top)
> ...
> > +static inline unsigned long get_delta_hdr_size(const unsigned char **=
datap,
> > +					       const unsigned char *top)
> > +{
> > +	size_t size =3D get_delta_hdr_size_sz(datap, top);
> >   	return cast_size_t_to_ulong(size);
> >   }
>=20
> I like this trick to use the 64-bit implementation and only to
> down-cast for API compatibility. This allows a more gradual
> transition than if we replaced ulongs with size_ts everywhere
> at once.

Thank you! That was indeed the exact thing I wanted to achieve: To allow
for incremental, easy-to-review patch series.

Ciao,
Johannes
