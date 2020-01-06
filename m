Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C4C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 16:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3F2207FD
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 16:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF3Irh4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgAFQEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:04:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43983 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgAFQEM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 11:04:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so50192094wre.10
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 08:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=E4qJQzS4YO2A75RyIVtZVXTQrvmO7o3kA3AuqNlTFUM=;
        b=TF3Irh4nmuRcc8SXNtgWmq2x5cD6BakDtYbwaqxG58ExdVKJarh0VbvsSAc4LS9xmx
         K2uWdynvbViqNGG4Rmc6qOnIS/m1C0Z/9l+icnmQSqJjcaX0LONV9tlNhRRwbiPxfaIf
         s6BtNQmYEcfsC5qGV4fryIZFrDL8g6mUlVGj9aC4AIQ0u0ISkkdIGucvYtczjh7PQLKi
         TdELU5rDGjVUbtWCEBd0ZXvjQNHC3HyTqFFW4nxstEgXJsvP+oQn/dEiwrhadyDW2toz
         jVFyfbv3dpuYNWxN0/Z6bHeXlSUcgWp435httxe20Oazs6WH7HrKEPi1gsploSC0tjUe
         V4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E4qJQzS4YO2A75RyIVtZVXTQrvmO7o3kA3AuqNlTFUM=;
        b=sRHibh0rzHTAMWWuvpt6qAVu6nIFJnQoTDxncKbFqBWEcBA0LFd9lMe3ocAwbNV9nP
         WIw9dKAW9/u0arWgFH3G/9bLBsNs9Ma2NYHdL9jTbA83BAQ/1uwWeJTSV795vpqj3uEW
         6QZVxHoIVbnldFizVMZ0o+eaRydxxOG/E/xbMszocIn7hFinEjcJMxka4D3EaffYuUGh
         Yc8am/3KGYfejz3iO7Re9ZwV0hmeHlYSaysQcgmsUljM2k1xUTKEZ/Adbg9AUi4flX7f
         B1PVpYPEAjlUak8zUFcNOqeyckJ+1ZT/uFJKOk1iOZPFWE4F7V1sly1r3vqCgRH5R8K7
         k6Ew==
X-Gm-Message-State: APjAAAX57kzSAUzecoPZN/kIPXGbd/6eXHLd208GbUXCH5bWm1aZxOq5
        m/3s9Rx7jv3bVSo4XhRQqorKT82C
X-Google-Smtp-Source: APXvYqzyehHXfcLAGL2dWg3lkuGp2ilOZhFOMTld9dl555tWrt9JmvD0BQUCTsZ75iZEQgSyaxWX+w==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr100715616wrv.144.1578326650269;
        Mon, 06 Jan 2020 08:04:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm72314109wrr.95.2020.01.06.08.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 08:04:09 -0800 (PST)
Message-Id: <pull.511.git.1578326648.gitgitgadget@gmail.com>
From:   "Michael Rappazzo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jan 2020 16:04:07 +0000
Subject: [PATCH 0/1] sequencer: comment out the 'squash!' line
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When performing a squash commit, the commit comments are combined into a
single commit. Since the subject line of the squash commit is used to
identify the squash-to target commit, it cannot offer any useful
contribution to the new commit message. Therefore, the squash commit subject
line it commented out from the combined message (much like a fixup commit's
full comment).

The body of a squash commit may contain additional content to add to the
commit message, so this part of the squash commit message is retained.

Since this change what the expected post-rebase commit comment would look
like, related test expectations are adjusted to reflect the the new
expectation. A new test is added for the new expectation.

Signed-off-by: Michael Rappazzo rappazzo@gmail.com [rappazzo@gmail.com]

Michael Rappazzo (1):
  sequencer: comment out the 'squash!' line

 sequencer.c                   |  1 +
 t/t3404-rebase-interactive.sh |  4 +---
 t/t3415-rebase-autosquash.sh  | 36 +++++++++++++++++++++++++++--------
 t/t3900-i18n-commit.sh        |  4 ----
 4 files changed, 30 insertions(+), 15 deletions(-)


base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-511%2Frappazzo%2Fcomment-squash-subject-line-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-511/rappazzo/comment-squash-subject-line-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/511
-- 
gitgitgadget
