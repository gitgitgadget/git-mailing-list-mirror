From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] install-webdoc: quell diff output on stdout
Date: Mon,  6 Sep 2010 08:18:39 +0200
Message-ID: <52f347f82734e5d75d0b93a67edca9941efaa5a9.1283612149.git.git@drmicha.warpmail.net>
References: <7vhbi842gx.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 08:18:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsV2P-0006xT-DH
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 08:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075Ab0IFGSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 02:18:36 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60912 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751653Ab0IFGSg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 02:18:36 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E92E8150;
	Mon,  6 Sep 2010 02:18:35 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 06 Sep 2010 02:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=yrz2p1P+YRHdfXLenDs2gGKEaxQ=; b=e/mz+vpgw2o/O1B7cEn25Qsn0jIIvDb5LYVvx5ColK0GVy56XiCxDyF8Sxe3oRnZv+xYASbKjpKtr1m8PCEKh9CPCy+26bLE2L+KVILanqcBacyCR/HLQ9ra+MRXrlbJBMOIcSMZSpaCr3siOqm7bKF8GZ2Qi3XrLMTvIs2/mhU=
X-Sasl-enc: 8gsAsG3+rLCghUz+6EvfQnTd0M8VIQWT1zhdKUWim2vz 1283753915
Received: from localhost (unknown [195.113.246.47])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7D7CF5E6B9E;
	Mon,  6 Sep 2010 02:18:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.2.540.g9d56f.dirty
In-Reply-To: <7vhbi842gx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155533>

When installing html-doc, install-webdoc.sh compares the installed html
with the version to be installed using diff. Currently, the diff output
fills up stdout.

install-webdoc.sh actually uses $DIFF, and is the only user. Redefine
DIFF from "diff" to "diff -q" to quell the output which is a more useful
general default and in line with the default "QUIET" make rules.

This can be easily overriden by prefixing make with "DIFF=diff" or
putting this in config.mak.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 38a8b65..b5d9c51 100644
--- a/Makefile
+++ b/Makefile
@@ -301,7 +301,7 @@ export prefix bindir sharedir sysconfdir gitwebdir
 CC = gcc
 AR = ar
 RM = rm -f
-DIFF = diff
+DIFF ?= diff -q
 TAR = tar
 FIND = find
 INSTALL = install
-- 
1.7.2.2.540.g9d56f.dirty
