Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D95F14F9DA
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720701594; cv=none; b=BBgRDTbv+MoXOgPEASQWvk15KjqAr1AkPEF/eOUCb/tugw7mTdu6Gbk2JsfMbh6reQArtRxE2+wcOUce2MaQ0X5ahkLMQWBEwkW4wZ7sAPT7OhQ9SxaaPYpzK8/VAJpqDUPboHUpS1TDY7QQN2L/NpgREX9eQW6mtk8XiUdIg+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720701594; c=relaxed/simple;
	bh=trMQ7IDeyqrwNODR5BbfQvpP4mgGunNOVVY6DNwEajo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lySWVSF+8ucGNamtTyIXoJ+YFul0uuxhC6iIK0rqvlLsEIXOv5R2QVF/QcgzXGlGWAbD7aiS7uhYieMNhlCPXlpeanrjig1g51+Rbl5lcdwxVp6UOLD0hPEqar3eBGcsCrRVP8qDlQCovDruAoos6D2xIDBoVUgPM7C1wQjkTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9uYO3os; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9uYO3os"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70445f0d9b8so469535a34.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 05:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720701592; x=1721306392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VUbOyLFI9X0gfZuOeKbRFo+QjO/z/B+oxVHS2XjRNA8=;
        b=c9uYO3osP/qWzbMMmumRqsTvEq/5Zu9hrc90Jf6tiLuWOdzTKo5VSi+XWuEd+hIj9f
         HpNzz9uW1iijy9YWQH1wKP0cFTPh9JqX6ZkGTKCyL6KcNfipzEVtkjYBk2f0YOCWFjyZ
         TcZuwAYyjWNeNkJGJHop05u8Vb4c5AOlooHdK74+wxMb3eDo18GFuFE/pB/gNUUBuveu
         FW/Qo6pzr2cbbIM6afVodUjB7yKHuer54ByXJNUZLpyLpZP/oSuPyWP++n+AL8pSbyCz
         dH88ndIx6qrnlhu9lf4aQCNS8USOivtAH8mZmDeEUHtify/0hpJTV/hxXrXREWRWuHDZ
         4gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720701592; x=1721306392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUbOyLFI9X0gfZuOeKbRFo+QjO/z/B+oxVHS2XjRNA8=;
        b=K4fo99fyVuLoNdlrNUeZ1NkzEhBmEyQvSQM8LJUIM9OGMTdcim5wHbf8XGe+KuRKp8
         b/u34AIYstYLyr3ViC27Icz/W0m82/cDouFzZXXNHDoP7pEWDC+RQ9FX+4XaxnygJOCO
         npdqrx5HejPSjemb+y/xiUYPKgs3h+lDXmCeSuMCoK98wXKF1Tk6sLa4c85pJBBlzsmR
         OdoS5WOFbKgD0UzdZoxO/cfa18pksVGAuza+A9FKfssvNxORWjVGqJ2XZptEyh5aMizz
         qeh78KOjXCGi6hWzqVyMwBOybG6zJrNI+XsSN3MDNcgqdafdh+gsN0y4nrrrxPoZjNzo
         bp1w==
X-Gm-Message-State: AOJu0YycXnlpLscHRm4dPeH+qRaRO8ZBdgjHWHBlGcPgTLWg6cqagykg
	GV8bcGS+mw933jkudplSdQQeAZPSkygYDAGcsMs6rn34sgXAJ4NBSulm9A==
X-Google-Smtp-Source: AGHT+IFKH6oFuKpSTyk7yvfZy346IXFCfdy6SgJPuYE9a1SI4ibMTiErk068ZCof4H7w1pfoMs1sVA==
X-Received: by 2002:a05:6870:171e:b0:258:3455:4b02 with SMTP id 586e51a60fabf-25eaec511f3mr6820633fac.51.1720701592326;
        Thu, 11 Jul 2024 05:39:52 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439e95afsm5527372b3a.210.2024.07.11.05.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 05:39:51 -0700 (PDT)
Date: Thu, 11 Jul 2024 20:39:52 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v10 06/10] builtin/refs: add verify subcommand and
 verbose_refs for "fsck_options"
