From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 0/9] Handling empty notes
Date: Wed, 12 Nov 2014 01:40:07 +0100
Message-ID: <1415752816-22782-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, peff@peff.net, blume.mike@gmail.com,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 01:40:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoLz7-0005lR-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 01:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbaKLAka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 19:40:30 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:44168 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbaKLAk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 19:40:29 -0500
Received: by mail-lb0-f180.google.com with SMTP id z11so1729838lbi.25
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 16:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=LocgiY3w1wJRrOSyAbjnIZ2ya7CZcGTEB/9qtwDWwGA=;
        b=Wmgxc4bdjfG8pq+G3i1zw0hecHA69yqKXWuK94cowj3iX/tHnsWUWPVUjDqkWoy3ZR
         UNjK5tzd7CBJmMa+Tx0xCKiO7E1HyvuxyaA2Y8uN/NrNubyL32EDIVB36QasLRnsN3GC
         Hd9Y98zWXLqqETtfMsjcpj//99OTmBctOJ1eZVeba60bD0g1YWU0QStfNrF2+RioPjrc
         zuEe9sy0Bk8r3cAnS5LqBhc4P+MJScjEazHnuUMhtJ7on4sykcWcOJmKY6UK3KcjoMaT
         hObGxlaINXm8QU73yJJ94YHTByqcPG3NLcnvXt4JPocK/EKCJgtzosiGcrI3aR6nFtkp
         5ueQ==
X-Received: by 10.152.42.172 with SMTP id p12mr39154684lal.11.1415752827540;
        Tue, 11 Nov 2014 16:40:27 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm6341174lav.15.2014.11.11.16.40.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Nov 2014 16:40:26 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes v4 -> v5:

 - Patch #5: Reorder code to ease readability and fix issue with
   checking d.given after free_note_data(&d), noticed by Junio.

 - Patch #9: Fix typo in commit message, noticed by Junio.

 - Patch #9: Rename "output" files to "actual", suggested by Eric.

 - Patch #9: Use test_line_count instead of wc -l, which behaves
   differently on Macs. noticed by Michael, diagnosed by Eric, and
   fix suggested by Peff.

 - Patch #9: Use -r option to ls-tree when counting entries in notes,
   tree as this also works for trees with fanout level > 0. Noticed
   by Peff.


Have fun! :)

...Johan


Johan Herland (9):
  builtin/notes: Fix premature failure when trying to add the empty blob
  t3301: Verify that 'git notes' removes empty notes by default
  builtin/notes: Improve naming
  builtin/notes: Refactor note file path into struct note_data
  builtin/notes: Simplify early exit code in add()
  builtin/notes: Split create_note() to clarify add vs. remove logic
  builtin/notes: Add --allow-empty, to allow storing empty notes
  notes: Empty notes should be shown by 'git log'
  t3301: Modernize

 Documentation/git-notes.txt |   12 +-
 builtin/notes.c             |  258 +++++----
 notes.c                     |    3 +-
 t/t3301-notes.sh            | 1341 +++++++++++++++++++++----------------------
 4 files changed, 789 insertions(+), 825 deletions(-)

-- 
2.0.0.rc4.501.gdaf83ca
