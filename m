Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1595BC4360C
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23EB224D3
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgL1Wzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:37 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:59424 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgL1Tai (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:30:38 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktyDM-006Pmz-52; Mon, 28 Dec 2020 12:29:56 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1ktyDL-0002GV-GT; Mon, 28 Dec 2020 12:29:56 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 1CC0312802EC;
        Mon, 28 Dec 2020 12:29:55 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cF_Uxlj6G6DC; Mon, 28 Dec 2020 12:29:55 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id 8F17E12801DF;
        Mon, 28 Dec 2020 12:29:54 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 28 Dec 2020 12:29:14 -0700
Message-Id: <20201228192919.1195211-1-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc2.4.g8f3eabcc0e
In-Reply-To: <20201228045427.1166911-1-seth@eseth.com>
References: <20201228045427.1166911-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktyDL-0002GV-GT;;;mid=<20201228192919.1195211-1-seth@eseth.com>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v9 0/5] mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Junio and Johannes for patiently pointing out all my newbie
mistakes.

Changes since v8:

- Improve documentation of what the autoMerge flag does.
- Add documentation note for the `automerge_enabled` override.

  - Junio, is there another place this should also live?

- Cross-reference merge.autoMerge and merge.<tool>.autoMerge docs.
- Sort the list of mergetool options. Added as a standalone commit in
  case this change doesn't belong as part of this patchset. I'd be happy
  to move this to a standalone patch if that's preferable.
- Improve all commit messages with full explanations and rationale:

  - Johannes, I didn't directly respond to your `initialize_merge_tool`
    question because you're right that explanation should be part of the
    commit message. Please let me know if that now answers your question
    and if not we can discuss further in a thread.

- Fix omitted exit codes when running `initialize_merge_tool`.
- Fix `automerge_enabled` return value for consistency.
- Update commit message capitalization to conform to repo norms.
- Rephrase commit message 'thanks' as Helped-by markers.

Felipe Contreras (1):
  mergetool: add automerge configuration

Seth House (4):
  mergetool: alphabetize the mergetool config docs
  mergetool: add per-tool support for the autoMerge flag
  mergetool: break setup_tool out into separate initialization function
  mergetool: add automerge_enabled tool-specific override function

 Documentation/config/mergetool.txt   | 28 ++++++++++++++++++++++------
 Documentation/git-mergetool--lib.txt |  4 ++++
 git-difftool--helper.sh              |  2 ++
 git-mergetool--lib.sh                | 11 ++++++++---
 git-mergetool.sh                     | 22 ++++++++++++++++++++++
 t/t7610-mergetool.sh                 | 18 ++++++++++++++++++
 6 files changed, 76 insertions(+), 9 deletions(-)

-- 
2.29.2


