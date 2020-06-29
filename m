Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23952C433DF
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EAA215A4
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmFxvWxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbgF2VWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbgF2Swl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAFCC00F81C
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 05:32:55 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d16so6031058edz.12
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=W41lIYgo7SQSqDP7WDRrshQ3+iMxhyiAVRsZJgsYJTk=;
        b=rmFxvWxDU03gb9meJeriUXe7Stl/z70s9kL4U0IOcQndIOlR4UTk0+xTEUuXK4o0Yi
         IqDBYDU/QSfrlesgwzPvWqddbumgaVx1Rf8DVwsHgIu3eRFUALDqw4oTtlbpp8KALCzB
         zrMJG3TNeV+fSgzza4Gege8kUnGT/Lwj2H4/gavZ91opI5WRTheZdJvj6JQeD12P1w7O
         8B1ozp2iNyEdUVBRKFEnIR/aCxmS2kqhDTbBECN9D0OqLyO5EOokoh8l/0ZkxDrMmBUz
         3IMOpa6TxZCKNitQU6LG0A/MOrEX3za4bsS4soFWkZvT/E/9ytXCK2MZa3adOg5mZ/Da
         LgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=W41lIYgo7SQSqDP7WDRrshQ3+iMxhyiAVRsZJgsYJTk=;
        b=MXPZrkcTzlxvjx5FUSV35FzaLCl/GFUEN1i64IF7d3rfpDShlfg0qmdQU8QobqQ7MK
         1Um656rXjRUevBngS6w9ofmpheTdfphdPFfnBSzgpjVWdFl3oVdOVI1w5zGvPyKGn0X7
         JZI6jRcIS+PWdTsabU4/JQIFsmJ+I5388mkpebGNrtPqhOWVUKVwKJl6vyYtzUfJYFDE
         oApZNtVr49IqiQ7PJfF57wBti84ED6T2zj44FleQBa+gdPnszfIWiWMPbY7mKvliOtTw
         xI9hYI5IvKK+z1OSj9RK6RFaWeYZHq4BMXv/+7v+hWptgA5aqof3SAplqUcp4XFcIpPX
         zvxQ==
X-Gm-Message-State: AOAM533reCAZz3eEjrrG58vmNSHwsz7GLjlgFYLGiQGZRzuypBhwI2QA
        pcyYSlRjCvqmyz85hrHqwdTHkS0mx+TMLGhhug1Ft/BF/3U=
X-Google-Smtp-Source: ABdhPJyq4B8BDJD1LgZ+pyrMyQmBm/MKCJOBfe3/7INc6cxwpM5b9mQ5VCi5Bop7kPR0E0Z6c5BkIczpthlQSjPpOFg=
X-Received: by 2002:a05:6402:1217:: with SMTP id c23mr17334258edw.270.1593433974603;
 Mon, 29 Jun 2020 05:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.781.v2.git.git.1591672753363.gitgitgadget@gmail.com> <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com>
From:   Git Gadget <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 14:32:43 +0200
Message-ID: <CANg4QoHZS0o5k_qb8BEW0yGUc8xQXSKPVA4-BHBcQkOEzO=D6Q@mail.gmail.com>
Subject: Fwd: [PATCH v3] Enable auto-merge for meld to follow the vim-diff beharior
To:     git@vger.kernel.org, "lin.sun" <lin.sun@zoom.us>,
        sunlin <sunlin7@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-sending, as this mail seems to have been dropped by vger.

---------- Forwarded message ---------
From: sunlin via GitGitGadget <gitgitgadget@gmail.com>
Date: Mon, Jun 29, 2020 at 9:07 AM
Subject: [PATCH v3] Enable auto-merge for meld to follow the vim-diff beharior
To: <git@vger.kernel.org>
Cc: sunlin <sunlin7@yahoo.com>, lin.sun <lin.sun@zoom.us>


From: "lin.sun" <lin.sun@zoom.us>

The mergetool "meld" does NOT merge the no-conflict changes, while the
mergetool "vimdiff" will merge the no-conflict parts and highlight the
conflict parts.
This patch will make the mergetool "meld" similar to "vimdiff",
auto-merge the no-conflict parts, highlight conflict parts.

