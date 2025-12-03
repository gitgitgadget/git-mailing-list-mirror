Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85C2367D5
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764803991; cv=none; b=Fpi+D/Ca8k5cnkWxRMYL3iuFiXoFidB05JJ9KzPHh0xLLcWWjubd8T8tiKOz6EvDBgLV7gt5IY03I+0E6UCMwz/bq0dniKB0DWrToU/8gwMw3T9BqoJ0rCDA212E/LulXZwIr+dkeaxhi+HabDp1+VxbQqncseoUGYf2HqQu60M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764803991; c=relaxed/simple;
	bh=oXPwshJ73TvOmhH4anFVFlm7bYwmTQcsREB6p1WIZ7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsSQBk4e7Y/wX8l9CKjSOhIJ/3l6CO8Tj8YEDH5gKufI4/GMFa+Mdksr7FcebMz5t6DrGF+nrpC/XULw49QAZkGWogNgx1HUEXmj+T9gNUm2xT39lfuzRsqr/0QpsugV06Lt3PGSKJPoKuNZZ+yQiXglgYIrALUkTtvmvIKVR1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ZTuPzq8C; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ZTuPzq8C"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787da30c50fso3454327b3.3
        for <git@vger.kernel.org>; Wed, 03 Dec 2025 15:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1764803988; x=1765408788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqCFfgvoQ8MPZoGvfps01Uu4tx8tBPkwo2sBORo+UVI=;
        b=ZTuPzq8Csl7rVO5fNyQTOmHb4E/eNbtQEKpYbUeCYzFytWjSsIPmgtw7L5x/uToYXk
         S3SJ3XoHWtE4ymbe2JXEsECbPHqvM6UU00Dwmhdt8dYAtbTYWxIlMp00E+MG8HsQcgcX
         UtzourAeeRzwUTARsGuWdM5cCa0whRX6JbMBt/5hIZ2SVNY+BqaxmvnD6xe2DrWlSUVj
         APgDJRV9YkYlWpcwQi86dSgH96y3TiVmm5d+aaZbnRHueTNG25uvKXhu5gPvNO5tg19p
         YAVEVJVK3G5JTo8VN1H+DGPDp4ONILwIy8fGyRjeRp0+8Ene61BJoHRptcv7urjzX5tM
         X/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764803988; x=1765408788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqCFfgvoQ8MPZoGvfps01Uu4tx8tBPkwo2sBORo+UVI=;
        b=vqKTq+VRaAz7ctwgumawYRva9U8Z4aloEEjrpDzCHaqiMgaGKlPg8GR1oM1EVssdKG
         ki1ICVHLQGRl8d4lBzhikLBxxeA1Ssm6jOLsNrjyAeQOo63yEQAkOr8GNolrpMAO13KU
         JpREVgth4TANUBPFJQZGPiiKiijhoS/EPxg4tFOb2QelB6lYzdlm9ObJdIdMZrgHoSRu
         ousSnWHU6AgNdI/EPxLEjtKJFfPL3ZI1PR4AWdXOWturOIoPtDNLl129s/IPg4YPMrlN
         At+FCM5WoWDFIvRyVMgetfvrenT3tELbk44MDdvmdWiCQrmWGOljLbUyWd2binwmvqA6
         HX1g==
X-Forwarded-Encrypted: i=1; AJvYcCWnEOCvZArZqGoDs301Zs0HvrG8de5q1CLasPH4TmJ4yA/Z0XLUImwPbn/7Xm4rM+G4yb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHyfPtCqfEcTkLga/5obcJ6E1eJ0A9QhcVuGJdrizcQP6X2WX
	2TwUJH8EgHzskpeOlObnn5cQvJQXRzwGurPnGXFkzrdc5t75tvtm8HzdPu7WLObrQ8g=
X-Gm-Gg: ASbGncuqRgI3uhgiGxYiMPziNL/WdE/0MwJOCe93Zl9mShX1DkkgKsClxOHhbkuHu9Y
	gDF1CdaLMEbein7gT5GHkCB5MVc2bfR9PgxPRCefn95pDFkoztuGSlyK5ESvYC37CJ2D65sxNvH
	4pOhciogcOmKI/H2TiGbu100b/GmIjoQ/a9AdXONTTI5aKcSPQipUZi5CIq9/af4zCLSDZdJnfm
	PoUmVr3CoUa/53BOSbI62BPqU5huwdOW3mHTDrYTMM/PctDplwPIWuSxX0FbFKg0/pOnq89M16u
	JFV8pRD+DUzPPboFavDyWNdKUUfrZ10hb/CF3A530e7qiYZ/UGBVEzHVloARPGa1QPLHMWH2bZI
	KHETLHHvBoO3MK3o99JsxNuj8GZKyAZDfIaAtD9zjWoyP9BQ+hZ7Y+vHtWZPQsDTnBItrHBSLS4
	ImLNInbDRExXWWSHfR9FwsdvUY5eYZsF9eMVvRzlbgKr0FdHvtLvtSkiS5FUYAFAqWh1+yKweO5
	e7Xv1PFn9CZ/YE3FA==
