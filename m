From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] pull: prefer invoking "git <command>" over "git-<command>"
Date: Sun, 14 Apr 2013 02:45:27 +0530
Message-ID: <1365887729-9630-2-git-send-email-artagnon@gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 13 23:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR7np-0001HY-MS
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 23:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077Ab3DMVPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 17:15:53 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36307 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab3DMVPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 17:15:52 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so1977348pad.39
        for <git@vger.kernel.org>; Sat, 13 Apr 2013 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bL6OcPW56YGe+VIDd+6cFPxTX1bLTVT8WSCXGP5jHR4=;
        b=iPVWrmNDZHRIeRRQOok19/9AjloBSOeSyc5nQcKxgqmzkr5YLYtboAl6EUqUMMciiw
         Q/6FziE5mLfe4XJZhrOZFk1DMfU3wsRQMaBPLzMh4NnFjT/BVwlfSuOWW0CigUIQrF2M
         Mr6fnlKu0mZUap/PTqJcGMZX13sHucWK0qoXC97JFyACweW+V7dJap0MPAm9mnwJyaLF
         A4yrToDoPOyPU/G0Gp2SbPcT5iWM9VZVQZevFKUDHTT77xk3O7D5erUxpR5wP5bLmD83
         NJ9Go0ptJ/8A2MAJHfQiHZp51DVbLip9usiEzk47rOQRTt3V+vHJxCDig/yXbD6FiYr3
         iF+w==
X-Received: by 10.68.253.133 with SMTP id aa5mr21084664pbd.131.1365887751892;
        Sat, 13 Apr 2013 14:15:51 -0700 (PDT)
Received: from localhost.localdomain ([122.164.25.24])
        by mx.google.com with ESMTPS id fb7sm15112193pab.16.2013.04.13.14.15.49
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 13 Apr 2013 14:15:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.392.g6943ea6
In-Reply-To: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221070>

14e5d40c (pull: Fix parsing of -X<option>, 2010-01-17) added the lines
containing "git-push" and "git-merge", even though the prevelant style
at the time was to use the unhyphenated "git <command>" form.  Fix
this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 638aabb..5fe69fa 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -285,11 +285,11 @@ fi
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
-	eval="git-rebase $diffstat $strategy_args $merge_args $verbosity"
+	eval="git rebase $diffstat $strategy_args $merge_args $verbosity"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
-	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
+	eval="git merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
 	eval="$eval  $log_arg $strategy_args $merge_args $verbosity $progress"
 	eval="$eval \"\$merge_name\" HEAD $merge_head"
 	;;
-- 
1.8.2.1.392.g6943ea6
