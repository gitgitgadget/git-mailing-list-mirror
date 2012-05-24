From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCHv2] Do not autosquash in case of an implied interactive rebase
Date: Thu, 24 May 2012 13:57:26 +0000
Message-ID: <1337867846-5336-1-git-send-email-vfr@lyx.org>
References: <1337867575-7212-1-git-send-email-vfr@lyx.org>
Cc: Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 15:57:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYXw-0006k9-C2
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 15:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929Ab2EXN5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 09:57:40 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49548 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab2EXN5j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 09:57:39 -0400
Received: by eeit10 with SMTP id t10so2440854eei.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 06:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=sWwbSa7OczbKJ8xOfXelbgaZFQHLFl7b63Sn70T7rp0=;
        b=pT6fH6O7pU934hM8QsdHeXsKza+VUj/QTU1V0kXxewKmeiFFq8q8tY9MHjrGJ5+ZCS
         m410Ds5IohLtYsgDu2S6F2CTU0eC1YtmE+AnP66d1NfEQb+VtCd6dLM00i6tQStTgPZm
         HS2eLLJZ1gUTwtPvKU7/rDFQuxFW+MNkuuO1NeqnWh1vxgirbxUAzs4rbfbGAPdn/X1e
         PKFvbInXl1Ha+uilUWpATt2V5wAOZgL9LdLTC8HAVMWwGQYr3R6WNgWOrSr5lWYaqYwm
         6Pnb00wRP3pPKKt2kzORZoDqgg3m/bJf+XJVIyrZDIwnlQPVm+h5AvPkX3YRIe3sW4hV
         aZcg==
Received: by 10.213.108.72 with SMTP id e8mr2236979ebp.40.1337867858444;
        Thu, 24 May 2012 06:57:38 -0700 (PDT)
Received: from localhost (wlan-145-94-170-237.wlan.tudelft.nl. [145.94.170.237])
        by mx.google.com with ESMTPS id m5sm1239239eeh.17.2012.05.24.06.57.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 06:57:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.msysgit.0
In-Reply-To: <1337867575-7212-1-git-send-email-vfr@lyx.org>
X-Gm-Message-State: ALoCoQlgj5FCxX8Fg/ZkHSybiirOHbq0vuFILoOVOUQtUqmHAJcCi1qPdzTAe1Da3yuEXC7NFbQ4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198373>

The option to autosquash is only used in case of an interactive rebase.
When merges are preserved, rebase uses an interactive rebase internally,
but in this case autosquash should still be disabled.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 git-rebase.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 24a2840..9148ec2 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -167,6 +167,7 @@ run_specific_rebase () {
 	if [ "$interactive_rebase" = implied ]; then
 		GIT_EDITOR=:
 		export GIT_EDITOR
+		autosquash=
 	fi
 	. git-rebase--$type
 }
-- 
1.7.9.msysgit.0
