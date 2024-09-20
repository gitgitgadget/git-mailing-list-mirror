Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436F13BC0C
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726868801; cv=none; b=qwfpXooeqfd6CTaIoOdNr0pAblJU+vuJHy38NpsYqdCxYiaBO9y224F6C8+6k9XnEg7AwGlBR9TH1AdDMCGNGqbIcE/XRydu1GLHQs8KEKLqbgizQ5VDw2ul50ojUeDT9CxaPcW890o9UwdCfwK3TL7Ptejz2doh6FgaDWVubIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726868801; c=relaxed/simple;
	bh=CVb+dzSbKjWMNoVSViX2jdFTMdLX1dabumnjsN++3kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+6N6X/JaTqarMVqT/YV7zjQWZp6zjNBFlVyXG1I45/0cDOBHeVxrgXM3KL8i2TrfodbtDhWNiJ+Bxk/xxZnFxfMO+00INRbu/Qv6Raffjd/JwCSUuqVHfblO40pfDwHjfn2pAQMIIkyvMvwfgsP4q5ZnKnjM/xxNafAkSpxD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyoBLtQa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyoBLtQa"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so20051685e9.3
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726868798; x=1727473598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EateJdQFtVBuGfl2Oeasz52Q4hDDRGgSY5GNafRX7L8=;
        b=KyoBLtQa6vrejc0nRlMdSZY4lp3LZ8anU4jsCfeFJgz38yC4o//WEPD38jAHixSczR
         D8u9O6NhsNgti1F5Ba2HOzaCiQfRGJCIbfpbmf1CKktNSxAsiWS5F8hD75OwdkXPyg6V
         srRwC2R14qqDUVvJsKLdZEAaQtrX1gK1EB2Nr3YOhyHSIsDW2KG6+86JYrvqOWU8yjjx
         9iBC+L8p3GPdGwtJiWU37sdvjudHbiES3WZxsJJMXqFU3vBFiNJg74ukQzCWpZYlVdFX
         iByip2aQDSiX6dlrqvO8eG7qGDZ/6oh2fQhLYD6qKzPlPKnF+UlGCfhsF6iVN4RM+Orw
         wYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726868798; x=1727473598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EateJdQFtVBuGfl2Oeasz52Q4hDDRGgSY5GNafRX7L8=;
        b=i0Lo8ev2YmucS87qEtsMi2pxKkj3sAMzh7N3rY0HpZGk/5uU2Z7NrWw/a7iB5kXwwH
         ZyUYCRVBXU2y+x0DuaOaL1C5UHwujTNUQXbLxAFA0E0S8v9D32v7ZrXqi16NYGjibDO1
         Kbq841p4KHTfXEI0x0Cs2W+paGYOcL2LLRU2NG/9wldt39S9M4GDiDxkeQw/Legckdgk
         SOHpfnY+Onvc/CBe3MZheeYvQhPwsTi9b1TfK50wfnS4duhODJa0gMsI9LXp9+Uicvs8
         o0bWfJzml0WErwTi2RCdtEORTsdlVxnTAWrfaBuPMDtRU77Ja6Q4XlT75wKFG9oIbBnM
         HJKQ==
X-Gm-Message-State: AOJu0Yxbu0zexaer+Mxmw0QDstjKKlVFywSHJa2XgxLeZ/edu8+EME/R
	Kw/gLJSc6K8tMn4+/G2fBfL0VvrVFTlc2b1aFOP1z485KDpij5S8QquF87xW
X-Google-Smtp-Source: AGHT+IGGNuK71Rc1XicNmCrRW4bsjnb3skQFRbyDgud+rXLh97kYyVy1NXzHUHkWQn1+jlChgGtKjw==
X-Received: by 2002:a5d:640a:0:b0:374:af04:d6a3 with SMTP id ffacd0b85a97d-37a42398688mr1904247f8f.57.1726868797395;
        Fri, 20 Sep 2024 14:46:37 -0700 (PDT)