X-Google-Smtp-Source: AGHT+IHV8TQzkALSZ+bvaefOi4zUb4OS48lE+dG5Cf9OkrXQZZLk+XC7fUJ5oL0bxOZfLDBiRErOcw==
X-Received: by 2002:a05:690c:4d01:b0:784:88df:d9d with SMTP id 00721157ae682-78c186006d7mr15221197b3.2.1764803988294;
        Wed, 03 Dec 2025 15:19:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78ad100bd23sm79204937b3.36.2025.12.03.15.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 15:19:47 -0800 (PST)
Date: Wed, 3 Dec 2025 18:19:46 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH] lockfile: add PID file for debugging stale locks
Message-ID: <aTDFks3RW57Ytwvq@nand.local>
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
 <20251203211610.GA64204@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251203211610.GA64204@coredump.intra.peff.net>

On Wed, Dec 03, 2025 at 04:16:10PM -0500, Jeff King wrote:
> On Tue, Dec 02, 2025 at 03:07:27PM +0000, Paulo Casaretto via GitGitGadget wrote:
>
> > The .lock.pid file is created when a lock is acquired (if enabled), and
> > automatically cleaned up when the lock is released (via commit or
> > rollback). The file is registered as a tempfile so it gets cleaned up
> > by signal and atexit handlers if the process terminates abnormally.
>
> I'm sympathetic to the goal of this series, and the implementation looks
> cleanly done. But I wonder if there might be some system-level side
> effects that make these .pid files awkward.
>
> Temporarily having an extra .git/index.lock.pid file is probably not a
> big deal. But for other namespaces, like refs, we're colliding with
> names that have other meanings. So if we want to update refs/heads/foo,
> for example, we'll create refs/heads/foo.lock now. And after your patch,
> also refs/heads/foo.lock.pid.
>
> The ".lock" suffix is special, in that we disallow it in a refname and
> know to skip it when iterating over loose refs. But for the ".pid"
> variant, we run the risk of colliding with a real branch named
> "foo.lock.pid", both for reading and writing.

Good point. I don't have a strong opinion on whether or not we should
use an append-only log of which PIDs grabbed which lockfiles when versus
tracking them on a per-lock basis. But I wonder if this would be
mitigated by either:

 - Keeping the ".lock" suffix as-is, so that holding a lockfile at path
   "$GIT_DIR/index.lock" would create "$GIT_DIR/index-pid.lock" or
   something similar.

 - Introducing a new reference name constraint that treats ".lock.pid"
   as a reserved in a manner identical to how we currently treat
   ".lock".

Between the two, I vastly prefer the former, but see below for more on
why.

> But we can see the writes in the opposite order, which I think can also
> lead to data loss. Something like:
>
>   - process A wants to write branch "foo", so it holds
>     refs/heads/foo.lock and now also the matching foo.lock.pid
>
>   - process B wants to write branch "foo.lock.pid", so it holds
>     refs/heads/foo.lock.pid.lock (and the matching pid)

Changing the naming scheme as above would cause us to hold
"foo.pid.lock" in addition to "foo.lock". That would allow process B
here to write branch "foo.lock.pid" (as is the case today). But if the
scenario were instead "process B wants to write branch foo.pid.lock", it
would fail immediately since the ".lock" suffix is reserved.

> I think both could be mitigated if we disallowed ".lock.pid" as a suffix
> in refnames, but that is a big user-facing change.

Yeah, I don't think that we should change the refname constraints here,
especially in a world where reftable deployments are more common. In
that world I think we should err on the side of removing constraints,
not adding them ;-).

> So I dunno what that means for your patch. I notice that the user has to
> enable the feature manually. But it feels more like it should be
> selective based on which subsystem is using the lockfile (so refs would
> never want it, but other lockfiles/tempfiles might).

Yeah, I think that something similar to the "which files do we fsync()
and how?" configuration we have today would be a nice complement here.

(As an aside, I wonder if that interface, too, could be slightly
improved. Right now we have a comma-separated list of values in the
"core.fsync" configuration for listing different "components", and then
a global core.fsyncMethod to either issue a fsync(), or a pagecache
writeback, or writeout-only flushes in batches. It might be nice to have
something like:

  [fsync "loose-object"]
    method = fsync
  [fsync "packfile"]
    method = writeout

, so the analog here would be something like:

  [lockfile "refs"]
    pidfile = false
  [lockfile "index"]
    pidfile = true

or similar. That could also be represented as core.lockfile=index,
omitting "refs" to avoid tracking it. It may be that people don't really
care to ever use different fsync methods for different fsync-able
components, so perhaps the analogy doesn't hold up perfectly.)

Thanks,
Taylor
