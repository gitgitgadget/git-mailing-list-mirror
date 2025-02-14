Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D1B22B8CF
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536567; cv=none; b=XwyOQCXbZ5Sa+boHlj/5oz4KsHQdvLEaTd/sAMJm+Qm4DZVYP0pLojB4Zvm7b+0fw5e1afzda7WwMeuF/u/WDFMlCp7PIut2EHC0JJsiUN7Rhk1zDda4PRSVsoK9M8lmHoxNpKodMpNnO6d24SfPry0C4Qcboc/nR8y2riq8iGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536567; c=relaxed/simple;
	bh=A6GrvlfD8urrVLTctGUXiORAOCSZwWJYYOs5Dj93nRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsGmwwJ3XuLWRd4u/hRlWYPguk9Sech8ddUe0SzBf5lnnUatc0C1Qih/Ij7Wbdr6ds8honuhrSTm/EsVb7//j1fdmNcxnU4hd9wj7sh+errlb78hiVaHu9DY6Y35U6ZnBAVsQbrx/Rz0Zm5hPxF+KJpaeWjSfB10VK9BwYEM5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je2vO4eI; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je2vO4eI"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e479e529ebcso1524082276.3
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739536565; x=1740141365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSVifD8SikBjt9FLrQqfBy3KkEshYPHcyUboXoUgE6Q=;
        b=Je2vO4eI1nPj+zGFFInaTUkHfh4cTxJ/xXIQx7PmiJraCPcI8fu+rexSjWqeK8HLgd
         gqO+R3tW6O72q4etQxYIW74kRCP4KQ77qNzFG44LEqDiDFKl7nTq81E2zJ4ty6gTHCw9
         5hqTpE9g3s7hgJ5lhpblAGW5tU3UgazNQ5WQIoaL06tKfat0TyHjUfhg6V3yOanmJ5Ck
         GvqVn0kfjGrae/CwQzjjRyfxmPa/J1pi0y8/fzHQay+HsKLQkvVEHrI23Gea/LGleslo
         3vAK2UqMNQNDfZmsudyuHrt6yVRO785uuAJMllvXB/vdt/rAyqZPRJlYK46utgR81dpj
         +TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536565; x=1740141365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSVifD8SikBjt9FLrQqfBy3KkEshYPHcyUboXoUgE6Q=;
        b=bugPvJW1ew1c9W3ZjC9SysIIopxLiPdFf7tZBmnkJKwxbCe/XkMv9G7S+hvF0JmXrA
         /r+Nz3eibQL+mCR5vTMuR7S/zXfVm8KAV+M6KLfqVXhIUj6vzDoOpQsyDUnwSHH/tIQN
         CJfYInqlpeA/jAAw7BBKU2s/9r2NL7MoicowarXJ/9pTFlLNwae1KJBBCsV77Q1Esm2h
         bDSRdUos8L6IRPwDfTwOliD70qiFrL7JG0IwJSzM5ZbRdfI5GrHaMXRJNK5TrvG9uLZx
         2Nu449b7QJnnwU7i3/KZPh8u6nfwZkzkHMaRjTU6P0DLL2XzD4KqILUkcqdYo4+ck9qJ
         Lzag==
X-Gm-Message-State: AOJu0YwLrwbSEg6Ad5I9l2Rax0rZU9Iicy5R7FIjUj9zRl0KWFS/qag+
	axRKihnjNaN3SRVf8uA8zqTIHvJQrZhx7tyUx9TUAzbc3CZ5TAu1
X-Gm-Gg: ASbGncvkQj6XVwOIAzTkD1KleGO9lDHcCzOXHJpL0iVZui3wk0ZKMgiSDZhW5xeoEVQ
	9Dy0vP6LkrN/uDpjlrt1E+U4ob4Zrk+zsUwB7wbUMCDwHSvE9l+6t76pvO89hzhh028NCv0arXl
	zCq3e8GbLzBzJgF/L7BQOjNKgu+Vkgzz6+lNtlWaE6nOVe1AiSQ+GWDllEdz3xXs0iHgGlmVK/A
	IhTiovEJhEqcp/4a5FSN/yE0u4HcUwIJ3bbpHbsIlIMqU74QiazgBy8W7gXfQU9xwiR8Q==
X-Google-Smtp-Source: AGHT+IHU+LaF5Hk3/DKuvlgLDAOamtRYVbNJQLn+jEaSDIhie1ySo39VC+muA+Ghu88A52+e2Yg0Xg==
X-Received: by 2002:a05:6902:2289:b0:e5d:c11c:3494 with SMTP id 3f1490d57ef6-e5dc11c3b5amr714641276.30.1739536564825;
        Fri, 14 Feb 2025 04:36:04 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e5dadfc0919sm954998276.34.2025.02.14.04.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:36:02 -0800 (PST)
Date: Fri, 14 Feb 2025 20:37:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 3/8] packed-backend: check whether the "packed-refs"
 is regular file
Message-ID: <Z685JSRGeZA2fuFq@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux>
 <Z67MDPtjoXQB2sGB@ArchLinux>
 <CAOLa=ZQ7CAXP-bYzTv3GJhauwtaL+pFj-2_QPWBh7SMiMsa6bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ7CAXP-bYzTv3GJhauwtaL+pFj-2_QPWBh7SMiMsa6bQ@mail.gmail.com>

On Fri, Feb 14, 2025 at 01:50:26AM -0800, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > Although "git-fsck(1)" and "packed-backend.c" will check some
> > consistency and correctness of "packed-refs" file, they never check the
> 
> Because you say 'some' here, it made me more curious. Could you state
> exactly what checks are being done here?
> 

