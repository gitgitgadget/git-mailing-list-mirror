From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv8 00/10] git notes
Date: Fri, 20 Nov 2009 02:39:04 +0100
Message-ID: <1258681154-2167-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 02:39:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBITR-000444-3N
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757162AbZKTBjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756723AbZKTBjd
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:39:33 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61751 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755853AbZKTBjc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 20:39:32 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTD000QTWLZF7A0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Nov 2009 02:39:35 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTD00D7NWLXUY10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Nov 2009 02:39:35 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.11.20.12721
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133280>

Hi,

Here is the 8th iteration of the git-notes series. Changes in this
iteration are as follows:

Changes to existing patches:
- Rebased onto current 'next', dropping the early part of this series
  which has now been merged to 'next'.
- Patch 8 (was patch 22): Major rewrite of fast-import's notes handling
  code based on comments from Shawn.

New patches:
- Patch 9: Rename t9301 to t9350, to make room for more fast-import tests
- Patch 10: More fast-import tests

TODO:
- Builtin-ify git-notes shell script to take advantage of notes API
- Garbage collect notes whose referenced object is unreachable (gc_notes())
- Handle note objects that are not blobs, but trees


Have fun! :)

...Johan


Johan Herland (10):
  Notes API: get_commit_notes() -> format_note() + remove the commit restriction
  Notes API: init_notes(): Initialize the notes tree from the given notes ref
  Notes API: add_note(): Add note objects to the internal notes tree structure
  Notes API: get_note(): Return the note annotating the given object
  Notes API: for_each_note(): Traverse the entire notes tree with a callback
  Notes API: Allow multiple concurrent notes trees with new struct notes_tree
  Refactor notes concatenation into a flexible interface for combining notes
  fast-import: Proper notes tree manipulation using the notes API
  Rename t9301 to t9350, to make room for more fast-import tests
  Add more testcases to test fast-import of notes

 fast-import.c                                    |  297 +++++++++++-
 notes.c                                          |  336 +++++++++----
 notes.h                                          |  114 ++++-
 pretty.c                                         |    8 +-
 t/t9300-fast-import.sh                           |  156 ++++++-
 t/t9301-fast-import-notes.sh                     |  578 ++++++++++++++++++++++
 t/{t9301-fast-export.sh => t9350-fast-export.sh} |    0
 7 files changed, 1370 insertions(+), 119 deletions(-)
 create mode 100755 t/t9301-fast-import-notes.sh
 rename t/{t9301-fast-export.sh => t9350-fast-export.sh} (100%)
