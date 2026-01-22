Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CD3DC5AC
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769125662; cv=none; b=t1DdWN8Jf5MsoLyUjEJhFM8NgotH7XuMIkl3N3gww2MbdsHSUuZuXGryrgQ85sHAZdC303XDicD8IyVqo8k5GJ3rK34aLb+dggKxmzkUthznUGIqW9fWfSNkEzNPjNr5K0zRWegtWODdcdXTDmWYI7EWsND5xPuT82KGxfAOP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769125662; c=relaxed/simple;
	bh=tRFp/rNdLEvrmFOkMBEB3/bpkpqPzTJm1MgVWOZPAqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACxeUANrTf+94Amxz+9WfCaaJrI/oqnEVeKVjg5+g2XK2gQHnGJJvkQKXEDEBDwkLfXOAmSDhXwjqXzLjKEZGoliyyXlddIzrYtXZn+I7IF7iVFoe6vE2zCgGRe6xh+OvexgiaaaQ7Zh01TZWkLYWuNrGm5hdWNu9FcvzK220VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gigkgNDY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gigkgNDY"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c0f13e4424so160576885a.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769125655; x=1769730455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tRFp/rNdLEvrmFOkMBEB3/bpkpqPzTJm1MgVWOZPAqo=;
        b=gigkgNDYkjnpBGpv/t9NodjhHuk9v6fv21G+xgqdQHMRAASGljZX9mGrE+RpLZG5Qy
         5TRmboeIcexbCUCb3ivH/5GJq2/PNrtyOBkQD5lhzk39l90sRH+zqFDeHm/bZ4+vtcwC
         ZmtucTVWFqSxJhjl9buLr4LWDewqMhGIpt+lFG6w7INMFVuCdi3E2Am+trZmstzXf15z
         IGvgoEpCma3Hmo6XKQdKK2FbWjncE5A1c97g3wk0esJFevw12nPO12i/UaXTC23uCACI
         ryEA2f0ZH4mkP06zmfWUtDW/YEZcDRuemkfxJEGs/xFSjYD5aq5M7coXNN/B2wnSUINL
         Suxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769125655; x=1769730455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRFp/rNdLEvrmFOkMBEB3/bpkpqPzTJm1MgVWOZPAqo=;
        b=l0xV5NjSPxBytOKDiNZ4/CTNmj2gejPnYm0nrp++7FJQUP9KZrubLHVE9Ji2es0KN5
         xG6orJ9MmP6JB5+oGOXA7rjn4QcWDYvk34c6Qa0OeYpiCjjLB+a7Ywaa01JDNnehud+Q
         tWsoWW4KsnzhrvYZlJZ6URP+tXOzCio3xmuaF1WZKOaCA04wkgWbJRSohN3vKSHgR9o7
         D8mGJVbAXNxom9r55CoLtiHEzCVwneWX4nt7tNYha+kLubiPu8pbDRKffWhZ7hoOZYYJ
         F1UAi0i8ad/9cOyi80N86ELh2sHLNOG2j5eqO6RmgPlCC/wWaIVZVsPAryVyTM7sf/aq
         Mc4A==
X-Gm-Message-State: AOJu0YxHGn4x9pJignXIXwWGp4+XWq5Uf5B/FsAt7StgOlyIDkT+5RJF
	66hVhOwC1VVbSS1pZBI8FOERJlwRLnjnqrxNaX3/EK9Xjh+93lTsvlqDnbn76L+rUpc=
X-Gm-Gg: AZuq6aIo2RnOMo944KQlKgS0zMMo4yNNrK+WMfgCpDJEygJSCQex9HVXkiJu9/317MU
	Awaf/GZCK7B6neQo80yreDBMhNLW5Imgv4YWLVa3U+d64UeAAMqUK99r1gObmYMu1Fi0SbLjzqU
	ZuLc2/z31Xesyv3TaidSNThkvsd+uow4FYxBfhNnDcWl0sM5A+IH4TOmPdx/OdHbSevwfTVlnN9
	TVRFjBKIGCda4pEPSRzkY0kiyqY7XKz5b70v4m88GAu32Lwmj61PS9D+UayJRM065uDaPRabCeH
	RvW0BxV+8ARlL1bBa2mAUGXpb/cu+onFUP5kxB+Eqzkr88F9+ZM/anYfBVt9GOpjE3xdlQLmv5L
	36keNunX5eimWy9eY20OrMO2VGxTYLQZ7Cye1uT9Pu4XtkTQNjLjuwu8sDHt3miJOreXPlfyhUS
	RS1m+Ge4oqwCrgXm6ZZCN2/kVPeUT/dLKTd+AYboxBEi4n0OUTVyBHAzm3/kNV6W8VNjHHaBSJP
	xuf1c5MYWMnzitdcYAhI/lr8z4K
X-Received: by 2002:a05:620a:2a0e:b0:89e:f83c:ee0c with SMTP id af79cd13be357-8c6e2e46003mr135527085a.74.1769125655173;
        Thu, 22 Jan 2026 15:47:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e3854a87sm45447185a.42.2026.01.22.15.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 15:47:34 -0800 (PST)
Date: Thu, 22 Jan 2026 18:47:33 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/14] object-file: extract function to read object
 info from path
Message-ID: <aXK3FV8MoEBeAcu9@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-3-12c4dfd24227@pks.im>
 <aXFpcms/adskOx3X@nand.local>
 <aXHI_Q_88q1aAXlW@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXHI_Q_88q1aAXlW@pks.im>

On Thu, Jan 22, 2026 at 07:51:41AM +0100, Patrick Steinhardt wrote:
> On Wed, Jan 21, 2026 at 07:04:02PM -0500, Taylor Blau wrote:
> > On Wed, Jan 21, 2026 at 01:50:19PM +0100, Patrick Steinhardt wrote:
> > > Extract a new function that allows us to read object info for a specific
> > > loose object via a user-supplied path. This function will be used in a
> > > subsequent commit.
> >
> > I think that I'm a tad unsure of this interface. I understand that for
> > the existing object storage mechanism that having a path makes sense:
> > loose objects are stored in files which are referenced by their path.
> >
> > But this feels like a leaky abstraction to me. If we are dealing with an
> > object store implementation that uses entries in a database, or
> > arbitrary blob storage, do they have an equivalent concept of "path"?
>
> It is leaky indeed, but that should be fine given that it's local to the
> loose object backend anyway. So no other object storage format uses or
> even sees it.

If it's local to the loose object backend then I agree it's OK here.
I think I was unclear that was the case since I saw "path" being used in
conjunction with the generic "odb_source" type.

Thanks,
Taylor
