Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531B71F461
	for <e@80x24.org>; Wed, 28 Aug 2019 21:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfH1V5g (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 17:57:36 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:51877 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1V5g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 17:57:36 -0400
Received: from localhost.localdomain (unknown [1.186.12.40])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 10EBF200003;
        Wed, 28 Aug 2019 21:57:32 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v3 0/4] git-gui: Add ability to revert selected hunks and lines
Date:   Thu, 29 Aug 2019 03:27:21 +0530
Message-Id: <20190828215725.13376-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819214110.26461-1-me@yadavpratyush.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This series adds the ability to revert selected lines and hunks in
git-gui. Partially based on the patch by Bert Wesarg [0].

The commits can be found in the topic branch 'py/revert-hunks-lines'
at https://github.com/prati0100/git-gui/tree/py/revert-hunks-lines

Changes in v3:
- Drop the confirmation dialog on partial reverts. It is still there for
  full file reverts (which was the original behaviour).
- Allow undoing the last revert.
- Update the context menu button layout. In v2, the layout was:
   Stage Hunk
   Revert Hunk
   Stage Lines
   Revert Lines

  Now it is:
   Stage Hunk
   Stage Lines
   -----------
   Revert Hunk
   Revert Lines
   Undo Last Revert
- Return early when applying a patch fails. This is useful for this
  series because in that case we don't save a faulty patch in
  last_revert, causing the same error to pop up when reverting the patch
  that failed to apply in the first place.

Changes in v2:
- Add an option to disable the revert confirmation prompt as suggested
  by Johannes Sixt.
- Base the patches on Pat's git-gui tree instead of git.git.

[0]
https://public-inbox.org/git/a9ba4550a29d7f3c653561e7029f0920bf8eb008.1326116492.git.bert.wesarg@googlemail.com/

Pratyush Yadav (4):
  git-gui: allow reverting selected lines
  git-gui: allow reverting selected hunk
  git-gui: return early when patch fails to apply
  git-gui: allow undoing last revert

 git-gui.sh   | 57 +++++++++++++++++++++++++++++--
 lib/diff.tcl | 96 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 135 insertions(+), 18 deletions(-)

--
2.21.0

