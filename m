From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 058/144] t5304-prune.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:03 -0700
Message-ID: <1395735989-3396-59-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMiF-0007wX-RG
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbaCYI1s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:48 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:61092 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbaCYI1m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:42 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so131994pbc.16
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wghXD0AjKJky4ZUPsQDdpyHhFOesoLPVTjF2QNrj9oI=;
        b=l9J6SPcmokrRhvSVqobe53Q6NHYsDV47gi+nj29/I5zbDzrCrn5NYdkpZEkbMiXE5Y
         YElIAWFAjwrIxNeuQSw5vxTTfiDNbLRPjHpU9WuwNpnLveegcQ77TFZjFx6Vz1ZtmluU
         kar+XLYQd0IMV0lV3EP8dXtnw1lgtXcNJ3WC3GfsPlh4cLeJhG1uZHFNQ9LGPEbcrJaA
         IyT75ef/sFDSl7BJXlv5LxbOfTGzAd73Pp9muB+1bOdvvA0qpLBEqpkXyo/5G0/tUU7Z
         OHcdVaMzWGhOS0tzekXnnEmTri+tdZ9KvGgoWwg35noeDHtLQuvAEDuHFjJ/Z9a/dji0
         lytw==
X-Received: by 10.68.231.196 with SMTP id ti4mr44120731pbc.48.1395736062037;
        Tue, 25 Mar 2014 01:27:42 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244924>

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
 t/t5304-prune.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 66c9a41..84501a5 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -222,7 +222,7 @@ EOF
 '
=20
 test_expect_success 'prune .git/shallow' '
-	SHA1=3D`echo hi|git commit-tree HEAD^{tree}` &&
+	SHA1=3D$(echo hi|git commit-tree HEAD^{tree}) &&
 	echo $SHA1 >.git/shallow &&
 	git prune --dry-run >out &&
 	grep $SHA1 .git/shallow &&
--=20
1.7.10.4
