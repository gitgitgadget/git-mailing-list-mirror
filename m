From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v10 2/5] t4205 (log-pretty-formats): revert back single quotes
Date: Fri,  5 Jul 2013 16:01:47 +0400
Message-ID: <d89f8e7b5900eddf7b60f721b3dcd9dd46c381ca.1373024281.git.Alex.Crezoff@gmail.com>
References: <cover.1373024281.git.Alex.Crezoff@gmail.com>
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 14:02:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv4ia-0004To-6f
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565Ab3GEMCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:02:22 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:43512 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757265Ab3GEMCF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:02:05 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so1999720lbc.17
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 05:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=0DFopuHGxLXnyM5bumlwXkr+jeNwbSjOwX6Fl0/mjo4=;
        b=QO1hwXkwu+xGgnI37uA7fW24o2B/DV5iMwbST+f2Pq1OYybRKNOCSleR6yg2z6TQT6
         YvEPUsk19ApDPv2/isXOwXXWDUwv8Y6c1tWEM+Mpvd5JMuNMd6sEoM4nig5z7N97ck5P
         yz91up3UHAebw7X4ccONkvwfigOdT7x91v5TBBO8n4s7pxjBKTMW8xKFXh4M453Gsikr
         o9d6yKTi9mKbAcqGFA8EY5w5m/8EhW+ok85wIivT8i/ITi6IN7jP9CyR/5pUOS/hHuDs
         BDFkpLMh9/SpzNRTVUABhBYfe2QXg8fZgF5HmfS8b6y0k9WL8yEwnnpbu/iGN5jwtSHE
         EyWw==
X-Received: by 10.112.4.164 with SMTP id l4mr5417531lbl.94.1373025723009;
        Fri, 05 Jul 2013 05:02:03 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id 6sm2809527lbu.13.2013.07.05.05.02.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 05:02:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.16.gb1f0d63
In-Reply-To: <cover.1373024281.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1373024281.git.Alex.Crezoff@gmail.com>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com> <cover.1373024281.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229655>

In previuos commit de6029a (pretty: Add failing tests: --format output
should honor logOutputEncoding, 2013-06-26) single quotes were replaced
with double quotes to make "$(commit_msg)" expression in heredoc to
work. The same effect can be achieved by using "EOF" as a heredoc
delimiter instead of "\EOF".

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
1.8.3.2.16.gb1f0d63
