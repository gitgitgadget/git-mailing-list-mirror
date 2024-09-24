Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C24146A87
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215424; cv=none; b=CvVPdWl8riEgOXi7rgKFX0phoisd3OhaGRYVKUEpIB7Rj0Job3zs1+TAWi8qUYzngCb0+JyJ+jmmlEMVeu1LRrztzBiVmWWx0PVbROaeJR1fcKF7+MYm3wSPcDBQbnlJ9h6hNrpq+Cp+5Siq+kIeB24IqKHVxZMhuvayYhFtx6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215424; c=relaxed/simple;
	bh=RMndvhznzi/zLUYY9N8TeOX6jYPNJepLKcnCYAot0cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPlSJadHVVR4wBCBRQC/xSLjjnlC75bxzDsVcXhscAvPmQoEmbj4nxIv/ZpErJnL/MJru7PgrzuObs6un37e8EnmAo2n+/AhNv6iYcjM1hOTyTcRCLMc1OPiLLncBUxkh36LoI47lmcVbyuHmWyLRsmOre07+86f/c/71RDciH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DLcIiLry; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLcIiLry"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20546b8e754so29105ad.1
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727215422; x=1727820222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWEz2Q6HK20fU0C8/DOFplDoFVZNx4V+x5pkLTOwyjE=;
        b=DLcIiLryOpv+mC/jgOhdH8XFhJI/kfETeMVCDuSf98Ud/YDPueWtEJmG2MIkh/SdF+
         GTgmc+PzQAhSuzyWF7PrOie1b+vEl4LZb5B1bciLu16STYkQxb5xITiavIuDrmmh5Htf
         maymMATuINbkPG8VKnY4TsjjW69Hfv1iInnKJujXg+HBYiO0qh4xRVXQ7dzyDTTiUIEM
         btRn55Pm2dwDtVYqcnx4Maqe2XmoWAZ2I6dOjQC+fSAT6bZEZJVDmIV/fJ7pavYmhIH0
         gBEdQ+rpLULFr24p7gOKXoeuVTDIjKv4Idu8lBj2WeDRvPY/jx9jr40KGe9cgQ6SgtAG
         R9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727215422; x=1727820222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWEz2Q6HK20fU0C8/DOFplDoFVZNx4V+x5pkLTOwyjE=;
        b=p1B+BBPqReI1xEuetkPkj3uPbw67GS+b8IuEtCedj7ueSGV04yTOD4GlFdUPbVlo+g
         wDfoHEJ13L1+/7Br7IJrv4NDNFg2IM+1xaCbcZDQ/5FEb+GUWYe/noj+BPRTXmcaRlLh
         5VU/LmWaW2gWebS7W4fVdZjvW3k8jFVxVDM8XPD184LqcshnZrsBVtPQDOmPjBSUJLYI
         VHe0QkBWj1S3MlvvyE4GmZIUXb6CCsGEXnSuI4fdfX2VIraabQhxbssz9u0/GkA54NdF
         egbMhyPv+b4hWeU7W0hMtKMMSoViVdCU2OIUuAZxtEo61JDroU12upGiC5Au4TIk54H3
         ZzVw==
X-Forwarded-Encrypted: i=1; AJvYcCX1itmd1W6Xh/xTVT1q5ogVYE6SdsVF1VpmDNozcTGtUD4JKs5DdypKFeYMm6PbDvFfmu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbi0uremOb8QfiCSFx6QLG1UrROCyWpiMlpPNgBU2YN6LjJ3Jk
	gMicQGhw/Zo7MVZPr8iotDRihkgqSu1Bw+PEj/tv3T2087aPe0LmHkxlwK2Y6A==
X-Google-Smtp-Source: AGHT+IGIpZ3XlKcoqleQe+SBIjmWL2uBsCc6rk8kWh2Gnmd45hgdlWB7MaFaywdF2otwuw9e9ftVfA==
X-Received: by 2002:a17:902:b182:b0:206:bf6e:6001 with SMTP id d9443c01a7336-20afdb9adbfmr239835ad.17.1727215421683;
        Tue, 24 Sep 2024 15:03:41 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:88c1:de40:ff42:2e59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e2d7a48sm24478a91.35.2024.09.24.15.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 15:03:26 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:03:21 -0700
From: Josh Steadmon <steadmon@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Chris Torek <chris.torek@gmail.com>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/3] doc: introducing synopsis para
Message-ID: <gfwncnuvogwawlvp7mr64xrar3xv7fmevy3n3puro25wubi6mq@qdt6qmqi3o5n>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>, 
	Chris Torek <chris.torek@gmail.com>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
 <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
 <xmqqo74rxvw0.fsf@gitster.g>
 <4ww5v253vz2g4i3z2x3dmgkrot7mcn2qm6ckjcxbyky6yvrozy@mr5hnrsfj6sn>
 <xmqq34ltbkah.fsf@gitster.g>
 <xmqqy13la5jb.fsf@gitster.g>
 <CAPx1GvdfE+v-wV=gbTZJi6GvwGhw8NZcZHnEwj0K+YSTfMs4Kw@mail.gmail.com>
 <xmqqh6a6496d.fsf@gitster.g>
 <CAPig+cQgw8xf5bQaUEW=qvKQpnxrkiTrMsqa+VW9d_GX0au1sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQgw8xf5bQaUEW=qvKQpnxrkiTrMsqa+VW9d_GX0au1sA@mail.gmail.com>

On 2024.09.23 14:14, Eric Sunshine wrote:
> On Mon, Sep 23, 2024 at 12:38 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Chris Torek <chris.torek@gmail.com> writes:
> > > On Fri, Sep 20, 2024 at 11:24 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >> The reason why I am curious is because https://ss64.com/mac/sed.html
> > >> claims that -E works.
> > >
> > > It does for me, on my Mac, which is deliberately behind current: I am
> > > still on Big Sur.
> >
> > Josh, the topic has been cooking in 'next' long enough to graduate
> > to 'master' without anybody else complaining.  Could you
> > double-check and if possible see what is different in your
> > environment from others?
> >
> > I can hold the topic in 'next' longer but not forever without
> > progress.  Help from macOS folks (if it is macOS specific issue)
> > is greatly appreciated.
> 
> I checked my High Sierra installation (macOS 10.13) which is even
> older than Big Sur (macOS 11), and High Sierra's "sed" also
> understands -E.

Hi folks, sorry for the false alarm and the delayed response. For some
reason our build environment has a >decade old version of sed. I'm still
tracking down why that is, but please do not hold back this topic any
longer due to our out-of-date-ness. Sorry again!
