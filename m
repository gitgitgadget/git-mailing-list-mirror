From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 01/33] setup: call setup_git_directory_gently before
 accessing refs
Date: Tue, 01 Mar 2016 19:33:50 -0500
Organization: Twitter
Message-ID: <1456878830.5981.7.camel@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
	 <1456793586-22082-2-git-send-email-dturner@twopensource.com>
	 <20160301083535.GA4952@sigill.intra.peff.net>
	 <1456876072.5981.5.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 01:34:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaujy-0004vx-Gl
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 01:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbcCBAdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 19:33:54 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33494 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbcCBAdx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 19:33:53 -0500
Received: by mail-qg0-f51.google.com with SMTP id t4so615053qge.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 16:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8ZoEvCrFpR7wnxSIMiLef4hln1GlYrS0pxBv8hpE4oE=;
        b=fNEdXTQWT3rcQQ5Lr2mH42d71ZxWIhrx+JywWgJOYPiUpNl1+OzDy7tGADx4w25Le/
         qPhDSMRPZWye5ykfHKVUQZF2ZcHC2pTUWMlirMEMfAjgjMUEPofwrvHC52VzkGGmASyZ
         IrKY36qNMAUQheOJPQHYwWqDoM5XYfY91VU8FneJElbAX6BEV9ZL3h8MulZnu9cDAmd3
         UaDgDasB2FB6tSOa0tIc2XVwCouJF94hYFaurRlbGUBr02M7GQC1r3s4EgY4V4EEL+FZ
         i06ZH5cCS8MDZhZoVuW/WcND2vKUxqmh2CyZYXxCVjfxMH3BKsmg2MS6cbOg44syZHYL
         DSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8ZoEvCrFpR7wnxSIMiLef4hln1GlYrS0pxBv8hpE4oE=;
        b=H37blPtFXlW5ICPb+YSvJGapECthGIkLfJVVy1St2oBRll1WugpFwTltjxso7FvOdR
         g0IAkYrxqWcQD1JMPzhUTkBo18trSsvNaRG0t1yAxgP5oCCXS9asw7EnObAdhYOKQ/P8
         AqxyxIfrAp2MvC9Q5OONRo1ESc1YrKrUzFOsE4HvL2FWqMQwDBOp/BprLAzEU4i1sl0a
         x/TPOSFAW4EzTcBlLG7SzEVzsvXvZ/rSZZMee30q/CcHcP6YHmHJ9c0JcvvoV0mvQA3L
         Z9gRFf9llg01Rr7oXLBPDIooWkwvbvgiAgwBv4twde3v9INTo8/YdM8ZxS139A0KTwQM
         OcTw==
X-Gm-Message-State: AD7BkJJdOI7mcweaObfeTWhjbk6Z0vqcEF5/WlBVTmDX32pfmt50/1M8PQ+6el7b8rlvaQ==
X-Received: by 10.140.157.7 with SMTP id d7mr31864840qhd.17.1456878831938;
        Tue, 01 Mar 2016 16:33:51 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id t64sm13517262qki.10.2016.03.01.16.33.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 16:33:51 -0800 (PST)
In-Reply-To: <1456876072.5981.5.camel@twopensource.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288086>

