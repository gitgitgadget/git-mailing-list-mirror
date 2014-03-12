From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] Add grep.fullName config variable
Date: Wed, 12 Mar 2014 08:11:09 +0100
Message-ID: <87r467q4c2.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 08:11:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNdJu-0000Fc-9F
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 08:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417AbaCLHLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 03:11:14 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:57912 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbaCLHLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 03:11:13 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fkPTq4skpz3hjG3
	for <git@vger.kernel.org>; Wed, 12 Mar 2014 08:11:11 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fkPTq0wyZzbbjc
	for <git@vger.kernel.org>; Wed, 12 Mar 2014 08:11:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 0TU6kWhTlqff for <git@vger.kernel.org>;
	Wed, 12 Mar 2014 08:11:10 +0100 (CET)
X-Auth-Info: apielB5a/g3Q2sE8vq9+FHM2QTMEwdMYXKb4DpbuT6o=
Received: from igel.home (ppp-46-244-235-17.dynamic.mnet-online.de [46.244.235.17])
	by mail.mnet-online.de (Postfix) with ESMTPA
	for <git@vger.kernel.org>; Wed, 12 Mar 2014 08:11:10 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id E5BED2C19F2; Wed, 12 Mar 2014 08:11:09 +0100 (CET)
X-Yow: Is this "BOOZE"?
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243923>

This configuration variable sets the default for the --full-name option.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 Documentation/git-grep.txt | 3 +++
 grep.c                     | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index f837334..31811f1 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -53,6 +53,9 @@ grep.extendedRegexp::
 	option is ignored when the 'grep.patternType' option is set to a value
 	other than 'default'.
 
+grep.fullName::
+	If set to true, enable '--full-name' option by default.
+
 
 OPTIONS
 -------
diff --git a/grep.c b/grep.c
index c668034..ece04bf 100644
--- a/grep.c
+++ b/grep.c
@@ -86,6 +86,11 @@ int grep_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "grep.fullname")) {
+		opt->relative = !git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value);
 	else if (!strcmp(var, "color.grep.context"))
-- 
1.9.0


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
