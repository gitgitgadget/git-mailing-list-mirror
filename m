From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/3] git-gui: remove 'no such variable' for s error when encounter unknown file states
Date: Thu,  9 Dec 2010 21:46:22 +0100
Message-ID: <ab91f8f7447c20f518554c57c4f85483cab4ee2f.1291927374.git.bert.wesarg@googlemail.com>
References: <c373e73fb114ebc580c36bc494dc62f80a19ece9.1291927374.git.bert.wesarg@googlemail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 21:46:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnNs-0002Ki-Fj
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 21:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756636Ab0LIUqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 15:46:32 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:41154 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab0LIUqb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 15:46:31 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so2914425fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 12:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=MPUevvILi9OXlK67MMNr9XCgq0HUpsvR4MMNTLhW4tE=;
        b=LgXFOQwWdDKvBOV1nJWJp3hT/VcqIE9tbvvr78Wr1JIkMU9GNFmK5BuTc3JbgkzlbW
         GeY3/49wh47yIdxHx222gZgbIlQjTkxk2WvnpQLAcpF9uWWSojWqR2olj1oPUcxQB1U3
         JABNcFE+1sYQvqdB/w2eoB6Aex2EOHM62xjYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NZK7Lu+jsBVrRT2ImUaGovDfHQVEvtta0AZBluMdyK1+zTPLD1zb3I6czozW7HoB46
         l/OmiXS78Jzzwiuv+czsRGFUvJ2zxU7X5O/8tXM4PyC3SBoGlr0pMP9gIV08iGbq3hcR
         x0VjOqPkWXQj3P5XKj/Ce/tdDrs7p65ZE8Q1c=
Received: by 10.223.116.9 with SMTP id k9mr10453746faq.124.1291927590669;
        Thu, 09 Dec 2010 12:46:30 -0800 (PST)
Received: from localhost (p3E990761.dip.t-dialin.net [62.153.7.97])
        by mx.google.com with ESMTPS id k6sm692821faa.30.2010.12.09.12.46.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 12:46:29 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
In-Reply-To: <c373e73fb114ebc580c36bc494dc62f80a19ece9.1291927374.git.bert.wesarg@googlemail.com>
In-Reply-To: <c373e73fb114ebc580c36bc494dc62f80a19ece9.1291927374.git.bert.wesarg@googlemail.com>
References: <c373e73fb114ebc580c36bc494dc62f80a19ece9.1291927374.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163311>

$s will be referenced in the error message. Which was broken since
"git-gui: Automatically update-index all included files before commit"
(bbe3b3b, 2006-11-16).

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/commit.tcl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/commit.tcl b/lib/commit.tcl
index 7f459cd..83b3d9d 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -161,7 +161,8 @@ The rescan will be automatically started now.
 	#
 	set files_ready 0
 	foreach path [array names file_states] {
-		switch -glob -- [lindex $file_states($path) 0] {
+		set s $file_states($path)
+		switch -glob -- [lindex $s 0] {
 		_? {continue}
 		A? -
 		D? -
-- 
1.7.3.2.1200.ge4bf6
