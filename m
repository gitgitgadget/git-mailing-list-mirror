Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FAE238D22
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806452; cv=none; b=tIqXwghLwe/BF7CZ3yETQ0S5JViTNrVgTcIB69/dTyLoVZu+G+KAmcj4Hv8zCyeMSnJmJxvzZqlMw8anltFBdOqMAqiPNKzwOOQpMswaNdtl5ZjhU+sN7/F/092esCDULoZvdgQdAP0tfDWxTpF0q48uPL+MO5vE7NGwFQuU7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806452; c=relaxed/simple;
	bh=gLuPfzX9KhPRQFHe1Yq4Dsl5Zz8E6d7u+COLR/GRLCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+dBJWU0FbL03RYm6jVNGElYM5kDKovCVaojC5nX0OgB+itWEHufZEz4mXniFNm5lB0akwmhrGu17Qj1b2vLHbDwnUn3HEJFwSra2CNsFo6l6oVShhy4OAHGI5QLC8SbuZHStGfpxAQmQ7xcmcueh8KE5MWHIQ1nLahY/PXxp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/qZ6aAS; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/qZ6aAS"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3588a4b1205so695650fac.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758806450; x=1759411250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJC3HwVGH3w89hwlALK32iHFjpRHPjSUrdX7WM0ANos=;
        b=O/qZ6aASM/SIyDahrHfEtz3vCm4ls0lI17ua1TaqEBUy8TF+LhKTe0YAax7eLfwikb
         18mQYgYsNQmpbaHM5w1zXLNDnBTv82M/IewMcbG+CjUtjETWN0xly2bPpPzIKDUCfcdM
         8usTumObr0hTp1TDDZ8fHlIE0xp9/5Su0eEjrRjLUf5zW/qmbpsxptXdbh3XX7eZErec
         qS7jfKqRFZESSdSvRtYifz8hsiaNbYSbnhZGDiFjl3Vugr0Sdbbn1T3NyQyK5ubqD8e2
         /fm9Zbsk1LMVdJdptDT60uj18xUdrlNFHJCoK9sbYuTJn1Brgyl2u9qYjU8YWH2cZkIt
         Q4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806450; x=1759411250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJC3HwVGH3w89hwlALK32iHFjpRHPjSUrdX7WM0ANos=;
        b=l9skDqD8HYIkn6iwjzK/4vz67A/E9cEKhDMNggStPIWRYZ+bbTpMnrzh+muAXp00fb
         lKaqwuc47Pe1QEo8oW2m8W2d4/y83oMMCCAjvYS3b3kSK4HOLQiEwXdU8xYP/p1YwApT
         1DaKfPcyfH8CkffT4oxhKOWvdPP/U/zRhrSVlRc74RWoguujRb/exnIjPQcG990ikgrx
         Jr5DgpNeI8ZdJhNHvB2cMZK31unBBEikRVIgmWoW7UFQ5ept0oiUJq6Pdu2PGep8Wjhl
         yJRocZkZwWZpODPx33YICuBAb4LJfmRHWXYA7drip5Pt+0z/crBi2g3QJoDHsuYAL7VD
         2h1w==
X-Gm-Message-State: AOJu0YytRxQKGla2oNcdlP3wvtkGZRNIQX6IO23TmXvSMDqrtmm2ZXv8
	T4q6qQMfUWKXG9PE+Ook2Fvfn0ur3tIkvVZjczj1Kc6SP61Gzue8eeQt
X-Gm-Gg: ASbGnctoez5vICBL5+zPKWaxPXUXJMJgoEdoGwFBW2xBXpFudSHL45bL/2VyAG92FId
	tlRcPm2a/zj5zWAsbmguHFkanbaRCQpiTK2N8Dn9pfK9KrA6Cwnfnqaxqj5F/ImIMifgNrFZ5OG
	saJvSPycP0z7XKRLGfd3v9inP6TwMzRrCKcFYShHsHrra9MgRMS7wKJAU9kwpbmM8PjIrxujA7K
	XqZ+k2zLwJn3SfCpDo8WvsjULOIWXoJaV1L/U/Sti6n1UwxsUUzqniKF3A/kst3YYr66HpgWuQn
	utGr8lmPnRyJT/Z0jOxBFFYoGZNO+lXj5NBSBOkc/8615b+0s2Z6ai0rj0PlRAcJH5VOwXfZadm
	qD5ppzQymBoJGr13y
X-Google-Smtp-Source: AGHT+IETXhFYkg9woP5U5xiMHs/MEMGW8rDZUUEfsC5SAasNfiyClZE69eB5ERupWz7xF6P0ZzllMg==
X-Received: by 2002:a05:6870:f6aa:b0:349:de3c:bfbc with SMTP id 586e51a60fabf-35ee920185emr1550430fac.33.1758806449727;
        Thu, 25 Sep 2025 06:20:49 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-363b055c3c2sm558021fac.21.2025.09.25.06.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:20:49 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:20:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH v2 6/6] builtin/repo: add progress meter for stats
Message-ID: <ehjxy2qvwhrtmyvmjv6hu5ej2pslomjn476mlkkodmbxwutel5@yx6an6nj75p4>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
 <20250924212426.2930029-7-jltobler@gmail.com>
 <aNTVgnEGE2qUwZwK@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNTVgnEGE2qUwZwK@pks.im>

On 25/09/25 07:39AM, Patrick Steinhardt wrote:
> On Wed, Sep 24, 2025 at 04:24:26PM -0500, Justin Tobler wrote:
> > diff --git a/builtin/repo.c b/builtin/repo.c
> > index fe7d43f78e..fdc8af92dc 100644
> > --- a/builtin/repo.c
> > +++ b/builtin/repo.c
> > @@ -344,8 +345,14 @@ static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
> >  	strbuf_release(&buf);
> >  }
> >  
> > -static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
> > +static void stats_count_references(struct ref_stats *stats, struct ref_array *refs,
> > +				   struct repository *repo, int show_progress)
> >  {
> > +	struct progress *progress = NULL;
> > +
> > +	if (show_progress)
> > +		progress = start_progress(repo, _("Counting references"), refs->nr);
> 
> We tend to use `start_delayed_progress()` so that the progress meter is
> not displayed when the action takes less than a second. The delay can be
> disabled in our tests by using `GIT_PROGRESS_DELAY=0`.

Good to know. I'll update in the next version.

[snip]
> > +	object_count = stats->tags + stats->commits + stats->trees + stats->blobs;
> 
> We have this computation in two locations now. Maybe we should
> deduplicate it via something like:
> 
>     static inline size_t stats_get_total_object_count()
>     {
>         return stats->tags + stats->commits + stats->trees + stats->blobs;
>     }

Make sense. Will add.

> 
> > @@ -417,8 +442,12 @@ static void stats_count_objects(struct object_stats *stats,
> >  		}
> >  	}
> >  
> > +	if (show_progress)
> > +		data.progress = start_progress(repo, _("Counting Objects"), 0);
> 
> s/Objects/objects/

Will fix in the next version.

[snip]
> > +	stats_count_references(&stats.refs, &refs, repo, show_progress);
> > +	stats_count_objects(&stats.objects, &refs, &revs, repo, show_progress);
> >  
> >  	switch (format) {
> >  	case FORMAT_TABLE:
> 
> Should our tests be updated to verify that we know to print progress
> depending on whether or not `--progress` is passed?

That seems reasonable to me. I'll add a test for this in the next
version.

-Justin
