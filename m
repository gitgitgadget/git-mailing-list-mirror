From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/10] shell helpers usage: always send help to stderr
Date: Fri, 29 Apr 2016 17:40:39 -0700
Message-ID: <1461976845-18228-5-git-send-email-sbeller@google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:41:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awIy1-0006bS-Qb
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 02:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbcD3Ak6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 20:40:58 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35211 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbcD3Akz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 20:40:55 -0400
Received: by mail-pf0-f175.google.com with SMTP id 77so21988335pfv.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 17:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NKsKnpU6PVlyGE7VT7XmmwZeGPR4t4u0DLrhc8qcopk=;
        b=WEotFr3cVgVFZDpUQWaYNefgqX7LdYmc/PxVl7U8+33c5NeROfLXIbJnWbQP/jsAPu
         1WkgDasTnBt3c4xkZb+bb4jSXmkxSqb7X4MPHl4g9YY09CIhSIRP0iImtnp5F8PsShjj
         ntYgPJc/Z5tx1oFrMAp/K2zww+N8IEnpFSyH43vtcqa4snS/36ReoNp2HosoUUhHf53W
         cG/rj6Rjx9hWpEQcTJsEnGWKlyKC1DO9Xbvcu1c0NcPzA1gKevn0YQ6CAIiNhfecmYTu
         usvhdxUwL06Aza38fWz/VNRcXoT1L5S4OUrAYM9BaRMZ9aKa0cZd7iVhSpBx9kdRu1Ry
         AGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NKsKnpU6PVlyGE7VT7XmmwZeGPR4t4u0DLrhc8qcopk=;
        b=bqsev6m9Cf3xTN+b5ITsPZO0Y47QMJWFzbWEAgs+kF/4DZ3fnxClLllLCkRjyskqmz
         aUtuuIZIDAuRygp8osZfmLNXRU0LnLiL67N3oV90kWyo90gV5UkB7zOIH+kR1A9smnj+
         qC7Kxwsn7EWuy0t+45FjRgiCTCmyUSklj3WPAYY/PbV2f2mb4nEYobEBrwPotLJnYDrz
         DZwV3APIucRNNdwHz8yiNSIBwaScCTvVT7MjexWajGrM8Tz50PNCYHcnVYFc1lP/OvGe
         pH2PcRKxEsOzj58vFcSR2R3JhBz51RSpYwTCFXphLY+HiLvtZZKxw6320ZurAbE0pjCM
         FWSQ==
X-Gm-Message-State: AOPr4FXfq9+9jWPTD+8puDFmzj3y4kMdRvKisRMBI/Rb0RfWdMCzFjask/JNJiQwfBRZ5Wd0
X-Received: by 10.98.19.131 with SMTP id 3mr33277167pft.17.1461976855017;
        Fri, 29 Apr 2016 17:40:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id ee5sm26659815pac.35.2016.04.29.17.40.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 17:40:54 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461976845-18228-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293089>

`git submodule asdf` would trigger displaying the usage of the submodule
command on stderr, however `git submodule -h` would display the usage on
stdout. Unify displaying help for shell commands on stderr.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-sh-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c48139a..5c02446 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -65,7 +65,7 @@ say () {
 
 if test -n "$OPTIONS_SPEC"; then
 	usage() {
-		"$0" -h
+		"$0" -h 1>&2
 		exit 1
 	}
 
-- 
2.8.0.32.g71f8beb.dirty