Received: from void.void ([141.226.14.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7805193sm18435597f8f.98.2024.09.20.14.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 14:46:37 -0700 (PDT)
Date: Sat, 21 Sep 2024 00:46:34 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: fix typos
Message-ID: <Zu3tOos7yJnTgbao@void.void>
References: <20240920082815.8192-1-algonell@gmail.com>
 <20240920082815.8192-3-algonell@gmail.com>
 <xmqq7cb6f5bt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7cb6f5bt.fsf@gitster.g>

On Fri, Sep 20, 2024 at 01:17:10PM -0700, Junio C Hamano wrote:
> Andrew Kreimer <algonell@gmail.com> writes:
> 
> > Fix typos in documentation.
> >
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> > ---
> 
> Some hunks have become irrelevant between 'master' and 'seen', it
> seems.  Please separate them out and resend once these in-flight
> topics are merged to 'master'.
> 
> Thanks.
> 
On it.
> 
> >  Documentation/BreakingChanges.txt        | 2 +-
> >  Documentation/CodingGuidelines           | 2 +-
> >  Documentation/DecisionMaking.txt         | 2 +-
> >  Documentation/gitformat-commit-graph.txt | 2 +-
> >  Documentation/gitweb.txt                 | 2 +-
> >  5 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
> > index 2b64665694..112770a9da 100644
> > --- a/Documentation/BreakingChanges.txt
> > +++ b/Documentation/BreakingChanges.txt
> > @@ -117,7 +117,7 @@ Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
> >  
> >  * The git-pack-redundant(1) command can be used to remove redundant pack files.
> >    The subcommand is unusably slow and the reason why nobody reports it as a
> > -  performance bug is suspected to be the absense of users. We have nominated
> > +  performance bug is suspected to be the absence of users. We have nominated
> >    the command for removal and have started to emit a user-visible warning in
> >    c3b58472be (pack-redundant: gauge the usage before proposing its removal,
> >    2020-08-25) whenever the command is executed.
> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> > index 3263245b03..8a5e0b7dad 100644
> > --- a/Documentation/CodingGuidelines
> > +++ b/Documentation/CodingGuidelines
> > @@ -838,7 +838,7 @@ Markup:
> >   When literal and placeholders are mixed, each markup is applied for
> >   each sub-entity. If they are stuck, a special markup, called
> >   unconstrained formatting is required.
> > - Unconstrained formating for placeholders is __<like-this>__
> > + Unconstrained formatting for placeholders is __<like-this>__
> >   Unconstrained formatting for literal formatting is ++like this++
> >     `--jobs` _<n>_
> >     ++--sort=++__<key>__
> > diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMaking.txt
> > index dbb4c1f569..b43c472ae5 100644
> > --- a/Documentation/DecisionMaking.txt
> > +++ b/Documentation/DecisionMaking.txt
> > @@ -54,7 +54,7 @@ implementation, for very large changes).
> >  
> >  For non-technical decisions such as community norms or processes, it is up to
> >  the community as a whole to implement and sustain agreed-upon changes.
> > -The project leadership committe (PLC) may help the implementation of
> > +The project leadership committee (PLC) may help the implementation of
> >  policy decisions.
> >  
> >  
> > diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
> > index 3e906e8030..14d1631234 100644
> > --- a/Documentation/gitformat-commit-graph.txt
> > +++ b/Documentation/gitformat-commit-graph.txt
> > @@ -122,7 +122,7 @@ All multi-byte numbers are in network byte order.
> >        for commits with corrected commit date offsets that cannot be
> >        stored within 31 bits.
> >      * Generation Data Overflow chunk is present only when Generation Data
> > -      chunk is present and atleast one corrected commit date offset cannot
> > +      chunk is present and at least one corrected commit date offset cannot
> >        be stored within 31 bits.
> >  
> >  ==== Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
> > diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
> > index 56d24a30a3..5e2b491ec2 100644
> > --- a/Documentation/gitweb.txt
> > +++ b/Documentation/gitweb.txt
> > @@ -234,7 +234,7 @@ from the template during repository creation, usually installed in
> >  configuration variable, but the file takes precedence.
> >  
> >  category (or `gitweb.category`)::
> > -	Singe line category of a project, used to group projects if
> > +	Single line category of a project, used to group projects if
> >  	`$projects_list_group_categories` is enabled.  By default (file and
> >  	configuration variable absent), uncategorized projects are put in the
> >  	`$project_list_default_category` category.  You can use the
