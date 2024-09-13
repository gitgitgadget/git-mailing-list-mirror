Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D751B985B
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223041; cv=none; b=asW0BqVN8Tvj5ON2WscUAsedGBApJq5nOTqBbr7nEnEAEJCRwxfn4XGEeAhDv/fzkjp3clXox9ocF/43mj7TjntHVjqpjJA0Fv0aKB2PQTavsRocShG14ARSAHa+GclL44qb/BmeMURiSPV7gFaJQRbb/77PPoLbTMxNZKVZMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223041; c=relaxed/simple;
	bh=2lZ5V/nX1iTCy7BVZJ7gBD5a7/IYTZe5PDjKYesGk4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1wgLJGgDOKmO2AM7K1vwkrY92udKLrN0x+0m+yHDdaUXCw46hvOskTBu5/T2r53Z8ailvH0YsFteNcijv5gUPgPRIGAkFMo/3k6VlYGnyl6rPC8v5I6ZZO05Zq3lACwiKYcQKkjVS6CTWTd8m8rDQZgzOZY+LVhsfFXbGSPoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QA+MFhSv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA+MFhSv"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-719270b7c94so550995b3a.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 03:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223039; x=1726827839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3s7kQiLoUoCk885bOJnuIBQoRyEIFrpPcawwDNDjMb0=;
        b=QA+MFhSvZkV73ucyibS7Uh4co2RcS9gKbjXUoBPCmZ9GO6Tw6u0w3x9k7qTxlFrazg
         CbYMoAZ4Xn3JYOhD1J2P5cagEYSCH5BRFDEU4EiOiuMyc0Idc2NmVqceKETDJXq0LLVL
         rXrSrxe3N9ck/dEpDD3bdL4rRvq0xgIc61ZabgGH5rKJhGfQ0rsu3muuzj2lyCf4W1v6
         8sfAhg4Q9NxspD5Cb+v9HZk4L0yq1MPuxLm7QiXbpNTkAFehu0kitckGcaLl/bv4yJCk
         YAh4anZnu4rhdYlgY34O12+KFwRX5Dtid1Z+z23BFYXEca11rt0a8lshc8esiTvb7xuJ
         zY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223039; x=1726827839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3s7kQiLoUoCk885bOJnuIBQoRyEIFrpPcawwDNDjMb0=;
        b=VrAh9F4STcU1Rs0m0lMUfSBCk66Zutw9FGfkS13oSZtCtjHa7BiMsMEpDdbTDiQ53g
         3QTHfVPUazuyr3utTZwacX/67T1lY0udGNdi0DhDUbLGCSz+7/z25p8KYIYWFzznaZQJ
         LLFxkeAmmzYKdzbhGsFLp56eKTGqP13sYstSJAS2utwe1BF/H9EVP+ernE5F7FXSYNzO
         FCmCcpSKGKVVeiQTDjahFud45tK16d033AWfTZgAOfuWOiaGi94u35L9zXdjkWkMIrox
         6VdRnO5X//EjBzNcdkilxxJuk/JsImikFKUdZ2jgTmGWCfgCbMPxj/6+OR3cZGw/U+RJ
         Me7A==
X-Gm-Message-State: AOJu0YwDKZsdeqhAMPv3lQnLizuF1rzDIwLKrZY9+nmTH8gY/veY2mY5
	i3pddQgHiQk1Mf3XKHptrqSb6/QmcoU6QV0Gn4b32WIvu7P0hxZW
X-Google-Smtp-Source: AGHT+IFi1I7zEGXpRYMB+THa8AMwQkO3OVoult1aFAr/imhL4DaUjl8yrNLFJ5znfdDj9axarYh01Q==
X-Received: by 2002:a05:6a21:2d8a:b0:1d0:56b1:1c59 with SMTP id adf61e73a8af0-1d112e8bf37mr3281245637.32.1726223039277;
        Fri, 13 Sep 2024 03:23:59 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb581esm3146168a12.34.2024.09.13.03.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:23:58 -0700 (PDT)
Date: Fri, 13 Sep 2024 18:25:06 +0800
From: shejialuo <shejialuo@gmail.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] ref: add regular ref content check for files
 backend
Message-ID: <ZuQTApWlM8jOt9Ev@ArchLinux>
References: <Ztb-mgl50cwGVO8A@ArchLinux>
 <Ztb_HqLg-WvwA2I0@ArchLinux>
 <CAOLa=ZT8N7TRSVNhqGrjskMTTFgO16Q4VKMVM1LPHtEorkT6cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT8N7TRSVNhqGrjskMTTFgO16Q4VKMVM1LPHtEorkT6cg@mail.gmail.com>

On Tue, Sep 10, 2024 at 09:07:15AM -0700, karthik nayak wrote:

[snip]

> > +static int files_fsck_refs_content(struct ref_store *ref_store,
> > +				   struct fsck_options *o,
> > +				   const char *refs_check_dir,
> > +				   struct dir_iterator *iter)
> > +{
> > +	struct strbuf ref_content = STRBUF_INIT;
> > +	struct strbuf referent = STRBUF_INIT;
> > +	struct strbuf refname = STRBUF_INIT;
> > +	struct fsck_ref_report report = {0};
> > +	const char *trailing = NULL;
> > +	unsigned int type = 0;
> > +	int failure_errno = 0;
> > +	struct object_id oid;
> > +	int ret = 0;
> > +
> > +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
> > +	report.path = refname.buf;
> > +
> > +	if (S_ISLNK(iter->st.st_mode))
> > +		goto cleanup;
> 
> Since we iterate over all refs, we don't need to check the target for a
> symbolic link. So we skip all symbolic links. Makes sense. Would be nice
> to have a comment here.
> 

Today I am handling the reviews, there is a misunderstanding here. It's
correct that "We don't need to check the target for a symbolic link".
But we do need to check the symbolic links. It might be a symlink
symref. In here, we just ignore the implementation and will be
implemented in the later patch.

