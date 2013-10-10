From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: git-svn: rewrite git-svn-id to something else on cherry-picking
Date: Thu, 10 Oct 2013 09:37:37 +0200
Message-ID: <CAA01CsrsmxCrpDpQGLNh1WvmWwfEntJ1oJ8yYfze=SMCwZN8ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 10 09:37:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUAoZ-00031y-21
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 09:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027Ab3JJHhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 03:37:39 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:65164 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab3JJHhi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 03:37:38 -0400
Received: by mail-ea0-f169.google.com with SMTP id k11so933079eaj.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 00:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+6ip8R5v41VdI4yp4vdHQ6ykdckQah17Bwz8u1PLZ7U=;
        b=bVMdVcLKFbIUznYKe6iTFJAYulNJA46S0MSzUTOYd+qQFd+/vDGI4H6NBnA6J1b7Vv
         EdLTx3nrFRcXn2FrYOpEG7ES3sEGe0OneqCd8YihftQR9jbW5EEyCABszEEFL2RGZv+r
         06Vyf5vhXmdQqEpZwpE5/R0Vl3AN19HE0lIchY6Zb9iZgtCcL41oJcWV4mMoMGgSyZlT
         g0NJ4b7mRuw4HSUg7Zu/PIAS5bO9zQUeW5pNAMkJl70768L38TPZebl22HFz8XajnibB
         rTBCMNaw1olMG8XwzICXU2HvxAZqwdYbXKOjRzcRY0jwKi/eDWcy0/PdhRo5CLaBXmhL
         Ljkg==
X-Received: by 10.14.0.193 with SMTP id 41mr210158eeb.88.1381390657193; Thu,
 10 Oct 2013 00:37:37 -0700 (PDT)
Received: by 10.223.193.4 with HTTP; Thu, 10 Oct 2013 00:37:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235854>

Hi,

maybe some people will find this useful:

based on an old mail from Daniele Segato (to be found here:
http://git.661346.n2.nabble.com/cherry-pick-from-a-branch-to-another-with-git-svn-automatically-stripping-git-svn-id-from-commit-mese-tt4548700.html#none)
I made following .gitconfig entry:

[alias]
    cherry-pick-svn =  !GIT_EDITOR='sed -i
\"s/git-svn-id:.*\\/\\(.*\\)@\\(.*\\) .*/Merged from \\1: r\\2/\"' git
cherry-pick -e

This allows me to cherry-pick changes from some branch and rewrite e.g.
  git-svn-id: http://server/repo/branch_name@43860
7b134e4a-3e3f-4a80-a66b-82fcf99633eb
to
  Merged from branch_name: r43860


(Why: I'm using one old svn server which does not support mergeinfo. I
had a feature branch and I needed to "merge" it back to trunk. But
without mergeinfo it's no fun, so I tried using git-svn and
cherry-pick. This worked but commits had those ' git-svn-id:
http://branch_url@41986 some-hash-id' and I was not sure if dcommit
would work correctly (would it strip them and commit to trunk and not
to the branch?) and even if it would, there would be no information
that the commit was "merged" from the branch.)


-- 
Piotr Krukowiecki
