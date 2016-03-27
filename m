From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] git-format-patch.txt: don't show -s as shorthand for multiple options
Date: Sun, 27 Mar 2016 17:26:07 -0400
Message-ID: <1459113967-13864-1-git-send-email-sunshine@sunshineco.com>
Cc: Kevin Brodsky <corax26@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 27 23:26:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akICh-0005pG-My
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 23:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbcC0V0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 17:26:25 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35540 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbcC0V0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 17:26:24 -0400
Received: by mail-ig0-f171.google.com with SMTP id cl4so41605998igb.0
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=svT8vEmiFW0YTqcXTzBDFMslgb2bGWIiNyqjYsZ5yvQ=;
        b=Dka1fLzEQ1h9F4QhXZImzNdHn16ZuAXpLHn1gf+8/E6z3HHeMuyDKTZHGoMnQvL8aS
         v/RD4OjgaV4qmsAvbnzyZ9BtxJSv2gOq80Mtl9DtsiquxorsfROhiDkPcS3CwAkVZoiM
         TxKUPZrYS4HAdoBiuxybYIaHfi1EbdE7ABQBtJ+HAOXeST45LdZLrapLg6/qBCTpr4Fm
         x0RG/WanPdWGvFIH7guO9km4UQVV4lUDG+kkrdHdDiQMrjM3sahMRGwAAztGVY8Ir6Or
         63FnnX+bn5vIGhc85fymI2s1fYi9O4iMS9iaRAraiwfLZpFcRGY2kbgkMk4Zyp/GVNdU
         e0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=svT8vEmiFW0YTqcXTzBDFMslgb2bGWIiNyqjYsZ5yvQ=;
        b=DXZppt3jNVWFnuGSzrSnzANHXOhHFm+UTzS/Hr7+3nhuXpOy0cTqq3QynPCgJKBwcL
         pQY/kGc2QdL5mxVMZ0YM4PH+AulwtYYmXSjH2JyR6ug+MSjaHeg2ZJaWQaKob9ktvMe9
         vB4BYjNoQgJ8LPFbHQRw4pPucRroXlfb0X3FZRwitzEGiZwTOonIEZ/gtaMRT08oWgJy
         u1NGiaIyqf+rUot3UbAFv6/VQr2gbEc9jIj9wVmV5N3Vonhx3zn6AWO4guABgJ0hGocE
         V1Yo1CmUXoZSOfJi37JTGC+9PEVw+8D/FYApSXb/xHHqnZFQvFzXNPXS5/vw0Rybuvb0
         xNoQ==
X-Gm-Message-State: AD7BkJI8qpNSB8dgYVbpb9EFSenLEqyLNQ+hUakiwla+3E4G79uLwqOz+XRpM6WddgWlBg==
X-Received: by 10.50.61.147 with SMTP id p19mr6884148igr.10.1459113983636;
        Sun, 27 Mar 2016 14:26:23 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id b13sm2454784ign.0.2016.03.27.14.26.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 27 Mar 2016 14:26:23 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.285.gc3ac548
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290023>

git-format-patch recognizes -s as shorthand only for --signoff, however,
its documentation shows -s as shorthand for both --signoff and
--no-patch. Resolve this confusion by suppressing the bogus -s shorthand
for --no-patch.

While here, also avoid showing the --no-patch option in git-format-patch
documentation since it doesn't make sense to ask to suppress the patch
while at the same time explicitly asking to format the patch (which,
after all, is the purpose of git-format-patch).

Reported-by: Kevin Brodsky <corax26@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

I haven't quite managed to trace the code yet, but git-format-patch
oddly does recognize --no-patch, and it appears to act as an alias of
--no-stat. At any rate, --no-patch seems rather senseless with
git-format-patch, hence this patch suppresses it in documentation
altogether.

Documentation/diff-options.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 306b7e3..6eb591f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -28,10 +28,12 @@ ifdef::git-diff[]
 endif::git-diff[]
 endif::git-format-patch[]
 
+ifndef::git-format-patch[]
 -s::
 --no-patch::
 	Suppress diff output. Useful for commands like `git show` that
 	show the patch by default, or to cancel the effect of `--patch`.
+endif::git-format-patch[]
 
 -U<n>::
 --unified=<n>::
-- 
2.8.0.rc4.285.gc3ac548
