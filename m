From: Jay Soffian <jaysoffian@gmail.com>
Subject: combined diff seems to ignore diff attribute
Date: Tue, 7 Sep 2010 20:33:02 -0400
Message-ID: <AANLkTinbaQbS=pU44sSCf7+_3bLrREpehYQCiV5CFuVB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 08 02:33:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot8bc-0000AA-EP
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 02:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860Ab0IHAdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 20:33:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38687 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab0IHAde (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 20:33:34 -0400
Received: by iwn5 with SMTP id 5so5784231iwn.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 17:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=dwkDVm8oOetZYQEPPgEiqJUdypPZIQANYPwa/GO1qCg=;
        b=CdfD6CORbYoe0eFP6iE/zfO1G/soJ+jrEyc6mi2V9NRCCrYhx2zJPjs9/j7zVP8MaM
         ccg6JQDew7C7H/i9BaKMe30E+Cnr823ed8McXDKTnRWJ7QvGhzlFJuOY0dmmcgaxzGh+
         WeON7EpETYbKjkXYOfhBTQGTBvt0gFDb6N5G8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=SKa3sPGmwDlXGHxBRkruJVbS7VrfhwF+vofOtjEFoePjkKQ9WDfwDn/IlGqIRkye4L
         oTHOi7CusYPMID0ojhJBzSJIfZCzbBMZvzlfPJWifPbxMbbq7iKt/JLGTmOCxJmrQEqf
         IVo9Q28i96cq3prS3vQtO+0VfXLQPViy0H38c=
Received: by 10.231.157.195 with SMTP id c3mr1278800ibx.155.1283906014135;
 Tue, 07 Sep 2010 17:33:34 -0700 (PDT)
Received: by 10.231.44.208 with HTTP; Tue, 7 Sep 2010 17:33:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155751>

I want to squelch the output of a particular file type because it's
too noisy (Mac OS X xib files). So I added:

*.xib -diff

to .git/info/attributes

which works fine except for --cc output. Is this a bug, oversight, or
my stupidity?

$ git log -p --cc
commit fdffb6081c2c09f55e2fdb6a02905054484965ed
Merge: 947da38 dcce084
Author: Jay Soffian <jaysoffian@gmail.com>
Date:   Tue Sep 7 20:28:44 2010 -0400

    Merge branch 'side'

    * side:
      side

    Conflicts:
        file.xib

diff --cc file.xib
index 1f7391f,2299c37..0f8f0c9
--- a/file.xib
+++ b/file.xib
@@@ -1,1 -1,1 +1,1 @@@
- master
 -side
++master side

commit dcce0846b493edc0ab4301fae6c3910a6dd31ed8
Author: Jay Soffian <jaysoffian@gmail.com>
Date:   Tue Sep 7 20:28:17 2010 -0400

    side

diff --git a/file.xib b/file.xib
index e69de29..2299c37 100644
Binary files a/file.xib and b/file.xib differ

commit 947da38b8ec84527aa60c0e8bca7279e6b2bb0af
Author: Jay Soffian <jaysoffian@gmail.com>
Date:   Tue Sep 7 20:28:09 2010 -0400

    master

diff --git a/file.xib b/file.xib
index e69de29..1f7391f 100644
Binary files a/file.xib and b/file.xib differ

commit 419c5c0dc0ae4d548227d85ded2d8abc42001720
Author: Jay Soffian <jaysoffian@gmail.com>
Date:   Tue Sep 7 20:27:49 2010 -0400

    initial

diff --git a/file.xib b/file.xib
new file mode 100644
index 0000000..e69de29
