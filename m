Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC3CC2D0EC
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 02:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C4C2078E
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 02:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7e0baO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDKCob (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 22:44:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51390 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDKCob (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 22:44:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id x4so4230243wmj.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 19:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LCit2TAicDqxpYVE+1SUwgsAu17+40kD3Te5pIaBa3o=;
        b=I7e0baO0eJJlSS+GRFaovFhiS3h27GUvnZQmxlNarUBZEHYru9IKh7Vae+7+z1nsQK
         Ia/88aKqhC/KyHM+Z+9+4oqktjqUraizFy8vO60/6xk3RIE9RsaFfqXX3nd8uVDT635g
         W6cXYU5ZEHayoxrv2PdbfBgRo4C/ojOQKTpzCjhr1Aop/nxU2c/9PNqoQGoZ4IxAaitn
         GsuFrBeXNZQs7ZC4sDHlKoCxouYoYk7JxVXCnV9Rg8BU9OwkXqQI+4gllxyvKaQ131rE
         49/6FVPP6PpBIdyeBUo3EPZ5tearAA/NB83PZ28nuZUoBqiNFtDHo2Q2kMxfyS+KEVhk
         HY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LCit2TAicDqxpYVE+1SUwgsAu17+40kD3Te5pIaBa3o=;
        b=jwajCxLgYGZDRUn1RPYjqkcADcTCu7SZvKRvXDiB8zWEhnKarYuKiCcqTbOL7wQEQ0
         Nlu2Lgp3W9XPaok0gxYIOH9DWfiwC37kPpss3vKbuQPpB2gsdy6HyhETD57aC+22UaWU
         ctxoAQReU5Ealq0gL/yojPOQDn6UXeb3lxSnUenRFEHdvb0BG8KCGqO+beJnO3S4x08R
         3bArrBQL5Ru+DcY4U2IkjwWa/SBiXRaOBuuub8H2tv4p5gcpBXPj2VsD7myzvXGC/L73
         L2Ih+ITrSVDMNTPuEozW9iqMh9mNt6pjs+VLptCOFz9UcOlEXxjxwvTYmFGsjISX6EwD
         lH2w==
X-Gm-Message-State: AGi0PuaJYdtrgLCtqnpYR+xA/vbykEY1xez0PcIdsIDjnvUkWkcQzNEd
        uGLneg3sXsuzTJfDb+ug62xcWqOi
X-Google-Smtp-Source: APiQypKwPQUysdaZVXR9i2KKL4U0xG3VBBxY0cie40dVbeMnRDU2guP7UGCL7wq7AvXIsukFjOXXDg==
X-Received: by 2002:a05:600c:4152:: with SMTP id h18mr5152047wmm.31.1586573069209;
        Fri, 10 Apr 2020 19:44:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16sm5082116wml.30.2020.04.10.19.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 19:44:28 -0700 (PDT)
Message-Id: <pull.757.v3.git.git.1586573067.gitgitgadget@gmail.com>
In-Reply-To: <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
References: <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 02:44:23 +0000
Subject: [PATCH v3 0/4] rebase -i: mark commits that begin empty in todo editor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, bturner@atlassian.com,
        sami@boukortt.com, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 * Addressed feedback from Junio in patch 2, including moving some of the
   wording to the new patch (see next point)
 * Edited jt/rebase-allow-duplicate to include the changes Jonathan
   mentioned on the list, then rebased it on top of this series, and made
   the related options mention each other.

Elijah Newren (3):
  rebase -i: mark commits that begin empty in todo editor
  rebase: reinstate --no-keep-empty
  rebase: fix an incompatible-options error message

Jonathan Tan (1):
  rebase --merge: optionally skip upstreamed commits

 Documentation/git-rebase.txt      | 70 +++++++++++++++++++++-------
 builtin/rebase.c                  | 24 +++++++---
 sequencer.c                       | 14 +++++-
 sequencer.h                       |  4 +-
 t/t3402-rebase-merge.sh           | 77 +++++++++++++++++++++++++++++++
 t/t3421-rebase-topology-linear.sh | 10 ++--
 t/t3424-rebase-empty.sh           | 36 +++++++++++++++
 7 files changed, 202 insertions(+), 33 deletions(-)


base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-757%2Fnewren%2Frebase-mark-empty-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-757/newren/rebase-mark-empty-v3
Pull-Request: https://github.com/git/git/pull/757

Range-diff vs v2:

 1:  0d94eea376a = 1:  0d94eea376a rebase -i: mark commits that begin empty in todo editor
 2:  e15c599c874 ! 2:  3a5bedc68d6 rebase: reinstate --no-keep-empty
     @@ Commit message
      
          Commit d48e5e21da ("rebase (interactive-backend): make --keep-empty the
          default", 2020-02-15) turned --keep-empty (for keeping commits which
     -    start empty) into the default.  That commit viewed this, though as
     -    turning that flag into a no-op.  As such, --no-keep-empty was translated
     -    into undoing a no-op, i.e. also a no-op.  The logic underpinning that
     -    commit was:
     +    start empty) into the default.  The logic underpinning that commit was:
      
            1) 'git commit' errors out on the creation of empty commits without an
               override flag
     @@ Commit message
          look really weird despite making perfect sense (the first will drop
          commits which become empty, but keep commits that started empty; the
          second will keep commits which become empty, but drop commits which
     -    started empty).
     +    started empty).  However, --no-keep-empty was named years ago and we are
     +    predominantly keeping it for backward compatibility; also we suspect it
     +    will only be used rarely since folks already have a simple way to drop
     +    commits they don't want with an interactive rebase.
      
          Reported-by: Bryan Turner <bturner@atlassian.com>
          Reported-by: Sami Boukortt <sami@boukortt.com>
     @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
      -always dropped.
      +Note that commits which start empty are kept (unless --no-keep-empty
      +is specified), and commits which are clean cherry-picks (as determined
     -+by `git log --cherry-mark ...`) are detected and dropped as a preliminary
     -+step (unless --keep-cherry-picks is passed).
     ++by `git log --cherry-mark ...`) are always dropped.
       +
       See also INCOMPATIBLE OPTIONS below.
       
     @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
      -	to halt.
      +	Do not keep commits that start empty before the rebase
      +	(i.e. that do not change anything from its parent) in the
     -+	result.  For commits which become empty after rebasing, see
     -+	the --empty and --keep-cherry-pick flags.
     ++	result.  The default is to keep commits which start empty,
     ++	since creating such commits requires passing the --allow-empty
     ++	override flag to `git commit`, signifying that a user is very
     ++	intentionally creating such a commit and thus wants to keep
     ++	it.
       +
      -See also BEHAVIORAL DIFFERENCES and INCOMPATIBLE OPTIONS below.
     ++Usage of this flag will probably be rare, since you can get rid of
     ++commits that start empty by just firing up an interactive rebase and
     ++removing the lines corresponding to the commits you don't want.  This
     ++flag exists as a convenient shortcut, such as for cases where external
     ++tools generate many empty commits and you want them all removed.
     +++
     ++For commits which do not start empty but become empty after rebasing,
     ++see the --empty flag.
     +++
      +See also INCOMPATIBLE OPTIONS below.
       
       --allow-empty-message::
 3:  ee5e42361fc = 3:  5c8863b9d34 rebase: fix an incompatible-options error message
 -:  ----------- > 4:  20d3a50f5a4 rebase --merge: optionally skip upstreamed commits

-- 
gitgitgadget
