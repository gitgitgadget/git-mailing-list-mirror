From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: What's cooking in git.git (Mar 2009, #03; Wed, 11)
Date: Thu, 12 Mar 2009 21:22:50 +0100
Message-ID: <49B96F1A.3060001@lsrfire.ath.cx>
References: <7vvdqg5s17.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 21:24:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhrS6-0008LG-8G
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 21:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbZCLUW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 16:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbZCLUW6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 16:22:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:38243 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbZCLUW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 16:22:57 -0400
Received: from [10.0.1.101] (p57B7E5D4.dip.t-dialin.net [87.183.229.212])
	by india601.server4you.de (Postfix) with ESMTPSA id 632BC2F8045;
	Thu, 12 Mar 2009 21:22:54 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7vvdqg5s17.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113121>

Junio C Hamano schrieb:
> Tonight's 'pu' does not pass its self-test and it is expected; I won't be
> fixing it and I'm going to bed now.

This fixes a segfault:

diff --git a/remote.c b/remote.c
index 68c1a84..ea1841e 100644
--- a/remote.c
+++ b/remote.c
@@ -655,9 +655,9 @@ struct remote *remote_get(const char *name)
 	struct remote *ret;
 	int name_given = 0;
 
 	read_config();
-	if (name || strcmp(name, "-"))
+	if (name && strcmp(name, "-"))
 		name_given = 1;
 	else {
 		name = default_remote_name;
 		name_given = explicit_default_remote_name;
