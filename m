From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: [PATCH] git-p4 submit: prevent 'Jobs' section from being removed from
 p4 change log
Date: Fri, 25 Feb 2011 21:31:13 -0500
Message-ID: <AANLkTimdd_AdVyDGKyLUoOABuRjJ5QmpC3DnMQYRRcNm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>, gitster <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 03:31:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt9wQ-00018y-Fl
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 03:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133Ab1BZCbP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 21:31:15 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:53647 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab1BZCbO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 21:31:14 -0500
Received: by qyg14 with SMTP id 14so1989769qyg.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 18:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=INqzGf6q7nCryG2NY0XqlY5CT19XBR1yLwyqoNEgWUg=;
        b=HAmZEugGEo6di9laoXGRi19kC+MusA4HdLNoVbwQe5guhXVXwp09PCtmDFcyo3w/8q
         E9IByuMDc8jsTOIKTSY1JKI3RgxaeDEPLe+LYgN6uGmIPCgRE28+X7sxe7Nsvs5OS5pD
         wb0FJzSRS5XuDllNpx0L4wCcQCs0Yt5WTGvl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=h/ZAq0/ERhUTLzU13I8N843Ul0OCk/+2lOVMKbKNsWM1ym0qg2b50myq38l2PMVhz7
         BXGzbgU4ZVqrgsl8NFdZvr7lgGbEFY7od2ba4TAr65pRlqK/1V7H71jVXOrWQSjzEkSp
         Pxtbif6xXMZr3YSYZOVrg7HW4uzBNtrVikQ5E=
Received: by 10.224.210.137 with SMTP id gk9mr1254413qab.20.1298687473896;
 Fri, 25 Feb 2011 18:31:13 -0800 (PST)
Received: by 10.229.84.2 with HTTP; Fri, 25 Feb 2011 18:31:13 -0800 (PST)
X-Google-Sender-Auth: -uN3JOGFj94-LllxMRrw_C280fo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167951>

In an attempt to overwrite the 'Description:' section of the p4 change
log to include the git commit messages, it also overwrote the 'Jobs:'
section. =A0This fix restores the 'Job:' section.

Signed-off-by: Michael Horowitz <michael.horowitz@ieee.org>
---
=A0contrib/fast-import/git-p4 | =A0 =A02 +-
=A01 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index a92beb6..8b00fd8 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -570,7 +570,7 @@ class P4Submit(Command):
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue

=A0 =A0 =A0 =A0 =A0 =A0 if inDescriptionSection:
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if line.startswith("Files:"):
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if line.startswith("Files:") or line.s=
tartswith("Jobs:"):
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inDescriptionSection =3D False
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else:
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
--
1.7.4
