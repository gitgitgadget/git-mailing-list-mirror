Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2919F20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 16:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeLJQmm (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 11:42:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36231 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLJQmm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 11:42:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so5499420plo.3
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 08:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6mkzZTcsm/LNsuIBKjgClTcrrBbh8hA19WJq5E3dAus=;
        b=ZiKsyagU8o+EVkUVirlD5KfAUynNUQ8H6EC9Gbm0geekbjB4/WLUPoVtXIwXah7wyv
         p+Ga+IMOO6U/iWjyhQOI5b/g5Vyd4sSiF8zdWl9GklP+i1/E6DKDWyu5rgKzQ02z45Ux
         SIcjvAFF1XyGL+6aysdEI+p4zthbIPrv8jIe3+buVAWHZmAKginqaqaVYXbiYaqUSM7N
         eFTe/HYPSJryAuZKLxxCAE2cT1gFl+T3lBimslS66HtpN06A6q6O7m/ticr35BJwjL7B
         oKw+M6f2690V82iWNa6PhNyCtmqf+kTIAtomPpgOZ9gO23gQOBqYNUVtoTKf1yJ3cqV7
         s0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6mkzZTcsm/LNsuIBKjgClTcrrBbh8hA19WJq5E3dAus=;
        b=fNdlLg1PM38wiNj/DKqOmBtogjDVm6YvSkt2SxZL1mK67JvV5VJzPVo6THe6117tzX
         oorWsaIIaKhV8pZvcE3GlG7t49H/qg7woerPuIZ5BhYp61G6Mjoeq5L7JYWJJitOoXsp
         WAlFJSHyUieSDCsSQljSYb7jP2+Tk2Kx3Uig5HrEP84/eZbrF5aPGntbS64ow/d8pt6l
         lZrtwN41z4npR37beqz1N058M4duMTonXd4TXyWDf1ENywrPEQ2Kxx5zAcu+BF7ONoU4
         16/umBOSf8MzwE+U8gF8n91LGKciS84pmAlyuRylrjAOD5IKioChe86az6atKr5or1aK
         yI+Q==
X-Gm-Message-State: AA+aEWZX1fwOrygxcg/meWV7xqWKy/bkYS2ciXV6D9S/oZ6l8GFdJS7T
        y0xPjAGmSduL5ECux4p4AMimUO70
X-Google-Smtp-Source: AFSGD/X0HIC6rH3KjTJrWPDKcjLEs1I7YPmjLA4gTBIvxiEuU71dR434w0q6w4xZRv+pRl+HvEmlTw==
X-Received: by 2002:a17:902:70c6:: with SMTP id l6mr13063014plt.30.1544460161320;
        Mon, 10 Dec 2018 08:42:41 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id z62sm20079639pfi.4.2018.12.10.08.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:42:40 -0800 (PST)
Date:   Mon, 10 Dec 2018 08:42:40 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 16:42:32 GMT
Message-Id: <pull.89.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v2.git.gitgitgadget@gmail.com>
References: <pull.89.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/6] Add a new "sparse" tree walk algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the biggest remaining pain points for users of very large
repositories is the time it takes to run 'git push'. We inspected some slow
pushes by our developers and found that the "Enumerating Objects" phase of a
push was very slow. This is unsurprising, because this is why reachability
bitmaps exist. However, reachability bitmaps are not available to us because
of the single pack-file requirement. The bitmap approach is intended for
servers anyway, and clients have a much different behavior pattern.

Specifically, clients are normally pushing a very small number of objects
compared to the entire working directory. A typical user changes only a
small cone of the working directory, so let's use that to our benefit.

Create a new "sparse" mode for 'git pack-objects' that uses the paths that
introduce new objects to direct our search into the reachable trees. By
collecting trees at each path, we can then recurse into a path only when
there are uninteresting and interesting trees at that path. This gains a
significant performance boost for small topics while presenting a
possibility of packing extra objects.

The main algorithm change is in patch 4, but is set up a little bit in
patches 1 and 2.

