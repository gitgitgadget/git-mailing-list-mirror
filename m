Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025D2F26
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731646848; cv=none; b=Q4K5H7SCHTGYc37kTXxLnblk+0wn/KQPuNCttXvIfJhLrNnwQrNc0qrVCbUk4Ki/DCQR+LYMolVbTIPeB22SJkSkS7HZF6V7n+qUXTNXq39s6E/pfzBynnW0X7N3+PpCtlDA7C36VUC5CdQpLSBBx8qjLArBtoowbVBbbsKKQ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731646848; c=relaxed/simple;
	bh=ecQSZGtFXK1Ny7YmnclFNm41p/QanFTfPMMWknPtlHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDXcGpEhYAW6GrtHrWBBw80dg2MwkWV3qgL79TWXAkDtNl2zwM8Zr0g8yxOOb2hG3YQ7sIsPN275s6+pc8vmPM/oyEbVbFgfZUd5twhLr55WTleF4Wl4/iKif0nCxwl4fzJutqbsE6vXlcgqYhBHBHMEcIFG3g/ArJZlbydwwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+HMeP0p; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+HMeP0p"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72467c35ddeso1180890b3a.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 21:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731646847; x=1732251647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TkI6R29hIDwh4aVgMYDJdMW0vUMlqi9UE/dSPaOBKUQ=;
        b=K+HMeP0pb3LQVCWSyteezTQK26S+z4sezA4ZwEQnqHA9xOHLd1Qg63xVutAGgrJtSD
         QxOM8Fff9BpH1a6nTeU7cIA2Ud2DBCl1ol7oK2TX+Q6Z/UIqXpFKyf6bnwpcSSxycbRF
         kITBEeWKhtCWOork9i6Ce9yFjJ4IrYP7rmiMemR/J+BNSYqwxjEbSA/mGIvNPojT7GIz
         ph9W05i/u287y7HgmAb0dzzmlvaYPym4BhjOG7ykxx3ccK6C3+lwCqqG0RnXV8ViaWLK
         zAjVAz6DICvR9eV32Q5QagKq4xwKwBBU61WPNaOfMspXCV6wzeKjuAg3ueCn682PePN/
         mZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731646847; x=1732251647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkI6R29hIDwh4aVgMYDJdMW0vUMlqi9UE/dSPaOBKUQ=;
        b=wgxbJrzpMTL0QyvYqGkhqCYMNODUBv4RWvlCk+xwtZrEMFon418maNnXiJQHwCDDol
         bKXr2PEDDCNKl4vdbd7eKK04gE1rfTqT+MoLDAV1lHZO8dWrK3Qh7UZ6ucSN2uggxdnB
         geZm4dzG65o7r/Xo8r8+nQx0Hz6eRwqEniOpLHZRlceH+1drBHLJ7dusQO0co5fdYbcS
         k8plrSIfkK4Hj4xK85gYJYH4SZVq+nH7qMjqvILs0v4IW7SjGFAYzzl3zyZARtkZtpn5
         /77aKpwwxl5Y0oAo7s3Bnb6fLVBm8heEEUe90d1nVRieQ4h4G/Ye1Dq0TJV9NgcGfWQ2
         EpbA==
X-Forwarded-Encrypted: i=1; AJvYcCUVg4z4fKos2MpyeUhCDTdR8HobExFdNihzKDNyW5xyHPfAccGRE6wRdarah4HmrEFZXrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcIDqrWgtBXsx5FPEEeeNZrPhW/8bhd+s/OcqeTGcwgeJ+Ex4t
	hbNpgIoN90hNmE609MESbfvGDex3DWaDi2E/JjoA+36ttMSWpwPW
X-Google-Smtp-Source: AGHT+IGh2cCnrRNhmSsKOyTlXhdsnC7baw7HLiBa/M/gcNqBQX+z7Bbyl0/ErudX0lRRzZBn6ex9QQ==
X-Received: by 2002:a05:6a00:2294:b0:724:5815:5e50 with SMTP id d2e1a72fcca58-72466713507mr11156367b3a.4.1731646846731;
        Thu, 14 Nov 2024 21:00:46 -0800 (PST)
Received: from gmail.com ([172.56.122.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0ea6sm517376b3a.123.2024.11.14.21.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 21:00:46 -0800 (PST)
Date: Thu, 14 Nov 2024 21:00:43 -0800
From: David Aguilar <davvid@gmail.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: Shallow clone of a specific git revision?
Message-ID: <ZzbVe79p_Zbnb6rs@gmail.com>
References: <ZzNJGHMlxGQyFV_c@kitsune.suse.cz>
 <87wmh7ig98.fsf@iotcl.com>
 <ZzR_nOqQxfGNPyYV@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzR_nOqQxfGNPyYV@kitsune.suse.cz>

On Wed, Nov 13, 2024 at 11:29:48AM +0100, Michal Suchánek wrote:
> On Wed, Nov 13, 2024 at 11:23:47AM +0100, Toon Claes wrote:
> > Michal Suchánek <msuchanek@suse.de> writes:
> > 
> > > Hello,
> > >
> > > Looking through clone man page it supports shallow clones of branches
> > > and tags only.
> > >
> > > Would it be possible to do shallow clone of a specific revision,
> > > and checkout specific revision on clone?
> > 
> > Hi Michal,
> > 
> > I'm working on a patch, and I've submitted a first version [1] a little
> > while ago to allow users to pass a reference on git-clone(1). Would this
> > change fit your needs, or what else would you like to support?
> 
> > [1]: https://lore.kernel.org/git/20240927085438.1010431-1-toon@iotcl.com/
> 
> Hello,
> 
> that slightly expands the available options but it does not make it
> possible to clone an arbitrary revision, ie. specified by a SHA
> 
> Thanks
> 
> Michal

In case it helps, here's a short recipe demonstrating how to do a
shallow "clone" of a specific commit ID:

    git init the-repo
    cd ./the-repo
    git remote add origin <url>
    git fetch --depth=1 origin <commit-id>
    git checkout <commit-id>

It'd be nice to add this feature to "git clone" for convenience.

This recipe depends on the server's configuration. You must have one of
the following configuration variables set "true" server-side in order
for the server to accept requests for arbitrary commit IDs:

    uploadpack.allowReachableSHA1InWant
        Allow upload-pack to accept a fetch request that asks for an
        object that is reachable from any ref tip. However, note that
        calculating object reachability is computationally expensive.
        Defaults to false. Even if this is false, a client may be able
        to steal objects via the techniques described in the "SECURITY"
        section of the gitnamespaces(7) man page; it’s best to keep
        private data in a separate repository.

    uploadpack.allowAnySHA1InWant
        Allow upload-pack to accept a fetch request that asks for any
        object at all. Defaults to false.

cheers,
-- 
David
