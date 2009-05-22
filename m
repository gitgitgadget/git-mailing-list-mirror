From: Tim Uckun <timuckun@gmail.com>
Subject: can anybody explain the following to a git noob?
Date: Fri, 22 May 2009 15:46:08 +1200
Message-ID: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 05:46:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7LiB-00089V-SK
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 05:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbZEVDqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 23:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbZEVDqI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 23:46:08 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:47724 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbZEVDqI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 23:46:08 -0400
Received: by gxk10 with SMTP id 10so2773568gxk.13
        for <git@vger.kernel.org>; Thu, 21 May 2009 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=TXsU5zo1dGKIhevl7pnCNhcUnUOwcg/G02dcgC32d18=;
        b=KpT9aAVQfQHdnDBjkRK9c35HIE9Jj9x4DB3kLmtRZ4/Vi4/3HXNKXMSiFAv9rPq9W1
         6ojwrE5VYlQ+1sDwA9mSdyfLcOCzS1SkJzh6oEXgpnmFzYlh8Bb4kRFje3rlPC9NdKn1
         t7DrOmo4mboZoAlB0IPNle9Xc/fA/bmav6azQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=cDoXTdXg/J4qLnw3wsOeuPSWsJ49NLuOWkGRa9+1QTTX/3KPwE43xTsbQjSILRBSf6
         5PK1CslFWhCg0oG7UiGGXCq7dMG+k9g6DU2a3nrv/84AYOyS7fI1EYj1Yjlv9QlWxS1f
         WGed54b+CXc3WXWKc+7O1DDpmKRheqBpDC4eY=
Received: by 10.90.81.11 with SMTP id e11mr2728308agb.119.1242963968385; Thu, 
	21 May 2009 20:46:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119710>

A transcript...

git init
git add . > /dev/nul
git commit -m 'initial import'

git status
# On branch master
nothing to commit (working directory clean)

***** Create new branch  ********
git checkout -b my_branch
Switched to a new branch "my_branch"

*********Try to rename a directory  WTF?: Git thinks any directory with a
.git folder is empty and refuses to rename the directory.
git mv vendor vendor_new
fatal: source directory is empty, source=vendor/plugins/acts_as_audited,
destination=vendor_new/plugins/acts_as_audited

ls vendor/plugins/acts_as_audited/
CHANGELOG  generators  init.rb  lib  LICENSE  Rakefile  README  spec  tasks
test.txt

******** Initial state of the test directory
ls test
fixtures  functional  integration  mocks  test_helper.rb  unit  watir

****** Rename and commit changes
git mv test test_new
git commit -m 'renamed the test directory'

********Current state of the directory
 ls
app  Capfile  config  db  doc  lib  MyProject.kpf  public  Rakefile  README
script  test_new  tmp  vendor


********Checkout master. WTF?: Both the test and the test_new directories
exist. Why does the test_new exist in this branch?
git checkout master
ls
app  Capfile  config  db  doc  lib  MyProject.kpf  public  Rakefile  README
script  test  test_new  tmp  vendor

******** list  the test directory.  WTF?: Where did the mocks subdir go??
(see above for the initial directory listing)
 ls test
fixtures  functional  integration  test_helper.rb  unit  watir

**** Check the test_new directory:  WTF?: Where are all the other
subdirectories?
ls test_new
functional  mocks

******** Merge  Everything is merged properly.
git merge my_branch

ls
app  Capfile  config  db  doc  lib  MyProject.kpf  public  Rakefile  README
script  test_new  tmp  vendor
ls test_new
fixtures  functional  integration  mocks  test_helper.rb  unit  watir


obviously I am doing something profoundly wrong. Can somebody explain why
this is happening?