On Tue, 2016-03-01 at 18:47 -0500, David Turner wrote:
> On Tue, 2016-03-01 at 03:35 -0500, Jeff King wrote:
> > On Mon, Feb 29, 2016 at 07:52:34PM -0500, David Turner wrote:
> > 
> > > Usually, git calls some form of setup_git_directory at startup. 
> > >  But
> > > sometimes, it doesn't.  Usually, that's OK because it's not
> > > really
> > > using the repository.  But in some cases, it is using the repo. 
> > >  In
> > > those cases, either setup_git_directory_gently must be called, or
> > > the
> > > repository (e.g. the refs) must not be accessed.
> > 
> > It's actually not just setup_git_directory(). We can also use
> > check_repository_format(), which is used by enter_repo() (and hence
> > by
> > things like upload-pack). I think the rule really ought to be: if
> > we
> > didn't have check_repository_format_gently() tell us we have a
> > valid
> > repo, we should not access any repo elements (refs, objects, etc).
> 
> I'll change that commit message to say
> "check_repository_format_gently".
> 
> > > diff --git a/builtin/grep.c b/builtin/grep.
> > [snip: this is a probably-good behavior change]
> 
> Agreed.
> 
> > My fix for this was to teach read_mailmap to avoid looking for
> > HEAD:.mailmap if we are not in a repository, but to continue with
> > the
> > others (.mailmap in the cwd, and the mailmap.file config variable).
> > ...
> > But I do think your patch is a potential regression there, if
> > anybody
> > does do that.
> 
> Your version sounds better.  But I don't see it in the patch set you
> sent earlier? 
> 
> > > diff --git a/git.c b/git.c
> > > index 6cc0c07..51e0508 100644
> > > --- a/git.c
> > > +++ b/git.c
> > > @@ -376,7 +376,7 @@ static struct cmd_struct commands[] = {
> > >  	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
> > >  	{ "annotate", cmd_annotate, RUN_SETUP },
> > >  	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
> > > -	{ "archive", cmd_archive },
> > > +	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
> > >  	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
> > >  	{ "blame", cmd_blame, RUN_SETUP },
> > >  	{ "branch", cmd_branch, RUN_SETUP },
> > 
> > I didn't have to touch this case in my experimenting. I wonder if
> > it's
> > because I resolved the "grep" case a little differently.
> > 
> > I taught get_ref_cache() to only assert() that we have a repository
> > when
> > we are looking at the main ref-cache, not a submodule. In theory,
> > we
> > can
> > look at a submodule from inside an outer non-repo (it's not really
> > a
> > submodule then, but just a plain git dir). I don't think there's
> > anything in git right now that says you can't do so, though I think
> > your
> > refs-backend work does introduce that restriction (because it
> > actually
> > requires the submodules to use the same backend).
> > 
> > So with that requirement, I think we do need to require a repo even
> > to
> > access submodule refs. Is that what triggered this change?
> 
> No.  What triggered this change was a test failure with your earlier
> patch on master -- none of my stuff at all.  The failing command was:
> 
> git archive --remote=. HEAD
> 
> When writing my patch, I had assumed that the issue was the
> resolve_ref
> on the HEAD that's an argument -- but it's not.  The actual traceback
> is:
> 
> #0  die (
>     err=err@entry=0x57ddb0 "BUG: resolve_ref called without
> initializing repo") at usage.c:99
> #1  0x00000000004f7ed9 in resolve_ref_1 (sb_refname=0x7c4a50
> <sb_refname>, 
>     sb_contents=0x7fffffffcfc0, sb_path=0x7fffffffcfe0,
> flags=0x7fffffffdaaa, 
>     sha1=0x7fffffffd100 "\b\326\377\377\377\177",
> resolve_flags=5572384, 
>     refname=0x2 <error: Cannot access memory at address 0x2>)
>     at refs/files-backend.c:1429
> #2  resolve_ref_unsafe (refname=refname@entry=0x550b3b "HEAD", 
>     resolve_flags=resolve_flags@entry=0, 
>     sha1=sha1@entry=0x7fffffffd100 "\b\326\377\377\377\177", 
>     flags=flags@entry=0x7fffffffd0fc) at refs/files-backend.c:1600
> #3  0x00000000004ffe69 in read_config () at remote.c:471
> #4  0x0000000000500235 in read_config () at remote.c:705
> #5  remote_get_1 (name=0x7fffffffdaaa ".", 
>     get_default=get_default@entry=0x4fe230 <remote_for_branch>)
>     at remote.c:688
> #6  0x00000000005004ca in remote_get (name=<optimized out>) at
> remote.c:713
> #7  0x00000000004159d8 in run_remote_archiver (name_hint=0x0, 
>     exec=0x550720 "git-upload-archive", remote=<optimized out>, 
>     argv=0x7fffffffd608, argc=2) at builtin/archive.c:35
> #8  cmd_archive (argc=2, argv=0x7fffffffd608, prefix=0x0)
>     at builtin/archive.c:104
> #9  0x0000000000406051 in run_builtin (argv=0x7fffffffd608, argc=3, 
>     p=0x7bd7a0 <commands+96>) at git.c:357
> #10 handle_builtin (argc=3, argv=0x7fffffffd608) at git.c:540
> #11 0x000000000040519a in main (argc=3, av=<optimized out>) at
> git.c:671
> 
> > I'd think you would need a matching line inside cmd_archive, too.
> > It
> > should allow "--remote" without a repo, but generating a local
> > archive
> > does need one.  And indeed, I see in write_archive() that we run
> > setup_git_repository ourselves, and die if we're not in a git repo.
> > So
> > I'm puzzled about which code path accesses the refs.
> 
> I agree that  --remote should work without a repo,  It seems that we
> do
> n't test this and we probably should.  
> 
> I'm not sure what the right way to fix this is -- in read_config,
> we're
> about to access some stuff in a repo (config, HEAD).  It's OK to skip
> that stuff if we're not in a repo, but we don't want to run
> setup_git_directory twice (that breaks some stuff), and some of the
> other callers have already called it.  On top of your earlier
> repo_initialized patch, we could add the following to read_config:
> 
> +       if (!repo_initialized) {
> +               int nongit = 0;
> +               setup_git_directory_gently(&nongit);
> +               if (nongit)
> +                       return;
> +       }
> 
> But that patch I think was not intended to be permanent.  Still, it
> does seem odd that there's no straightforward way to know if the repo
> is initialized. Am I missing something? 

I guess we could add a bit in startup_info.  Was that what you were
talking about there?
