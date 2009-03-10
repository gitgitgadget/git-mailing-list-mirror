From: Tim Visher <tim.visher@gmail.com>
Subject: Confusing `stash apply` behavior
Date: Tue, 10 Mar 2009 15:46:00 -0400
Message-ID: <c115fd3c0903101246n1eff50d4rc819e5fe7586a974@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 20:47:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh7vM-0007Km-8g
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 20:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbZCJTqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 15:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753049AbZCJTqF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 15:46:05 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:15258 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbZCJTqC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 15:46:02 -0400
Received: by yw-out-2324.google.com with SMTP id 5so196645ywh.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/wAFLPZYT0mZWw5Ju1aZ2TjSIGcrkiBDoI1oRppUjTQ=;
        b=OClVsB4cOyFfoceDimCk1NQ5shy2BjyD4cOIT9aR/5iwqIia+fqHSVKNiscJUkU+t7
         MnvN+p4MzzvwF06ux69pIr21cfQSFlwwEkVzw3ZecK+cAGRLO3hhjmDv+H73rmfMSD5u
         0KkmAUVBbWKNLJeLoPm1y6GbVgLOy+8sm1LZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=LXr26DxLQq6t808AzhYBDW/cW8L6rmVatTUND2yJ4nlyURp7qfbWOsugofjEWtB5Ab
         4Fn24Y/dQsWd32J9rEtudZ52tNQ7xLO2+q2HtgTZ94N0nP2PjmdAaVslX1v9BVOSyyqR
         Uo44qMs/FUZiDlhlflN8+JwTRTO3Y26/oOhmM=
Received: by 10.100.253.7 with SMTP id a7mr2004048ani.153.1236714360701; Tue, 
	10 Mar 2009 12:46:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112842>

Hello Everyone,

I was just trying to do some experimentation with `stash` and I've run
into a problem.

I was working on my `master` branch and decided that I wanted to
create a `dev` branch.  I did `git stash` and then `git checkout -b
dev`.  Then I did `git stash apply` and everything worked as expected.
 I continued working but then realized that I wanted a `refactoring`
branch.  In the process of continuing to work I had also cleared the
stash stack with `git stash clear`, although this had no visible
effect other than to remove any entries from `git stash list`.  As
before, I did `git stash` and then `git checkout -b refactoring` and
here lies my problem.

When I do `git stash apply`, it deletes the file I'm working with.

    $ ls
    featureList.txt*  keycontrol.mdb*

    $ git show stash@{0}
    commit b3c0f4b9b3c3ef7741a03fb27174f5838abc939d
    Merge: 9fb9886 112bba9
    Author: Tim Visher <timothy.visher@fms.treas.gov>
    Date:   Tue Mar 10 15:25:04 2009 -0400

    WIP on dev: 9fb9886 Added DB Lock file to .gitignore. EOM

    diff --cc keycontrol.mdb
    index 68a9bac,68a9bac..0000000
    --- a/keycontrol.mdb
    +++ b/keycontrol.mdb

    $ git stash apply
    Removing keycontrol.mdb
    # On branch refactoring
    # Changed but not updated:
    #   (use "git add/rm <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working
directory)
    #
    #       deleted:    keycontrol.mdb
    #
    no changes added to commit (use "git add" and/or "git commit -a")

Considering the output of `git show` I would expect that the contents
of the stash are, well, what I expect them to be: a new version of
keycontrol.mdb.

I'm sure I'm missing something completely juvenile but I could really
use some help because that stash represents about an hours worth of
work.  Not something to totally loose sleep over but something that
would be nicer to not have to do over.

Thanks in advance for your help!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
