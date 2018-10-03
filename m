Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E96111F453
	for <e@80x24.org>; Wed,  3 Oct 2018 10:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeJCREs (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 13:04:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53458 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeJCREr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 13:04:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so5138093wme.3
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wUFrWiBXyEiL1g4E6pHus/hsp5hTAvnxEzkrlVoSPRE=;
        b=mOLIyEYVEuwoBtmb3Xid0caFJyBgkeCNYEvcm1tWTr3uSrnIhc1C0UWJVsUyU7/N1j
         LeesATdIWTq6Wn2lxraob7DycoXCEz5UAC8WuxhD4vDlfcloq+f4K6rOJEd+OehQUDu1
         ZNgQbkfWR7TIaPLoQLrElOEgvylWm+GqzhU8wnyTbebRvsGIyPJ4Wm0aK1amd5IapgE1
         h0rz75FTgEaOFpe5bRcCcNaZ8/WhweVcdYi0+Vv9sPU5NBhT3t2QjgbcaNd58aEoqw6K
         YsW+8V3HVoJ9XceztRCvC32gQCH1CCJJvhXjTBg/udJBsAVkuFzxKLvhgx5omnlTWpFd
         JLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUFrWiBXyEiL1g4E6pHus/hsp5hTAvnxEzkrlVoSPRE=;
        b=RklWstrbushTq/W+Bm7hTn+FzAMM3vm3+vg5+Rzb6NJ9fTVsZ5Z6xf2deicoOAGXWj
         33nUHdSf9KVlLAAvyG6DQ9o8YjnhdLeYOafXXgugYkY40EDCZhgItfZ5fzOGeyCqlKW5
         lWz8SOOgw8FyuvWjzXL/DtFuPchWmp43bu9wfTzFNGLDibMp4lXfT+BTGnp7u3riHn/d
         3l5Y3OCbS4nJp9PFWA7eWens7ujBurEVQz5qhYMpH8h9VbdlOJq20ld3e9n40bL5vCC8
         FER/7i49cSMo7dXpQgb6drBbP7kn3M7kj9pHuFwYFrV1CGJiRvXfv1SARUkUdrdgVwRf
         /zEA==
X-Gm-Message-State: ABuFfohbPU4nzf9EHq97J0vd4MXaQqmY3FAGQsVCg6LvCM2ahHG+WMml
        fGaCm1Pf9hvplWm/61YTmpo=
X-Google-Smtp-Source: ACcGV62CjquEw6HNnd2fsoZTuIDlkaC7e7RmWlacd1W3mX5wG2gWLHWuJo+GeoxopeNOwgg5ajvHcQ==
X-Received: by 2002:a1c:9cc9:: with SMTP id f192-v6mr993184wme.135.1538561821315;
        Wed, 03 Oct 2018 03:17:01 -0700 (PDT)
Received: from localhost (x4dbea401.dyn.telefonica.de. [77.190.164.1])
        by smtp.gmail.com with ESMTPSA id r8-v6sm1383004wrm.14.2018.10.03.03.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 03:17:00 -0700 (PDT)
Date:   Wed, 3 Oct 2018 12:16:58 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] coccicheck: process every source file at once
Message-ID: <20181003101658.GM23446@localhost>
References: <20181002191642.21504-1-jacob.e.keller@intel.com>
 <20181002195519.GB2014@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181002195519.GB2014@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 03:55:19PM -0400, Jeff King wrote:
> On Tue, Oct 02, 2018 at 12:16:42PM -0700, Jacob Keller wrote:
> 
> > make coccicheck is used in order to apply coccinelle semantic patches,
> > and see if any of the transformations found within contrib/coccinelle/
> > can be applied to the current code base.
> > 
> > Pass every file to a single invocation of spatch, instead of running
> > spatch once per source file.
> > 
> > This reduces the time required to run make coccicheck by a significant
> > amount of time:
> > 
> > Prior timing of make coccicheck
> >   real    6m14.090s
> >   user    25m2.606s
> >   sys     1m22.919s
> > 
> > New timing of make coccicheck
> >   real    1m36.580s
> >   user    7m55.933s
> >   sys     0m18.219s
> 
> Yay! This is a nice result.
> 
> It's also one of the things that Julia suggested in an earlier thread.
> One thing I wasn't quite sure about after digging into the various
> versions (1.0.4 on Debian stable/unstable, 1.0.6 in experimental, and
> pre-1.0.7 at the bleeding edge) was whether the old versions would be
> similarly helped (or work at all).
> 
> I just replicated your results with 1.0.4.deb-3+b2 from Debian stable.
> It's possible there are older versions floating around, but for
> something developer-only like this, I think "in Debian stable" is a
> reasonable enough cutoff.

