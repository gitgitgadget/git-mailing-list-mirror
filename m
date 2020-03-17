Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF2C4CECE
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 13:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4419E205ED
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 13:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCQN3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:29:36 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:48869 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQN3f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 09:29:35 -0400
Received: from localhost.localdomain (unknown [103.227.96.249])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7176A24000D;
        Tue, 17 Mar 2020 13:29:23 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Jonathan Gilbert <JonathanG@iQmetrix.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v2 0/2] git-gui: reduce Tcl version requirement from 8.6 to 8.5
Date:   Tue, 17 Mar 2020 18:59:19 +0530
Message-Id: <20200317132921.7222-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.26.0.rc1.11.g30e9940356
In-Reply-To: <20200314224159.14174-1-me@yadavpratyush.com>
References: <20200314224159.14174-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Some MacOS distributions ship with Tcl 8.5. This means we can't use
TclOO. So, use our homegrown class.tcl instead.

While here, fix a potential variable name collision by creating a
separate namespace for a chord's script evaluation.

Jonathan,

Can you please test the patches the same way you tested your original
series just to be sure we don't break anything? A review would also be
nice.

Changes in v2:
- Add a note _after_ checking if the user agreed to the deletion.
  Otherwise, if the user denies, two "zombie" notes are left lying
  around which will never be activated. This means that the chord won't
  complete and the index won't be unlocked, leading to git-gui becoming
  frozen.

Pratyush Yadav (2):
  git-gui: reduce Tcl version requirement from 8.6 to 8.5
  git-gui: create a new namespace for chord script evaluation

 git-gui.sh    |  4 ++--
 lib/chord.tcl | 56 +++++++++++++++++++++++++--------------------------
 lib/index.tcl | 10 +++++----
 3 files changed, 35 insertions(+), 35 deletions(-)

--
2.26.0.rc1.11.g30e9940356

