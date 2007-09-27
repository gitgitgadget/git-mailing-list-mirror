From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH] gitview: revamped to use string.join, stripped a function def
Date: Fri, 28 Sep 2007 03:55:17 +0800
Message-ID: <1190922917-5044-1-git-send-email-crquan@gmail.com>
Cc: git@vger.kernel.org, cr_quan@163.com
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:56:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IazTI-0002nP-61
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbXI0T4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbXI0T4U
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:56:20 -0400
Received: from qb-out-0506.google.com ([72.14.204.226]:2651 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbXI0T4T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:56:19 -0400
Received: by qb-out-0506.google.com with SMTP id f9so876789qba
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=U9ueyaau6nj23+izxHzQjSQoN2ZkZFzLoTqxuuIpZDc=;
        b=GaLVagzMMBLela6SwmVaUVrec3Km4lYPcT9sU1bVEnCXJBv6YOLLE7DxxHYNClsttzWRahc6t0yrMnTUYJEItK0DSxsYojWg6spOzS1N7ZDbCcDQHo7nOoaeR9+XId560fpZEgBKtz70VITbyBGwb/7gkCriDXyk3TJxefTErv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=YnUFftryBr5tYAuAwDtHEA8jbHDf1H9hK/sqqDtwiGjdmPd+L2Qoq9BmYXNaOIZBkEMES4IaxRTA0Z/E/oSv1iZhY2mMGIy7OEkvL/jZeEXv96U36M4PmvMl8j9HdsjnEwlvG7Ty5mIwVLCJleNtK8mY/me8WLwmZhwgBmwcF8o=
Received: by 10.141.146.11 with SMTP id y11mr1138743rvn.1190922978525;
        Thu, 27 Sep 2007 12:56:18 -0700 (PDT)
Received: from tux ( [116.24.36.195])
        by mx.google.com with ESMTPS id b21sm5439756rvf.2007.09.27.12.56.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Sep 2007 12:56:14 -0700 (PDT)
Received: by tux (sSMTP sendmail emulation); Fri, 28 Sep 2007 03:55:17 +0800
X-Mailer: git-send-email 1.5.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59325>

Signed-off-by: Denis Cheng <crquan@gmail.com>
---
 contrib/gitview/gitview |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 5931766..2eb72b1 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -36,17 +36,6 @@ except ImportError:
 
 re_ident = re.compile('(author|committer) (?P<ident>.*) (?P<epoch>\d+) (?P<tz>[+-]\d{4})')
 
-def list_to_string(args, skip):
-	count = len(args)
-	i = skip
-	str_arg=" "
-	while (i < count ):
-		str_arg = str_arg + args[i]
-		str_arg = str_arg + " "
-		i = i+1
-
-	return str_arg
-
 def show_date(epoch, tz):
 	secs = float(epoch)
 	tzsecs = float(tz[1:3]) * 3600
@@ -1115,7 +1104,7 @@ class GitView(object):
 
 	def set_branch(self, args):
 		"""Fill in different windows with info from the reposiroty"""
-		fp = os.popen("git rev-parse --sq --default HEAD " + list_to_string(args, 1))
+		fp = os.popen("git rev-parse --sq --default HEAD " + " ".join(args[1:]))
 		git_rev_list_cmd = fp.read()
 		fp.close()
 		fp = os.popen("git rev-list  --header --topo-order --parents " + git_rev_list_cmd)
-- 
1.5.3.2
