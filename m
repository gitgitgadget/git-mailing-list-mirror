From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 0/14 resend] fork/exec removal series
Date: Fri, 19 Oct 2007 21:47:52 +0200
Message-ID: <1192823286-9654-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:48:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IixpW-0002gS-Oh
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765930AbXJSTsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765363AbXJSTsJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:48:09 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:44478 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764582AbXJSTsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 15:48:09 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id C1D0A97B0D;
	Fri, 19 Oct 2007 21:48:06 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.315.g2ce38
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61747>

Here it is again, a series of patches that removes a number fork/exec pairs.

The series goes on top of the builtin-fetch pack topic, specifically,
cfa5b2b7f (Avoid scary errors...) and obsoletes q/jsi/no-fork of Lars'
patch queue.

The difference compared to the last time I sent are in:

[02/14] Use start_command() in git_connect() instead of explicit fork/exec.
[13/14] Avoid a dup2(2) in apply_filter() - start_command() can do it for us.
[14/14] Use the asyncronous function infrastructure to run the content filter.

which had conflicts with the strbuf series.

 builtin-archive.c     |    8 +-
 builtin-fetch-pack.c  |  101 +++++++++----------------
 cache.h               |    4 +-
 connect.c             |  128 +++++++++++++++----------------
 convert.c             |   88 ++++++++--------------
 diff.c                |   38 +---------
 peek-remote.c         |    8 +-
 run-command.c         |   78 +++++++++++++++++---
 run-command.h         |   23 ++++++
 send-pack.c           |    8 +-
 t/t0021-conversion.sh |    7 ++-
 transport.c           |    9 +--
 upload-pack.c         |  199 ++++++++++++++++++++++---------------------------
 13 files changed, 332 insertions(+), 367 deletions(-)

-- Hannes
