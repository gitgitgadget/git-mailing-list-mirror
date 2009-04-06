From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 0/3] git remote update: Check args and fallback to remotes
Date: Mon,  6 Apr 2009 15:40:59 +0200
Message-ID: <1239025262-16960-1-git-send-email-finnag@pvv.org>
Cc: gitster@pobox.com, Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:44:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqp6z-0002xr-Bx
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774AbZDFNlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 09:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754598AbZDFNld
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:41:33 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:56625 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbZDFNld (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:41:33 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1Lqp4k-0004Pq-Fz; Mon, 06 Apr 2009 15:41:24 +0200
X-Mailer: git-send-email 1.5.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115828>

This series is on top of next.

git remote update <non-existing> would previously silently do nothing.
With this patch series, it will (with 1/3) error out when non-existing groups
are given, and with 2/3 & 3/3 it will use a remote if a group cannot be found.

This enables "git remote update origin" for example. All previous uses
of "git remote update <x>" that did something useful should still work
exactly as before.

There seems to be no current way to check for the existence of a configured
remote, so 2/3 adds a remote_is_configured() function which checks for a
configured remote.

Finn Arne Gangstad (3):
  git remote update: Report error for non-existing groups
  remote: New function remote_is_configured()
  git remote update: Fallback to remote if group does not exist

 Documentation/git-remote.txt |    2 +-
 builtin-remote.c             |   17 ++++++++++++++---
 remote.c                     |   11 +++++++++++
 remote.h                     |    1 +
 4 files changed, 27 insertions(+), 4 deletions(-)
