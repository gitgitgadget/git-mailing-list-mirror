Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FF5CCA479
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 00:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiGSAKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 20:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiGSAKV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 20:10:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12002A404
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 17:10:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v16so19275489wrd.13
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CIga4U+HkGdxt6HKZbmGuii/QO/DKpUpR+vO68SRSSk=;
        b=KvyjXMH4FctoewLu8t55OfNDdhQDUEz4dxPTOq6lMu5KUEqGz4WtC1O14BRM2jXaoI
         lCOfXM/vB/I9UPSTlkIkVPXcqtVI+DN5Y0rzbGI1nHanQcYM0dTihD02iXGHnzjgdCQ5
         UCbmsIrN680CABJqwDcWPRz5G9vVqU9vVSm4n7NrgIwqPtvxbDLxiJ0g1x+arUF9SOF3
         oiI1UW/RrM0WyBFLPOOtZK2v8zgdNgWc2iVH4PRguJlxzkJ8v1AIRKHSMYHVpUccvmom
         M/L7Fvnz7cZj9Yd9GUpn40S9Q/sY3+KSO2qmsf7z3mt8dKLkaqCpLPBsR9nBxKiljOO8
         KOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CIga4U+HkGdxt6HKZbmGuii/QO/DKpUpR+vO68SRSSk=;
        b=tz95/hl/qdUSAPL9CkO9SEux6DVTu1p3KAFA9afSxgwEBiwnCAOdn0PuOpaBZjZUyd
         nXDLht9RJFdeB6RuUj2Bq33OinOmQS/6wnVeg7XUKhbvNBqsuIXzSVsOtJARl67EzLTH
         kGWP4n3FdBvjk1OkWC0PoCZcr8OLbwW5OadK9uFohFfbrIMsxtwPmX6E6p7AO2fgl07t
         rawuYoDzGwKQIWreeYZ6WzV08nOtuwWH3T8fbUL0MfRrqinh4S3I9jbhEscMAnHJYHXL
         flgWEZB6wFu3tkeRKmmG9771G4hDSc6hFtEKi6pkOBANgIrkLUFVRRzAEtJemrCy7s3t
         LJqw==
X-Gm-Message-State: AJIora98BbGao3dOfGB6+l8dqerMBQkOaux/62gkPCB5O/sfvLtVj4F7
        bielnzPY42FepBBxd53FcnJQL5xfOi8UwQ==
X-Google-Smtp-Source: AGRyM1sUaPhEO+WR7rW8W+iOZbUfbThiS6E5ZylrZzQcW8bGbtKNl3fl3Vj43k7BjrQXtJwE6vPUww==
X-Received: by 2002:adf:d08c:0:b0:21d:768b:c56a with SMTP id y12-20020adfd08c000000b0021d768bc56amr24991873wrh.318.1658189417770;
        Mon, 18 Jul 2022 17:10:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d16-20020a05600c049000b0039c96b97359sm16255433wme.37.2022.07.18.17.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 17:10:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] docs: remove pre-v1.6.0 "repack --delta-base-offset" docs
Date:   Tue, 19 Jul 2022 02:09:42 +0200
Message-Id: <patch-v2-1.1-98b6de56019-20220719T000847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1032.gb00b5447790
In-Reply-To: <patch-1.1-363f84a3fa7-20220715T075114Z-avarab@gmail.com>
References: <patch-1.1-363f84a3fa7-20220715T075114Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove documentation about --delta-base-offset that's only pertinent
to those running versions of git older than v1.4.4 and v1.6.0. Both of
those versions are too ancient to care about.

For the purposes of evaluating this change it only matters that v1.6.0
is too old at this point for anyone to care about, since the change in
default behavior discussed in the removed documentation impacted
pre-v1.4.4 versions of git.

Details:

A. As the documentation notes the "--delta-base-offset" switch
   introduced in 1.4.4[1] became the default in 1.6.0[2]. The "by
   default" part of the removed documentation discusses a change in what
   had been the status quo in v1.4.4..v1.6.0^.

B. When exactly "--delta-base-offset" was introduced and when it
   became the default (as noted in "A" above) is only of academic
   interest once we decide that anything older than 1.6.0 isn't worth
   caring about.

   The documentation being removed here was added in [3] and [4],
   which were first released with v1.4.4 and v1.7.0, respectively. At
   the time it was of interest to someone running v1.6.0 or later that
   they'd be creating packs incompatible with older git versions.

   But at some point the last user of v1.4.4 in the wild would have
   went away, presumably followed some time afterwards by the last
   v1.4.4..v1.6.0^ user.

   If we were turning back the clock we might have removed the
   "incompatible with" part of this documentation once v1.4.4 became
   irrelevant, but as v1.6.0 was still relevant kept the "by default"
   part.

   But as neither are relevant at this point let's remove this entire
   paragraph[5].

1. be6b19145f6 (make git-pack-objects able to create deltas with
   offset to base, 2006-09-21)
2. 22c79eab295 (repack.usedeltabaseoffset config option now defaults
   to "true", 2008-06-25)
3. b6945f570ac (git-repack: repo.usedeltabaseoffset, 2006-10-13)
4. 9f17688d93c (update git-repack documentation wrt
   repack.UseDeltaBaseOffset, 2010-02-04).
5. In <xmqqsfn21fmt.fsf@gitster.g> [6] Junio suggests that anything
   older than v2.0.0 or v2.16.0 isn't relevant at this point

   I think that's defensible, but as e.g. "gcc110" on the GCC Farm has
   a /usr/bin/git version v1.8.3.1 (which was released in mid-2013)
   that would be a different argument.

   As that case shows there are still OS's with 2013-era software in
   common use (particularly RHEL and its derivatives).

   But I don't think anyone knows about or can plausibly contrive a
   scenario where someone still is still v1.6.0 or older, and might
   therefore benefit from these docs.

   We might want to follow-up with removal of documentation that only
   benefits users of those ancient version, and tell them that they
   should consult their OS-installed documentation, newer git isn't
   going to carry those backwards compatibility notes forward.

   But as long as there are still systems in active use with those
   versions let's leave that to a future follow-up, either because
   it's far enough in the future that those versions are truly dead,
   or because we'd like to drop documentation in that category.
6. https://lore.kernel.org/git/xmqqsfn21fmt.fsf@gitster.g/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Changes in v2:

 * Updated commit message per
   https://lore.kernel.org/git/220718.86tu7eyhvz.gmgdl@evledraar.gmail.com/