As demonstrated in the included test script, we see that the existing
algorithm can send extra objects due to the way we specify the "frontier".
But we can send even more objects if a user copies objects from one folder
to another. I say "copy" because a rename would (usually) change the
original folder and trigger a walk into that path, discovering the objects.

In order to benefit from this approach, the user can opt-in using the
pack.useSparse config setting. This setting can be overridden using the
'--no-sparse' option.

Update in V2: 

 * Added GIT_TEST_PACK_SPARSE test option.
 * Fixed test breakages when GIT_TEST_PACK_SPARSE is enabled by adding null
   checks.

Update in V3:

 * Change documentation around 'pack.useSparse' config setting to better
   advertise to users.
 * Mostly a ping now that v2.20.0 is out.

Derrick Stolee (6):
  revision: add mark_tree_uninteresting_sparse
  list-objects: consume sparse tree walk
  pack-objects: add --sparse option
  revision: implement sparse algorithm
  pack-objects: create pack.useSparse setting
  pack-objects: create GIT_TEST_PACK_SPARSE

 Documentation/config/pack.txt      |   9 ++
 Documentation/git-pack-objects.txt |  11 ++-
 bisect.c                           |   2 +-
 builtin/pack-objects.c             |  10 ++-
 builtin/rev-list.c                 |   2 +-
 http-push.c                        |   2 +-
 list-objects.c                     |  55 +++++++++++-
 list-objects.h                     |   4 +-
 revision.c                         | 121 +++++++++++++++++++++++++
 revision.h                         |   2 +
 t/README                           |   4 +
 t/t5322-pack-objects-sparse.sh     | 139 +++++++++++++++++++++++++++++
 12 files changed, 351 insertions(+), 10 deletions(-)
 create mode 100755 t/t5322-pack-objects-sparse.sh


base-commit: a1598010f775d82b5adf12c29d0f5bc9b41434c6
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-89%2Fderrickstolee%2Fpush%2Fsparse-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-89/derrickstolee/push/sparse-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/89

Range-diff vs v2:

 1:  60617681f7 = 1:  60617681f7 revision: add mark_tree_uninteresting_sparse
 2:  4527addacb = 2:  4527addacb list-objects: consume sparse tree walk
 3:  9644f6ff04 ! 3:  4ef318bdb2 pack-objects: add --sparse option
     @@ -32,7 +32,9 @@
       
      +--sparse::
      +	Use the "sparse" algorithm to determine which objects to include in
     -+	the pack. This can have significant performance benefits when computing
     ++	the pack, when combined with the "--revs" option. This algorithm
     ++	only walks trees that appear in paths that introduce new objects.
     ++	This can have significant performance benefits when computing
      +	a pack to send a small change. However, it is possible that extra
      +	objects are added to the pack-file if the included commits contain
      +	certain types of direct renames.
 4:  c99957d06f = 4:  571b2e2784 revision: implement sparse algorithm
 5:  d6912188be ! 5:  33d2c04dd6 pack-objects: create pack.useSparse setting
     @@ -19,6 +19,26 @@
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     +diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
     +--- a/Documentation/config/pack.txt
     ++++ b/Documentation/config/pack.txt
     +@@
     + 	true. You should not generally need to turn this off unless
     + 	you are debugging pack bitmaps.
     + 
     ++pack.useSparse::
     ++	When true, git will default to using the '--sparse' option in
     ++	'git pack-objects' when the '--revs' option is present. This
     ++	algorithm only walks trees that appear in paths that introduce new
     ++	objects. This can have significant performance benefits when
     ++	computing a pack to send a small change. However, it is possible
     ++	that extra objects are added to the pack-file if the included
     ++	commits contain certain types of direct renames.
     ++
     + pack.writeBitmaps (deprecated)::
     + 	This is a deprecated synonym for `repack.writeBitmaps`.
     + 
     +
      diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
      --- a/builtin/pack-objects.c
      +++ b/builtin/pack-objects.c
 6:  3d394a9136 = 6:  e4f29543ee pack-objects: create GIT_TEST_PACK_SPARSE

-- 
gitgitgadget
