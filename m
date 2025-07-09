Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506C111A8
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091883; cv=none; b=UtTK9wpt7TmardFrp54wa/LyCFaWfRmpQVspqMVlW1GM0qX5vGggKroGRah7IXMI1EvUCl+qJT9R5JkjZpQHr9LjDp5klwXH6s8NE8b3E0e1K7gQvKZ++bZTiDOkJ+OXa1wSHwm5NMWYZUbyOy5i4kUCNqwi4aTf+DGmyBfZBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091883; c=relaxed/simple;
	bh=pO1ful3+ggC3f9Rtk/d/ZhkKd5t+2iQnrqmIfFr43tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gwy9iLEcCOrRNVCsCosWwzUVOsfjTr8UdATczKFks57/0vq6p4v5aszS56006FfQQUddDuGHPxYR5puqAUhm+jOalWRV+kle9lPM9ejDIzTlp7A6K3Z6MYBw4/4uXNQlAJ0CVWF+vnMXCniw+KwB7u/n5ctvpBkpRG5VexVf9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BN2lMk/a; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN2lMk/a"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73caf1152bdso106610a34.3
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091871; x=1752696671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9RpOGMlsT0QjvpgisRXgXmYoraAxlNH64g1GWc7DQdk=;
        b=BN2lMk/apm/IaEB5xSH/NFv66d/xk3ISwVvqjy999sPDF14wOsgRgTqWr0m3excF7s
         WD8QUiYDKUmi0/Gcupc9i0cM89B/oq0BhqpCw0tNDQMSSCGzt7pkf53Rrk1ORl2/2vv4
         s6m+nuoA7YAzaGfk4epyW8FTCTfCycA45OOT7ZlMNoWuGwZvnI+74KWPnpeLRFKkg0Mo
         vuUQJnd9F+WZG/0fvcVd5eIAZxi678iQFTJBMMtkIzacNwz7HTJmDNFUfuMCMOxNiOux
         8IIcOLSdVBbJBhFpocnI3gzX0jZ202I5yp7OWRrTPRAX75S2nxOBdNZ2OwVYDDfaIKW3
         7E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091871; x=1752696671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RpOGMlsT0QjvpgisRXgXmYoraAxlNH64g1GWc7DQdk=;
        b=ehFc74Y80lCr1B4Cvpfdsm09FEajGMZvXKZt6/A4plDoboU89g6M/oWUSI0iWIloWY
         Sv9BkhOETQeGdN6J7jYSDbzEUNjm/XviTnsggbVccsTKiPju3dnvco0tb4Xk6jc0/krp
         dlZI5RNA/cUVmmGjVraBWiXC9myNlLjuF50WyGMdJu9s96Rox8dY2K8xUM974SAckfDr
         HVD9BlUihwA95mYCTSVPnegVjMtNl7kIiCPWNmo1LeJ41k7+BjSRJrAIXGzMJF6WmPtk
         botM3kw5Ah/izSQzFczH5SrQOh1IGddj1NAcsACr0lhynvk6UF7YUKXahmyx9iuED4zg
         q+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXimbTTWCR/SLKt5bWMKFZad3dKmbi5YSPMB7dOV9BzMg83x4jYiueakpT8oy7WQUIwz7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrkn52d1I/V4YVxmIzGWiP8a9D9Tc5fxMOx6u7vTiP6uT+aTZ
	G/5CB9nDSjqYmTcnvh3r09pzglQapxiXkWiqFilg8lBNFjII0ynd9p3I
X-Gm-Gg: ASbGncvLQPLtOtGiBP6PYtozcPS+lISr3Mk16sXgRdR2X5ZCq6wgT/NQ/Z3TkE1qCL8
	5nSu6LZDBKGqeIjnXEG5BWAoYqu0oQBYczlq9IYvD6trNae0IUk+76GLR9SeVWrAvyAKmgpsXM9
	icW/shNXMix+Xe0oufA4doo6FADdPvZnvOa4y3eMCLhLJe8fJpy6/6rn4PFlse66zmouOrMF3mK
	/bMKG+BqmSD+kjZdEbI3EPxU97gBv5NSOtMWMedJxau1t/q+ez7Thmtep+0vxRMMxOQDyTuVGhv
	QObcTx1IjutQT6J/BeJYZEfNsRHtivv4zD5qE1K+mEHdj/HJeT/nFJc=
X-Google-Smtp-Source: AGHT+IF7qGVR7RmVdP22rbj7ccpMf69SB8UuK72u4eRT/38U3L4TvszUF9pgKmtkRUvx2kCFmJY9PQ==
X-Received: by 2002:a05:6830:3506:b0:727:3303:7ea8 with SMTP id 46e09a7af769-73ce63871cbmr3167308a34.25.1752091870651;
        Wed, 09 Jul 2025 13:11:10 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73c9f938806sm2469547a34.55.2025.07.09.13.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:11:10 -0700 (PDT)
