From: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
Subject: git 2.6.0 apply --cached failed
Date: Thu, 1 Oct 2015 13:38:17 +0800
Message-ID: <CAHtLG6TxAZsd54g+_eH2R3M=5oZ65V5cJ-0kkBt4vjbga+h9rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 01 07:38:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhWZf-0004hH-SQ
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 07:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbbJAFiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 01:38:20 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34328 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbJAFiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 01:38:18 -0400
Received: by vkat63 with SMTP id t63so33091081vka.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 22:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=pOTTOOck9BOYu27O6oXr7NvGtB4W/5EkUuJvRWHIaa0=;
        b=kH8U0u0k+qkldlG+DgvQRJUTqvPDgA7xSV1aULdX3BbvGpHs9pclcvGCsUK7udpoC2
         1jgfLKd5oVX9aB6nuDJTwhzwHrhIJzwGsv2+cyBxhmb/1T5jtHYy3Hn8PJ15Ddug9vEg
         pAsfCjSN3eJr/OCZEalymBLtr+9oOY7/qbvF9/0cOZNkOJ0Q3LiQyrgAk0q20VhuA9i9
         /3WxLEFDfIO/gsrqDUISK5JntWndrXJNGyNJuBYF/0qCOwL7QT+xA/NI+CQr4m8zgfoZ
         cMoraYWTyXDRz4FexLXrPWmo6bLnoBgs2h8hyumyhtXi2HbylJFmvtlRFjVwY5JYJPqV
         KHwg==
X-Received: by 10.31.9.212 with SMTP id 203mr5749238vkj.74.1443677897963; Wed,
 30 Sep 2015 22:38:17 -0700 (PDT)
Received: by 10.31.9.133 with HTTP; Wed, 30 Sep 2015 22:38:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278887>

Hi,

Using git 2.6.0 on Linux 64-bit
git apply --cached failed

Please test with command with the repository inside the attached tarball.

With git 2.6,
git apply --cached < patch.patch

fatal: corrupt patch at line 27


Expected result: no error

Step to reproduce: Please run the following shell script.

#/bin/sh
set -e
mkdir 2
cd 2

cat > d0c886e2-2cfe-4636-825b-3622fac0b27f <<EOF
0
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
EOF
git init
git status -s -b -u
git diff --numstat --cached --
git diff --numstat --
git update-index --add --stdin <<EOF
d0c886e2-2cfe-4636-825b-3622fac0b27f
EOF
git commit --file=- <<EOF
a commit for d0c886e2-2cfe-4636-825b-3622fac0b27f
EOF
git status -s -b -u
git diff --numstat --cached --
git diff --numstat --
git diff d0c886e2-2cfe-4636-825b-3622fac0b27f
git apply --cached <<EOF
diff --git a/d0c886e2-2cfe-4636-825b-3622fac0b27f
b/d0c886e2-2cfe-4636-825b-3622fac0b27f
index 749b185..1627b6b 100644
--- a/d0c886e2-2cfe-4636-825b-3622fac0b27f
+++ b/d0c886e2-2cfe-4636-825b-3622fac0b27f
@@ -1,8 +1,8 @@
 0
 1
-2
-3
-4
+2!
+3!
+4!
 5
 6
 7
@@ -10,9 +10,9 @@
 9
 10
 11
 12
 13
 14
 15
 16
 17
@@ -20,9 +20,9 @@
 19
 20
 21
-22
-23
-24
+22!
+23!
+24!
 25
 26
 27
EOF
