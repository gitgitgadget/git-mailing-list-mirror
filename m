From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH] StGit: export: fix base commit reporting in series file
Date: Sun, 21 Nov 2010 17:57:06 +0200
Message-ID: <20101121155706.16544.20984.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 21 16:57:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKCI0-0008GF-Km
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 16:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab0KUP5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 10:57:11 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58194 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab0KUP5K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 10:57:10 -0500
Received: by ewy5 with SMTP id 5so1283727ewy.19
        for <git@vger.kernel.org>; Sun, 21 Nov 2010 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=g0MT8puwH5OvOsubnFZNcRnPMhAKTTBPTM2JsTegtWM=;
        b=mTXeVyqJVruNrDGDKWDCz3EfHDg7Ol8RAqU7QHxr9uKIPwdf4SYloOn2G/nEIxd71Z
         KhvEI/kGZ6bA6QpuvNJUjkQreCqaxhrG2gS70ZOEsueM3uEicsUXaE6a0PYwgKsUO3bv
         FnfI5WgjFOAPmxiLCBPutIDMDDHOpDeNB9P8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=TiOA6DS1kaJcjeDSDwRX1iPRngJzB8FNw3AaiRX+Zb2QSMhjI8QCDfQ350XgpKiqoJ
         c3LrBHZjQFG4uFhH+EKd2o8XuFh+dDFE+cbherfePqxpw6kngCejz5HGaEaJljR+kVXR
         b8dwUQHCo5dNsMmEyEHBEwNt664KnFOCIuDvs=
Received: by 10.213.114.75 with SMTP id d11mr3519385ebq.74.1290355028837;
        Sun, 21 Nov 2010 07:57:08 -0800 (PST)
Received: from localhost.localdomain (clients-217-17-87-199.mikrovisata.net [217.17.87.199])
        by mx.google.com with ESMTPS id q58sm3714651eeh.15.2010.11.21.07.57.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Nov 2010 07:57:07 -0800 (PST)
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161865>

This bug was introduced in 3f19450c426970b78b19c522a82df1a962da5761
It should report the commit stg stack is based on, but not the
last patch in stack.

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---

 stgit/commands/export.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 4285612..a661a7d 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -115,7 +115,7 @@ def func(parser, options, args):
 
     # note the base commit for this series
     if not options.stdout:
-        base_commit = stack.patches.get(patches[0]).commit.sha1
+        base_commit = stack.base.sha1
         print >> series, '# This series applies on GIT commit %s' % base_commit
 
     patch_no = 1;
