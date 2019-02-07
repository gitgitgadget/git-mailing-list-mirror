Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1DD1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 19:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfBGTfN (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 14:35:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39107 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBGTfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 14:35:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id f16so1101234wmh.4
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 11:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4xcsHW01INWBIdQuB7P2Bjxr/a2b3NJ1MbAgxRhoPro=;
        b=Y41ItyRDB04nZ9S/YpUVhapXR542XR/Fw9KK3KtImhf3/Z0iBPK1sAZCTx2cHCT8gf
         H5dj+oYOqfi6+cSE71+O6YWHnWidkNlP27tP6dzPFOyGOwDKi5Fx29g+1Zvcce2nXaVf
         e/HTCD5htrn269AXusySpVqPCdo0Zj9AajU97nxYkpsMN+7vIfZDiDnuEa0OeXsoIsSv
         XE1yPXOhcywWFL4swrnnjho4yP1G5aKgBfFZKeXGygQ8UZXdZRJafEJIXI8xheKZ+H8H
         KNI3V1pokvNnyXnXEV6/n11yTPkYR8Phor4XzcgFS/vCc1HzKhC9OCYDczG38yJzD+g3
         Mdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4xcsHW01INWBIdQuB7P2Bjxr/a2b3NJ1MbAgxRhoPro=;
        b=eYbCvDWcZhWUgmRd6cDKBKzruP31/n5okIpodIAh9kCx5PwaTrVrH6NIE2bKFAfQTX
         aPbdQ89ObEQYRYFvWhknYTozV1+GDkmtzoVLNmDApQNlAVEiR3Rw7hff/kbjdfLxaid2
         NfRvt00XeNwvxSKJio3K/F+WEorGiknm9RHpQBlkcl8F8LpruL/l7/gzLyF3HuDtMkb1
         8q/1BKE6PrlMywd4kf9EmcQr+1LCluMkEguoj79aYBWeOIXELGjtmnyKKxUW/sjvkM9R
         aZNDDAQso4Hz3xPkchCY1S5oI/0dwG1HEQQvRjQ3yvXGUkclpFjIMXG3lH6Eq4ltngdb
         FaaA==
X-Gm-Message-State: AHQUAubr81FNh972dRuwXQjoJSZNW8FLjmKkt/54rpYvNSpzBYZdVazl
        3gDA7j87e0NA9VcotwmQ0Fagc0iE
X-Google-Smtp-Source: AHgI3IbN3ty3+k2OaF8Dt/nkOD9XB7oKV+8bhFqVKB5pbo4ntuPY5Q4R798K63oo12kJipQKUzhy3w==
X-Received: by 2002:a1c:7616:: with SMTP id r22mr6895176wmc.35.1549568110231;
        Thu, 07 Feb 2019 11:35:10 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w13sm260857wmf.5.2019.02.07.11.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 11:35:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: make sure we build Git parallel
References: <20190207183736.9299-1-szeder.dev@gmail.com>
        <xmqqbm3npgox.fsf@gitster-ct.c.googlers.com>
        <xmqq1s4jpgh6.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 07 Feb 2019 11:35:08 -0800
In-Reply-To: <xmqq1s4jpgh6.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 07 Feb 2019 11:04:53 -0800")
Message-ID: <xmqqsgwzo0ib.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Wouldn't all other hits of "MAKEFLAGS=" in ci/lib.sh also want the
> same treatment, though?  We know that "if travis to this, otherwise
> if Asure, do that" is the first block to muck with MAKEFLAGS in the
> script, but a new assignment before that block can be added in the
> future and cause a similar issue unless we do so.
>
> Of course, at some point we do want to say "we do not want to
> inherit it from the outside environment", but then such an
> assignment of empty value should be done at the very beginning with
> a comment, not with "this happens to be the first one to set, so
> let's not append but assign to clear any previous value", I would
> think.

That is, in a patch form on top of yours, something like this.


 ci/lib.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index cee51a4cc4..288a5b3884 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -74,6 +74,9 @@ check_unignored_build_artifacts ()
 	}
 }
 
+# Clear MAKEFLAGS that may come from the outside world.
+export MAKEFLAGS=
+
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
 # Set tracing executed commands, primarily setting environment variables
@@ -101,7 +104,7 @@ then
 	BREW_INSTALL_PACKAGES="git-lfs gettext"
 	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --immediate"
-	export MAKEFLAGS="--jobs=2"
+	MAKEFLAGS="$MAKEFLAGS --jobs=2"
 elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
 then
 	CI_TYPE=azure-pipelines
@@ -126,7 +129,7 @@ then
 	BREW_INSTALL_PACKAGES=gcc@8
 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
-	export MAKEFLAGS="--jobs=10"
+	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test windows_nt != "$CI_OS_NAME" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
@@ -185,4 +188,4 @@ GIT_TEST_GETTEXT_POISON)
 	;;
 esac
 
-export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
+MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
