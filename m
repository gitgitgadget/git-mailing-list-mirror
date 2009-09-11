From: Geoffrey Irving <irving@naml.us>
Subject: one half of a rebase
Date: Fri, 11 Sep 2009 13:25:59 -0400
Message-ID: <7f9d599f0909111025q42e3cdc6vba602b84c1d81215@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dylan Simon <dylan@dylex.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 19:26:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm9tP-0007v5-90
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 19:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706AbZIKR0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 13:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755693AbZIKR0T
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 13:26:19 -0400
Received: from mail-vw0-f195.google.com ([209.85.212.195]:57541 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbZIKR0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 13:26:16 -0400
Received: by vws33 with SMTP id 33so852330vws.33
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=Wy1U/QUSMbpm6rb6KeTfOq3jewUf1MfzXauo5PVahnI=;
        b=Ry3Gg7oC3wiTbnLS5m+6NsaHbLRspriR7wBxqtnYx9unWwNuaTrjPZzcJw2/1NnYtx
         5gEoXQ3vRJJs06h2UcU3s2E8hjaMW9uMzj7vf8t7oR3nug8LZ7JbmUB5gLRoLtKuRF3c
         RSVPIBPABsPsnCGqz5AVLt+nOI6POoBS2mHDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        b=ot/IPg15AGy4Upp2zBPWGwMSA6rWi7Cn0+GX0mIfXMd4kxyGRhLgfcxGyRZjJG5T9c
         x3z4bbmczA4VwCdFY9Jt8NZGA4xjopTuiaEG+i832OvLROyW8jgyN7qWdRy9p8zNEnjg
         rV8/C+PeLJr5m5os96FxUsEDq0OsW8F0qMJME=
Received: by 10.220.88.140 with SMTP id a12mr4067039vcm.27.1252689979345; Fri, 
	11 Sep 2009 10:26:19 -0700 (PDT)
X-Google-Sender-Auth: 413f6654dc55ac4c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128207>

If I'm on branch topic and do "git rebase master", git performs two operations:

1. Rewind the current head to master.
2. For each commit in topic that isn't in master, cherry pick it onto
the current head.

I would like to be able to do (2) as a separate operation.  For
example, if I start out on branch master and want to get all of
topic's commits on top of the current head, I currently do

    git checkout topic
    git rebase master
    git branch -d master
    git branch -m master

If I could do (2) as a separate operation, it would look something like

    git cherry-pick-all topic

which is simpler and faster since it avoids switching files back and
forth (master to topic and back).  Is there a robust way to achieve
the cherry-pick-all semantics with current commands?  If not, how
difficult would it be to partition rebase accordingly?

Thanks,
Geoffrey
