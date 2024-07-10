Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27931922D6
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614494; cv=none; b=tD69hPkecMOGCox9CUXmxjY8meNInA2SQg9qEBoYq16ccCJmgSdVUYlcHA1ftLuXv6DM4P9RuE1zpCSROcpEVnuxEQlFfCqbN/D3D8j0mdapTTXM2FR2cHqDSP1EftI+URcqiNJ/jKRZ5oTTkgHcYcj0VS77Yvtnq+lfk8LkBow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614494; c=relaxed/simple;
	bh=b4GEIujnFcs90u7x3GrR6xoao/3/6InURGfYFGh7Cjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JH5ALIYZpIOIarpFqSRKfRYkRxmQGz+85d8p+Nq+xg1xBeTf88/GH7UBostbQBU3bskRgqjMHfW2PK0BLf/L/TPl87LdZLoXBT7ArEHALkMirImLebwToFSgTVIC93ncPxPnuvOdRSn5TTR1sOPTPaeDPWDTKyHRliuQdHiOJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyK5gKa5; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyK5gKa5"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-78135be2d46so1079557a12.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720614492; x=1721219292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5TmEOJlDxAftTVNISdpxzkwUzLlPnhq8YG9NI3N98+w=;
        b=fyK5gKa5tCkQsclxSjTvoMkOhs7/6OB5EmFxH3N2qOUCs0GwSTE2dFGqn05QuUWuou
         6pahy+j/gDA90H6JRc0LjimsH058FnIBWZFJyVf7ZCyAP6yaP8Rs+06yWOBzQGWLA9hu
         y5bDMlFoCoOyX7LBfbpOFeArHZddeop8QXzaerMy/m0nYDWvMZuHdMkAY/T/mrGWZGqu
         Oxec9lOumxkVOkzwcIk20KC9rfMuVAK8/9BOVPaaPZ0Q1QgS+cNLcAB9bIrx+4oMFj/Y
         L5yMRGhAiq80UdDMnYWHbNCzIEugsZtC8CES/w9RftKatLp0akNRliVzMXPzUREim8jS
         hViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720614492; x=1721219292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TmEOJlDxAftTVNISdpxzkwUzLlPnhq8YG9NI3N98+w=;
        b=Kbpopkng15GepgUqK6fPuf+BsUTXPqudD0aIstL6Vj0td5inlsNqm1EoGjSeDZQsOz
         dyD6+zjPXL92sreGFXJkyu2gflPYe7XHY0h1wjP1//u/0zSf9h07PLZiKz/q93u1JKmw
         ugp1/Nw5yoks1qspmmo0QFkkJfNBVKjsV25jb2UqWWTNmAusfh5Pb9rnAEzRjj0+qLmd
         tlOUlEETerftYvFjltdDLzHLwULiwF0DCr+wNGysObsxttmTqmDdspJMa/ITyNlQFoWb
         QqGDdR3K57ZiztXi3/1Jg4FXsCg9Pj91elBI5y2GvS1VC0E4Jx34lfp1EH8IZdPVw+oV
         nJ3w==
X-Gm-Message-State: AOJu0YxFPAq1bhYzPN6frf+hjLpuG7jhEgnEOxvSpG0Tiivrvm1JNSUh
	t+6tR1X/pwyROovBEOl24HtITEBcyFNy3/ltrIOv8uG9dtpLifzfUBmymg==
X-Google-Smtp-Source: AGHT+IHVY5IxwC3CYGeHih8pdQtyscl2KGDkFGt1vt5HqnZ7hvWd3neA7KpadPfVn4Ts0+q/j5DAPw==
X-Received: by 2002:a05:6a20:9f0a:b0:1c0:f2ee:7dc0 with SMTP id adf61e73a8af0-1c2984c9dc7mr5444758637.55.1720614492159;
        Wed, 10 Jul 2024 05:28:12 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a1094dsm32589395ad.22.2024.07.10.05.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 05:28:11 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:28:12 +0800
From: shejialuo <shejialuo@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v9 3/9] fsck: add refs-related options and error
 report function
Message-ID: <Zo5-XAzqt3YxWJ-v@ArchLinux>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
 <Zo0uiz1y6hJld2Rv@ArchLinux>
 <oan7pcamqpi2z4jzfshff2sfziqgisd3jcbpzfoiuyks5g57mk@7isgeztkcgmy>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oan7pcamqpi2z4jzfshff2sfziqgisd3jcbpzfoiuyks5g57mk@7isgeztkcgmy>

On Tue, Jul 09, 2024 at 04:29:24PM -0500, Justin Tobler wrote:
> On 24/07/09 08:35PM, shejialuo wrote:
> > Add refs-related options to the "fsck_options", create refs-specific
> > "error_func" callback "fsck_refs_error_function".
> > 
> > "fsck_refs_error_function" will use the "oid" parameter. When the caller
> > passes the oid, it will use "oid_to_hex" to get the corresponding hex
> > value to report to the caller.
> 
> Out of curiousity, under what circumstances would the caller want to
> also pass the oid? Would it simply be to optionally provide additional
> context?
> 

Because when we check the refs, we will use "parse_loose_ref_contents"
here to check the ref contents. Below is the prototype:

  int parse_loose_ref_contents(const char *buf,
                               struct object_id *oid,
                               ...)

So we could get a oid here. However, we don't know the type of the oid.
It may not be commit object but rather a tag object. And I want to
provide more flexible operations for caller. When caller passes the oid.
The message could be the following:

  ref_name -> (oid) : fsck_error_type: user-passed message.

So, actually we have provided additional context for the caller. From
another perspective, the object check needs the "oid" parameter, we
cannot remove it from the callback "error_func" prototype. So why not
just reuse this parameter? It truly provides the caller more flexibility
without big changes.

> >  struct fsck_options {
> >  	fsck_walk_func walk;
> >  	fsck_error error_func;
> >  	unsigned strict:1;
> > +	unsigned verbose_refs:1;
> 
> What is the purpose of adding `verbose_refs` in this patch? At this
> point, I'm not seeing it used. If there is a reason to be included in
> this patch, it might be nice to mention in the commit message.
> 

The reason is that fsck builtin handles the object check but we want to
use "git refs verify" command to handle ref check and we put all the
real functionality into each file backend. And there is only one entry
point in the "git refs verify" command. So we need to use "fsck_options"
as the parameter to maintain this state across the ref checks.

Actually, "git-fsck(1)" maintains "verbose" global variable. I think I
should not add this option in this patch which may cause a lot of
confusion here. I will improve this in the next version.

> >  	enum fsck_msg_type *msg_type;
> >  	struct oidset skip_oids;
> >  	struct oidset gitmodules_found;
> > @@ -173,6 +181,13 @@ struct fsck_options {
> >  	.gitattributes_done = OIDSET_INIT, \
> >  	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
> >  }
> > +#define FSCK_REFS_OPTIONS_DEFAULT { \
> > +	.error_func = fsck_refs_error_function, \
> > +}
> > +#define FSCK_REFS_OPTIONS_STRICT { \
> > +	.strict = 1, \
> > +	.error_func = fsck_refs_error_function, \
> > +}
> >  
> >  /* descend in all linked child objects
> >   * the return value is:
> > -- 
> > 2.45.2
> > 
