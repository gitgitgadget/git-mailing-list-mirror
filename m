Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF97C2BC11
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 14:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BCC221EF
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 14:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIuJxXwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgIKOEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgIKNUX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 09:20:23 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB753C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:19:50 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lo4so13743093ejb.8
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7wObJFSQyVY/hsjQFc3gE26zkuwkPQkj8/OkOFr52NA=;
        b=rIuJxXwGSUXaCkIU1LKqmGSnAOvWADQ6RYA4e+pswRkzVike3qcrg+hKEMJwX7osEu
         z2MTPc1/a8oJyPetbi5DF9AGp/ZAoTvWUMjz7Obq18KyKskOQN13XTut5R0kWdyk9Ppo
         9NwSuaSRQ0DAzaSVEm4GIpecMvD3ECexOQP/fu48WWm/BeegZZHr2FkrMgTNvRApswUr
         IStRsHkve2kj4pfy+hWs4TQZ4kjDaHUtMWnkAtgYPw9FNLnm9oL8VRW7gPuugki5hBLu
         qG4XHL87cXKig0UCBCPda4t4ZCm8S0x1ownYes9iTiCbQh+ZwMtQ8s8i0IdawjmOCZtg
         FpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7wObJFSQyVY/hsjQFc3gE26zkuwkPQkj8/OkOFr52NA=;
        b=qPlND94IT1sV+4/drgncmm0ZVOuzMwYL6Z9lhFHBtPxlnkeQ7QJr/rT0Jzi2hJjf0W
         K+Gn8HjEzm8cMTVwjvbh5AE6QqHLRy4QyvqsTKPfaeHJ6dXUhdymUzZL/6+GLRXCLyVw
         ERWTeD5dE9kUF1dg37hzdYkdTzaCS8HULCIfkmt6t//hwR0kT91zJyWc8Pyst2cwvhD0
         sbrKY1GEb8S19fVfYPyoYriqNzyTA4CK7wy7ww+SA3CZd4MEntii/kS2XjQhX1EGCH5H
         tx9Qo7MJHZ+UMiVZkNwmUz2UqvkJrIXywTc0Y4/Os7Q2goKgAhamXVsChtvM9oR37jlH
         pWVA==
X-Gm-Message-State: AOAM531FTEHOrBnIw7LXQDE1kwKA2S/AbvVH4it3DW140e9gOf/tMWVk
        0bQo5rzQrVykByzegXIs89k=
X-Google-Smtp-Source: ABdhPJz7P3AJ0XaSAf5Hk7dOaA4wW3qQYOk7/TWbif++DcKPC2rSSb87wciao0T97l+wMLkxTDJ+ZQ==
X-Received: by 2002:a17:906:1186:: with SMTP id n6mr1900850eja.331.1599830389427;
        Fri, 11 Sep 2020 06:19:49 -0700 (PDT)
Received: from szeder.dev (94-21-23-168.pool.digikabel.hu. [94.21.23.168])
        by smtp.gmail.com with ESMTPSA id i15sm1686481edf.82.2020.09.11.06.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:19:48 -0700 (PDT)
Date:   Fri, 11 Sep 2020 15:19:43 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?Q?J=C4=99drzej?= Dudkiewicz <jedrzej.dudkiewicz@gmail.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Cannot run `git submodule init` on Cygwin from script with
 strict error checking
Message-ID: <20200911131943.GA23146@szeder.dev>
References: <CABJqhQNh2Qc2Btp==bGUbT-AaSjGdGEmhtphQQyX=nqjWOis0A@mail.gmail.com>
 <CA+kUOan0N32W22xkoYsGYqM7rJDnc=tjQe_2Hnh2H47=19bbeQ@mail.gmail.com>
 <CABJqhQMST-n6-uEDpFCUSsYueF_=7ZLPCtj_mQnu679oY99ZVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABJqhQMST-n6-uEDpFCUSsYueF_=7ZLPCtj_mQnu679oY99ZVg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 01:46:43PM +0200, Jędrzej Dudkiewicz wrote:
> On Fri, Sep 11, 2020 at 1:30 PM Adam Dinwoodie <adam@dinwoodie.org> wrote:
> >
> > Hi Jędrzej,
> 
> > I think there's something odd about the way you're calling `git
> > submodule init`: it should normally be a separate execution that
> > wouldn't inherit the `-aeu` or `-x` settings from the parent Bash
> > process.
> 
> Sorry for not including the test script. Here it is:
> 
> ----8<----8<----8<-- CUT HERE--8<----8<----8<----8<----
> #!/bin/bash
> 
> set -aeu
> 
> export SHELLOPTS
> 
> set -x
> 
> git submodule init
> ----8<----8<----8<-- CUT HERE--8<----8<----8<----8<----
> 
> I use "export SHELLOPTS" because I want these flags to be effective in
> subshells.

