From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/9] rm: add --staged option
Date: Thu, 29 Aug 2013 13:14:34 -0500
Message-ID: <1377800080-5309-4-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
 <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:20:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6pI-0004lO-HB
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756499Ab3H2SUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:20:06 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:50873 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295Ab3H2SUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:20:04 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so1070712oag.8
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cgGNg6iL73Z/eeNgkG+FPWDUhJKSkw8Boo6R9JoegUQ=;
        b=d1wqmsRwReLYHsfwN4BmWzbdLGwQ/37qSkYtIscRTnR+fl2krAr0C3XhZ0Aeb2OpUr
         bGjq9oP5LI4H2+eLpXxIuHxpltzs34+aRtLo5Tkq7bhVk2ALCrInE+B9E11PGVQz8eLb
         NwYV1CMlmubTxqGYpg6k7jCkLf33gEi7HWBTcyvW1ipeIatDiSZ9hIpvbwe6DhMAxBzu
         D4E8st+6i13ZT/Ya68Ag/SRwRMznXhUJQqeuc7W6HEFgpcluPU2KC8prX1wlTnQ1u+NV
         g7Qp03MCzFA68f6g3+NNVgaTuwRVYVSxxNIt2eSejhkY/Gb709wg+c4ol5Yi5gA18yTn
         ZeUQ==
X-Received: by 10.60.50.168 with SMTP id d8mr1522758oeo.77.1377800403458;
        Thu, 29 Aug 2013 11:20:03 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ps5sm33847450oeb.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:20:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233312>

Synonym for --cached.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-rm.txt | 5 ++++-
 builtin/rm.c             | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 1d876c2..156b40d 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -8,7 +8,7 @@ git-rm - Remove files from the working tree and from the index
 SYNOPSIS
 --------
 [verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...
+'git rm' [-f | --force] [-n] [-r] [--cached | --staged] [--ignore-unmatch] [--quiet] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -60,6 +60,9 @@ OPTIONS
 	Working tree files, whether modified or not, will be
 	left alone.
 
+--staged::
+	Synonym for --cached.
+
 --ignore-unmatch::
 	Exit with a zero status even if no files matched.
 
diff --git a/builtin/rm.c b/builtin/rm.c
index 0df0b4d..919911f 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -268,6 +268,7 @@ static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__QUIET(&quiet, N_("do not list removed files")),
 	OPT_BOOLEAN( 0 , "cached",         &index_only, N_("only remove from the index")),
+	OPT_BOOLEAN( 0 , "staged",         &index_only, N_("only remove from the index")),
 	OPT__FORCE(&force, N_("override the up-to-date check")),
 	OPT_BOOLEAN('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
-- 
1.8.4-fc
