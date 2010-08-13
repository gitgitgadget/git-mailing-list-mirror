From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: BUG: git log: fatal: internal error in diff-resolve-rename-copy
Date: Fri, 13 Aug 2010 15:25:57 +0400
Message-ID: <AANLkTikPhWgeeLBV3dbLZ5UM3UDmkOmpqrmwqPmGfn7Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 13 13:26:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjsP2-0002Ek-ND
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 13:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958Ab0HML0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 07:26:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44086 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab0HML0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 07:26:03 -0400
Received: by gyg10 with SMTP id 10so862673gyg.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 04:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=fqhYNlpSChDFYhwQgyWceeLcm39tEiCeRjGUhjp/TGQ=;
        b=i3dFJUeSAutlKc3qALOzh7YyM+ow+KjGGKRuQT+rGe/1upMB8SLvZExVxt9no1Q6s2
         JZz9t2xIcg0OUgpKnrxFI0YjgYrTEmMXbu/0TCNJ6q/mrzL0iXvBFfGhaUIhSyXqoVQe
         v0eZmBkhWVCMDB3Oc2fJUh9ub909AjEpjpxq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=PGUuLr1iMUPdm0CODqeD2N6O/zCVC+wIeynQXnNOrOHRbyShq0C4+wJy9AJBWKUefz
         5EE44dJsX161lTJRg4d1zKMJORlWXLhK9uw07pdhanOss8dOOsQ8BTeNIRN9WrOaloPZ
         X71MzzZowK2idCeQ7F+dtT5Si/81jUUGiGiBg=
Received: by 10.231.183.200 with SMTP id ch8mr1528941ibb.124.1281698757292;
 Fri, 13 Aug 2010 04:25:57 -0700 (PDT)
Received: by 10.231.174.69 with HTTP; Fri, 13 Aug 2010 04:25:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153470>

Somewhere between the git 1.7.0.2 and the git 1.7.2.0 the rename
detection started to fail with fatal error on some files in our
repository. The bug could be seen on the public IntelliJ IDEA
repository (about 760M in size), but our users have reported it as
well.

To reproduce the error, run the following sequence of the commands:

git clone git://git.jetbrains.org/idea/community.git idea
cd idea
git log -M --follow --name-only --
platform/lang-api/src/com/intellij/lang/documentation/CompositeDocumentationProvider.java

As result "fatal: internal error in diff-resolve-rename-copy" is
written on stderr. This is somewhat unexpected result. Git 1.7.0.2 and
1.6.5.2 seems to work without visible problems.

Regards,
Constantine
