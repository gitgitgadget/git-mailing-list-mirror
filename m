Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A071F453
	for <e@80x24.org>; Fri,  8 Feb 2019 12:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfBHMyl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 07:54:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41225 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfBHMyl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 07:54:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so3442813wrs.8
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 04:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=w/FIrENyqwgNVXB4KjZ2gvkgpqTcoUcdWXHzZoUQvq4=;
        b=Y3tvOcyUf6vZddeQyNOi5yUH0myZFprnPaHwoZGR2ZGT5PzzkUxjPx1fO9N1mIAJlu
         qswOdgjxdGP8qw9nr9Omba7DZk1VKoPlKy0q2i7o6Gb35jy1P8LKgZd5bjnR70tqYp5O
         LkkdzMeJ5hBZpWADZRey25D+oBvKfSQGKcYw99If8KHi02sVQ6SA8MpmFaQOQv2jMvem
         M3lQYmN82qQREFXyx45T+aYLPl+zWvr17Vw8LurINCteL+Zo5HUNfpEWEsvP04WooZ7X
         +Ond17wLNm1VWfzoblO5n5L3oFUZgaTHzfxwAa0sD7Jn72rmsXyDO6lvwDwgWOyJrAg4
         lNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w/FIrENyqwgNVXB4KjZ2gvkgpqTcoUcdWXHzZoUQvq4=;
        b=dU1IMShhpfQs69UMPkd6eRyd8lxNXZDoIser561i5EWKYkF9SdTHUGYhmXCp7lWBcB
         gwgdVrCe++4jDg8hbq7vc4neJMjnHcHzR/rU4cEzj4mgsz4hwoUYc7FFwkBAapyEUlQZ
         LSHnonbQA4Ma1Z5nYx5EeW4BvDs+LcSAk1A7gntZwyt13bLGh0oOM8qyeQnvVGeLSsC2
         meefUTPwz8izzJl/1wILMOBoFB8t4OHpLfiDqwmLhTuKoLmeWmO6KgTl+L1kNz7gFYxP
         P7MNJ3znmKuQ89lAD0w7UpmEB7RGkTvGk0bneg7iZxplRLdbppyuW6kWW+hrW5wkm9aO
         3otQ==
X-Gm-Message-State: AHQUAuaQKYwqkNoGPKcN6UgFBmCunVhRRqrX9NeULMdqJi4fbBQo1PSG
        /zPg0qkos5g4y4bZQNhXgIc=
X-Google-Smtp-Source: AHgI3IZsUPP+hsJ97YXU1CZON0vgvxjEm1NrWygfGisq1AUgQa+kNqRtDt+uXLp7nspMVHO9ErQQQQ==
X-Received: by 2002:adf:eb45:: with SMTP id u5mr15908139wrn.102.1549630478875;
        Fri, 08 Feb 2019 04:54:38 -0800 (PST)
Received: from szeder.dev (x4db62aaa.dyn.telefonica.de. [77.182.42.170])
        by smtp.gmail.com with ESMTPSA id a187sm3413746wmf.33.2019.02.08.04.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 04:54:38 -0800 (PST)
Date:   Fri, 8 Feb 2019 13:54:35 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
Message-ID: <20190208125435.GW10587@szeder.dev>
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com>
 <CAM0VKjkM-THZALy20VrZ-JSMyZjUXUqp1CAoCPrezXRsBfRJ2A@mail.gmail.com>
 <nycvar.QRO.7.76.6.1902080928500.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1902080928500.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 09:32:32AM +0100, Johannes Schindelin wrote:
> Team,
> 
> On Mon, 6 Aug 2018, SZEDER Gábor wrote:
> 
> > [Resending with Clemens' last used email address.
> > Clemens, please consider sending a patch to update our .mailmap file.]
> > 
> > 
> > On Mon, Aug 6, 2018 at 5:11 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > >
> > > Travis CI changed its default OSX image to use XCode 9.4 on 2018-07-31
> > > [1].  Since then OSX build jobs fail rather frequently because of a
> > > SIGPIPE in the tests 'fetch notices corrupt pack' or 'fetch notices
> > > corrupt idx' in 't5570-git-daemon.sh' [2].  I think this is a symptom
> > > a real bug in Git affecting other platforms as well, but these tests
> > > are too lax to catch it.
> 
> I am seeing this very frequently now, as it feels like failing in the
> Azure Pipeline about half of the time.

I was wondering whether it's only an issue on Travis CI, and was
waiting whether you'll complain about it :)  Evidently it is not, but
I still would like to see a report about macOS running directly on
someone's Mac hardware, i.e. without all the CI/cloud/whatnot magic.

> Any ideas how to fix this test, anyone?

I'm afraid that this is not merely an issue with the test, but a
platform issue that we should work around somehow.  I would have
suggested to follow up on what Peff suggested, but I see that you
already did, and it didn't work out...

In the meantime, for lack of a better option, I started to skip the
two failure-prone tests in the OSX build jobs in my automated CI
builds with:

 -- >8 --