Message-ID: <Zo_SmLOg8znMJm52@ArchLinux>
References: <Zo6eJi8BePrQxTQV@ArchLinux>
 <Zo6fFS7xzFwWKrEW@ArchLinux>
 <xmqq7cdtue7c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7cdtue7c.fsf@gitster.g>

On Wed, Jul 10, 2024 at 02:31:03PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > Subject: Re: [GSoC][PATCH v10 06/10] builtin/refs: add verify subcommand and verbose_refs for "fsck_options"
> 
> Just saying
> 
> 	git refs: add verify subcommand
> 
> would be clearer.  If you really want to talk about two modes, you
> could say
> 
> 	git refs: add "verify [--strict|--verbose]" subcommand
> 
> but that may be too much.
> 

Thanks, I will change in the next version.

> > Introduce a new subcommand "verify" in git-refs(1) to allow the user to
> > check the reference database consistency and also this subcommand will
> > be used as the entry point of checking refs for "git-fsck(1)". Last, add
> > "verbose_refs" field into "fsck_options" to indicate whether we should
> > print verbose messages when checking refs consistency.
> 
> Is there a reason why this has to be verbose_refs and not a simple
> verbose bit?  When people see how it is useful to ask for the
> verbose output while checking refs, wouldn't people wish to add the
> same "--verbose" support while checking objects, and at that point,
> wouldn't it be awkward to add verbose_objs member to the struct and
> having to flip both bits on?
> 

Actually, this is really what I thought. I just want to provide more
find-grained control here. However, when I implemented the code, I also
felt awkward about this. I can't find the balance here.

I will improve this in the next version.

> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  Documentation/git-refs.txt | 13 +++++++++++
> >  builtin/refs.c             | 44 ++++++++++++++++++++++++++++++++++++++
> >  fsck.h                     |  1 +
> >  3 files changed, 58 insertions(+)
> >
> > diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
> > index 5b99e04385..1244a85b64 100644
> > --- a/Documentation/git-refs.txt
> > +++ b/Documentation/git-refs.txt
> > @@ -10,6 +10,7 @@ SYNOPSIS
> >  --------
> >  [verse]
> >  'git refs migrate' --ref-format=<format> [--dry-run]
> > +'git refs verify' [--strict] [--verbose]
> >  
> >  DESCRIPTION
> >  -----------
> > @@ -22,6 +23,9 @@ COMMANDS
> >  migrate::
> >  	Migrate ref store between different formats.
> >  
> > +verify::
> > +	Verify reference database consistency.
> > +
> 
> The error reporting function for refs consistency check was still
> about reporting a problem for a single ref.  I am wondering how
> consistency violations that are not about a single ref should be
> handled.  For example, if refs/packed-backend.c:packed_fsck() finds
> that the file is not sorted properly or has some unparseable garbage
> in it, it is not something you can report as "refs/heads/main is
> broken", but those who are interested in seeing the "reference
> database consistency" verified, it is very much what they want the
> tool to notice.  How would detection of such a breakage that is not
> attributed to a single ref fit in this "ref consistency check
> infrastructure" that was introduced by [05/10]?
> 

Yes, I didn't consider other cases. Although I have said in the subject
that this series is to set up the infrastructure of fscking refs. It's
a little hard for me to set up a perfect "fsck_refs_report" at the
moment.

As you said, I think currently I should consider about the packed-refs
in this series. I will find a way to achieve this in the next version.
Well, I could say I intentionally ignored this problem. But we should
face the problem directly.

Really thanks.

> > +	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
> > +	if (argc)
> > +		usage(_("too many arguments"));
> 
> I do not think we want to change this line in this topic, but
> because I noticed that the issue is widespread, let me make a note
> here that we may want to clean up all the commands that give this
> message as a #leftoverbit item:
> 
>     $ git cmd foo baz
>     usage: too many arguments
> 
> is very unfriendly in that it is not immediately obvious to users
> which arguments are excess.  Should they have given "git cmd<RET>"?
> Is it "git cmd foo" that does not take any argument?
> 
> If you said something like
> 
>     $ git refs verify baz
>     error: 'git refs verify' takes no arguments
> 
> or even
> 
>     $ git refs verify baz
>     error: unknown argument 'baz' given to 'git refs verify'
> 
> it would be much more helpful.
> 

I will improve this in the next version.

> 
> Thanks.
