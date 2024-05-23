Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661817CD
	for <git@vger.kernel.org>; Thu, 23 May 2024 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716424700; cv=none; b=Z5uN8V3PVUHW8N+CBHw0rMa4gVJfP3Fj0kbtTli4aBCB8Xzd3zTZqbZkdA9VwT/jJwI1jN9LE+2o04F7FDHkfo6xtI5ZsfqYZ2JnPCK+eylJKLBvVBEWPIaape00KAftM4z/Uxs9r8PajgT4DIcaBPe9wHgRAl/ShqTe94XsJsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716424700; c=relaxed/simple;
	bh=Wud/hs9LCNXWGkisihZ0sNAi/alC7kDQUc2GN/LKCGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo6/I5f4gSfYkRUcAQkYDHWLJV6L31lcurE209bZBrwObpjYsRJsqBpWF5eIhYH2vMIEZ0k0skTdUD0J7WNCXXzYI6JciqwfY6TUCvhLHId2ZogmT6D8RbWtqvLR1NBu6sVw6aeOLhuz/lN32MTRSpoJWjZHmaBeYWhBAdbuTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4PYdm85; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4PYdm85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716424697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GyZRcS4O3RZJXWI1NHtIrDRqdnDOiUQcnXpIJhrt+w8=;
	b=g4PYdm85tB1AzLXUCloSdinSdnKAqAhPBgFRwn2oOc19WhgLAeO6ViaLkKJNRrffCjWlMR
	jE0BudU5IThDfqJakk74JOjN6t+vGdSp7Xqg8xLptskOL/z9rddNompCMM++DQ5bjA/93X
	kuLZ0qowlwQiYQUkQwKKaR5xWEli/hA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-HbD-a98BNjq4x1H-a0iLOg-1; Wed, 22 May 2024 20:38:15 -0400
X-MC-Unique: HbD-a98BNjq4x1H-a0iLOg-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dc647f65573so31829996276.2
        for <git@vger.kernel.org>; Wed, 22 May 2024 17:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716424695; x=1717029495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyZRcS4O3RZJXWI1NHtIrDRqdnDOiUQcnXpIJhrt+w8=;
        b=Oe4nBypFiZVzVLDqHEMURWgkiEP4RMcNw4lOQzq6twWGrtYd8DJDRcZmRrxX3SLOjk
         F6q2+dk7xCbr9eMPlOiiNwMDnYUkqm2QzDAVtA1/MFSJyEKmu8+/Ghv7eyQ/MVo0imNC
         f6uO7iGfKqy6ny0xnqI2W8aMuNd1Z5lEVqdbsmFPIHaK9K6AWeO2DB7JR//tB+Rg1rSu
         q9ZNFYyTVDrYj6Vkamcm7pKQzXxf+Jo41lMzctkio97f+H0dc/pUf3wWTHqvjearRN1s
         nM6TXEf0teKpjh+B1Dtq3raSDWj1l24FsPNVD7mCyltwSEOH84/j75WbagCcUBl8lTSu
         pggw==
X-Gm-Message-State: AOJu0Ywx7VqP+sUmOtUNydZtudUYXNNBlPOXPS3eT27BkKRo4vQ8nGfX
	AEXdoo6mJCX2Lej0Hbls3Jre+T3Wdee5xz4SQWahz65MGOmt9W16Mz8bMRe8xovNBRcyp33I7v3
	gLA54fCyWTS41ZYhGlskLrPLFqx+PCGX2bNPsHIxtLK7f2h8ctg==
X-Received: by 2002:a25:aa6c:0:b0:dee:7942:c099 with SMTP id 3f1490d57ef6-df4e0c30539mr3969115276.38.1716424694927;
        Wed, 22 May 2024 17:38:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4vmM7OMAFPr2ad70qsTQA9VjgV+Q7VciyYGCXOvBBDdOCTHWUufiQCdeQ43OgfKSzPsfGhw==
X-Received: by 2002:a25:aa6c:0:b0:dee:7942:c099 with SMTP id 3f1490d57ef6-df4e0c30539mr3969107276.38.1716424694462;
        Wed, 22 May 2024 17:38:14 -0700 (PDT)
