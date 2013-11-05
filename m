From: chunguang qu <quchunguang@gmail.com>
Subject: error when git-diff get pipe args
Date: Tue, 5 Nov 2013 08:03:28 +0800
Message-ID: <CABk77Dj6RUaY9bBShiUJkZp0SdURCNR0SbpS3HFXdmeEAOMYow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 05 01:05:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdU7K-0000H2-3F
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 01:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab3KEADa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 19:03:30 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:48748 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab3KEADa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 19:03:30 -0500
Received: by mail-wg0-f46.google.com with SMTP id m15so2756724wgh.13
        for <git@vger.kernel.org>; Mon, 04 Nov 2013 16:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=FStE+iWHzmAHNv+fteDd4JczkKH2qee1Y+VOC50dT9E=;
        b=l1xEKhSuCLO0ntJWmvR4g09gSEiLgS95ap3efZav8P++l7xJcL5mq0hCrBo7LJoQoh
         4M6hULHhhqfw0GtJbNZPKEb2iYg9nVuNini+Y7gN7e0AEat2ki5zdPqGDwQl6HAstif7
         7UP+i0XbUvI3tVzISkN0QnV34vEcr7d3Fn/kxTMRbG0SuBmTMj6deN9d14fCuHaKHWwu
         k3BEufClZ0RGXhTZo42BCWJdKVBU+FJuQEe1w8isA2nn1is2chAuJiV4EIOhvH8zq0Uz
         oa2iPGUmY+bT404mXyqElB7sG7wrtAIxBFiimJ2iFLkfRCiPr7lD9lxNpMb1+/Fy+LZz
         8P9w==
X-Received: by 10.180.38.99 with SMTP id f3mr14306561wik.40.1383609808587;
 Mon, 04 Nov 2013 16:03:28 -0800 (PST)
Received: by 10.227.165.5 with HTTP; Mon, 4 Nov 2013 16:03:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237315>

$ cat a
111
fdsf
333
$ cat b
111
222
333
$ git diff a b                             # OK
diff --git a/a b/b
index 768560b..641d574 100644
--- a/a
+++ b/b
@@ -1,3 +1,3 @@
 111
-fdsf
+222
 333
$ git diff <(cat a) <(cat b)          # ERROR: no result print out
diff --git a/dev/fd/63 b/dev/fd/62
index 311e262..554e9f4 120000
--- a/dev/fd/63
+++ b/dev/fd/62
@@ -1 +1 @@
-pipe:[729963]
\ No newline at end of file
+pipe:[729965]
\ No newline at end of file

# compare with diff
$ diff -u a b                            # OK
--- a 2013-11-05 00:18:17.394805923 +0800
+++ b 2013-11-05 00:18:25.546805865 +0800
@@ -1,3 +1,3 @@
 111
-fdsf
+222
 333
$ diff -u <(cat a) <(cat b)         # OK: get result in same case
--- /dev/fd/63 2013-11-05 01:02:59.706787117 +0800
+++ /dev/fd/62 2013-11-05 01:02:59.706787117 +0800
@@ -1,3 +1,3 @@
 111
-fdsf
+222
 333
