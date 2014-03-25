From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 068/144] t5522-pull-symlink.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:13 -0700
Message-ID: <1395735989-3396-69-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:32:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMmG-0004SA-JD
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbaCYIbw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:31:52 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:41134 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbaCYI1w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:52 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so130629pbb.26
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hCuqt2AdPxiFJEWQbaA5FUNJoODRXrc5d3tbM/eabOg=;
        b=KeLkrHKubxqI5Oviou+zutJz4O349TOVcBErID4lJrfU9xGvCozcxcMB1+g+8+dlc4
         ZI+ho6yDq1OXEKc5rldhPsii/GJmFoUqED+Vn/B1TQ6icVRR9Owbzn+WHwKbVmG4x9ed
         tbyZSGq0uR6/hP/fHKhnXuVyn1epHsMdiXBYZu8MLqX8/PhTI07J7h/XetI4mZHhA+Tz
         YmwSVOttRsIQ0f7eGrN2/kfNaWlPqLzU5glmkFguo7NX5wUZRKnELlbMzHQrkIlZAsVQ
         zuDs+g2uX38L4ep3vWE9E40NhHWtnzIeCSxC/CYbtTLEz16LXTBTnwk9EH0fODmwuJBu
         lhyw==
X-Received: by 10.68.244.229 with SMTP id xj5mr78742248pbc.108.1395736071874;
        Tue, 25 Mar 2014 01:27:51 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244966>

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
 t/t5522-pull-symlink.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5522-pull-symlink.sh b/t/t5522-pull-symlink.sh
index 8e9b204..bcff460 100755
--- a/t/t5522-pull-symlink.sh
+++ b/t/t5522-pull-symlink.sh
@@ -54,7 +54,7 @@ test_expect_success SYMLINKS 'pulling from real subdi=
r' '
 # git rev-parse --show-cdup printed a path relative to
 # clone-repo/subdir/, not subdir-link/.  Git rev-parse --show-cdup
 # used the correct .git, but when the git pull shell script did
-# "cd `git rev-parse --show-cdup`", it ended up in the wrong
+# "cd $(git rev-parse --show-cdup)", it ended up in the wrong
 # directory.  A POSIX shell's "cd" works a little differently
 # than chdir() in C; "cd -P" is much closer to chdir().
 #
--=20
1.7.10.4
