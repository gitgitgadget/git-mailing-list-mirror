From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 0/3 v2] diff --stat: use the real terminal width
Date: Fri, 10 Feb 2012 17:39:29 +0100
Message-ID: <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl>
References: <CACsJy8AQdz=uwDm+FOgcUB5JOi5U7w-W4w7yUPL6wd2FO-bArg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 10 17:40:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvtWJ-0000XQ-6s
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 17:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759342Ab2BJQkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 11:40:15 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52357 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754323Ab2BJQkN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 11:40:13 -0500
Received: from amanda.fuw.edu.pl ([193.0.82.254] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RvtW7-0000kd-Je; Fri, 10 Feb 2012 17:40:11 +0100
X-Mailer: git-send-email 1.7.9.263.g8cced
In-Reply-To: <CACsJy8AQdz=uwDm+FOgcUB5JOi5U7w-W4w7yUPL6wd2FO-bArg@mail.gmail.com>
References: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl> <1328831921-27272-4-git-send-email-zbyszek@in.waw.pl> <CACsJy8APGeTNv_E3qD=xFCiLC25M_nm3aJbq6YU73J=X0Wxh2w@mail.gmail.com> <4F34FE9A.7020600@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190416>

Hi,
this is version 2.
Changes:

- style fixes
- some tests for git-format-patch added
- patches 3 and 4 squashed together, since they touch the same lines
- graph width is limited to 40 columns, even if there's more space
- patch descriptions extended and cleared up

Description (modified):

this is a patch series to make 'git diff --stat' use full terminal
width instead of hard-coded 80 columns.

This is quite useful when working on projects with nested directory
structure, e.g. Java:
 .../{ => workspace/tasks}/GetTaskResultAction.java |   10 +-
 .../tasks}/RemoveAllAbortedTasksAction.java        |    7 +-
 .../tasks}/RemoveAllFailedTasksAction.java         |    7 +-
is changed to display full paths if the terminal window is wide
enough.

Git usually uses the full terminal width automatically, so it should
do so with --stat too.

The "big" functional change in the patch series is
s/80/term_columns()/ in show_stats(). The partitioning of available
columns is changed to dedicate more space to file names and the number
of columns used for +- graph is limited.
