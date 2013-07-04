From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v9 2/5] t4205: revert back single quotes
Date: Thu,  4 Jul 2013 16:45:47 +0400
Message-ID: <b7ac1f5c14ab4571f06030ab02a33b1489ab4dcd.1372939482.git.Alex.Crezoff@gmail.com>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 14:46:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuivM-0000zZ-83
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 14:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965Ab3GDMqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 08:46:04 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:45092 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901Ab3GDMqA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 08:46:00 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so1192750lbc.3
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=fXSVr+u3KZzdKkB+5gVLb8cbnDqNEe+xVBdwfK2itsc=;
        b=Ni1BXb9lMVQbR4z2jA94B7ubiMELxK366W1HEuaDTE/UrY2Z4Pd5O7cm3+Nd+qQnWu
         9rtC6nybI1/zUfkA+nJ1IKvt5VpIGEmbPK6XakXA3Ew68v/sd8xcV1F3S7ulbYzMh2Pt
         gR+29pCYYyPlp2DtC03wy2vvsmTVKq0rV8BUx27+gk7LRMZqescQlEdgraGRndvVHv3p
         8tLE1F7Vzybfjqm1hSqFvadgvuI6gB3HbMYAmxH1ndjy5+30vaW0vr6nKhkczK0dR97V
         jjsWoUBuSKlizWRwnvA7k1HLKabdw4/HVeLxq7dH9JyPRl2c2O16Z837wEZ9+Q1He07O
         U8Pg==
X-Received: by 10.152.4.194 with SMTP id m2mr2819546lam.23.1372941958675;
        Thu, 04 Jul 2013 05:45:58 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id m1sm1085141lag.3.2013.07.04.05.45.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 05:45:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372939482.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372939482.git.Alex.Crezoff@gmail.com>
References: <cover.1372719264.git.Alex.Crezoff@gmail.com> <cover.1372939482.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229577>

In previuos commit de6029a2d7734a93a9e27b9c4471862a47dd8123 single
quotes were replaced with double quotes to make "$(commit_msg)"
expression in heredoc to work. The same effect can be achieved by using
"EOF" as a heredoc delimiter instead of "\EOF".

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Suggested-by: Johannes Sixt <j.sixt@viscovery.net>
---
 t/t4205-log-pretty-formats.sh | 106 +++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index c283842..ef9770a 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -145,174 +145,174 @@ test_expect_success 'setup more commits' '
 	head4=$(git rev-parse --verify --short HEAD~3)
 '
 
-test_expect_success 'left alignment formatting' "
-	git log --pretty='format:%<(40)%s' >actual &&
+test_expect_success 'left alignment formatting' '
+	git log --pretty="format:%<(40)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 message two                            Z
 message one                            Z
 add bar                                Z
 $(commit_msg)                    Z
 EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'left alignment formatting at the nth column' "
-	git log --pretty='format:%h %<|(40)%s' >actual &&
+test_expect_success 'left alignment formatting at the nth column' '
+	git log --pretty="format:%h %<|(40)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 $head1 message two                    Z
 $head2 message one                    Z
 $head3 add bar                        Z
 $head4 $(commit_msg)            Z
 EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'left alignment formatting with no padding' "
-	git log --pretty='format:%<(1)%s' >actual &&
+test_expect_success 'left alignment formatting with no padding' '
+	git log --pretty="format:%<(1)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	cat <<\EOF >expected &&
+	cat <<EOF >expected &&
 message two
 message one
 add bar
 $(commit_msg)
 EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'left alignment formatting with trunc' "
-	git log --pretty='format:%<(10,trunc)%s' >actual &&
+test_expect_success 'left alignment formatting with trunc' '
+	git log --pretty="format:%<(10,trunc)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 message ..
 message ..
 add bar  Z
 $(commit_msg "" "8" "..*$")
 EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'left alignment formatting with ltrunc' "
-	git log --pretty='format:%<(10,ltrunc)%s' >actual &&
+test_expect_success 'left alignment formatting with ltrunc' '
+	git log --pretty="format:%<(10,ltrunc)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 ..sage two
 ..sage one
 add bar  Z
 $(commit_msg "" "0" ".\{11\}")
 EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'left alignment formatting with mtrunc' "
-	git log --pretty='format:%<(10,mtrunc)%s' >actual &&
+test_expect_success 'left alignment formatting with mtrunc' '
+	git log --pretty="format:%<(10,mtrunc)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 mess.. two
 mess.. one
 add bar  Z
 $(commit_msg "" "4" ".\{11\}")
 EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'right alignment formatting' "
-	git log --pretty='format:%>(40)%s' >actual &&
+test_expect_success 'right alignment formatting' '
+	git log --pretty="format:%>(40)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 Z                            message two
 Z                            message one
 Z                                add bar
 Z                    $(commit_msg)
 EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'right alignment formatting at the nth column' "
-	git log --pretty='format:%h %>|(40)%s' >actual &&
+test_expect_success 'right alignment formatting at the nth column' '
+	git log --pretty="format:%h %>|(40)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 $head1                      message two
 $head2                      message one
 $head3                          add bar
 $head4              $(commit_msg)
 EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'right alignment formatting with no padding' "
-	git log --pretty='format:%>(1)%s' >actual &&
+test_expect_success 'right alignment formatting with no padding' '
+	git log --pretty="format:%>(1)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	cat <<\EOF >expected &&
+	cat <<EOF >expected &&
 message two
 message one
 add bar
 $(commit_msg)
 EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'center alignment formatting' "
-	git log --pretty='format:%><(40)%s' >actual &&
+test_expect_success 'center alignment formatting' '
+	git log --pretty="format:%><(40)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 Z             message two              Z
 Z             message one              Z
 Z               add bar                Z
 Z         $(commit_msg)          Z
 EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'center alignment formatting at the nth column' "
-	git log --pretty='format:%h %><|(40)%s' >actual &&
+test_expect_success 'center alignment formatting at the nth column' '
+	git log --pretty="format:%h %><|(40)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 $head1           message two          Z
 $head2           message one          Z
 $head3             add bar            Z
 $head4       $(commit_msg)      Z
 EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'center alignment formatting with no padding' "
-	git log --pretty='format:%><(1)%s' >actual &&
+test_expect_success 'center alignment formatting with no padding' '
+	git log --pretty="format:%><(1)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	cat <<\EOF >expected &&
+	cat <<EOF >expected &&
 message two
 message one
 add bar
 $(commit_msg)
 EOF
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'left/right alignment formatting with stealing' "
-	git commit --amend -m short --author 'long long long <long@me.com>' &&
-	git log --pretty='format:%<(10,trunc)%s%>>(10,ltrunc)% an' >actual &&
+test_expect_success 'left/right alignment formatting with stealing' '
+	git commit --amend -m short --author "long long long <long@me.com>" &&
+	git log --pretty="format:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	cat <<\EOF >expected &&
+	cat <<EOF >expected &&
 short long  long long
 message ..   A U Thor
 add bar      A U Thor
 $(commit_msg "" "8" "..*$")   A U Thor
 EOF
 	test_cmp expected actual
-"
+'
 
 test_done
-- 
1.8.3.1.15.g5c23c1e