Signed-off-by: Lin Sun <lin.sun@zoom.us>
---
    Enable auto-merge for meld to follow the vimdiff beharior

    Hi, the mergetool "meld" does NOT merge the no-conflict changes, while
    the mergetool "vimdiff" will merge the no-conflict changes and highlight
    the conflict parts. This patch will make the mergetool "meld" similar to
    "vimdiff", auto-merge the no-conflict changes, highlight conflict parts.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
pr-git-781/sunlin7/master-v3
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v2:

 1:  6e98a10bfa ! 1:  3b70fd0bfc Enable auto-merge for meld to follow
the vim-diff beharior
     @@ Commit message

       ## mergetools/meld ##
      @@ mergetools/meld: merge_cmd () {
     +  then
     +          check_meld_for_output_version
     +  fi
     ++ if test -z "${meld_has_auto_merge_option:+set}"
     ++ then
     ++         check_meld_for_auto_merge_version
     ++ fi
     ++
     ++ option_auto_merge=
     ++ if test "$meld_has_auto_merge_option" = true
     ++ then
     ++         option_auto_merge="--auto-merge"
     ++ fi

        if test "$meld_has_output_option" = true
        then
      -         "$merge_tool_path" --output="$MERGED" \
     -+         "$merge_tool_path" --auto-merge --output="$MERGED" \
     ++         "$merge_tool_path" $option_auto_merge --output="$MERGED" \
                        "$LOCAL" "$BASE" "$REMOTE"
        else
      -         "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
     -+         "$merge_tool_path" --auto-merge "$LOCAL" "$MERGED" "$REMOTE"
     ++         "$merge_tool_path" $option_auto_merge "$LOCAL"
"$MERGED" "$REMOTE"
        fi
       }

     +@@ mergetools/meld: check_meld_for_output_version () {
     +          meld_has_output_option=false
     +  fi
     + }
     ++
     ++# Check whether we should use 'meld --auto-merge ...'
     ++check_meld_for_auto_merge_version () {
     ++ meld_path="$(git config mergetool.meld.path)"
     ++ meld_path="${meld_path:-meld}"
     ++
     ++ if meld_has_auto_merge_option=$(git config --bool
mergetool.meld.hasAutoMerge)
     ++ then
     ++         : use configured value
     ++ elif "$meld_path" --help 2>&1 |
     ++         grep -e '--auto-merge' -e '\[OPTION\.\.\.\]' >/dev/null
     ++ then
     ++         : old ones mention --auto-merge and new ones just say OPTION...
     ++         meld_has_auto_merge_option=true
     ++ else
     ++         meld_has_auto_merge_option=false
     ++ fi
     ++}


 mergetools/meld | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/mergetools/meld b/mergetools/meld
index 7a08470f88..91b65ff22c 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -7,13 +7,23 @@ merge_cmd () {
        then
                check_meld_for_output_version
        fi
+       if test -z "${meld_has_auto_merge_option:+set}"
+       then
+               check_meld_for_auto_merge_version
+       fi
+
+       option_auto_merge=
+       if test "$meld_has_auto_merge_option" = true
+       then
+               option_auto_merge="--auto-merge"
+       fi

        if test "$meld_has_output_option" = true
        then
-               "$merge_tool_path" --output="$MERGED" \
+               "$merge_tool_path" $option_auto_merge --output="$MERGED" \
                        "$LOCAL" "$BASE" "$REMOTE"
        else
-               "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+               "$merge_tool_path" $option_auto_merge "$LOCAL"
"$MERGED" "$REMOTE"
        fi
 }

@@ -34,3 +44,21 @@ check_meld_for_output_version () {
                meld_has_output_option=false
        fi
 }
+
+# Check whether we should use 'meld --auto-merge ...'
+check_meld_for_auto_merge_version () {
+       meld_path="$(git config mergetool.meld.path)"
+       meld_path="${meld_path:-meld}"
+
+       if meld_has_auto_merge_option=$(git config --bool
mergetool.meld.hasAutoMerge)
+       then
+               : use configured value
+       elif "$meld_path" --help 2>&1 |
+               grep -e '--auto-merge' -e '\[OPTION\.\.\.\]' >/dev/null
+       then
+               : old ones mention --auto-merge and new ones just say OPTION...
+               meld_has_auto_merge_option=true
+       else
+               meld_has_auto_merge_option=false
+       fi
+}

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
--
gitgitgadget
