Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200891F461
	for <e@80x24.org>; Thu, 18 Jul 2019 15:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfGRPWl (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 11:22:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39338 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfGRPWl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 11:22:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so29127651wrt.6
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ndw8q5XxmexqNLDZC3U7iswAwuzV6AjjR0zepEzKF8U=;
        b=qjlejmf8XV+5AIKWLFKUjarS9yaduixFqm6jZrHFAMrGiguQugMJ6gNbUmmaP9tsiP
         0ddhW13z9GUOS3k1VRzKHqX75VAKipDHA/gdSLMdCIteReolMPhTBMn1xNTpptY41fA7
         hP5pObXOiQlijuP2Qs9SY25yspT3PF122ST65HNL1NIgXWzPj9hnj0Ef5HPgbDZplLcs
         72/+0rdMVaztKAbuX2q9VLe+FLqfs4EhYw7z7DKO4elmOzbozkKhWB2Fy0syg455u522
         Y1dwUhG10PGEN72Xbz64smGqOKCbNgXqcf7M4XbxPLScJO3Eg0qamg/Y7Mpz/Lw0LTEP
         Gz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ndw8q5XxmexqNLDZC3U7iswAwuzV6AjjR0zepEzKF8U=;
        b=BH5b63fgaMMHfk/0e/WUJ7oYgVGO9CYNnSBcgg02Kwh8Im9ur/ds9KTEnE+ponZoFO
         iG7VvllAWIBW/S06hQscfswa0jpc6bf3Nmlsh0cUjP1EtWlvugP/ks9CJazbld6eZEJ3
         sLV//sDVv7K0oG5Z7+EM/P1+EHaGybrEnV/HPG6GXxWHp6pDXucmgCsYrGVhteGptH1x
         aRy0sc5erqXMx2SEUQWxO547/S9grdV+dZSwA0DWMehrx1oekcTsJL8dtNJbOxP2FR9t
         9ZmLRym0NzF2dqsQLIuAi6TktJ7zDSM2dJ6nzfMi8tOfm0pLRmkLOsswK0aVtmwChX/D
         6FDg==
X-Gm-Message-State: APjAAAUmSIZoPH9rZvkRAQrolLPo0Wk44cEhrqqjvoU9YkUcmDA5zc08
        6zqFQX3tk/YGuD4gvSZwzJM=
X-Google-Smtp-Source: APXvYqwnz6/Im6lnk4w09wqMzaNFnoTNZWc8+xm1Ms1IYhxFtSqW6lBmBvyKJ5iOKrCRwWPCjvc2XQ==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr52695295wrm.235.1563463358132;
        Thu, 18 Jul 2019 08:22:38 -0700 (PDT)
Received: from szeder.dev (x4db919f4.dyn.telefonica.de. [77.185.25.244])
        by smtp.gmail.com with ESMTPSA id t6sm27473063wmb.29.2019.07.18.08.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 08:22:37 -0700 (PDT)
Date:   Thu, 18 Jul 2019 17:22:34 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in
 push_refs_with_push
Message-ID: <20190718152234.GI20404@szeder.dev>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <20190709211043.48597-1-emilyshaffer@google.com>
 <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
 <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 16, 2019 at 09:53:59AM -0700, Junio C Hamano wrote:
> Carlo Arenas <carenas@gmail.com> writes:

> >> +                       for (struct ref *it = remote_refs; it; it = it->next)
> >
> > moving "struct ref it" out of the loop, allows for building with ancient
> > compilers that don't support C90 (even if only by default) as I found
> > out while building pu in a Centos 6 box

> but I think we still reject variable definition in
> for loop control (we saw and rewrote another patch that tried to use
> it late last year).
> 
> Apparently, this one slipped our review process.

I expected that this will eventually happen after Travis CI's default
Linux image recently changed from Ubuntu 14.04 to 16.04; explanation
in the commit message below.

With that patch issues like this could be caught earlier, while they
are only in 'pu' but not yet in 'next'.  But do we really want to do
that, is that the right tradeoff?  Dunno...  Adding a dedicated CI job
just to check that there are no 'for' loop initial declarations seems
kind of excessive, even if it only builds but doesn't run the test
suite.  And I don't know whether there are any other undesired ("too
new") constructs that GCC 4.8 would catch but later compilers quietly
accept.

  --- >8 ---

Subject: [PATCH] travis-ci: build with GCC 4.8 as well

C99 'for' loop initial declaration, i.e. 'for (int i = 0; i < n; i++)',
is not allowed in Git's codebase yet, to maintain compatibility with
some older compilers.

Our Travis CI builds used to catch 'for' loop initial declarations,
because the GETTEXT_POISON job has always built Git with the default
'cc', which in Travis CI's previous default Linux image (based on
Ubuntu 14.04 Trusty) is GCC 4.8, and that GCC version errors out on
this construct (not only with DEVELOPER=1, but with our default CFLAGS
as well).  Alas, that's not the case anymore, becase after 14.04's EOL
Travis CI's current default Linux image is based on Ubuntu 16.04
Xenial [1] and its default 'cc' is now GCC 5.4, which, just like all
later GCC and Clang versions, simply accepts this construct, even if
we don't explicitly specify '-std=c99'.

Ideally we would adjust our CFLAGS used with DEVELOPER=1 to catch this
undesired construct already when contributors build Git on their own
machines.  Unfortunately, however, there seems to be no compiler
option that would catch only this particular construct without choking
on many other things, e.g. while a later compiler with '-std=c90'
and/or '-ansi' does catch this construct, it can't build Git because
of several screenfulls of other errors.

Add the 'linux-gcc-4.8' job to Travis CI, in order to build Git with
GCC 4.8, and thus to timely catch any 'for' loop initial declarations.
To catch those it's sufficient to only build Git with GCC 4.8, so
don't run the test suite in this job, because 'make test' takes rather
long [2], and it's already run five times in other jobs, so we
wouldn't get our time's worth.

[1] The Azure Pipelines builds have been using Ubuntu 16.04 images
    from the start, so I belive they never caught 'for' loop initial
    declarations.

[2] On Travis CI 'make test' alone would take about 9 minutes in this
    new job (without running httpd, Subversion, and P4 tests).  For
    comparison, starting the job and building Git with GCC 4.8 takes
    only about 2 minutes.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .travis.yml               |  4 ++++
 ci/run-build-and-tests.sh | 17 +++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index ffb1bc46f2..fc5730b085 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -21,6 +21,10 @@ matrix:
       compiler:
       addons:
       before_install:
+    - env: jobname=linux-gcc-4.8
+      os: linux
+      dist: trusty
+      compiler:
     - env: jobname=Linux32
       os: linux
       compiler:
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cdd2913440..ff0ef7f08e 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -11,9 +11,9 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 esac
 
 make
-make test
-if test "$jobname" = "linux-gcc"
-then
+case "$jobname" in
+linux-gcc)
+	make test
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
 	export GIT_TEST_OE_SIZE=10
@@ -21,7 +21,16 @@ then
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	make test
-fi
+	;;
+linux-gcc-4.8)
+	# Don't run the tests; we only care about whether Git can be
+	# built with GCC 4.8, as it errors out on some undesired (C99)
+	# constructs that newer compilers seem to quietly accept.
+	;;
+*)
+	make test
+	;;
+esac
 
 check_unignored_build_artifacts
 
-- 
2.22.0.810.g50207c7d84


