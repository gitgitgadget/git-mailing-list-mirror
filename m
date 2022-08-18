Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D10C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 06:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243564AbiHRGRy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 02:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243263AbiHRGRw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 02:17:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF8E96FDA
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 23:17:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so415217wms.0
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 23:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=kMO06dB3kmc0/SshrP7wgoi8kN78OozTSP+/oS2xZMk=;
        b=b01xX3/atS+Wyi5CBPTSPAh3GcKU39sX3CArzDyHHhK/zUkvZr3UY6VBASUaUwGjKC
         tPY9Y+1i7xRVZuHlEG9T7q8dBOkepWqtSprj8tTBVkSfur0mLQKPWAnOPmVZrxER9u7D
         dxSkjMyrvRSlGfccYNUgwyq3mVfBPIbkGAx8czM+7EuKpANYePJ/eMYIteVdodd6aCNz
         J/qheGoEmHYad9vWCDamTDUUyCG0ntbPqmnbN3yJMejviKGAQJup9ryoeblcz8VFfqT6
         F2NiKvMwEO4sti1paMLxmA8AbNnmxC++K02X3kohsLCzdzO23ryw7f6A3wHt1LSp3IDU
         TEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=kMO06dB3kmc0/SshrP7wgoi8kN78OozTSP+/oS2xZMk=;
        b=72/ZnNLroco5yXOcKQdRC/CVMunIzqSD1locJ/+x3em+lUp1WRvK/mT76XwJntCGgv
         jEriC0KDVcc/ZA/xQhOhCRXQ5njcdTa1mWjoYUoQuH4biZuBlJjK2i5DlIFPHQFgYXoj
         6YkV4yereiyUasMHHFFhlX1BR54EOi5+b6jIotUkMZhuptT2uIj7LbYzaPfsQN1eZ6g1
         Hshl5vLstkzo3kD6uKXKN+7dloCyuXjmqKksVKaGkWEkJ8gjXynbLlPj3zrZP55YqHVw
         Rp51L+OwjSIaaUeJphgb8vPAZcCUZ/7jvuKUOkA7Qx7m8+Zup32SpaCQ5fcKjxMU7IC8
         IFGg==
X-Gm-Message-State: ACgBeo06g5yMCL3qKW9c5dbZjHhRCQLTBOZP/PWMA8yYiCshIyAQBDXs
        krhTdmh6E54SpvgpimQh7l0tn9imqGY=
X-Google-Smtp-Source: AA6agR56z95WBKxvjb2Zyswt6h73F8Urx4i03kjt+qcJYX4jrpjJI8Ha2L0VReo8+fgmbre4is/iRg==
X-Received: by 2002:a1c:7907:0:b0:3a5:a965:95e6 with SMTP id l7-20020a1c7907000000b003a5a96595e6mr4056581wme.75.1660803468957;
        Wed, 17 Aug 2022 23:17:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b003a5fa79007fsm996753wmq.7.2022.08.17.23.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 23:17:48 -0700 (PDT)
Message-Id: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
In-Reply-To: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 06:17:45 +0000
Subject: [PATCH v2 0/2] Allow --ancestry-path to take an argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

 * Tweaked the commit message, and incorporated Junio's suggestion to update
   left_flag and ancestry_flag together.

Series description:

This came out of a previous thread[1], where I wanted to be able to run
something like

git log --oneline --ancestry-path=ab/submodule-cleanup main..seen


and see the commits in main..seen which contained ab/submodule-cleanup in
their ancestry path. Let me start by defining the terminology "X is in a
commit's ancestry path". By that, I just mean that either the commit is X,
the commit is an ancestor of X, or the commit is a descendant of X. With
that definition...

The command

git log --ancestry-path A..B


means find the commits in A..B which contain A in their ancestry path. I
sometimes still want to use A..B to get the basic range, but would like to
use a commit other than A for specifying which ancestry path is of interest.
So, for example, I might want to use