Received: from fedora19.localdomain (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab854d1703sm9124556d6.103.2024.05.22.17.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 17:38:12 -0700 (PDT)
Date: Thu, 23 May 2024 10:38:08 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] alias: document caveats and add trace of prepared command
Message-ID: <Zk6P8AMIBUt5X1A1@fedora19.localdomain>
References: <20240522024133.1108005-1-iwienand@redhat.com>
 <xmqq8r017rtw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8r017rtw.fsf@gitster.g>

On Wed, May 22, 2024 at 09:07:55AM -0700, Junio C Hamano wrote:
> Ian Wienand <iwienand@redhat.com> writes:
> 
> > For a "split" alias, e.g. test = "!echo $*" you will see
> >
> >  $ GIT_TRACE=1 git test hello
> >  11:00:45.959420 git.c:755               trace: exec: git-test hello
> >  11:00:45.959737 run-command.c:657       trace: run_command: git-test hello
> >  11:00:45.961424 run-command.c:657       trace: run_command: 'echo $*' hello
> >  11:00:45.961528 run-command.c:437       trace: prepare_cmd: /bin/sh -c 'echo $* "$@"' 'echo $*' hello
> >  hello hello
> >
> > which clearly shows you the appended "$@".  
> 
> A question and a comment on this part.
> 
> Who are "you" in this context?

Heh, "you" is the person who has been given a large git alias that
probably should have been written some other way (but likely due to
the fact that stuffing all the workflow logic into a git config-file
means that nothing extra like shell/python scripts needed to be
distributed) that "you" have to now debug :) I feel the extra info in
GIT_TRACE output showing what is _actually_ happening after
prepare_cmd would really help this person (who was me :).

> It is somewhat surprising if we do not consistently add "$@" (or do
> an equivalent), as the point of adding "$@" is to allow an alias to
> specify "the initial part of a command line", e.g.
> 
> 	[alias] lg = log --oneline
> 
> to let you say "git lg" to mean "git log --oneline" and also you can
> say "git lg --graph" to mean "git log --oneline --graph".  In other
> words, what you type after "git lg" makes "the rest of the command
> line", while alias gives "the initial part".
> 
> Are you sure that with
> 
> 	[alias] lg = log
> 
> you get the rest of the command line ignored, in other words, if you
> say "git lg --oneline", it does not do "git log --oneline"?

I'm not quite sure I'm following here, sorry.  The behaviour is
different for "shell" aliases prefixed with !.  There the stragtegy is
to append "$@", but only if there are arguments.  Whatever the merits
or not of that, I feel like it's impossible to change because it's out
there now.

Now I've been looking, I've seen a number of interesting ways people
have been dealing with this.  Some people have ignored it, for example
I've seen credential helpers use ":" to ignore it, like

 "!echo password=\$${TOKEN_NAME}; :"

The git documentation for credential helpers gives another way,
defining an inline function, so the "$@" appended becomes function
arguments to "f()" like

 "!f() { echo $1 $2 ; }; f"

Then I've seen other people nest in a "sh -c" call, and "fake" $0 so
that the appended "$@" becomes the $1 arguments to the interior shell
call (cue quoting nightmares!) like

 "!sh -c 'echo $1 $2' foo"

Once you realise what is going on, these are somewhat understandable,
but the documentation as written doesn't guide you in the right
direction.

> The above does a bit too many things in a single patch to be
> reviewable.  Perhaps make the above change in two patches?

Sure, I am happy to split this up

> You have a lengthy new text in the documentation to help confused
> users, but it looks to me that it places too much stress on the
> mechanics (i.e. '$@' is added to the command line) without saying
> much about the intent (i.e. you need to use '$@' to allow the
> command line invocation to supply "the rest of the command line"
> when you are running the alias via the shell).  I've learned over
> the course of this project that readers learn better when the intent
> behind the mechanics is given in an understandable form.

Let me take your feedback here and work it into the split up change,
and we can discuss further.  Thanks.

> > diff --git a/run-command.c b/run-command.c
> > index 1b821042b4..36b2b2f194 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -435,6 +435,7 @@ static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
> >  		}
> >  	}
> >  
> > +	trace_argv_printf(&out->v[1], "trace: prepare_cmd:");
> >  	return 0;
> >  }
> 
> Hmph, we do not have much tests that look for 'trace: foo' in our
> test suite, but t0014 seems to use it.  Don't we need to cover this
> new trace output in the test in the same patch (probably becomes
> patch 3 after the two documentation changes)?

Ok, thanks for the pointer, I'll look at expanding this one.

-i

