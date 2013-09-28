From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 37/44] ruby: request-pull: use shortlog()
Date: Sat, 28 Sep 2013 17:04:02 -0500
Message-ID: <1380405849-13000-38-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2k3-00047C-4T
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377Ab3I1WLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:54 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:56896 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372Ab3I1WLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:49 -0400
Received: by mail-oa0-f51.google.com with SMTP id h16so3023314oag.38
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HKcRadFlvuWKM+KRkasWDNpKUS3hnl4/4ngXGH+9FJo=;
        b=gomYuvnkc7Z56gmfjlGMC0QlVomPc++ZgCS5I7SMrqG1sEurcVYEAWD5ZJsrFAIXf5
         OIpo/6I6S4tvSzjSpjwKwMNpxxco4/ue9+3HxPZf/Vc5FLIFq1hlC+USF5L9XdV39REJ
         9BGwtfQO5jAFAUjT9scaU0RDKw1FijDPdxSd3v2lJ7MkGGsVljRnubJUTeNze1YscaPp
         G7ynkxgh37tySboT/vNl2wpOAqdLVFg2Hrq422YRKwp6aCP1d89/d3wXxuvW+ZAcCaTd
         XD01vDr+QECJnxHJbi9kvVNFgrUtGtPg30ua9Siq7GwX7LAhjN6F/uqrsQt4UYxpVLey
         YFJw==
X-Received: by 10.60.80.8 with SMTP id n8mr12240829oex.33.1380406309310;
        Sat, 28 Sep 2013 15:11:49 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm19471321obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235557>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.rb | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index 233981f..0db64c3 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -79,6 +79,11 @@ def parse_buffer(buffer)
   return [summary, date]
 end
 
+def show_shortlog(base, head)
+  rev = Git::RevInfo.setup(nil, ['^' + base, head], nil)
+  shortlog(rev.to_a)
+end
+
 until ARGV.empty?
   case ARGV.first
   when '-p'
@@ -174,7 +179,7 @@ for you to fetch changes up to %s:
     puts "----------------------------------------------------------------"
   end
 
-  run(%[git shortlog ^#{base} #{head}])
+  show_shortlog(base, head)
   run(%[git diff -M --stat --summary #{patch} ^#{merge_base_commit} #{head}])
 
   if ! ref
-- 
1.8.4-fc
