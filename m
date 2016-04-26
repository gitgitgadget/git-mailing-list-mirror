From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/15] submodule deinit: loose requirement for giving '.'
Date: Tue, 26 Apr 2016 13:50:25 -0700
Message-ID: <1461703833-10350-8-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9wk-0006WI-OR
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbcDZUuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:50:55 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33883 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbcDZUuy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:50:54 -0400
Received: by mail-pa0-f45.google.com with SMTP id r5so11013045pag.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DMpnLgv2ACnL+BGi2gbmyj8z+0m11zkBsieIuMBGv34=;
        b=WR/13Ppl2npH+myYQpJJ9rIrA5LAe8erioOdeiaGm2GVMaT3qonutuXBDdwprmc0p3
         C7XuufwQZwKBwR1uFXY7w8JVCvT3xm79I4msI0yylAACr6QW/RA0HQQO7Ub7OWkOXh/7
         cWbKHAP0lO/EWeCFz6vS9CgdKWOHADmT4OlpQGH0W5QnkbfRAm/AuK2hIaOIp6LkGIE7
         FUQEh1SBEyK5gd9oqit/P0p0ezHxHH3StNATywV3aN6/L+zzsvaaQlA8nsxH5kJ78fV/
         RQtqmVASZ7dEpbTNAis+bZd4lZ/mQU8b3i4tpY6y/8hY315fbfaor+l7mWbzmKVZmqb7
         9RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DMpnLgv2ACnL+BGi2gbmyj8z+0m11zkBsieIuMBGv34=;
        b=SDf0UPT8R04gNC51KD/ef7ctVZG+M8DWYexCjLDlY0jGN7IMwSQuSIilYUKgnmHOur
         XEay6tZQ3w6L6BfVDEsiHX3GJT527ZzXEC1bXjI1vDn6iWQAyorNkdahi7aGcT0jiIgk
         c0E3MngRbxbnLWYvo+Z2EEqFRsc794RIbtd1y1akq19y/TmvITmClT7DpAw3j9jBK57M
         eDO9zPw6KRHHNS20I6gRmEv90jMIC7QMx3oJ8ecaBdETXm7a2LPnYlC7QVTjIfn1lVlM
         NLKQCG0NRyvVUia+8V4mkj4JSFJH0ZWhMBpykfz93xm99ioLYP1+vEAVW3m3NaRX/i0O
         WLfw==
X-Gm-Message-State: AOPr4FVZJ5Za1f8Nk1CszAQmRgQyk7CUPXUFeAZRDq1Sx7eFopxS1SQ8REy3GFytsDgxM10D
X-Received: by 10.66.160.201 with SMTP id xm9mr6505722pab.68.1461703853911;
        Tue, 26 Apr 2016 13:50:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id hk7sm690781pad.25.2016.04.26.13.50.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:50:53 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292673>

This is needed later to make a distinction between 'all specified'
and the default group of submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh           | 5 -----
 t/t7400-submodule-basic.sh | 1 -
 2 files changed, 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d7a5e1a..253ad07 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -440,11 +440,6 @@ cmd_deinit()
 		shift
 	done
 
-	if test $# = 0
-	then
-		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
-	fi
-
 	git submodule--helper list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e9d1d58..ac477b2 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -932,7 +932,6 @@ test_expect_success 'submodule deinit . deinits all initialized submodules' '
 	git submodule update --init &&
 	git config submodule.example.foo bar &&
 	git config submodule.example2.frotz nitfol &&
-	test_must_fail git submodule deinit &&
 	git submodule deinit . >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
-- 
2.8.0.41.g8d9aeb3
