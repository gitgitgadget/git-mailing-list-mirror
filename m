From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 019/144] t1002-read-tree-m-u-2way.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:24 -0700
Message-ID: <1395735989-3396-20-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:37:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMrT-0002TC-3w
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbaCYI1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58904 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbaCYI1B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:01 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so131542pbb.19
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tWRYKJGh99nLGHrAL+/2p/OI61kTUAt1LLWTziwqMr0=;
        b=Yf45I0zlUqOStNoJG6u6S//+GLcelfpCA24jbiXZrLqKcJwJhpR+60Erw55rl4Z1Qw
         Rb4trh4HwSXN89F6aIeSk2P1ECYfCfK7/urcdDTKklzoYMEbPubypDFzMUanEszkYbxB
         wbuuTY+ekjQ4McAeXY+qbmbZzi9b5sxfhBWJ2Ia4y8rEPTEnzE2zK8WFQ8LEPs0pxZZz
         WfcHXmUpSMv3qxcQ3eM+BB+DEeeyDDv4S1W/caEKA6AVtQ91v09k2e275lbxxuhQwf0T
         klPF/UHYQcsEGTFjdawG4ymVValraCFDGIt3eXbFcvZAkAzTRf2RW1NMBsb+gM6GdbWi
         1mLA==
X-Received: by 10.67.24.1 with SMTP id ie1mr14381242pad.133.1395736020872;
        Tue, 25 Mar 2014 01:27:00 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245005>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t1002-read-tree-m-u-2way.sh |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way=
=2Esh
index a847709..fed877b 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -21,7 +21,7 @@ compare_change () {
 }
=20
 check_cache_at () {
-	clean_if_empty=3D`git diff-files -- "$1"`
+	clean_if_empty=3D$(git diff-files -- "$1")
 	case "$clean_if_empty" in
 	'')  echo "$1: clean" ;;
 	?*)  echo "$1: dirty" ;;
@@ -41,14 +41,14 @@ test_expect_success \
      echo bozbar >bozbar &&
      echo rezrov >rezrov &&
      git update-index --add nitfol bozbar rezrov &&
-     treeH=3D`git write-tree` &&
+     treeH=3D$(git write-tree) &&
      echo treeH $treeH &&
      git ls-tree $treeH &&
=20
      echo gnusto >bozbar &&
      git update-index --add frotz bozbar --force-remove rezrov &&
      git ls-files --stage >M.out &&
-     treeM=3D`git write-tree` &&
+     treeM=3D$(git write-tree) &&
      echo treeM $treeM &&
      git ls-tree $treeM &&
      sum bozbar frotz nitfol >M.sum &&
@@ -318,7 +318,7 @@ test_expect_success \
     'rm -f .git/index &&
      echo DF >DF &&
      git update-index --add DF &&
-     treeDF=3D`git write-tree` &&
+     treeDF=3D$(git write-tree) &&
      echo treeDF $treeDF &&
      git ls-tree $treeDF &&
=20
@@ -326,7 +326,7 @@ test_expect_success \
      mkdir DF &&
      echo DF/DF >DF/DF &&
      git update-index --add --remove DF DF/DF &&
-     treeDFDF=3D`git write-tree` &&
+     treeDFDF=3D$(git write-tree) &&
      echo treeDFDF $treeDFDF &&
      git ls-tree $treeDFDF &&
      git ls-files --stage >DFDF.out'
--=20
1.7.10.4
