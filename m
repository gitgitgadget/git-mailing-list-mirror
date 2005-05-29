From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH]  Don't remove missing files in cg-commit
Date: Sun, 29 May 2005 22:01:37 +0200
Message-ID: <d7d6ub$c5b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030807040900070900070304"
X-From: git-owner@vger.kernel.org Sun May 29 22:48:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcUdZ-0005xL-CM
	for gcvg-git@gmane.org; Sun, 29 May 2005 22:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVE2UqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 16:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVE2UqX
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 16:46:23 -0400
Received: from main.gmane.org ([80.91.229.2]:53425 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261434AbVE2UqV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 16:46:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DcUQX-0002J1-06
	for git@vger.kernel.org; Sun, 29 May 2005 22:30:29 +0200
Received: from 213-64-177-7-o871.telia.com ([213.64.177.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 29 May 2005 22:30:28 +0200
Received: from holmsand by 213-64-177-7-o871.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 29 May 2005 22:30:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-64-177-7-o871.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------030807040900070900070304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

cg-commit presently wants to remove missing files, even if they haven't 
been cg-rm'd. This is due to a missing "-m" in the call to git-diff-cache.

Signed-off-by: Dan Holmsand <holmsand@gmail.com>


--------------030807040900070900070304
Content-Type: text/plain;
 name="cg-commit.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cg-commit.patch.txt"

diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -73,7 +73,7 @@ else
 	# be committed along automagically as well.
 
 	if [ ! "$ignorecache" ]; then
-		eval changedfiles=($(git-diff-cache -r HEAD | cut -f 2 | \
+		eval changedfiles=($(git-diff-cache -r -m HEAD | cut -f 2 | \
 			sed -e 's/^/"/' -e 's/$/"/'))
 		commitfiles=($addedfiles $remfiles "${changedfiles[@]}")
 	fi

--------------030807040900070900070304--

