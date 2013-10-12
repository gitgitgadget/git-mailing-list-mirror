From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 15/15] contrib: related: add README
Date: Sat, 12 Oct 2013 02:06:16 -0500
Message-ID: <1381561584-20529-8-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNg-00059v-Cm
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab3JLHMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:45 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:55910 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab3JLHMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:44 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so3477353obc.13
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zqdkP7sXV1kNsw2PlXrKYW9U8Z2yJY9O09H0JZSDIgE=;
        b=gkvjgSiCUL9JrNhAxvpRaRolZTgVuvBF5pjQ04r47ZcHIiPFgt+OAY+Pn9sr/c259t
         1AJ2d9Uo7Q+T+LqhVDmFWBfF4BiZelwIyMx5fOZVKtmmbNmZWC05vJj3p/9+5QlR5irW
         tMqdjB8+hVMQyGsYg534ks0A59YR0q92dzMiSv6YzN2zmptX6rxgS5rxt7+rsQGTfZjO
         R5F4pWyeudXTKR8NEzFabdW5qPiXqD1sgb+8J7V7bLbyuWybYFhYBdmo4VHYpyjNG2Q0
         WQqOX/FcmTy4vWzF54kME9Q5/k5tuQi2rqdTzUcAJ9PD1tGXXg3mjKd+bU4nIhtHRruv
         UWvg==
X-Received: by 10.182.121.137 with SMTP id lk9mr17889234obb.32.1381561963882;
        Sat, 12 Oct 2013 00:12:43 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm28653755obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235998>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/README | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 contrib/related/README

diff --git a/contrib/related/README b/contrib/related/README
new file mode 100644
index 0000000..26188ca
--- /dev/null
+++ b/contrib/related/README
@@ -0,0 +1,65 @@
+= git-related =
+
+This tool finds people that might be interested in a patch, by going
+back through the history for each single hunk modified, and finding
+people that reviewed, acknowledged, signed, or authored the code the
+patch is modifying.
+
+It does this by running `git blame` incrementally on each hunk, and then
+parsing the commit message. After gathering all the relevant people, it
+groups them to show what exactly was their role when the participated in
+the development of the relevant commit, and on how many relevant commits
+they participated. They are only displayed if they pass a minimum
+threshold of participation.
+
+For example:
+
+------------
+% git related master..fc/transport/improv
+Junio C Hamano <gitster@pobox.com> (signer: 90%, author: 5%)
+Felipe Contreras <felipe.contreras@gmail.com> (author: 25%, reviewer: 2%)
+Sverre Rabbelier <srabbelier@gmail.com> (author: 17%, acker: 2%, signer: 7%)
+Jeff King <peff@peff.net> (acker: 17%, author: 10%)
+Shawn O. Pearce <spearce@spearce.org> (author: 5%, signer: 2%, cced: 2%)
+Elijah Newren <newren@gmail.com> (author: 10%)
+------------
+
+In addition, it has an option to output the list of commits, instead of the
+contributors, which allows you to easily find out the previous changes to the
+lines your patches modify.
+
+------------
+% git related -c master..fc/transport/improv
+99d9ec0 Merge branch 'fc/transport-helper-no-refspec'
+67c9c78 transport-helper: barf when user tries old:new
+0460ed2 documentation: trivial style cleanups
+126aac5 transport-helper: fix remote helper namespace regression
+21610d8 transport-helper: clarify pushing without refspecs
+a93b4a0 transport-helper: warn when refspec is not used
+664059f transport-helper: update remote helper namespace
+c4458ec fast-export: Allow pruned-references in mark file
+...
+------------
+
+Moreover, when sending patches for review, you can configure `git send-email`
+to use `git related` to find relevant people that should be Cc'ed:
+
+------------
+% git send-email --cc-cmd='git related' *.patch
+------------
+
+== Installation ==
+
+To use this script, simply put `git-related` in your `$PATH` and make sure it
+has executable permissions:
+
+------------
+wget https://raw.github.com/felipec/git-related/master/git-related -O ~/bin/git-related
+chmod +x ~/bin/git-related
+------------
+
+And make sure `~/bin` is in your `$PATH`:
+
+------------
+export PATH="$HOME/bin:$PATH"
+------------
-- 
1.8.4-fc