Well, I don't think we need to elaborate on this at now for the
following two reasons:

1. We will explain this in the later patches.
2. Here I just want to emphasis that it does not check the filetype.

> > filetype of the "packed-refs". The user should always use "git
> > pack-refs" command to create the raw regular "packed-refs" file, so we
> > need to explicitly check this in "git refs verify".
> >
> 
> Not sure I understand how the start of this last sentence correlates to
> the end of it. Is the intention to say that we want to explicitly check
> the filetype to ensure that the 'packed-refs' file was only created via
> 'git pack-refs'? If so, perhaps:
> 
>     Verify that the 'packed-refs' file has the expected filetype,
>     confirming it was created by 'git pack-refs'.
> 

Thanks for the suggestion, I will improve this in the next version.

> > We could use "open_nofollow" wrapper to open the raw "packed-refs" file.
> > If the returned "fd" value is less than 0, we could check whether the
> > "errno" is "ELOOP" to report an error to the user.
> >
> > Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
> > the user if "packed-refs" is not a regular file.
> >
> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  refs/packed-backend.c    | 39 +++++++++++++++++++++++++++++++++++----
> >  t/t0602-reffiles-fsck.sh | 22 ++++++++++++++++++++++
> >  2 files changed, 57 insertions(+), 4 deletions(-)
> >
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index a7b6f74b6e..6401cecd5f 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -4,6 +4,7 @@
> >  #include "../git-compat-util.h"
> >  #include "../config.h"
> >  #include "../dir.h"
> > +#include "../fsck.h"
> >  #include "../gettext.h"
> >  #include "../hash.h"
> >  #include "../hex.h"
> > @@ -1748,15 +1749,45 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
> >  	return empty_ref_iterator_begin();
> >  }
> >
> > -static int packed_fsck(struct ref_store *ref_store UNUSED,
> > -		       struct fsck_options *o UNUSED,
> > +static int packed_fsck(struct ref_store *ref_store,
> > +		       struct fsck_options *o,
> >  		       struct worktree *wt)
> >  {
> > +	struct packed_ref_store *refs = packed_downcast(ref_store,
> > +							REF_STORE_READ, "fsck");
> > +	int ret = 0;
> > +	int fd;
> >
> >  	if (!is_main_worktree(wt))
> > -		return 0;
> > +		goto cleanup;
> >
> > -	return 0;
> > +	if (o->verbose)
> > +		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
> > +
> > +	fd = open_nofollow(refs->path, O_RDONLY);
> > +	if (fd < 0) {
> > +		/*
> > +		 * If the packed-refs file doesn't exist, there's nothing
> > +		 * to check.
> > +		 */
> > +		if (errno == ENOENT)
> > +			goto cleanup;
> > +
> > +		if (errno == ELOOP) {
> > +			struct fsck_ref_report report = { 0 };
> > +			report.path = "packed-refs";
> > +			ret = fsck_report_ref(o, &report,
> > +					      FSCK_MSG_BAD_REF_FILETYPE,
> > +					      "not a regular file");
> > +			goto cleanup;
> > +		}
> > +
> > +		ret = error_errno(_("unable to open %s"), refs->path);
> > +		goto cleanup;
> 
> The paragraph in the commit message:
> 
>     Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
>     the user if "packed-refs" is not a regular file.
> 
> Gave me the indication that any error would be reported via
> 'fsck_report_ref()', but it seems like we are only reporting for
> symbolic links. Why is that being singled out?
> 

IIRC, when Patrick told me in first version that if I first stat the
file type and then use the `strbuf_read_file` to read the content, there
is a corner case that the file could be converted into symlink between
the `stat` and read.

So, I use `open_nofollow` to avoid this situation. (Actually, this could
not be avoided because in Windows, we would first stat the file and
then open the file due to that there is no "O_NOFOLLOW" flag for Windows).

I will find a solution to do this in the next version.

> > +	}
> > +
> > +cleanup:
> > +	return ret;
> >  }
> >
> >  struct ref_storage_be refs_be_packed = {
> > diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> > index cf7a202d0d..42c8d4ca1e 100755
> > --- a/t/t0602-reffiles-fsck.sh
> > +++ b/t/t0602-reffiles-fsck.sh
> > @@ -617,4 +617,26 @@ test_expect_success 'ref content checks should work with worktrees' '
> >  	)
> >  '
> >
> > +test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit default &&
> > +		git branch branch-1 &&
> > +		git branch branch-2 &&
> > +		git branch branch-3 &&
> > +		git pack-refs --all &&
> > +
> > +		mv .git/packed-refs .git/packed-refs-back &&
> > +		ln -sf packed-refs-bak .git/packed-refs &&
> 
> This still doesn't make sense to me. 'packed-refs-bak' doesn't exist, is
> the intention to symlink '.git/packed-refs' -> something which doesn't
> exist?
> 
> In that case why even make the effort to build a packed-refs file, could
> we simply do 'ln -sf packed-refs-bak .git/packed-refs' in an empty repo?
> 

You are correct. My intention is not this. If the "packed-refs" is a
symlink and points to file which we can successfully parse. Current Git
won't complain. So my motivation here is to imitate this situation.

> If not, then 'packed-refs-bak' is definitely a typo and needs to be made
> 'packed-refs-back' which would go in hand with how we setup the test...
> 

Thanks for noticing this problem. I definitely made a mistake to type the
"packed-refs-back" to "packed-refs-bak".

Jialuo