---
Range-diff against v1:
1:  363f84a3fa7 ! 1:  98b6de56019 git-repack doc: remove discussion of ancient caveat
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git-repack doc: remove discussion of ancient caveat
    +    docs: remove pre-v1.6.0 "repack --delta-base-offset" docs
     
    -    The backwards compatibility caveat discussed her hasn't been a concern
    -    for anyone after Git v1.6.0. Let's simply remove it, I daresay
    -    nobody's concerned these days with having git clients running older
    -    than 2008-era git.
    +    Remove documentation about --delta-base-offset that's only pertinent
    +    to those running versions of git older than v1.4.4 and v1.6.0. Both of
    +    those versions are too ancient to care about.
     
    -    See b6945f570ac (git-repack: repo.usedeltabaseoffset, 2006-10-13) and
    -    9f17688d93c (update git-repack documentation wrt
    -    repack.UseDeltaBaseOffset, 2010-02-04) for the commits that previously
    -    introduced and adjusted this documentation.
    +    For the purposes of evaluating this change it only matters that v1.6.0
    +    is too old at this point for anyone to care about, since the change in
    +    default behavior discussed in the removed documentation impacted
    +    pre-v1.4.4 versions of git.
    +
    +    Details:
    +
    +    A. As the documentation notes the "--delta-base-offset" switch
    +       introduced in 1.4.4[1] became the default in 1.6.0[2]. The "by
    +       default" part of the removed documentation discusses a change in what
    +       had been the status quo in v1.4.4..v1.6.0^.
    +
    +    B. When exactly "--delta-base-offset" was introduced and when it
    +       became the default (as noted in "A" above) is only of academic
    +       interest once we decide that anything older than 1.6.0 isn't worth
    +       caring about.
    +
    +       The documentation being removed here was added in [3] and [4],
    +       which were first released with v1.4.4 and v1.7.0, respectively. At
    +       the time it was of interest to someone running v1.6.0 or later that
    +       they'd be creating packs incompatible with older git versions.
    +
    +       But at some point the last user of v1.4.4 in the wild would have
    +       went away, presumably followed some time afterwards by the last
    +       v1.4.4..v1.6.0^ user.
    +
    +       If we were turning back the clock we might have removed the
    +       "incompatible with" part of this documentation once v1.4.4 became
    +       irrelevant, but as v1.6.0 was still relevant kept the "by default"
    +       part.
    +
    +       But as neither are relevant at this point let's remove this entire
    +       paragraph[5].
    +
    +    1. be6b19145f6 (make git-pack-objects able to create deltas with
    +       offset to base, 2006-09-21)
    +    2. 22c79eab295 (repack.usedeltabaseoffset config option now defaults
    +       to "true", 2008-06-25)
    +    3. b6945f570ac (git-repack: repo.usedeltabaseoffset, 2006-10-13)
    +    4. 9f17688d93c (update git-repack documentation wrt
    +       repack.UseDeltaBaseOffset, 2010-02-04).
    +    5. In <xmqqsfn21fmt.fsf@gitster.g> [6] Junio suggests that anything
    +       older than v2.0.0 or v2.16.0 isn't relevant at this point
    +
    +       I think that's defensible, but as e.g. "gcc110" on the GCC Farm has
    +       a /usr/bin/git version v1.8.3.1 (which was released in mid-2013)
    +       that would be a different argument.
    +
    +       As that case shows there are still OS's with 2013-era software in
    +       common use (particularly RHEL and its derivatives).
    +
    +       But I don't think anyone knows about or can plausibly contrive a
    +       scenario where someone still is still v1.6.0 or older, and might
    +       therefore benefit from these docs.
    +
    +       We might want to follow-up with removal of documentation that only
    +       benefits users of those ancient version, and tell them that they
    +       should consult their OS-installed documentation, newer git isn't
    +       going to carry those backwards compatibility notes forward.
    +
    +       But as long as there are still systems in active use with those
    +       versions let's leave that to a future follow-up, either because
    +       it's far enough in the future that those versions are truly dead,
    +       or because we'd like to drop documentation in that category.
    +    6. https://lore.kernel.org/git/xmqqsfn21fmt.fsf@gitster.g/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     

 Documentation/git-repack.txt | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0bf13893d81..fe1eac37090 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -218,16 +218,6 @@ CONFIGURATION
 Various configuration variables affect packing, see
 linkgit:git-config[1] (search for "pack" and "delta").
 
-By default, the command passes `--delta-base-offset` option to
-'git pack-objects'; this typically results in slightly smaller packs,
-but the generated packs are incompatible with versions of Git older than
-version 1.4.4. If you need to share your repository with such ancient Git
-versions, either directly or via the dumb http protocol, then you
-need to set the configuration variable `repack.UseDeltaBaseOffset` to
-"false" and repack. Access from old Git versions over the native protocol
-is unaffected by this option as the conversion is performed on the fly
-as needed in that case.
-
 Delta compression is not used on objects larger than the
 `core.bigFileThreshold` configuration variable and on files with the
 attribute `delta` set to false.
-- 
2.37.1.1032.gb00b5447790

