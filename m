Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BD7C33CB6
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 12:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5CD24655
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 12:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZ06441y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgAWM2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:28:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56158 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgAWM2X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 07:28:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so2356034wmj.5
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 04:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DSkNKB4ZqTcLCiTXsnSPN2pzUowvFTfWt4SlCU6qDsk=;
        b=oZ06441yK72apfPG2oxBndgrblJj+mqwOjswIt1wsnh9/5kUGImA/KGze901Tu1smE
         YtXs5MTV/Z8WWK/RBZPQQDFXk8zSs5wf6RRFbRJvypML5kaevh/QLmFE4sk/uY78Jo75
         c29ujuXKt5WXsJ0NqwSOXryvEiViEHg5GEkjjyGJxv1MrirSQONKIODg21LK02kX5CeF
         ZZ9RKDWPrJMccwoP4OjKs2/QBnHyvOxZlTDXkzW/mfmvHD3U0F5J+SGWvVT7iqYJsFoj
         uxSeFN7USC9bTfFXGX6G27lL7zyIgHcgnYVoVUG/ajAvBaqc3lVRrDu6UL88Aaps0LYP
         z+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DSkNKB4ZqTcLCiTXsnSPN2pzUowvFTfWt4SlCU6qDsk=;
        b=ha/8OoLw4iEkC+VDAKii50aqsCyC1I+i0RSOKJpF57GSG7XQLs7evKHVlNtrRUPhsY
         X/LJJEUSkDCtdFv9kieVsdufx7x1eMS2B96T02taICgWUdMPQop+s76VAWnE5LXbcyFP
         94gHMf6U9gx8RKYSLJMT5Rv77Rk9xnpXLsL4Aom0EDXmPB27dlVvPbcU7rbzSZBYsXDz
         AbDvCzgAH+uwSQ4N1e4lG7Fa3fQODZTZb6zqZmHxHQ2lDwYScR4ta3kVgWQLFLY98yO7
         XD/OT48d+lrI2PgYjcx+O8J/Q4mrd4bWgGEkbIlHtXc+vpJVqIfzzMaW6bIIdEatbg7Z
         QA+Q==
X-Gm-Message-State: APjAAAXxA1KUKhY04TK3m3tHfyGICjsBvL3DfJ1IdR/ctzQ5/H/hw7oz
        OlGwsBaiZ2ZiSxTb8LIrjMMj7Res
X-Google-Smtp-Source: APXvYqwEJv1VzQ1+9Gerj94QUo00teN+6qGhTNRWe/gf4w2tfpW+s01wSMWBEcE5kgyT0Da2dGLd+g==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr3795517wmi.149.1579782500979;
        Thu, 23 Jan 2020 04:28:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 60sm2931699wrn.86.2020.01.23.04.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 04:28:20 -0800 (PST)
Message-Id: <pull.529.v3.git.1579782499.gitgitgadget@gmail.com>
In-Reply-To: <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
References: <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jan 2020 12:28:16 +0000
Subject: [PATCH v3 0/3] Re-fix rebase -i with SHA-1 collisions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Triggered by one of brian's SHA-256 patch series, I looked at the reason why
the SHA-1 collision test case passed when it shouldn't. Turns out that the
regression test was not quite thorough enough, and the interactive rebase 
did regress recently.

While in the area, I realized that the same bug exists in the code backing
the rebase.missingCommitsCheck feature: the backed-up todo list uses
shortened commit IDs that may very well become ambiguous during the rebase.
For good measure, this patch series fixes that, too.

Finally, I saw that git rebase --edit-todo reported the line in an awkward,
maybe even incorrect, way when there was an ambiguous commit ID, and I also
fixed that.

To make sure that the code can be easily adapted to SHA-256 after these
patches, I actually already made those adjustments on top and offered them
up at https://github.com/bk2204/git/pull/1.

Changes since v2:

 * Clarified in the first commit message that the change from a positive
   return value to a negative return value (to indicate failure, in both
   cases) both was intentional, and does not require any change in the
   corresponding function's only caller.

Changes since v1:

 * Turned the error condition when parsing the todo list with just-expanded
   commit IDs failed into a BUG().

Johannes Schindelin (3):
  parse_insn_line(): improve error message when parsing failed
  rebase -i: re-fix short SHA-1 collision
  rebase -i: also avoid SHA-1 collisions with missingCommitsCheck

 rebase-interactive.c          |  8 +++++---
 sequencer.c                   | 18 ++++++++++++++----
 t/t3404-rebase-interactive.sh | 17 +++++++++++++++--
 3 files changed, 34 insertions(+), 9 deletions(-)


base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-529%2Fdscho%2Fre-fix-rebase-i-with-sha-collisions-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-529/dscho/re-fix-rebase-i-with-sha-collisions-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/529

Range-diff vs v2:

 1:  2ae2e435b0 ! 1:  6f5c7b0325 parse_insn_line(): improve error message when parsing failed
     @@ -7,6 +7,11 @@
          That makes it rather hard for users to understand what is going wrong,
          so let's fix that.
      
     +    While at it, return a negative value from `parse_insn_line()` in case of
     +    an error, as per our convention. This function's only caller,
     +    `todo_list_parse_insn_buffer()`, cares only whether that return value is
     +    non-zero or not, i.e. does not need to be changed.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/sequencer.c b/sequencer.c
 2:  102fa568dc = 2:  595ba81e09 rebase -i: re-fix short SHA-1 collision
 3:  486e9413a6 = 3:  b7b063408f rebase -i: also avoid SHA-1 collisions with missingCommitsCheck

-- 
gitgitgadget
