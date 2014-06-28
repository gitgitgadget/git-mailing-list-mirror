From: Max Kirillov <max@max630.net>
Subject: [PATCH 0/2] git-merge-file: do not add LF at EOF while applying unrelated change
Date: Sat, 28 Jun 2014 22:37:21 +0300
Message-ID: <1403984243-22717-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 28 21:38:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0ySN-0001wT-Ii
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 21:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbaF1Ti2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 15:38:28 -0400
Received: from p3plsmtpa11-06.prod.phx3.secureserver.net ([68.178.252.107]:35334
	"EHLO p3plsmtpa11-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751017AbaF1Ti2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jun 2014 15:38:28 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa11-06.prod.phx3.secureserver.net with 
	id KveM1o0063gsSd601veS1Z; Sat, 28 Jun 2014 12:38:27 -0700
X-Mailer: git-send-email 2.0.0.526.g5318336
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252617>

Hi.

I have noticed that cherry-pick adds trailing newlines when it is not
expected to - the change does not contain its addition. Here is the fix
for it.

The fix is quite debugging-driven, without detailed analysis of how
exactly this "add_nl" parameter works in all cases. But it passes all
tests. I have added some more where I felt there were not enough.

Also I have noticed that some tests in the t6023, which related to the
behavior contain a mistake which makes them meaningless. I have fixed it
and marked the tests as expected failure, because they are failing after
that. Hopely they will be fixed some day.

Max Kirillov (2):
  t6023-merge-file.sh: fix and mark as broken invalid tests
  git-merge-file: do not add LF at EOF while applying unrelated change

 t/t6023-merge-file.sh | 72 ++++++++++++++++++++++++++++++++++++++++++++++++---
 xdiff/xmerge.c        |  4 +--
 2 files changed, 71 insertions(+), 5 deletions(-)

-- 
2.0.0.526.g5318336