You don't need 'export SHELLOPTS' to make those flags effective in
_subshells_:

  $ cat test.sh 
  #!/bin/sh
  
  set -ex
  
  (
          false
          echo "after false"
  )
  exit 0
  $ ./test.sh
  + false
  1
  $ echo $?
  1

What 'export SHELLOPTS' does is make those flags effective even in
separate shell scripts executed by your script, but, as you just found
out, that's not really a good idea, because those scripts are beyond
your control.

> As a workaround I'm currently calling "set +u" before each
> execution of "git submodule init" and my script works, but it isn't
> very nice and IMHO shouldn't be required (i.e. it would be extremely
> nice if someone fixed it).

The right workaround would be to apply those shell options only to
your script, i.e. to remove that 'export SHELLOPTS'.

Having said that, unlike 'git submodule', 'git-sh-setup' is meant to
be dot-sourced into users' shell scripts, and, therefore, should work
with the shell options set in users' scripts, including even 'set -u'.

The patch below may or may not make it work; it's well over two years
old, and I haven't tested it at all since then.


  ---  >8  ---

Subject: [PATCH] git-sh-setup, git-sh-i18n: make our shell libraries work with
 'set -u'

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 git-sh-i18n.sh  |  6 +++---
 git-sh-setup.sh | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 8eef60b43f..4eb2a7ad70 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -7,7 +7,7 @@
 # Export the TEXTDOMAIN* data that we need for Git
 TEXTDOMAIN=git
 export TEXTDOMAIN
-if test -z "$GIT_TEXTDOMAINDIR"
+if test -z "${GIT_TEXTDOMAINDIR-}"
 then
 	TEXTDOMAINDIR="@@LOCALEDIR@@"
 else
@@ -17,7 +17,7 @@ export TEXTDOMAINDIR
 
 # First decide what scheme to use...
 GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
-if test -n "$GIT_TEST_GETTEXT_POISON" &&
+if test -n "${GIT_TEST_GETTEXT_POISON-}" &&
 	    git env--helper --type=bool --default=0 --exit-code \
 		GIT_TEST_GETTEXT_POISON
 then
@@ -25,7 +25,7 @@ then
 elif test -n "@@USE_GETTEXT_SCHEME@@"
 then
 	GIT_INTERNAL_GETTEXT_SH_SCHEME="@@USE_GETTEXT_SCHEME@@"
-elif test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
+elif test -n "${GIT_INTERNAL_GETTEXT_TEST_FALLBACKS-}"
 then
 	: no probing necessary
 elif type gettext.sh >/dev/null 2>&1
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 10d9764185..1cb1c8a2e8 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -66,16 +66,16 @@ say () {
 	fi
 }
 
-if test -n "$OPTIONS_SPEC"; then
+if test -n "${OPTIONS_SPEC-}"; then
 	usage() {
 		"$0" -h
 		exit 1
 	}
 
 	parseopt_extra=
-	[ -n "$OPTIONS_KEEPDASHDASH" ] &&
+	[ -n "${OPTIONS_KEEPDASHDASH-}" ] &&
 		parseopt_extra="--keep-dashdash"
-	[ -n "$OPTIONS_STUCKLONG" ] &&
+	[ -n "${OPTIONS_STUCKLONG-}" ] &&
 		parseopt_extra="$parseopt_extra --stuck-long"
 
 	eval "$(
@@ -89,7 +89,7 @@ else
 		die "$(eval_gettext "usage: \$dashless \$USAGE")"
 	}
 
-	if [ -z "$LONG_USAGE" ]
+	if [ -z "${LONG_USAGE-}" ]
 	then
 		LONG_USAGE="$(eval_gettext "usage: \$dashless \$USAGE")"
 	else
@@ -98,7 +98,7 @@ else
 $LONG_USAGE")"
 	fi
 
-	case "$1" in
+	case "${1-}" in
 		-h)
 		echo "$LONG_USAGE"
 		case "$0" in *git-legacy-stash) exit 129;; esac
@@ -366,7 +366,7 @@ esac
 # if we require to be in a git repository.
 git_dir_init () {
 	GIT_DIR=$(git rev-parse --git-dir) || exit
-	if [ -z "$SUBDIRECTORY_OK" ]
+	if [ -z "${SUBDIRECTORY_OK-}" ]
 	then
 		test -z "$(git rev-parse --show-cdup)" || {
 			exit=$?
@@ -381,7 +381,7 @@ git_dir_init () {
 	: "${GIT_OBJECT_DIRECTORY="$(git rev-parse --git-path objects)"}"
 }
 
-if test -z "$NONGIT_OK"
+if test -z "${NONGIT_OK-}"
 then
 	git_dir_init
 fi
-- 
2.28.0.820.g0db9d372c0

  ---  >8  ---

