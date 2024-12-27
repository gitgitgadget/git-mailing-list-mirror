Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC01DA21
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308170; cv=none; b=bS+OhMEFilEBsdWnnsCO8D6SJfqXZK/5ZGaAZQcYd0Ac58N8wECeab8rI741PFtFiu1B0Jmax1gHr5cv3d3rP+pufumMCzaEJdAs3v4uFcXMr0dDehXgiKBnGznleXDQrQOPZZN0zpYcLEjrzoQWKj02Vnx5TTUFf+L5Ep4RjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308170; c=relaxed/simple;
	bh=a8Q5xuH36QjbjaNQIvO1FGwMt0JsuODGdIZvQdi3sq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLLayAQX2RKwyqFcDYhsZzf9s2Kuc0sAH6WDxwYJWnzPc0gP1GazrUC55NDC5it4mUAE408yu1DCcktj9JvIXVUcMj0uYdXMloKdeytcNUCF9y5ilKqPBJB4hKO2ZU3NRaDbL47NQkOdItg4lTyEmT5DAR4Sax1PUuxBHROIn/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kz15Xd39; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz15Xd39"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so8405873a91.0
        for <git@vger.kernel.org>; Fri, 27 Dec 2024 06:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735308168; x=1735912968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3wXz4IB0bGgd4pq3HYRfiXWldJHCKn2ubYbqoZ7Iuw=;
        b=Kz15Xd39YIvPyGl+qscrz7s9tnIZawL/GPuoJdgSh9Ch06hn6yC4f45Np/sdr/p3It
         M6a/eweksEqV+vdnyT/1F3XQ4f0oxSvOwPbT3K90/+xIdjfiF3IqV17qEQ8uChLq1HSY
         KKgcV6Zyxw7U9waYZwx0hb6+/Hk+ZjNYWvFroRguPoYI9fv//kqW+alLhJp5CP1VwwCE
         i9+Mx2EvjfABU0jMCe4Yz0iy+Mj2ELH3fMTKdP0ctNg3j97mszi8ExnNiRMRTfWSUc37
         34dLTSUSpzYEgAMpVfDfx00mtF50mio4CFWbRg+Tm0hjgEedTOTt/GYLJkpFV7ehlLx2
         8gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735308168; x=1735912968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3wXz4IB0bGgd4pq3HYRfiXWldJHCKn2ubYbqoZ7Iuw=;
        b=byWxw+RrrEpHz2tipiDwBFDh3PkIHoZXahPJ92J2IxNKw7kMaPErdpfx9no9mUEm5y
         a5pWBatjlLkYy+RNS7KaMkSmnEmZA/KHySJn6U6Ds/RFtnV6/T6F2QXx4QQbvP1NZ4gY
         DXYoz+bMVIXM+97xpg+0YzcbA64jjbfkjRIzW1MTk4gGSs48D/zfeEsK94s/+7Xy3JWA
         6ABkCWbF3DGS/Xu7G9tCAmxotCNSBqKr5uFEHrrO/Ur+H9C8Q2rFbyFlRu+VjodL+VrE
         kO2JmvanVl5+3NF4MoaqDUiOcgQTFlhcVC2R3MiKlmE7ilMWoS/T9N/rrqN6keFzxbOK
         9lwg==
X-Gm-Message-State: AOJu0YwanwtgV7+qw/IB8mpGE1Ekx6e0jMUrYKI0/khMXWYwvz6Ujnr/
	+t8gvWOlBzzMEBIyZzHoU3rfUAVP7UgCUrhB22ra7wLk8OZDU+xogCPUAQ==
