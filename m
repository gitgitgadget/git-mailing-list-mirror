From: "John Yesberg" <john.yesberg@gmail.com>
Subject: [PATCH User manual-Added advice on proxies and autocrlf]
Date: Wed, 11 Jun 2008 20:48:47 +0100
Message-ID: <1033a22d0806111248l5184cf1at3c3130262d8fd0a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bfields@citi.umich.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 21:50:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6WKh-0006LB-H6
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 21:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659AbYFKTsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 15:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756653AbYFKTsz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 15:48:55 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:61284 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756625AbYFKTsy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 15:48:54 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2015429ywe.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=IszQrZZOiF4Pf5DMJ94QUiO0/YsxGtsBL8TqBMTMHx8=;
        b=pIpfHqiAgC2tFsRbMwpmj8OxXzqcF9HENNy9iKLXA29twuqG1IeGqd3XvelsVMHwFg
         mqM94F2vsiW6I6Dl0H23yoWHql1sPREMVkMfqbRguplz5CvMkKz1qVdvtuzLUHUm4WVi
         gASzbMxKIqA2uBLIrr/kDJws7Wu3AvIjK6r4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=piPfz2dt5oTiUShPa4ADnYUPXmzer9XWOtRob5yb1Ru7le3xd++l4hNhl0xrAJ7Uf8
         Rr2i63y0xYwOd7HHE6e9OvDHb/3kPtzR1j88tMh6z+UZNx2cZmwDnOh+Q3Gt5iIMXdmS
         z46lmo77h3ITdQJJBf4wLMHuKU0/yGvpPE1aY=
Received: by 10.151.14.4 with SMTP id r4mr781971ybi.199.1213213727638;
        Wed, 11 Jun 2008 12:48:47 -0700 (PDT)
Received: by 10.151.14.21 with HTTP; Wed, 11 Jun 2008 12:48:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84646>

---
 Documentation/user-manual.txt |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index bfde507..02b1be0 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -56,6 +56,16 @@ $ git clone
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
 The initial clone may be time-consuming for a large project, but you
 will only need to clone once.

+If there is a proxy between you and the repository you want to clone, you
+may not be able to use the git protocol. But you can use the http protocol, by
+configuring the proxy. Note that the address to access the repository via http
+may be different from the git address:
+
+------------------------------------------------
+$ export http_proxy=http://theproxy.example.com:8080
+$ git clone http://www.kernel.org/pub/scm/git/git.git
+------------------------------------------------
+
 The clone command creates a new directory named after the project ("git"
 or "linux-2.6" in the examples above).  After you cd into this
 directory, you will see that it contains a copy of the project files,
@@ -129,6 +139,19 @@ $ git branch
 * new
 ------------------------------------------------

+It is possible, particularly on Windows platforms, that as you checkout
+the original version, it will in fact be modified, by the autocrlf process.
+(Windows and Unix store newlines as CRLF and LF respectively, and autocrlf
+tries to adapt intelligently.) If the checked out version is modified, then
+trying to switch to a new branch will not work, because then the uncommitted
+changes would be lost. So you may need to add the +-f+ flag to _force_ these
+changes to be thrown away. Another option might be to edit +~/.gitconfig+ or
+use the following command to disable the autocrlf function.
+
+------------------------------------------------
++git config --global core.autocrlf false
+------------------------------------------------
+
 If you decide that you'd rather see version 2.6.17, you can modify
 the current branch to point at v2.6.17 instead, with

-- 
1.5.5.1015.g9d258
