Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD411C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DE7613BD
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhFJOEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhFJOD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 10:03:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8370EC061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:01:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b11so33181346edy.4
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=DQGdLwkM65bTGpRpPLPA2VGIwEBSPQyjP13l7Yy/+Cw=;
        b=mXmzsy7u6EQYzgn+ZwYsZFgZwPULKeccL1/ykbSAbbz9JY9JhLIQuf2g3FPn1whhxX
         JeIpc86VIxA+gOxJ2Rc700K0vpZBikxWJyVc8G/oj++bh0WxxblfSWFKKsbEQNkNNfW2
         6D7HVSTgsu9BzMCdDGSaRfC6Oqag4YEyUto6G7Og5POEuelLAudILwpNpqVYYm+wWeaQ
         Xn/Xk3Yk5oi0J//Ja0mSLsYQZGp/UgPlXixJdNxiBvD+Vja0JpuzNFkClFd578XoWaFg
         Gg5x1nXxwFTrlKdG7Ho3gZKSHzv4PN0OEcjDj/6dxIzsHLrSjKT3UGYHwC/tjWh8c8rU
         o6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=DQGdLwkM65bTGpRpPLPA2VGIwEBSPQyjP13l7Yy/+Cw=;
        b=VmoLIvrk4ErxxASMLofOeFeqdoGG3FEqvMoH13fDC41PUqp5Psxfh7mzC6aEkcGe62
         P7KooykqyNqCRbzEf2UEqUidRtABV1H9lAPaTTQMXCRbQtGC2hY3kvT8wtOAdRJt+ojj
         WNlJLwekPQmkr6otl7oYsv2LpFjvCxYLJmok1M0BCJOF8u66m5rbIi+HDpFYlSgaANbn
         kznOA34RPm+02JuIrp2c3OziLK0O7RbDvCdZNiJjSh/7nFnL5KU2vHXRPylmhFNofHGp
         FXLyr7LjIhsJxDJio6gOS5lDJHUJ7491t3tha5IJ0t7TFfn5dW2KJgYdrKTvijWN5W9P
         JVVA==
X-Gm-Message-State: AOAM530PU3AZ2Mu7BpyIF3WuAaxSozTpvIwye4ze9xMUqu9nArIlD5BO
        4j4/c5+qMOxVJD6E3SHlhzg=
X-Google-Smtp-Source: ABdhPJztWBFUoIVtYK8CYhuM7PBuIOPn2VuUOPriDa3t4VnXwpSViI4E2hnIsswie3CiNfx6HPOEYw==
X-Received: by 2002:a05:6402:1a4b:: with SMTP id bf11mr4926220edb.286.1623333705062;
        Thu, 10 Jun 2021 07:01:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ot30sm1080538ejb.61.2021.06.10.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:01:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Nikhil Gupta <nikhilgupta2102@gmail.com>
Cc:     git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
Subject: Re: Build errors when building git on MacOS 11 (x86-64) and for M1
 macs
Date:   Thu, 10 Jun 2021 15:52:09 +0200
References: <f5487adb-b7dc-4f97-bca1-749701337759n@googlegroups.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <f5487adb-b7dc-4f97-bca1-749701337759n@googlegroups.com>
Message-ID: <87sg1p24zc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[CC-ing the main git@ list for the "bug in git" aspect of this]

On Thu, Jun 10 2021, Nikhil Gupta wrote:

> &nbsp; | The following shell command exited with status 2:
> &nbsp; | &nbsp;
> &nbsp; | $ CFLAGS=-I/opt/chef-workstation/embedded/include -O3 -D_FORTIFY_SOURCE=2 -fstack-protector CPPFLAGS=-I/opt/chef-workstation/embedded/include -O3
> -D_FORTIFY_SOURCE=2 -fstack-protector CXXFLAGS=-I/opt/chef-workstation/embedded/include -O3 -D_FORTIFY_SOURCE=2 -fstack-protector
> LDFLAGS=-Wl,-rpath,/opt/chef-workstation/embedded/lib -L/opt/chef-workstation/embedded/lib LD_RUN_PATH=/opt/chef-workstation/embedded/lib MAKE=gmake
> OMNIBUS_INSTALL_DIR=/opt/chef-workstation
> PATH=/opt/chef-workstation/bin:/opt/chef-workstation/embedded/bin:/Users/administrator/.buildkite-agent/builds/MM009-local-1/chef/chef-chef-workstation-master-omnibus-adhoc/omnibus/vendor/bundle/ruby/2.7.0/bin:/opt/angry-omnibus-toolchain/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
> PKG_CONFIG_PATH=/opt/chef-workstation/embedded/lib/pkgconfig gmake prefix=/opt/chef-workstation/embedded bindir=/opt/chef-workstation/gitbin -j 10
> [...]
> &nbsp; | * new script parameters
> &nbsp; | builtin/archive.c:48:24: error: implicit declaration of function 'archive_format_from_filename' is invalid in C99
> [-Werror,-Wimplicit-function-declaration]
> &nbsp; | const char *format = archive_format_from_filename(name_hint);
> &nbsp; | ^
> &nbsp; | builtin/archive.c:48:24: note: did you mean 'archive_read_open_filename'?
> &nbsp; | /opt/chef-workstation/embedded/include/archive.h:527:15: note: 'archive_read_open_filename' declared here
> &nbsp; | __LA_DECL int archive_read_open_filename(struct archive *,
> &nbsp; | ^
> &nbsp; | builtin/archive.c:48:15: warning: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int'
> [-Wint-conversion]
> &nbsp; | const char *format = archive_format_from_filename(name_hint);
> &nbsp; | ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> &nbsp; | builtin/archive.c:101:2: error: implicit declaration of function 'init_archivers' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
> &nbsp; | init_archivers();
> &nbsp; | ^
> &nbsp; | builtin/archive.c:111:9: error: implicit declaration of function 'write_archive' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
> &nbsp; | return write_archive(argc, argv, prefix, the_repository, output, 0);
> &nbsp; | ^
> &nbsp; | builtin/archive.c:111:9: note: did you mean 'write_or_die'?
> &nbsp; | ./cache.h:1737:6: note: 'write_or_die' declared here
> &nbsp; | void write_or_die(int fd, const void *buf, size_t count);
> &nbsp; | ^
> &nbsp; | 1 warning and 3 errors generated.
> &nbsp; | gmake: *** [Makefile:2431: builtin/archive.o] Error 1
> &nbsp; | gmake: *** Waiting for unfinished jobs....
> &nbsp; | &nbsp;
> &nbsp; | &nbsp;

I have no access to such a system, but I think think I see the problem
from what you've supplied here.

You supplied a CFLAGS=-I/opt/chef-workstation/embedded/include which has
an archive.h file that's unrelated to the archive.h file git expects.

Thus we include that and find things unrelated to git, and error when we
encounter a function we expected to have declared in our own archive.h.

The solution is something like defining a config.mak file where you add
flags with BASIC_CFLAGS +=, not =. See config.mak.uname for an
example. You'll then add new directories after our own -I.

This is arguably a bug in git's Makefile in that we should have that
"-I." in an ESSENTIAL_CFLAGS variable or something, I can't think of a
scenario where git would compile without it. That or things in builtin/
should include e.g. ../archive.h, perhaps such a thing isn't portable.

I think (but have not confirmed) that you probably got this far because
your compiler will stick -I. at the /end/ of the flags implicitly (or is
that standardized C behavior? I can't remember).

So it worked until we had a filename conflict, i.e. we'd find strbuf.h
in our own sources, but have an issue with a common name like archive.h.
