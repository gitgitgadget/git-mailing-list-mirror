Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC54C433FE
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 21:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiKMV2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 16:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiKMV2o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 16:28:44 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE769D2F6
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 13:28:43 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z26so9386983pff.1
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 13:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n56CqfXJWABYylceOpl3fl7ngOCrz93TmIPu2JhQx1s=;
        b=RhFqb8UD6TykWwp0wTGX5gbZzRowaJzUM/UhE4ZyAUzBqMwF66s4pfMRlRzTKFQNQN
         JcnGmG73Ym5s4N3nmJQHopgXLPgRF5OmBytiaGQbfgCXFwfxtih02YiulvUHBHLYXxHz
         xDVt1YDN40O+WC11tbiA5JkJLNxvm7B73hlw75kykIjBpPdQRMI6p34WAMgOGp3jSgaT
         72zCCHpETZI6NiWBOLCDkDYKHpCVKafz/9Kr6nNiP4HiFoXCkuFLzjisCcZ4eFxFnUEu
         Cgb9cZBzKP8ys+mhu2np4KQ5d4wKshL0o+U03M4DPCuGFiiOlVdb6MB7zck5DwPjemam
         BKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n56CqfXJWABYylceOpl3fl7ngOCrz93TmIPu2JhQx1s=;
        b=4Vt9x3KTisgA2swhrmiLKM/roSR7XPGCHE57hPcqrt6ZH3mqdDuVn24LbbEakQXXPd
         GHhhQwqnvUJvgVHn9Fh1KfdslKH+SiE6BmnldXVlhRu0R5kqqDu3hpRQ54qkH5N0+jji
         kg47ntqYKpvgIXf0nN9rxjiVen0HqTonEXHrbKorreLQ/Elc+uZyC+4c7cAmFSr2lFkH
         698Z8rkCc+Mt0WdTu4HO1o3l+kAbjopgt4kr6lu268M8f0UD+wpzL9nLpdubgGxZm+V6
         d6C02AhVRzS2uiDyV9cBKb2leMjIIfHwLNdLvrHKDcAaRa5G4FE5DqA4ITRlzr2aoCaT
         6maw==
X-Gm-Message-State: ANoB5pk2QAjJmR11Ct5B9WL3ZjYPXAK6eRH43JypkxxaZDsdyPb6nE3w
        lTot6ng6dZ/sMQDzn0pOQZhzxL9CNEywYnv1
X-Google-Smtp-Source: AA0mqf7bkBxo2n1U0PuvSUDzh8Ekrl+amVZN4oksBA9/Dm/Jw5epDgCT/sVocRDYzvcPJPWQvDV8hg==
X-Received: by 2002:a62:a50a:0:b0:56b:b112:4a16 with SMTP id v10-20020a62a50a000000b0056bb1124a16mr11501435pfm.66.1668374922664;
        Sun, 13 Nov 2022 13:28:42 -0800 (PST)
Received: from HB2.. ([2409:4043:4c81:51c0:8e7b:5efe:71ba:3c2f])
        by smtp.gmail.com with ESMTPSA id 79-20020a621552000000b0056c704abca7sm5116337pfv.220.2022.11.13.13.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 13:28:42 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v4 0/3] Add mailmap mechanism in cat-file options
Date:   Mon, 14 Nov 2022 02:58:27 +0530
Message-Id: <20221113212830.92609-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.1.423.g41b4650b24
In-Reply-To: <20220916205946.178925-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot Junio, Taylor and Christian for the review :) I have made
the suggested changes.

= Description

At present, `git-cat-file` command with `--batch-check` and `-s` options
does not complain when `--use-mailmap` option is given. The latter
option is just ignored. Instead, for commit/tag objects, the command
should compute the size of the object after replacing the idents and
report it. So, this patch series makes `-s` and `--batch-check` options
of `git-cat-file` honor mailmap when used with `--use-mailmap` option.

In this patch series we didn't want to change that '%(objectsize)'
always shows the size of the original object even when `--use-mailmap`
is set because first we have the long term plan to unify how the formats
for `git cat-file` and other commands works. And second existing formats
like the "pretty formats" used bt `git log` have different options for
fields respecting mailmap or not respecting it (%an is for author name
while %aN for author name respecting mailmap).

I would like to thank my mentors, Christian Couder and John Cai, for all
of their help!
Looking forward to the reviews!

= Patch Organization

- The first patch makes `-s` option to return updated size of the
  <commit/tag> object, when combined with `--use-mailmap` option, after
  replacing the idents using the mailmap mechanism.
- The second patch makes `--batch-check` option to return updated size of
  the <commit/tag> object, when combined with `--use-mailmap` option,
  after replacing the idents using the mailmap mechanism.
- The third patch improves the documentation of `-s`, `--batch`,
  `--batch-check` and `--batch-command` options by adding they can be
  combined with `--use-mailmap` options.

= Changes in v4

- Improve the documentation patch to clearly state that the `-s`,
  `--batch-check`, `--batch-command` and `--batch` options can be only
  be used with `--textconv`, `--filters` or `--use-mailmap`.

Siddharth Asthana (3):
  cat-file: add mailmap support to -s option
  cat-file: add mailmap support to --batch-check option
  doc/cat-file: allow --use-mailmap for --batch options

 Documentation/git-cat-file.txt | 53 ++++++++++++++++++++++--------
 builtin/cat-file.c             | 27 ++++++++++++++++
 t/t4203-mailmap.sh             | 59 ++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 14 deletions(-)

Range-diff against v3:
1:  38bb89d350 ! 1:  4ae3af37d2 cat-file: add mailmap support to -s option
    @@ Commit message
     
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: John Cai <johncai86@gmail.com>
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
    - ## Documentation/git-cat-file.txt ##
    -@@ Documentation/git-cat-file.txt: OPTIONS
    - 
    - -s::
    - 	Instead of the content, show the object size identified by
    --	`<object>`.
    -+	`<object>`. If used with `--use-mailmap` option, will show the
    -+	size of updated object after replacing idents using the mailmap
    -+	mechanism.
    - 
    - -e::
    - 	Exit with zero status if `<object>` exists and is a valid
    -
      ## builtin/cat-file.c ##
     @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
      
2:  4d49cfde73 ! 2:  a692646228 cat-file: add mailmap support to --batch-check option
    @@ Commit message
     
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: John Cai <johncai86@gmail.com>
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
    - ## Documentation/git-cat-file.txt ##
    -@@ Documentation/git-cat-file.txt: OPTIONS
    - 	except `--textconv` or `--filters`, in which case the input lines
    - 	also need to specify the path, separated by whitespace.  See the
    - 	section `BATCH OUTPUT` below for details.
    -+	If used with `--use-mailmap` option, will show the size of
    -+	updated object after replacing idents using the mailmap mechanism.
    - 
    - --batch-check::
    - --batch-check=<format>::
    -
      ## builtin/cat-file.c ##
     @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
      	if (!data->skip_object_info) {
-:  ---------- > 3:  41b4650b24 doc/cat-file: allow --use-mailmap for --batch options
-- 
2.38.1.420.g319605f8f0

