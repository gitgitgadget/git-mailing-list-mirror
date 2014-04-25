From: Marius Ungureanu <marius.ungureanu@xamarin.com>
Subject: [PATCH] Updated C# userdiff patterns.
Date: Sat, 26 Apr 2014 02:25:28 +0300
Message-ID: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 01:25:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdpUk-000534-KO
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 01:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbaDYXY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 19:24:57 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:44323 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaDYXY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 19:24:56 -0400
Received: by mail-ee0-f48.google.com with SMTP id b57so3138744eek.35
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 16:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xamarin.com; s=google;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=dbwE5owwIQTVAKlcav+1LITU3mszG8QL6WlP0ATpvB0=;
        b=OPiIaRZlZ6T2uft0J7p+HE92u1DRkfKEKMjx1+fbzLr/JS8X+a0qKy0N7t7iZKJtNt
         mKZpXA7DVnbL0pi6qcdeq/LRyqy+dRwAaV52eGuTUXGNd2UYNZKq0x/qwFYIYApM4IvD
         1qFdLSWzCcjxfT6qhFycCjyLYf6CaYDGsusYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:content-transfer-encoding
         :subject:message-id:date:to:mime-version;
        bh=dbwE5owwIQTVAKlcav+1LITU3mszG8QL6WlP0ATpvB0=;
        b=Hv9XL+10dq6evqMasus9ixpygyYGa4fZHvYmZVuz6S0pFE6ygD/+trVVIUAndVW/BG
         SNLJR+JnCzaUw+tZlI4CB0yk0f7auMi21U6sjMRI/HhKBgXXGcIpleh9eXJ84WJNMLtA
         1hZqVVa6PwmFD1+ST/V50dEXxqzuRg27AZMagY0h5VwUfq8IfO6r1sP/TzjKIO5lCx+I
         x2pPwCZEQ1j7OOtLYShGeUEMdUdf2fLIXBZIUsw2ZDoZvVpHg11ecW6khDf1r/wpQfab
         eKSDR61HEkSgLAAbl0dmfxD+1k0z5hnEXZZGD0Fx0YcpZIefD/znPQm2Gu4BDXNd4zP3
         G7iA==
X-Gm-Message-State: ALoCoQnbpDX/YrcCezrbi6+WQEKipZ9vXGGOoIT8jib84klLTmxPAHpiBPZo8sH+OL+tKdCnB/yM
X-Received: by 10.14.88.199 with SMTP id a47mr13358181eef.6.1398468294896;
        Fri, 25 Apr 2014 16:24:54 -0700 (PDT)
Received: from [192.168.1.101] ([188.26.30.123])
        by mx.google.com with ESMTPSA id 48sm28510386eei.24.2014.04.25.16.24.53
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 16:24:54 -0700 (PDT)
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247133>

New keywords: foreach, break, in, try, finally, as, is, typeof, var,
default, fixed, checked, unchecked, this, lock, readonly, unsafe,
ref, out, base, null, delegate, continue.

Removed keywords: instanceof. It's only in Java.
Moved keywords to happen before modifier parsing, as matching a keyword
will stop modifiers from being matched.

Added method modifiers: extern, abstract.

Added properties modifiers: abstract.

Added parsing of events and delegates, which are like properties, but
take an extra keyword.

The reasoning behind adding unsafe to keywords is being also a
statement that can happen inline in code to mention blocks which are
unsafe. Also, delegates are not necessarily declared in class bodies,
but can also happen inline in other functions.

Keywords are based on MSDN docs.

Signed-off-by: Marius Ungureanu <marius.ungureanu@xamarin.com>
---
 userdiff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index fad52d6..7612c5d 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -133,14 +133,14 @@ PATTERNS("cpp",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
 PATTERNS("csharp",
-	 /* Keywords */
-	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
 	 /* Methods and constructors */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
-	 /* Properties */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
+	 "^[ \t]*(((abstract|extern|internal|new|override|private|protected|public|sealed|static|unsafe|virtual)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
+	 /* Properties, events, delegates */
+	 "^[ \t]*(((abstract|internal|new|override|private|protected|public|sealed|static|unsafe|virtual)[ \t]+)*((delegate|event)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
 	 /* Type definitions */
-	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
+	 "^[ \t]*(((abstract|internal|new|override|partial|private|protected|public|sealed|static|unsafe)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
+	 /* Keywords */
+	 "!^[ \t]*(as|base|break|case|catch|checked|continue|default|delegate|do|else|finally|fixed|for|foreach|if|in|is|lock|new|null|out|readonly|ref|return|switch|this|throw|try|typeof|unchecked|unsafe|using|var|while)\n"
 	 /* Namespace */
 	 "^[ \t]*(namespace[ \t]+.*)$",
 	 /* -- */
-- 
1.8.4