Subject: [PATCH] travis-ci: skip flaky tests in 't5570-git-daemon.sh' in OSX
 build jobs

See: https://public-inbox.org/git/CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com/

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 69dff4d1ec..1cd2c1db7d 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -121,7 +121,9 @@ osx-clang|osx-gcc)
 	# t9810 occasionally fails on Travis CI OS X
 	# t9816 occasionally fails with "TAP out of sequence errors" on
 	# Travis CI OS X
-	export GIT_SKIP_TESTS="t9810 t9816"
+	# In 't5570-git-daemon.sh', the tests 'fetch notices corrupt pack'
+	# and 'fetch notices corrupt idx' fail rather frequently.
+	export GIT_SKIP_TESTS="t9810 t9816 t5570.9 t5570.10"
 	;;
 GIT_TEST_GETTEXT_POISON)
 	export GIT_TEST_GETTEXT_POISON=YesPlease
-- 
2.20.1.940.g8404bb2d1a

 -- >8 --


> > > What it boils down to is this sequence:
> > >
> > >   - The test first prepares a repository containing a corrupt pack,
> > >     ready to be server via 'git daemon'.
> > >
> > >   - Then the test runs 'test_must_fail git fetch ....', which connects
> > >     to 'git daemon', which forks 'git upload-pack', which then
> > >     advertises refs (only HEAD) and capabilities.  So far so good.
> > >
> > >   - 'git fetch' eventually calls fetch-pack.c:find_common().  The
> > >     first half of this function assembles a request consisting of a
> > >     want and a flush pkt-line, and sends it via a send_request() call.
> > >
> > >     At this point the scheduling becomes important: let's suppose that
> > >     fetch is slow and upload-pack is fast.
> > >
> > >   - 'git upload-pack' receives the request, parses the want line,
> > >     notices the corrupt pack, responds with an 'ERR upload-pack: not
> > >     our ref' pkt-line, and die()s right away.
> > >
> > >   - 'git fetch' finally approaches the end of the function, where it
> > >     attempts to send a done pkt-line via another send_request() call
> > >     through the now closing TCP socket.
> > >
> > >   - What happens now seems to depend on the platform:
> > >
> > >     - On Linux, both on my machine and on Travis CI, it shows textbook
> > >       example behaviour: write() returns with error and sets errno to
> > >       ECONNRESET.  Since it happens in write_or_die(), 'git fetch'
> > >       die()s with 'fatal: write error: Connection reset by peer', and
> > >       doesn't show the error send by 'git upload-pack'; how could it,
> > >       it doesn't even get as far to receive upload-pack's ERR
> > >       pkt-line.
> > >
> > >       The test only checks that 'git fetch' fails, but it doesn't
> > >       check whether it failed with the right error message, so the
> > >       test still succeeds.  Had it checked the error message as well,
> > >       we most likely had noticed this issue already, it doesn't happen
> > >       all that rarely.
> > >
> > >     - On the new OSX images with XCode 9.4 on Travis CI the write()
> > >       triggers SIGPIPE right away, and 'test_must_fail' notices it and
> > >       fails the test.  I couldn't see any sign of an ECONNRESET or any
> > >       other error that we could act upon to avoid the SIGPIPE.
> > >
> > >     - On OSX with XCode 9.2 on Travis CI there is neither SIGPIPE, nor
> > >       ECONNRESET, but sending the request actually succeeds even
> > >       though there is no process on the other end of the socket
> > >       anymore.  'git fetch' then simply continues execution, reads and
> > >       parses the ERR pkt-line, and then dies()s with 'fatal: remote
> > >       error: upload-pack: not our ref'.  So, on the face of it, it
> > >       shows the desired behaviour, but I have no idea how that write()
> > >       could succeed instead of returning error.
> > >
> > > I don't know what happens on a real Mac as I don't have access to one;
> > > I figured out all the above by enabling packet tracing, adding a
> > > couple of well placed tracing printf() and sleep() calls, running a
> > > bunch of builds on Travis CI, and looking through their logs.  But
> > > without access to a debugger and netstat and what not I can't really
> > > go any further.  So I would now happily pass the baton to those who
> > > have a Mac and know a thing or two about its porting issues to first
> > > check whether OSX on a real Mac shows the same behaviour as it does in
> > > Travis CI's virtualized(?) environment.  And then they can pass the
> > > baton to those who know all the intricacies of the pack protocol and
> > > its implementation to decide what to do with this issue.
> > >
> > > For a mostly reliable reproduction recipe you might want to fetch this
> > > branch:
> > >
> > >   https://github.com/szeder/git t5570-git-daemon-sigpipe
> > >
> > > and then run 'make && cd t && ./t5570-git-daemon.sh -v -x'
> > >
> > >
> > > Have fun! ;)
> > >
> > >
> > > 1 - https://blog.travis-ci.com/2018-07-19-xcode9-4-default-announce
> > >
> > > 2 - On git.git's master:
> > >     https://travis-ci.org/git/git/jobs/411517552#L2717
> > 
> > 