X-Gm-Gg: ASbGncu3vzdoutIAzw7yCgcSI3ypPomsca+wgnCl56sQur5nvVRZREodLgM784ine9e
	dvF+87ACaTRPs4NoDtnqkw0L+xs5gj7uFJ5LFPlbqqyMdBUVB6f65RHJSU5bF1sohzJdwrMBz7D
	77kelBCAG/s+6iEJrznZWQdYyC8H5XOt+86rdMy8eDZWCgZZ+9x1grV0wsf7IFbC+gjrr8YeNzq
	pn1L2fYtls9lxLrUZlWrqdrnMLVUCaC2f7agWx356fb8IQDL9xj
X-Google-Smtp-Source: AGHT+IFHuvMmpY0TxhESGqoXy7pAWHYjnB2kQ/Nq4MMv2S1CSRgxiAYYYUAq2B3YKpz0lxUUavd3aw==
X-Received: by 2002:a17:90b:54d0:b0:2f1:2e10:8160 with SMTP id 98e67ed59e1d1-2f4536d193bmr39730472a91.11.1735308168344;
        Fri, 27 Dec 2024 06:02:48 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde2csm135963415ad.156.2024.12.27.06.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 06:02:47 -0800 (PST)
Date: Fri, 27 Dec 2024 22:03:39 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] builtin/log: fix remaining -Wsign-compare warnings
Message-ID: <Z26zu7X7VCSX3yn9@ArchLinux>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <20241227-b4-pks-commit-reach-sign-compare-v1-7-07c59c2aa632@pks.im>
 <Z26p9GJbmyUd6bG-@ArchLinux>
 <Z26yPlLMlxyecZVk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z26yPlLMlxyecZVk@pks.im>

On Fri, Dec 27, 2024 at 02:57:18PM +0100, Patrick Steinhardt wrote:
> On Fri, Dec 27, 2024 at 09:21:56PM +0800, shejialuo wrote:
> > On Fri, Dec 27, 2024 at 11:46:27AM +0100, Patrick Steinhardt wrote:
> > > @@ -717,14 +715,14 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
> > >  	unsigned long size;
> > >  	enum object_type type;
> > >  	char *buf = repo_read_object_file(the_repository, oid, &type, &size);
> > > -	int offset = 0;
> > > +	unsigned long offset = 0;
> > 
> > Why here we use `unsigned long`, is this a special situation where we
> > cannot use `size_t`?
> 
> Mostly because other variables already use `unsigned long` here,
> including `repo_read_object_file()`. So given that our object layer
> doesn't support `size_t` it wouldn't make sense to use it for the
> offset, either.
> 

Make sense. Thanks for the explanation.

> > >  
> > >  	if (!buf)
> > >  		return error(_("could not read object %s"), oid_to_hex(oid));
> > >  
> > >  	assert(type == OBJ_TAG);
> > >  	while (offset < size && buf[offset] != '\n') {
> > > -		int new_offset = offset + 1;
> > > +		unsigned long new_offset = offset + 1;
> > >  		const char *ident;
> > >  		while (new_offset < size && buf[new_offset++] != '\n')
> > >  			; /* do nothing */
> > 
> > > @@ -2183,7 +2182,7 @@ int cmd_format_patch(int argc,
> > >  		fmt_patch_suffix = cfg.fmt_patch_suffix;
> > >  
> > >  	/* Make sure "0000-$sub.patch" gives non-negative length for $sub */
> > > -	if (cfg.log.fmt_patch_name_max <= strlen("0000-") + strlen(fmt_patch_suffix))
> > > +	if (cfg.log.fmt_patch_name_max <= cast_size_t_to_int(strlen("0000-") + strlen(fmt_patch_suffix)))
> > 
> > A design question, why we don't change the type of
> > `cfg.log.fmt_patch_name_max` to be `size_t`?
> 
> The whole infra around this uses `int`s, too, so changing this variable
> here alone wouldn't suffice. We'd also have to adapt option handling,
> config handling, `struct rev_info::patch_name_max` and other bits and
> pieces. So in the end the size of required changes would likely balloon
> and thus I decided to not go down this rabbit hole.
> 

Yes, I agree. If we do this, there is a lot of efforts we need to deal
with.

> Patrick
