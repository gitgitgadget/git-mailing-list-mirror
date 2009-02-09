From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [Bug?] Problem with git show when not in repository's root dir
Date: Tue, 10 Feb 2009 07:23:08 +0800
Message-ID: <544dda350902091523i2989318bq3ee0f120ca77b7dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 00:24:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWfUW-0005A7-Qj
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 00:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbZBIXXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 18:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbZBIXXO
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 18:23:14 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:27843 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbZBIXXK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 18:23:10 -0500
Received: by wf-out-1314.google.com with SMTP id 28so2666067wfa.4
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 15:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=pxijyeVxBO/V+B3ROu8QkWl3lp8FByFvvmnVXH34UE8=;
        b=nQmeSStd3hyVNuCWD4XlOqZMq/A8u/pgAXLXpdq+7mgSWRiiy7d8kJ6jPiPHdjfRsw
         lq8keAYS6ivAGrX0s8dNmQsH2FO0NOugVjZuYNj0yZH2haTbOXk+YCSiL5/6gx4llTx2
         ttfY37iZgciXL1a/qqnqqzhBtrTkOKaCnCV3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ueUzIrCg9qyWTyAW6sDRaGqqSzuHyu4dqgHg0tA9eCMx2RI+KBQdKEQsqjBiHawurt
         +dyzdNHoWIZpVIAT6Pw7TyWH7A6n/gVVz/3TPnE0I56uNavgRAw8NPeFawYGnYwptB2S
         g/WEdRv2lzyBlsiDFCkMRISsi47IMHfuGizgk=
Received: by 10.142.154.14 with SMTP id b14mr1797358wfe.250.1234221789252; 
	Mon, 09 Feb 2009 15:23:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109160>

Repository structure:

a/         - repository's root dir (.git is in here)
a/a.txt
a/b/b.txt

After merging with conflict:

% git status
a.txt: needs merge
# On branch b1
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       unmerged:   ../a.txt
#
no changes added to commit (use "git add" and/or "git commit -a")

% git show :1:a.txt
Hello
Good World
Bye

% git show :2:a.txt
Hello
This is where it conflicts
Bye

% cd b

% git status
a.txt: needs merge
# On branch b1
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       unmerged:   ../a.txt
#
no changes added to commit (use "git add" and/or "git commit -a")

% git show :2:../a.txt    # here's the problem
fatal: ambiguous argument ':2:../a.txt': unknown revision or path not
in the working tree.
Use '--' to separate paths from revisions

Should "git show" be taught with the "--ours" and "--theirs" options?
git checkout knows them, but git show doesn't.  At least to me, "--ours"
and "--theirs" are easier to understand than :1: and :2:

nazri.