Linux build jobs on Travis CI run Ubuntu Trusty 14.04 LTS, and
therefore our static analysis build job still runs 1.0.0~rc19.deb-3.

This patch appears to work fine with that version, too, though note
that I also changed the build job to don't run two parallel jobs; for
the reason see below.

> > This is nearly a 4x decrease in the time required to run make
> > coccicheck. This is due to the overhead of restarting spatch for every
> > file. By processing all files at once, we can amortize this startup cost
> > across the total number of files, rather than paying it once per file.
> 
> One minor side effect is that we lose the opportunity to parallelize
> quite as much. However, I think the reduction in total CPU makes it well
> worth that (and we still have 8 cocci files and growing, which should
> keep at least 8 cores busy).

One major side effect, however, is the drastically increased memory
usage resulting from processing all files at once.  With your patch on
top of current master:

  $ for cocci in contrib/coccinelle/*.cocci ; do command time -f 'max RSS: %MkB' make ${cocci}.patch ; done
       SPATCH contrib/coccinelle/array.cocci
  max RSS: 1537068kB
       SPATCH contrib/coccinelle/commit.cocci
  max RSS: 1510920kB
       SPATCH contrib/coccinelle/free.cocci
  max RSS: 1393712kB
       SPATCH contrib/coccinelle/object_id.cocci
       SPATCH result: contrib/coccinelle/object_id.cocci.patch
  max RSS: 1831700kB
       SPATCH contrib/coccinelle/qsort.cocci
  max RSS: 1384960kB
       SPATCH contrib/coccinelle/strbuf.cocci
  max RSS: 1395800kB
       SPATCH contrib/coccinelle/swap.cocci
  max RSS: 1393620kB
       SPATCH contrib/coccinelle/xstrdup_or_null.cocci
  max RSS: 1371716kB

Without your patch the max RSS lingers around 87048kB - 101980kB,
meaning ~15x - 18x increase

This might cause quite the surprise to developers who are used to run
'make -jN coccicheck'; my tiny laptop came to a grinding halt with
-j4.

I think this side effect should be mentioned in the commit message.

Furthermore, the above mentioned static analysis build job on Travis
CI runs two parallel jobs.  Perhaps we should be considerate and
reduce that to a single job, even if that means that he build job will
run longer.

> I think recent versions of Coccinelle will actually parallelize
> internally, too, but my 1.0.4 doesn't seem to. That's probably what I
> was thinking of earlier (but this is still a win even without that).

I think Coccinelle parallelizes only when invoked with -j <N>, but
that option is not documented in 1.0.4.  I wrote "documented" instead
of "present", because e.g.:

  $ spatch --sp-file contrib/coccinelle/swap.cocci -j 2 a*.c

doesn't abort with "unknown option" and usage, but runs for a bit and
then outputs:

  init_defs_builtins: /usr/lib/coccinelle/standard.h
  HANDLING: abspath.c advice.c alias.c alloc.c apply.c archive.c archive-tar.c archive-zip.c argv-array.c attr.c
  Fatal error: exception Sys_error("swap: No such file or directory")

Without '-j 2' the command runs just fine.  I don't know what to make
of it.

> It looks like this also fixes a problem I ran into when doing the oideq
> work, which is that the patch for a header file would get shown multiple
> times (once for each file that includes it). So this is faster _and_
> more correct. Double-yay.

In that case I used to apply the change to the header first, and then
apply the semantic patch one more time.