git log --ancestry-path=C A..B


to mean find the commits in A..B which contain C in their ancestry path, or
use

git log --ancestry-path=C --ancestry-path=D A..B


to mean find the commits in A..B which contain either C or D in their
ancestry path.

This series implements this request, by allowing --ancestry-path to take an
optional argument. With it, I can find the answer to my question in the
thread at [1] within the git.git repository (replacing branch names with
actual hashes since the branches have since moved on):

$ git log --oneline --ancestry-path=5b893f7d81 8168d5e9c2..ac0248bfba | wc -l
36


This returns the answer I want, whereas dropping the '=5b893f7d81' from the
command line gives me 192 unwanted commits (228 total), and various other
command line flags (--first-parent, --boundary, etc.) also fail to give me
the set of commits I am looking for.

[1]
https://lore.kernel.org/git/CABPp-BF+8aqysioP_e27Q9kJ02rE2SuSqXu+XphzKWnk5a_Q+A@mail.gmail.com/

Elijah Newren (2):
  rev-list-options.txt: fix simple typo
  revision: allow --ancestry-path to take an argument

 Documentation/rev-list-options.txt | 47 +++++++++++++----
 object.h                           |  2 +-
 revision.c                         | 84 +++++++++++++++++++-----------
 revision.h                         |  3 ++
 t/t6019-rev-list-ancestry-path.sh  | 47 ++++++++++++++++-
 5 files changed, 139 insertions(+), 44 deletions(-)


base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1303%2Fnewren%2Fancestry-path-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1303/newren/ancestry-path-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1303

Range-diff vs v1:

 1:  68ab719d99c = 1:  68ab719d99c rev-list-options.txt: fix simple typo
 2:  99287b67fd1 ! 2:  f580ec6d060 revision: allow --ancestry-path to take an argument
     @@ Commit message
          revision: allow --ancestry-path to take an argument
      
          We have long allowed users to run e.g.
     -        git log --ancestry-path next..seen
     +        git log --ancestry-path master..seen
          which shows all commits which satisfy all three of these criteria:
            * are an ancestor of seen
     -      * are not an ancestor next
     -      * have next as an ancestor
     +      * are not an ancestor master
     +      * have master as an ancestor
      
          This commit allows another variant:
     -        git log --ancestry-path=$TOPIC next..seen
     +        git log --ancestry-path=$TOPIC master..seen
          which shows all commits which satisfy all of these criteria:
            * are an ancestor of seen
     -      * are not an ancestor of next
     +      * are not an ancestor of master
            * have $TOPIC in their ancestry-path
          that last bullet can be defined as commits meeting any of these
          criteria:
     @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *com
       {
       	struct commit_list *parent = commit->parents;
      -	unsigned left_flag;
     -+	unsigned left_flag, ancestry_flag;
     ++	unsigned pass_flags;
       
       	if (commit->object.flags & ADDED)
       		return 0;
      @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *commit,
     + 	if (revs->no_walk)
       		return 0;
       
     - 	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
     -+	ancestry_flag = (commit->object.flags & ANCESTRY_PATH);
     +-	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
     ++	pass_flags = (commit->object.flags & (SYMMETRIC_LEFT | ANCESTRY_PATH));
       
       	for (parent = commit->parents; parent; parent = parent->next) {
       		struct commit *p = parent->item;
     @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *com
       			if (!*slot)
       				*slot = *revision_sources_at(revs->sources, commit);
       		}
     -+		if (revs->ancestry_path)
     -+			p->object.flags |= ancestry_flag;
     - 		p->object.flags |= left_flag;
     +-		p->object.flags |= left_flag;
     ++		p->object.flags |= pass_flags;
       		if (!(p->object.flags & SEEN)) {
       			p->object.flags |= (SEEN | NOT_USER_GIVEN);
     + 			if (list)
      @@ revision.c: static int still_interesting(struct commit_list *src, timestamp_t date, int slop
       }
       

-- 
gitgitgadget
