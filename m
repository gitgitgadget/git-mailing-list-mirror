Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B957C636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 18:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661B361289
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 18:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbhGOSFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 14:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhGOSFz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 14:05:55 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B676C06175F;
        Thu, 15 Jul 2021 11:03:01 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id 109so2450552uar.10;
        Thu, 15 Jul 2021 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=e4lnR83fHStKz8gagpSU/N35+IdwX9t/08rZw/hyq5w=;
        b=DvYn3MIhCDH7pPtqBwYO1vERZZ/DS2cYqvvCSwhrYWE61W4Sd/t0w0T6z2m8RKO+3R
         /BHJAZhs/B/jAbIo3cfR7q+p/CDS/67YHMZlZZcMiFAj2ZdrS6drx41zlqCQfd/ceRrL
         b0a0gNtYAVFcx3NzRosv4xfaxfHG0E5OLk9xkMCVo5IV0GNXZx8/bsZQ3M0ZIaF2AeUO
         z6QEghLYm2XPqp2IMsaqEpWXw4sKQTwMFRswodK0ZCu5ahwhnsqL65VMGyz2LURK88ek
         77Vw9EmVMZUgcx3EbnBHr7l6ncVLvEs6HmfAZWzAI0foFBUqmHURKR5lFe0yunjCQaSq
         06Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=e4lnR83fHStKz8gagpSU/N35+IdwX9t/08rZw/hyq5w=;
        b=aPtpfV0uKbcOeuZ0euqJO9v48lgMpxwHhJFXAbtQLIck/5ZJHzxuSBKxQFBrcY4CYi
         ZK4KidOHVaXPHX6vx8NO74FgvpOMNzDQ4l36ybVrERUBAeHTA/wWS9TFYnZbxUoxb3fK
         4i1g9hIrXU9uueZ5LSJ3oql6tq9m7GDFj0oAWSzOqXEeYfEl+diYcDwmDKpFm2JCOas3
         uOGW5RW8u8rxkuYKtg8gw1Cd/ICGOwayk6Dx9PfcbAylCLriZhNGL/6cHJh4OH7hpP7f
         th30LYxL/GSVukDf2BmdNS69gimbNzLqHbtNCtkPMsGDI8q9rGQSNGMfRryrEM0NaZ9I
         p+Ow==
X-Gm-Message-State: AOAM530lj8VJ8ZUo4lXpwA4ydyegxv0euMYLz8+Vy/8u2+pX+GJL0Mv1
        EL/Y2P9VXZ8L9rfNVuoh0zuGcTcZ5nSPcj1OV8lv9dpAP3B8oA==
X-Google-Smtp-Source: ABdhPJwfC6HLLYe5EGD638Ry2LqztquNfcdYOoNa890sSo0t726e/beDIQZvwbYvaJROpa4feR8dqDmKgSH6mzijeSU=
X-Received: by 2002:ab0:4101:: with SMTP id j1mr8826206uad.13.1626372179487;
 Thu, 15 Jul 2021 11:02:59 -0700 (PDT)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Thu, 15 Jul 2021 12:02:33 -0600
Message-ID: <CAJfuBxwZbrAuzvfHRxLHhh8a9nva7fR4ZiLc7NECspVZ0gx2ow@mail.gmail.com>
Subject: subordinate trees ? we have %G-space, we should add %K-space
To:     git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi git people,

managing .configs, over time, and across work-trees, is an ongoing burden.
I wonder if/how git could help.

I imagine a subordinate/secondary tree,
which basically has only 1 tracked file ( .config ) in it.
Auto-commit on .config ( perhaps as 1st step of make ) would mean no
changes are missed

A tertiary tree could hold all of ./builds/*
or really any set of files that are ignored by the primary tree's
.gitignore file
its purpose would be to track build products; all *.o etc
its kind-of a superset of what might be found in your .ccache,
(it also includes *.cmd.o etc, and all other intermediate outputs)
but it is attributable to a TooChainCompilationTransferFn(.config, HEAD)

Since HEAD already has a sha*, we just need one for .config,
the secondary tree keeps that for us.

the tertiary tree doesnt REALLY need to keep *all* the build products,
it just needs to keep track of them (just the sha*, since they are
reproducible),
but every commit (to either source, or to .config) should result in 1 or more
build products changing.  It might be useful for QA purposes to predict and
verify what products should change.

Autocommit here means that make *anything* has known inputs,
so if results are useful/reportable, they have known inputs (no -dirty)

Also, it might be handy to be able to diff any 2 objdumps/readelfs of foo.o,
which would be easier with a cryptographically known DB


Heres how I think it could get leveraged for linux itself

We have %G space, expressed in the kernel name:
  5.14.0-rc1-lm1-00003-g4a7356173ef9-dirty

Lets add %K space, to extend that:
  5.14.0-rc1-lm1-00003-g4a7356173ef9-dirty-k6173ef96173

now posit a kverstr("%D-%G-%K") producing the 2nd name above.
    %T - tag :  "5.14.0-rc1"
    %L - localversion : "-lm1"
    %C - count : "00003", %C{5} default
    %G - HEAD-sha : "-g4a7356173ef9-dirty"
    %K - sha(.config) : "-k6c173efc961c", obviously 'c' is taken.
    %D - desc : "%T-%L-%C"

%L is seductive, but ultimately a nuisance; mine above is a
super-imaginitive "-localmod-1" abbreviation.

In contrast, %K would give:

- updates every time the .config is tweaked.

- each arch make defconfig yields single %Kval
  or a few (1 per salt-val)

- normalization done by make oldconfig narrows %K-space
  some %Kvals are "impossible" (aka: hand altered or fuzzed .configs)

- many .configs will get "well-known" %Kvals
  bots will report probs with %Gs against specific %Ks

- all well-known configs: defconfig, allmodconfig, etc...
  get unique %Ks, maybe become well-known
  esp as %K{5} which is short enough to recognize
  %Ks could be annotated
  %Ks change slowly as **/KBuild.* composition changes
  traceable to commits in %G

With (imagined) Git extensions:

1. subordinate trees, in same src/work-dir:

a configs subtree would have only .config file checked in, and
probably should auto-commit on changes.

ls ./.gitinclude.*

These actively define inclusions of files in the named subtree, rather
than ignores.  They dont see files that are not explicitly ignored by
primary tree.

so ./.gitinclude.1.configs:
# with
.config

could always, actively, track and commit changes to .config,
`history|grep config | tail -n5`, automatically added to commit-log,
would help (a little) explain why.  A string serialization of the
CONFIG_* changes, would completely characterize the .config diff, and

and ./.gitinclude.3.builds
# with
./builds/

captures all build product files written under ./builds/* into a
single subordinate tree.  This tree can only contain files ignored by
.gitignore (ie the primary/source tree)

obviously this will include all of ./**/*.o, which is essentially
a %G+%K versioned (and clean) ccache result set.

./builds/{*}   # distinct build-product (%G+%K dependent) sub-trees

./builds/foo # foo
./builds/bar

not really sure how the 2ndary tree (.config tracker) should play with
worktrees,
or even with multiple ./builds/ subdirs, each with a .config
those subdirs are our %K-space-explored,
ie those configs which we have at least tried

make randconfig is a rather low-quality way to expand the tested %K-space
but with %K handled a bit better, we could at least track how much of
the space gets tested this way.

ok, now Im meandering.
