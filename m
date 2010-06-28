From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH] Clarify text filter merge conflict reduction docs
Date: Mon, 28 Jun 2010 21:32:50 +0200
Message-ID: <0cd82ad22a6f240ebcde0c2f3a437a805dae5668.1277753114.git.eyvind.bernhardsen@gmail.com>
References: <20100628080234.GA7134@pvv.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Jun 28 21:33:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTK4p-0005Ou-Ki
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 21:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab0F1Tc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 15:32:58 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:45693 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab0F1Tc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 15:32:57 -0400
Received: by wwd20 with SMTP id 20so277240wwd.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=m2N8ZJJiPixaa7JBlOJidXZRhtjIbgRyjQ69NaX0kWk=;
        b=ljiLIz/eO7JH6yb3bGm8QaxUMq8h/JZCp6wmCAKbT53/DGmWFANzurmTs4TCkflb+q
         Rk1yKYkjA3dIVHDQt9uVC6TBnvsOU/qYIWjj4NEiRzNN5OXXw/f9uY9trR44eyWOPVfs
         LZya/iAxi6jmGtljHWQeD1yilfIKWi7/mlnmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l2AXi3k6WxYR3HogMtLaqWVP2m0NZnx846Z3l9s0chD7/gskYJLKfyXVLXXsqfXDx5
         cqGwPaG0jxf+7VFA3rpbh5Dcb3Pm37H7uik9EPYCmw5GWVSLEY+8SP+MU9uHMU3+g42O
         Ru8xlTvV0rWVpPrE3a7TvekZvdwHryqwChLBQ=
Received: by 10.216.174.142 with SMTP id x14mr4188682wel.8.1277753575709;
        Mon, 28 Jun 2010 12:32:55 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id w19sm3904821weq.44.2010.06.28.12.32.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 12:32:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.575.g383de
In-Reply-To: <20100628080234.GA7134@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149854>

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
How does this look?

This commit should really be squashed into the first one in the series.
Live and learn, next time I'll add new changes in a new commit and put
it _last_.  I'll submit a fixed series once we're happy with the
documentation.

- Eyvind

 Documentation/gitattributes.txt |   46 ++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b110082..22400c1 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -317,17 +317,16 @@ command is "cat").
 	smudge = cat
 ------------------------
 
-For best results, `clean` and `smudge` commands should produce output
-that is not dependent on the corresponding command having been run.
-That is, `clean` should produce identical output whether its input has
-been run through `smudge` or not, and `smudge` should not rely on its
-input having been run through `clean`.  See the section on merging
-below for a rationale.
+For best results, `clean` should not alter its output further if it is
+run twice ("clean->clean" should be equivalent to "clean"), and
+multiple `smudge` commands should not alter `clean`'s output
+("smudge->smudge->clean" should be equivalent to "clean").  See the
+section on merging below.
 
-The example "indent" filter is well-behaved in this regard: it will
-accept input that is already correctly indented without modifying it.
-In this case, the lack of a smudge filter means that the clean filter
-_must_ accept its own output without modifying it.
+The "indent" filter is well-behaved in this regard: it will not modify
+input that is already correctly indented.  In this case, the lack of a
+smudge filter means that the clean filter _must_ accept its own output
+without modifying it.
 
 
 Interaction between checkin/checkout attributes
@@ -346,16 +345,23 @@ with `text`, and then `ident` and fed to `filter`.
 Merging branches with differing checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-To prevent unnecessary merge conflicts, git runs a virtual check-out
-and check-in of all three stages of a file when resolving a three-way
-merge.  This prevents changes caused by check-in conversion from
-causing spurious merge conflicts when a converted file is merged with
-an unconverted file.
-
-This strategy will break down if a `smudge` filter relies on its input
-having been processed by the corresponding `clean` filter or vice
-versa.  Such filters may otherwise work well, but will prevent
-automatic merging.
+If you have added attributes to a file that cause the canonical
+repository format for that file to change, such as adding a
+clean/smudge filter or text/eol/ident attributes, merging anything
+where the attribute is not in place would normally cause merge
+conflicts.
+
+To prevent these unnecessary merge conflicts, git runs a virtual
+check-out and check-in of all three stages of a file when resolving a
+three-way merge.  This prevents changes caused by check-in conversion
+from causing spurious merge conflicts when a converted file is merged
+with an unconverted file.
+
+As long as a "smudge->clean" results in the same output as a "clean"
+even on files that are already smudged, this strategy will
+automatically resolve all filter-related conflicts.  Filters that do
+not act in this way may cause additional merge conflicts that must be
+resolved manually.
 
 
 Generating diff text
-- 
1.7.1.575.g383de
