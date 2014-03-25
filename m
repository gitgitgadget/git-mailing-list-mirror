From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 001/144] check-builtins.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:06 -0700
Message-ID: <1395735989-3396-2-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:26:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMh7-0006cP-0a
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbaCYI0n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:26:43 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:34623 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbaCYI0h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:37 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so131922pbc.27
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jPDgvnt+Yh/8uPAT+CUWbSuvghR4U1n0609Xlx+BqTQ=;
        b=NJmoN///OFTKpbzAreg7c4sCI9aw95pYN5UBD+kvN7irJlEzpWrEMMHrKMpBvfX+9c
         1C4u//Tn1tjm/lhlBIBNe5auii2WxXC8rP0kjcfptnVGRu0t+oY2GI0lwGgLiJQ4dCdV
         ytWa+AzhYEpuy4UxCXuHENXijwADeF3czqvB3e3GWtsfheEaD84ZhobaRlbZNcJeUudP
         vB7IdXdNLLoRk36aQ/hVB5nqBJNK4ehJrcATkOXgEWCyV/0Rt4ZazZ7cYDREIAjIc8oo
         keHmm1PkAAsDe5+cCZb5Nhc0PG4+Y7iWjqaBw+91mStsBRgPxxakqt+zpWe518gyNioq
         KYkQ==
X-Received: by 10.66.231.40 with SMTP id td8mr76978127pac.103.1395735997059;
        Tue, 25 Mar 2014 01:26:37 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244909>

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
 check-builtins.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/check-builtins.sh b/check-builtins.sh
index d6fe6cf..07cff69 100755
--- a/check-builtins.sh
+++ b/check-builtins.sh
@@ -14,8 +14,8 @@ sort |
     bad=3D0
     while read builtin
     do
-	base=3D`expr "$builtin" : 'git-\(.*\)'`
-	x=3D`sed -ne 's/.*{ "'$base'", \(cmd_[^, ]*\).*/'$base'	\1/p' git.c`
+	base=3D$(expr "$builtin" : 'git-\(.*\)')
+	x=3D$(sed -ne 's/.*{ "'$base'", \(cmd_[^, ]*\).*/'$base'	\1/p' git.c)
 	if test -z "$x"
 	then
 		echo "$base is builtin but not listed in git.c command list"
--=20
1.7.10.4
