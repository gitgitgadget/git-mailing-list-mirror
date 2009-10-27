From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: possible usability issue in rebase -i?
Date: Tue, 27 Oct 2009 11:13:42 +0100
Message-ID: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 11:13:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2j3k-0003ih-Vr
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 11:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbZJ0KNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 06:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbZJ0KNj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 06:13:39 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:46672 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbZJ0KNi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 06:13:38 -0400
Received: by fxm18 with SMTP id 18so12794849fxm.37
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type;
        bh=lJmllNAnFJpnczNiZCLA/A/EhmzzVJYEvQ/XLvtT+FQ=;
        b=u07/r3nOx2pxJsEPVLi10iX8sqCG6r82W0US0ray6mfxOWzNMMN5IeNMeWjhAGeorh
         IkSaiujsI0cSMbl+kSy/1GneDWhlJDzdPv2ezbQUsuHPbIaPoYTXmHnGRQzuaFSBFJIx
         BnNOa0SEniJKI1fkerThlhB0RNXShF1aIrJfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=dZL4knwMJthj0whGfvD4en05VMV/k9Np1Etx+hHPKOb44/x3noLXYkrqtJf2hlL4J+
         4z+IOZ3tetr4W+D+8lDwg5uLOlUNN+EXopJxbN3KQYzZ+LT9fPLCGtX2zrdFJl8HNkyx
         p1vOtfhIAD+N+YQHUFSDm7xjSHF6iG5B2KjVM=
Received: by 10.204.143.151 with SMTP id v23mr10277321bku.169.1256638422297; 
	Tue, 27 Oct 2009 03:13:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131322>

I recently came over a not-overly-helpful error in git rebase -i, when
a line got wrapped by the editor so that a part of the commit-message
was interpreted as a command:

---
$ git rebase -i HEAD~20
<edit file>
Unknown command: .
fatal: ambiguous argument 'Please fix this in the file C:/msysgit/git/.git/rebas
e-merge/git-rebase-todo.': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
fatal: Not a valid object name Please fix this in the file C:/msysgit/git/.git/r
ebase-merge/git-rebase-todo.
fatal: bad revision 'Please fix this in the file C:/msysgit/git/.git/rebase-merg
e/git-rebase-todo.'

$ git --version
git version 1.6.5.1386.g43a7a.dirty
---

In this particular case, the first character on the new line was '.',
so the first line of the error message makes perfect sense, but the
lines that followed the real error got me pretty confused. Perhaps
this is something that could be cleaned away? I'd think that an
unknown command always should be fatal, and not need to propagate
further. But I might be wrong, as I'm not familiar with the inner
workings of rebase -i.

-- 
Erik "kusma" Faye-Lund