Date: Wed, 9 Jul 2025 15:05:34 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSoC RFC PATCH v2 1/7] repo-info: declare the repo-info command
Message-ID: <vygdkwopfzrbdpxpxebnq3xdlg3ow4i3w5y5evduae2zuelqcn@la2dikht2qrf>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-2-lucasseikioshiro@gmail.com>
 <aGZqK5eBA18vHAa_@pks.im>
 <AD2EE71A-1395-4665-BB9C-38DD4B941574@gmail.com>
 <aGtiyGW4MIYUw3Ed@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGtiyGW4MIYUw3Ed@pks.im>

On 25/07/07 08:01AM, Patrick Steinhardt wrote:
> On Fri, Jul 04, 2025 at 06:40:11PM -0300, Lucas Seiki Oshiro wrote:
> > > Would it make sense to maybe have such whole-repo commands
> > > grouped together in a `git repo` top-level command? E.g. `git repo info`
> > > for your command, `git repo size` to gather information about the repo
> > > size.
> > 
> > It seems to be very nice for me! In fact, this being a home also for
> > statistics is something I considered while writing the first versions of
> > my GSoC proposal.
> > 
> > And what about merging the two codes into a single API? Something like:
> > 
> > ```
> > git repo-info layout.bare references.format survey.commit-count
> > {
> >   "layout": {
> >     "bare": true
> >   },
> >   "references": {
> >     "format": "files"
> >   },
> >   "survey": {
> >     "commit-count": 42
> >   }
> > }
> > 
> > ?
> 
> We could in theory do that. But there's two things we need to be
> cautious about:
> 
>   1. We should be mindful about what specifically this tool is about. It
>      shouldn't become the next tool that does way too many different
>      things.
> 
>   2. One of the idea of git-survey(1) is to eventually replace
>      git-sizer(1). This will require very specific presentation formats
>      that aren't really compatible with any of the other information.
> 
> Out of these two I think the second item is the more important one why
> git-survey(1) should exist as a standalone tool, either as a top-level
> command or as a subcommand.

As Patrick mentioned, the focus for git-survey(1) is to be an eventual
substitute for git-sizer(1). For the initial implementation I was
imagining a simple plaintext format that outputs key/value pairs and
looks something like the following example:

  references.branches.count=15
  references.tags.count=2
  references.remotes.count=5
  references.others.count=1
  objects.commits.count=50
  objects.commits.total_size=1234567
  objects.commits.max_size.oid=1817dc08b8ea00fce4cd1fb6bc75713ad00a74d3
  objects.commits.max_size.size=1234
  objects.commits.max_parents.oid=1817dc08b8ea00fce4cd1fb6bc75713ad00a74d3
  objects.commits.max_parents.count=8
  objects.trees.count=100
  objects.trees.total_size=12345
  objects.trees.total_tree_entries=999
  objects.trees.max_tree_entries.oid=1817dc08b8ea00fce4cd1fb6bc75713ad00a74d3
  objects.trees.max_tree_entries.count=99
  objects.blobs.count=142
  objects.blobs.total_size=99999999
  objects.blobs.max_size.oid=1817dc08b8ea00fce4cd1fb6bc75713ad00a74d3
  objects.blobs.max_size.size=999999
  objects.tags.count=1
  repo.max_depth=999
  <etc...>

The command will also need to eventually support other output formats,
namely a more human friendly table format that provides something
similar to git-sizer(1). As layed out above, this looks like it could
also work well with the git-repo-info(1) JSON format. This makes me
wonder if we should add this functionality as a separate flag for
git-repo-info(1). Maybe something like `--stats` and append the info do
the output. If we want a more clear distiction though, we could
implement this as a separate subcommand.

For a more human-readable format, maybe we could still implement a
standalone git-survey(1) that is more of a porcelain command and uses
git-repo-info(1) under the hood. I think the other information such as
reference format and object format may be useful to provide in
git-survey(1) output.

> > During our meetings, Karthik suggested (I'm planning to it later) to also
> > allow to request an entire category instead of only the fields. Then, this
> > would also be possible:
> > 
> > ```
> > $ git repo-info survey
> > {
> >   "survey": {
> >     "commit-count": 42,
> >     "blob-count": 1234
> > }
> > ```
> 
> It raises another question though: if we ever were to add `--all` we'll
> need to step a bit careful about what kind of information we add to this
> tool. All of the information proposed so far can be computed rather
> trivially. But computing repository sizes has way higher computational
> complexity and may easily take seconds, maybe even minutes in large
> repositories.
> 
> That to me further points into the direction of giving those two tools a
> common top-level command (`git repo info`, `git repo survey`), but to
> not mix concerns too much with one another.

Getting the info for git-survey(1) is certainly more computationally
complex so there should be a way to run the command without performing
the more expensive checks if the user doesn't want them. At the same
time, I think it may be nice to have a way for a user to request a dump
of "interesting" repository info via a single command.

> > But I don't know what are Justin's plans for git-survey, if it would be a
> > porcelain command for showing those stats to the user of if it is targeted
> > for being parsed like this `repo-info`.

I think the intent for git-survey was to provide a more porcelain
command to display interesting repository stats to the user, but also
provide an option to print in a machine-parsable format. I like the idea
of computing everything as part of git-repo-info though. This could
allow a standalone git-survey to focus on just being a human-friendly
porcelain command. For scripted use-cases, users could then just use
git-repo-info.

-Justin
