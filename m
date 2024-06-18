Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16F15279F
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700497; cv=none; b=dJ0e0I7cEFKRL8AU8AqnboJU/4lQZJre2n/TJQXAgmAvf68ijOJooFhKDVjDWt7r/OXkL/09PUlP+vB7sbWw/0qJ3TbIBhKMSlLqGpobxX+0KZ1Wzg2WTFVesERAWvD88dOTvRQOOGNxJ/V136wCpwqXOuiYAcVn9JB7rSrFi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700497; c=relaxed/simple;
	bh=TLvHAhZTXZGaE+Au3D/tlNbuzLHcsIoJebFdE/Bh9aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJduDk19QQlcjxyB0J6x46esyL65SnFrURcGMnoBM4XeQauJ4pPHba5iOQpU/gVKl24ktHRHvkQwNtTGNp12HInVG4fNaiTutLdxYa8Sx3t3XffzT9H+a8ZMTSJJ0LSuqZy7Y6/DrEz1ptZaRE6v8+sq+mwtalPlXuZK72eKhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR4x7sFN; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR4x7sFN"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5baf901ae65so2580970eaf.3
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 01:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718700495; x=1719305295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyRZStljhklN7GM9QbmyFOTM3LKbjUmyacyP4Hsuvmc=;
        b=BR4x7sFNwD2CrFmcvM2ABDauIhlanNcKAwXkdSZHvR3/gGl/Fh+I/XpOLk74OUStKq
         QIJEf9uGKIgNSBoqmUZFsnjwozMFh21Vl0g7R6nLhQvms1wdSlt7eSK9kSlzAPmKcAtm
         TDeybUeB4ay9fEGeUILv9syZ2BsCDFBTIwoJ2a4EceBhzI7aKd9P4PdnvssgFv4Ev25H
         AJ+F/OJSePnxiW1+Oz1YYiIvCwklRxvSG0hUQpVHWbZs2sn4/+W4K4Xdy8yd4bhbpM1l
         JtTtz0BVCb5HXl0zr5fhbJpH8d38I2yIZmnGQlCaDyr0A5pNsZNdLWYo2HiIOP2Qwj/0
         yeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718700495; x=1719305295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyRZStljhklN7GM9QbmyFOTM3LKbjUmyacyP4Hsuvmc=;
        b=LXkgABt+VclMzHvpo7zToJUW7WT7hF5Ng49ns6Y9KGUHuxj0R2m5kfblnxB1tqebp+
         PWmxpDDrDRDV5AhCTDWOfaNYC9WILAqx/gJaGQYqJ87Mm2OfTM5xii3WSSPjsBzGclwu
         PflZF/ee5EbBHD8w2ESoBZK1dSoB32+GHoR55Az0Hcnvtq/H1QiN7YcxbDjDDYRC7XWf
         mdu2Nmb9IiKT8kdlZ/3mL+7CG3VTEpnht2Ohwd+hHDVRe21v9RNI8IOVbGoGTt1m94Qe
         mw6Z46tr/k0qiE/cy1Gq51L5hLwJ7pE3fQAf/1MAO5sPSbjetK37MYtLA6vTvY97kMTd
         QFJA==
X-Gm-Message-State: AOJu0YyI+pJDlg3LQzKeXqhSXrcCGoNasyx47869d2ZSS+JTG5Oous/Z
	IiipXhA0PtF6/Ary/KUNzAyikqBaU4PbR4CoDNeGUnHHlskm/OM/
X-Google-Smtp-Source: AGHT+IFIiL8cB/LExOKQ0MyWaa6l8rMy4l8B6f4iMVajQtdLCT2333OKSas0QD8LH+6FygvAs4G0Cg==
X-Received: by 2002:a05:6358:5f1a:b0:19f:703c:ca7b with SMTP id e5c5f4694b2df-19fa9ddbf2cmr1434603655d.3.1718700495283;
        Tue, 18 Jun 2024 01:48:15 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fede16a532sm6604687a12.20.2024.06.18.01.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:48:14 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:48:12 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/7] builtin/refs: add verify subcommand
Message-ID: <ZnFJzFVNjisQn6dU@ArchLinux>
References: <ZnFCu7kDjjoNr9dr@ArchLinux>
 <CAOLa=ZT=B=7Ec7Ui6JmOCFC7gh+G0D=GGGO0MzL_HBcGW9pbOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT=B=7Ec7Ui6JmOCFC7gh+G0D=GGGO0MzL_HBcGW9pbOQ@mail.gmail.com>

On Tue, Jun 18, 2024 at 04:44:46AM -0400, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > Introduce a new subcommand "verify" in git-refs(1) to allow the user to
> > check the reference database consistency.
> >
> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  Documentation/git-refs.txt | 13 +++++++++++
> >  builtin/refs.c             | 45 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 58 insertions(+)
> >
> > diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
> > index 5b99e04385..16b518ecce 100644
> > --- a/Documentation/git-refs.txt
> > +++ b/Documentation/git-refs.txt
> > @@ -10,6 +10,7 @@ SYNOPSIS
> >  --------
> >  [verse]
> >  'git refs migrate' --ref-format=<format> [--dry-run]
> > +'git refs verify' [--strict] [--verbose]
> >
> >  DESCRIPTION
> >  -----------
> > @@ -22,6 +23,9 @@ COMMANDS
> >  migrate::
> >  	Migrate ref store between different formats.
> >
> > +verify::
> > +	Verify reference database consistency.
> > +
> >  OPTIONS
> >  -------
> >
> > @@ -39,6 +43,15 @@ include::ref-storage-format.txt[]
> >  	can be used to double check that the migration works as expected before
> >  	performing the actual migration.
> >
> > +The following options are specific to 'git refs verify':
> > +
> > +--strict::
> > +	Enable more strict checking, every WARN severity for the `Fsck Messages`
> > +	be seen as ERROR.
> > +
> 
> Nit: It would be nice to redirect users to the fsck documentation to
> understand severity levels.
> 

I agree. Will improve this in the next version.

> [snip]


