From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Add compiled date to git --version output?
Date: Fri, 18 Sep 2009 12:17:48 +0800
Message-ID: <544dda350909172117r44761577m11e7d30a1a5d0c91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 18 06:24:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoV1V-0007xa-97
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 06:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbZIREY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 00:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbZIREYY
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 00:24:24 -0400
Received: from mail-px0-f194.google.com ([209.85.216.194]:32921 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbZIREYU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 00:24:20 -0400
Received: by pxi32 with SMTP id 32so505607pxi.4
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 21:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=Ymkh0ZOuKqJww3dp0aCXkh+Fj7SbMDoxnXPVevT++rg=;
        b=BF74OTCqdonad74mM+47VfKP112MezC+/79fZH+l6QPWOmHMDpJ5l3b/95czfAH0T1
         1fwef5gQF2aEtpOz/ag3V2A48Gb+lMcuVCGBlfpp/IEP2GQ+7iO7Wkc2fThx8sCP6+Zj
         dsttewsPPgi6QOYtCRVRG7y7pCO40hxSplGnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=KAVEnwyqQg7ubdvjLl7r8SA8sRAUutQQXb5O+p0rH9R5EVdx+liUXLePVNZE6erwrQ
         WzLkPovHr70WmI2vol18+0x4n+glooK5S80oJOexClOfe6P8B3TNE612USHHYxc0QRLd
         9shp8RvprBBtQjl3QXcAdt9Ozz0e9Xx03IIfE=
Received: by 10.114.251.14 with SMTP id y14mr1582227wah.144.1253247468886; 
	Thu, 17 Sep 2009 21:17:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128781>

Sometimes I wanted to know how outdated git is on my system.

Coming up with a script to parse "git --version" output to get the SHA1,
and compare that to master's SHA1 seemed a little overkill compared to
this:

diff --git a/help.c b/help.c
index 294337e..bc83491 100644
--- a/help.c
+++ b/help.c
@@ -361,6 +361,9 @@ const char *help_unknown_cmd(const char *cmd)

 int cmd_version(int argc, const char **argv, const char *prefix)
 {
-       printf("git version %s\n", git_version_string);
+       printf("git version %s compiled %s %s\n",
+                       git_version_string,
+                       __DATE__,
+                       __TIME__);
        return 0;
 }

With this, git --version gives:

        git version 1.6.5.rc1.19.g8426.dirty compiled Sep 18 2009 12:03:29

Thoughts?

Nazri
