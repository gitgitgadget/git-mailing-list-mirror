From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] rebase: guard against missing files in read_basic_state()
Date: Thu, 13 Jun 2013 21:36:11 +0530
Message-ID: <1371139573-28047-2-git-send-email-artagnon@gmail.com>
References: <1371139573-28047-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 18:08:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnA4O-0005aw-1Q
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 18:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab3FMQIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 12:08:12 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:49025 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab3FMQIL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 12:08:11 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so8162603pad.9
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SWEBPLbjOnRVAAbkq1RTg1vl7GKo+j5AlBVXQXumaxA=;
        b=ZE12Yl7Cl+Ing4VvF+hweaSTVlbmgWvKcCdyadaZGKs1Q7dVYgf9nK5PTYxIeLumrl
         Iwho1zbrrE1lZV0iezw2khcM1rPqxNJLDq601j1C8dlI0d3E72eGyBliD1VKX2Ts04qa
         f3IBS4r5xyc/5V8sBLC2Sx3xJXMawn1dNcnnCxUO/CyCz88MIiRpKzsNHochyxtczKIR
         1t+vwNX8DJ04FUyA6GqOxCOP+beSpo92AwTThaDz+P7ylsMB+GFBxmfgl+IAwBo8aP34
         8Oq6CZ7GQUSSPimrmV8Aossa/KBAnjoxsRNoAuVWPTqM5N2DwB2+kYYmeer7xLICzWCp
         5PEg==
X-Received: by 10.66.191.99 with SMTP id gx3mr61265pac.88.1371139691109;
        Thu, 13 Jun 2013 09:08:11 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id rn7sm23911564pbc.12.2013.06.13.09.08.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 09:08:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.381.gf08dd97.dirty
In-Reply-To: <1371139573-28047-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227742>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index d0c11a9..2122fe0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -84,6 +84,8 @@ keep_empty=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 
 read_basic_state () {
+	test -f "$state_dir/head-name" &&
+	test -f "$state_dir/onto" &&
 	head_name=$(cat "$state_dir"/head-name) &&
 	onto=$(cat "$state_dir"/onto) &&
 	# We always write to orig-head, but interactive rebase used to write to
-- 
1.8.3.1.381.gf08dd97.dirty
