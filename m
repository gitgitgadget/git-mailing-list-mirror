From: "C. Cooke" <ccooke@gkhs.net>
Subject: [COGITO PATCH] Small, simple and obvious cleanups (are they wanted
 at this stage?)
Date: Wed, 01 Jun 2005 20:22:48 +0100
Message-ID: <429E0B08.5040603@gkhs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 01 21:22:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdYnH-0003UI-J3
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 21:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVFATYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 15:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVFATYV
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 15:24:21 -0400
Received: from mail114.messagelabs.com ([195.245.231.163]:35517 "HELO
	mail114.messagelabs.com") by vger.kernel.org with SMTP
	id S261258AbVFATWw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 15:22:52 -0400
X-VirusChecked: Checked
X-Env-Sender: ccooke@gkhs.net
X-Msg-Ref: server-10.tower-114.messagelabs.com!1117653769!6871901!1
X-StarScan-Version: 5.4.15; banners=.,-,-
X-Originating-IP: [217.40.157.153]
Received: (qmail 1747 invoked from network); 1 Jun 2005 19:22:49 -0000
Received: from host217-40-157-153.in-addr.btopenworld.com (HELO mail.inspiredbroadcast.net) (217.40.157.153)
  by server-10.tower-114.messagelabs.com with SMTP; 1 Jun 2005 19:22:49 -0000
Received: from [172.17.0.202] (helo=[172.17.0.202])
	by mail.inspiredbroadcast.net with esmtp (Exim 4.24; FreeBSD 4.7)
	id 1DdYnh-00089h-5h
	for git@vger.kernel.org; Wed, 01 Jun 2005 20:22:49 +0100
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a simple example - giving a nice error if you're in the wrong
directory.

Is this sort of patch wanted? If so, I'm sure I can spare the time to
look into some polishing.

------------------------------
Add some sanity checking - does $_git exist, and is it writable.

---
commit 06afdeefff9fe02cd2a67f223e687646cacf736f
tree cebc55541b89b5370335fc172814feb48456dc85
parent 20e473c9afd8b5d2d549b0e7881473600beb9c37
author C. Cooke <ccooke@slab.earth.gkhs.net> Wed, 01 Jun 2005 20:03:46 +0100
committer C. Cooke <ccooke@slab.earth.gkhs.net> Wed, 01 Jun 2005
20:03:46 +0100

 cg-Xnormid |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/cg-Xnormid b/cg-Xnormid
--- a/cg-Xnormid
+++ b/cg-Xnormid
@@ -16,6 +16,15 @@

 id="$1"

+# A little sanity checking.
+if [ ! -d "$_git" ]; then
+       echo "There is no Git repository here ($_git not found)" >&2
+       exit 1
+elif [ ! -r "$_git" ] || [ ! -x "$_git" ]; then
+       echo "You do not have permission to access this git repository" >&2
+       exit 1
+fi
+
 if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
        read id < "$_git/HEAD"


______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________
