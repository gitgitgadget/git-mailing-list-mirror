Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196281F9A9F
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586680; cv=none; b=mU0M8eV/58+LaxZ7OE1qu4to+807JbpHo3Lt4lZ63xDp47733FyeIbXRkI1oq+Rm/Ko3GT13lsZdJ4M1PP4unue04E5Jylih9zKExUSRj4Mxs7KmVbEeQNAK8yEFmCuKXJN7ljdoJIrGbhPhfSxJXnoTau3ISu0h9qCSW45gdCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586680; c=relaxed/simple;
	bh=cO+fc3BjEdyHCfBbNd9k3bPmvJIilQS6eE60NXoNHKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNBUXqufeJUCKrbZJHJsBuUOsJUhJCRoF0ukbFVUsxO4aOjZVn8QfzIGiiTLXCPZielmw2av6+TGLMwXpwrMCTduSyTB0zS58TTHSQ/jvpxDVUdIQ6EJa4LBMIYPgqBdj9RzkVQdcPuOYSww0Zk7GRFDM4RMA0w8U7rsKWLLQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMVcI/T6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMVcI/T6"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21145812538so4089095ad.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 04:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731586678; x=1732191478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6qDSykKBKPb7jOSKBINvAHDJEODXQPkVR204MMVDHc=;
        b=ZMVcI/T64AM7RVAcnBTSRdLxFHy0Jw3KWtzQVz8L2SBf3Nw6Ls/QoPl9RYTA09mpzr
         D/Vz5T49XR6rfV+hkw/xWlYq3Mdj3oj7wLThEJmQqXNJAtBO7AhTp4X6agIEtXtDqIPZ
         Z1qKXR07WeiS2L7mPZii4uQnA1U3JSoW8gliXuqF5KBjahpLCjUACkzQj0YqbK6R+ZBe
         LZk3UeAmtjiZDkAb9epzb5/jsDmqO7xS4hiihN40rxlwvFDTAqDwKzkmGGRvOMOGc0jS
         CfT0kX/VMbJo8JE6aW+1lup0wPJ9ETNkZBFiTfDyKh2zq9Wfflvu2APqXLHjkpeh4j2p
         L2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731586678; x=1732191478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6qDSykKBKPb7jOSKBINvAHDJEODXQPkVR204MMVDHc=;
        b=bboUnl/YwOBdVhqiYkz9bq5CZBANKinHapbB2KrjhflWLYkdt+VFPwEsjRalYENgYR
         LeGT8kOyQ80tkZMGWPDaQxOrnoSAykUw8KraC/pbkHhJYfyhfKtkjQDQ317yOT981d8M
         jNVi3IDVqMxbyS/3dkRcs5evCGe9BUhV7Yleh+4VxB5XhDzYzTzh2oSH0/y66gTV6Emw
         Q7C+18Cc+I4qxFWTknSS7hbhBurOV+9P00R9JbvBVqjbnFpI5rcP+Gb9s1iocHnYINrX
         84nl/9XqE9KA9yb6IwFmKll/mVfFjarfJVfY8zvoVn+2fDotwOcTCe6K1qITExb6zq3e
         WvkA==
X-Gm-Message-State: AOJu0YwKt/4kttJp+sYNKOxVlUFWr8WwnTxk5TxCXWDi4xivMNxq4LOi
	O8Rpnht9Y/yOejBPjsuucy0FIjDmsrywfDtiak6dFH40hTRPGNaf0UrzXg==
X-Google-Smtp-Source: AGHT+IFJyAUmnDr4m7qqAHYamEmUwAlCB4Skod0Pf405XV/zcbj0V7NUfhUT41r6hR7UUnhfoKNuTA==
X-Received: by 2002:a05:6a21:398:b0:1d7:ca7:bfce with SMTP id adf61e73a8af0-1dc22b9243fmr29737578637.42.1731586678158;
        Thu, 14 Nov 2024 04:17:58 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9a8d03sm1135491b3a.126.2024.11.14.04.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 04:17:57 -0800 (PST)
Date: Thu, 14 Nov 2024 20:18:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 9/9] ref: add symlink ref content check for files
 backend
Message-ID: <ZzXqeLGF5dfSlh1s@ArchLinux>
References: <ZzCiCGxL4Adnd_eq@ArchLinux>
 <ZzCis8E49O10O1zr@ArchLinux>
 <ZzRW8M39-hw1E9-h@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzRW8M39-hw1E9-h@pks.im>

On Wed, Nov 13, 2024 at 08:36:16AM +0100, Patrick Steinhardt wrote:
> On Sun, Nov 10, 2024 at 08:10:27PM +0800, shejialuo wrote:
> > @@ -3572,8 +3579,30 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
> >  
> >  	report.path = target_name;
> >  
> > -	if (S_ISLNK(iter->st.st_mode))
> > +	if (S_ISLNK(iter->st.st_mode)) {
> > +		const char* relative_referent_path = NULL;
> 
> Nit: the asterisk should stick with the variable name.
> 

I will improve this in the next version.

> > +		ret = fsck_report_ref(o, &report,
> > +				      FSCK_MSG_SYMLINK_REF,
> > +				      "use deprecated symbolic link for symref");
> > +
> > +		strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
> > +		strbuf_normalize_path(&abs_gitdir);
> > +		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
> > +			strbuf_addch(&abs_gitdir, '/');
> > +
> > +		strbuf_add_real_path(&ref_content, iter->path.buf);
> > +		skip_prefix(ref_content.buf, abs_gitdir.buf,
> > +			    &relative_referent_path);
> > +
> > +		if (relative_referent_path)
> > +			strbuf_addstr(&referent, relative_referent_path);
> > +		else
> > +			strbuf_addbuf(&referent, &ref_content);
> > +
> > +		ret |= files_fsck_symref_target(o, &report, &referent, 1);
> >  		goto cleanup;
> > +	}
> 
> I wonder whether this logic works as expected with per-worktree symbolic
> refs which are a symlink. On the other hand I wonder whether those work
> as expected in the first place. Probably not. *shrug*
> 
> In any case, it would be nice to have a test for this.
> 

Correct, I have ignored because I add worktree support in the later
version. Let me add a new test to verify this.

> Patrick

Thanks,
Jialuo
