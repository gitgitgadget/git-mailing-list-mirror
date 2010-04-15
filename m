From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Document new "already-merged" rule for branch -d
Date: Thu, 15 Apr 2010 02:25:38 -0500
Message-ID: <20100415072438.GA13394@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 09:25:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2JSF-0002V8-L1
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 09:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655Ab0DOHZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 03:25:35 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57655 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab0DOHZe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 03:25:34 -0400
Received: by gwaa18 with SMTP id a18so590629gwa.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 00:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=wrrLtOusrae9+31r9tacIiy6KUxxIeZ/AnxV3IJACmQ=;
        b=iFP6FJmX/pVJoaQ0h4GqSc4R4Ayz+3G1MRpiQpr32TLe+axDlE8CDSJQ/Z7uU/wIqc
         Frj19V/4g8boDpT0ZONSorX4JFTQZQ0kb8JrPUFOhNj/Y667bIyG5fC/JUX8geQisp9G
         WJq4GzbRwQPpwhftLbbQwhbGGmBPrE61RlYik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=USxmtfcobeAqzBZuv27qDHIWrbsRC8ztBGsRTQ8RUwzB5A5Qb10vm2BldrTcWOwVnt
         C5ECKXGqX7GVuzVJL+scSAPYyt8JrLVaKjCctU3SLE7TAE03IqI9+Onz7287wA/9Aegc
         eN6pWhHv3FlMzQ6pdRFGTndQcelOjVEib3QHw=
Received: by 10.101.3.35 with SMTP id f35mr14510166ani.129.1271316333237;
        Thu, 15 Apr 2010 00:25:33 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm798328iwn.13.2010.04.15.00.25.32
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 00:25:32 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144956>

v1.7.0-rc0~18^2 (branch -d: base the "already-merged" safety on the
branch it merges with, 2009-12-29) taught =E2=80=98git branch=E2=80=99 =
a new heuristic
for when it is safe to delete a branch without forcing the issue.  It
is safe to delete a branch "topic" without second thought if:

 - the branch "topic" is set up to pull from a (remote-tracking,
   usually) branch and is fully merged in that "upstream" branch, or

 - there is no branch.topic.merge configuration and branch "topic" is
   fully merged in the current HEAD.

Update the man page to acknowledge the new rules.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I was looking in the documentation for a way to disable the new
behavior.  But that was the wrong idea --- better to see what it=E2=80=99=
s
like to get used to it first.

 Documentation/git-branch.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index d78f4c7..1940256 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -63,7 +63,9 @@ way to clean up all obsolete remote-tracking branches=
=2E
 OPTIONS
 -------
 -d::
-	Delete a branch. The branch must be fully merged in HEAD.
+	Delete a branch. The branch must be fully merged in its
+	upstream branch, or in `HEAD` if no upstream was set with
+	`--track` or `--set-upstream`.
=20
 -D::
 	Delete a branch irrespective of its merged status.
--=20
1.7.1.rc1
