From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: git-p4 issue
Date: Thu, 24 Feb 2011 16:12:31 -0500
Message-ID: <AANLkTi=2evJB9Pffoo43bB6+qjUsG71t4o=pqHcu2Hzu@mail.gmail.com>
References: <AANLkTikXHJqmzZDv6NhujHqjUFva-uCRB3td306vi=WX@mail.gmail.com>
	<AANLkTi=b60kqd6fRXzf39BBepLOeA3ts6EN3AuY0iAp4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 24 22:12:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsiUN-0003AD-J9
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 22:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437Ab1BXVMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 16:12:33 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55205 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202Ab1BXVMc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 16:12:32 -0500
Received: by qwd7 with SMTP id 7so776676qwd.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 13:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=qB36+/wszJPPZHTNGtjLCKv0ZLw8BCDqYhKJ8WAshmw=;
        b=bqKtBdOhC2Ei8e8hcrh+wbvN2236XSXZVbgvT4u8oRxsxFnq/5oyZFIEKP6h2wwUsr
         0Bj6sbCTQbPaOLYSmXcsxAnaEhot/ZzOpOjaS1R0SEtKdwIRP3s4VgQzIfckXcPPJshd
         z382IyfG35EX5o7hEgP6UwnFHH1pzHTx+qV9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        b=HYPfpnr/5w++cmYT2L95YdgncjWz+1xXQPx8aY38fjjZ5Y4s+aMQV/As6BB26tNyE4
         iBMm7PJn6scTUsHLqB0FbY1o06x8gOfAQm0zamUkjdDB1PE1XU0bGjkEAmVj+Nq4bGK7
         Gt5DiTbcLJEgNLZTWRO/V0/khN0uTrhHKS+YI=
Received: by 10.229.186.212 with SMTP id ct20mr1207996qcb.92.1298581951808;
 Thu, 24 Feb 2011 13:12:31 -0800 (PST)
Received: by 10.229.84.2 with HTTP; Thu, 24 Feb 2011 13:12:31 -0800 (PST)
In-Reply-To: <AANLkTi=b60kqd6fRXzf39BBepLOeA3ts6EN3AuY0iAp4@mail.gmail.com>
X-Google-Sender-Auth: 5VOlUQqmveLSkyZ8iBy5Ny9gQHk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167863>

Hello,

I ran into an issue with git-p4 and was given a fix described below by
someone assisting me, but I am not a Python developer...

...
By looking at the git-p4 code turns out that in the prepareLogMessage
function, everything between the Description and Files section of the
p4 change specification is skipped. The Jobs section happens to be
between Description and Files...

Good thing the fix is simple, in the prepareLogMessage function, just add this:

    if inDescriptionSection:
-       if line.startswith("Files:"):
+       if line.startswith("Files:") or line.startswith("Jobs:"):

And you should now see your jobs appear in the p4 change specification.
...

Given the simple nature of it, I was hoping someone could help get
this fixed in the main git distro.

-- 
Mike
