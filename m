From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Branch merge bug
Date: Tue, 19 Jan 2010 12:52:58 +0530
Message-ID: <f3271551001182322p86a02d8p8b9ceb49e930d333@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 08:23:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX8Qt-0006mn-QE
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 08:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892Ab0ASHXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 02:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813Ab0ASHXT
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 02:23:19 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:46983 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812Ab0ASHXT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 02:23:19 -0500
Received: by ywh12 with SMTP id 12so2215648ywh.21
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 23:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=DRyQ7Of7ZPEgLwom93T8dhM9YndIuKSKVrh/qagLKBI=;
        b=i7p8JZ2DDcsEfoMaMPGZay8AOMjjHJEUEiC+r1SctFVzDVWEuYIuBf5AVIsZCLjI5+
         2XxMo/w2LhPPOf+72tZHBLeOb8h8Ezg8zAinslUCntyuMGnVXaYCRrT0+e+UzhlMw1QR
         wNfCOHSs3ht3vWrm1cEhSrySVLn3zm5qfCgHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Z7Ah7cghyc9QXz5L2o+j3oTSFq7tSrxbijYI2QH3r/qbTvRl778y9KI1+12cXHs0ry
         emaZCdhYEE74g7kjKDVV3Ey9JjNCJwXLvr1EW7eZyoP7/kghMd0dCLthpVEcvL3oK53m
         9T+UtgzN75oudx6udtBSxGF0zqtEQ/oBcbP2k=
Received: by 10.91.52.20 with SMTP id e20mr13413agk.47.1263885798272; Mon, 18 
	Jan 2010 23:23:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137440>

A friend showed me this reduced test case. It seems to work fine with
bzr and hg. Is this a git bug?

>: git --version
git version 1.6.3.1
>: git init
Initialized empty Git repository in /Users/lut4rp/Code/tester/.git/
>: echo asdjhaskd >fil
>: git add fil
>: git cm 'initial commit'
[master (root-commit) 9983161] initial commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 fil
>: git branch new
>: git branch
* master
  new
>: git mv fil fila
>: git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	renamed:    fil -> fila
#
>: git cm 'renamed to fila'
[master 9de0953] renamed to fila
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename fil => fila (100%)
>: git co new
Switched to branch 'new'
>: git rm fil
rm 'fil'
>: echo asjhdajkhsdkajhs >fila
>: git add fila
>: git cm 'renamed, heavily modified'
[new 5914271] renamed, heavily modified
 2 files changed, 2 insertions(+), 1 deletions(-)
 delete mode 100644 fil
 create mode 100644 fila
>: git co master
Switched to branch 'master'
>: git merge new
CONFLICT (rename/delete): Rename fil->fila in HEAD and deleted in new
Automatic merge failed; fix conflicts and then commit the result.
>: cat fila
asdjhaskd                                  #### Still the master
branch's content, `merge` apparently did nothing.
>: git show :2:fila
asdjhaskd
>: git show :3:fila
fatal: ambiguous argument ':3:fila': unknown revision or path not in
the working tree.
Use '--' to separate paths from revisions
>: git show new:fila
asjhdajkhsdkajhs
ajksh askjdhaksdh kajshdk asd
