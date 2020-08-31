Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87FCC433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938B8206F0
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svtTenRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgHaKvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgHaKvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:51:12 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E5AC061573
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a65so4914654wme.5
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYCg6T21pjqt0S9i+hALOKBBH0xkhz3wWWjm395koS0=;
        b=svtTenRgsKjFrmnZo5Fkh1wYUxAe0DVWPEUgiifZlCyPg67sD08oxldxtAvJZibvtm
         89yHfmvJPsH+5s0x2qPGjJg4cQhFDKGKr7fn57ixclAdwfSxFk4p6M/s607VQTavpMQk
         o5vNz32AMD1fcEXliBC6hY2MWJgCJh5fglkZP/Q1hdq3kOpQv9GgtHr7UqAp9Eocxhp4
         BpwgPHkI2Av3RTsOI/xJ2zcD9ANFjmBIwk4V/oBARVCarv8PZWqJcf3pDPJG60Hueahn
         Xlyi32vU7BnmlI7qK26o6mUFhLAipOr5ZNJN7f26cKohhI9bnyJdmZTMbPsICq708ydn
         xd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYCg6T21pjqt0S9i+hALOKBBH0xkhz3wWWjm395koS0=;
        b=GLnFZ+vJOxAbmZcRn9YRqEYAmsO+3fQp+/jNWpBNOWUZwdYg3meKG78uqqmFXap5Vz
         nEVTp8fKyEV3vuawyEPqADAunHdksv5OuV7N4TXXD/6IK2Eg5BVHbeF/XLWHR/UqW85n
         Vkm4MOOzX4e3EazSMn4Z4oyz8GNf3PHFAEwyr2LVEvdtlpevDfOMLO3536hiUGheTcTi
         XO5m7p/N19TERRRHcy7csdTxbda96wHbL5uMAwx6dgKSz6d2i9Eg8Ue43/ats6lWbQO1
         Fs/JDgiQlFff07KAKmDJpKrK7fVFkjrU+csO4ptC0gFFe963K4O9+pfqmxl35F4OLrQK
         TNRw==
X-Gm-Message-State: AOAM53235vZJMS5NtXgtrAc6pNKH/pLsw0d4qGa2R54qQprQ+HekdtNB
        VubaDCbzYtpQ5nl9+0P9noQArNs6luE=
X-Google-Smtp-Source: ABdhPJxhKhiz5dS6inIWFOqTjgjcz/D3t4rAeKAM42d2vydWImphzd7762OqX6Isypkky1j7YWe1tg==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr771168wmi.163.1598871068226;
        Mon, 31 Aug 2020 03:51:08 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id k84sm7674454wmf.6.2020.08.31.03.51.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:51:07 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 00/13] Finish converting git bisect to C part 2
Date:   Mon, 31 Aug 2020 12:50:30 +0200
Message-Id: <20200831105043.97665-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a second part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v7.

I would like to thank Junio Hamano for reviewing this patch series.

General changes
---------------

* Rebased on e9b77c84a0 (Tenth batch, 2020-08-24), to build on the
  strvec API (instead of argv_array) and adjust to the codebase
  after the "--first-parent" feature was added.


Specific changes
----------------

[1/13] bisect--helper: BUG() in cmd_*() on invalid subcommand

* Amend commit message.
* Remove casting to int.

---

[2/13] bisect--helper: use '-res' in 'cmd_bisect__helper' return

* Amend commit message.

---

[3/13] bisect--helper: introduce new `write_in_file()` function

* Use saved_errno variable.

---

[5/13] bisect--helper: reimplement `bisect_autostart` shell function in C

* Fix bug using empty_strvec instead of NULL in a `bisect_start()` call.

---


[6/13] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
 functions in C
 
* Remove unused `no-checkout` variable.
* Move a comment to more appropriate place.
 
---

.iriam Rubio (4):
  bisect--helper: BUG() in cmd_*() on invalid subcommand
  bisect--helper: use '-res' in 'cmd_bisect__helper' return
  bisect--helper: introduce new `write_in_file()` function
  bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'

Pranit Bauva (9):
  bisect--helper: reimplement `bisect_autostart` shell function in C
  bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
    functions in C
  bisect--helper: finish porting `bisect_start()` to C
  bisect--helper: retire `--bisect-clean-state` subcommand
  bisect--helper: retire `--next-all` subcommand
  bisect--helper: reimplement `bisect_state` & `bisect_head` shell
    functions in C
  bisect--helper: retire `--check-expected-revs` subcommand
  bisect--helper: retire `--write-terms` subcommand
  bisect--helper: retire `--bisect-autostart` subcommand

 bisect.c                 |  13 +-
 builtin/bisect--helper.c | 442 ++++++++++++++++++++++++++++++++-------
 git-bisect.sh            | 145 +------------
 3 files changed, 380 insertions(+), 220 deletions(-)

-- 
2.25.0

