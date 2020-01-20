Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA54FC2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B825B21835
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uxkMGEUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgATRd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:33:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43040 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgATRd4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Jan 2020 12:33:56 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EDDEF6044F;
        Mon, 20 Jan 2020 17:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579541635;
        bh=ncijF2fdsjAzBlw2SgJWdc8wvmTWXLB9YwULRTqlQS0=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uxkMGEUCO2SjkDWR8TxwrEHUVVGqaKVhmGxxrR6r1ZgXfJNn1u5KbSq/VqHtqKB3x
         yXHD4SjJSyVXxKd9ial80JAp9tIwTnmiHEaByxs5b+06dlKdd1hQeVp7a5XuhzhYpM
         TARZOfIXtNYn6CiN00EDlhBAL7L2A7NQeCLJOSpDoPQwNcrRfSoyrAjhErLUdkdkYM
         IFA5ewR9xb/w6NeirUFVHObh1obySpeWFr/Cje5BZgCjO3bMzrvc7OW6/bfSV7yNlk
         9sCWO3nRYm/N1qvcvWCuQirLC4/Ae5Lkfng2k2heBvlqDkUZfSxZgenjeqeazmjKqN
         79a/iGmIw7DyYtJ84oqm7ztHUpE7ZNOu+ohF8RdmWzCnJL+g+PfjBXMw3rmDE73Nl9
         rHQmnlQvPB4/IL/5XIlAu3djXwO71ph01YYN1GNYvZS07ZXhekKMxGeuk6HhGZaWCK
         vZ8SuKHRT4O+MNrXbWVIyhYqSLI4nLqGjuyPJyOdrKNnD9QGuBO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v4 0/6] Documentation for common user misconceptions
Date:   Mon, 20 Jan 2020 17:33:38 +0000
Message-Id: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v4 of a series improving the documentation to cover common user
misconceptions.

I did opt to keep the big commit information section because I think it
provides value when documenting the ordering of the variables.
Otherwise, it becomes confusing to advanced users which options control
what and in what order.

Changes from v3:
* Restructure docs around git-commit(1).
* Improve wording about templating as suggested by Peff.
* Document ordering between user.*, author.*, and committer.*.
* Document the environment variables more thoroughly.

Changes from v2:
* Move author and committer information to git-commit(1) where people
  will look for it.
* Move guidance on user.name format to git-commit(1) as well and mention
  a shortened form of the advice in the `user.name` description.
* Use a parenthetical to describe a "personal name" without contrasting
  it with a username.
* Offer a potential solution for people who want to ignore tracked
  files by recommending a templating mechanism.
* Be slightly more verbose about why memory is wasted with
  http.postBuffer.

Changes from v1:
* Remove parenthetical which was confusing.
* Add two more patches.

brian m. carlson (5):
  doc: move author and committer information to git-commit(1)
  docs: expand on possible and recommended user config options
  doc: provide guidance on user.name format
  doc: dissuade users from trying to ignore tracked files
  docs: mention when increasing http.postBuffer is valuable

 Documentation/config/http.txt      |  8 ++++++
 Documentation/config/user.txt      |  7 +++++-
 Documentation/git-commit-tree.txt  | 26 ++++---------------
 Documentation/git-commit.txt       | 40 +++++++++++++++++++++++++++---
 Documentation/git-update-index.txt | 16 ++++++++++++
 Documentation/git.txt              | 27 ++++++++++++++++++--
 6 files changed, 97 insertions(+), 27 deletions(-)

