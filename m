From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: Many gits are offline this week
Date: Fri, 5 Oct 2007 21:19:02 +0400
Message-ID: <37fcd2780710051019l37b3dde2p57f24fef27b62bf6@mail.gmail.com>
References: <20071005010448.GQ2137@spearce.org>
	 <863awq5p1y.fsf@blue.stonehenge.com>
	 <4d8e3fd30710050214j135260cn842ee7396a3d63c7@mail.gmail.com>
	 <86tzp54sez.fsf@blue.stonehenge.com>
	 <37fcd2780710050741x1760a585yeaa9023a8d8cdccf@mail.gmail.com>
	 <20071005162029.GA18522@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 19:19:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idqpa-0002S8-37
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 19:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929AbXJERTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 13:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756576AbXJERTI
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 13:19:08 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:36405 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbXJERTF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 13:19:05 -0400
Received: by nz-out-0506.google.com with SMTP id s18so484912nze
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 10:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1xcgjsqRSd/xGqMSveKfzgXcaKIKgF0vQV3JnC7DqJE=;
        b=nJ3a8SQJeUUrT6fqrbQaCSZtiVqszwXutsChI72i9+ZQm7lmuCRQ0LcjV1PTlUy09cBlBI7UkHTV+wbsxRBrbi7b+I/XmLjzk01nx0XuRwBZVEl1NiB0QBxWlLdVflDljabHsrWitOtp/AYM6LoFE9uVB9iY1uBmSP+w8S4avkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FyHjU+2qbi0Xf+bUxd5dTZi+Y53DMlwzeuUbRp3L5x1G+99ozdX3k9+40jvvSguhuW8Fg8676z3vwsmeJUbcWmZtJ08XHK7zwug0W4dVHLqA5LzQAP5SaQTmcTzjdZAETsN2JsNPkGPU7zCwbz4dPJjH+t/oaN+vNL8sdfBdT3E=
Received: by 10.142.135.9 with SMTP id i9mr1688521wfd.1191604742766;
        Fri, 05 Oct 2007 10:19:02 -0700 (PDT)
Received: by 10.143.37.15 with HTTP; Fri, 5 Oct 2007 10:19:02 -0700 (PDT)
In-Reply-To: <20071005162029.GA18522@old.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60115>

> >I believe I have found one mistake in your slides. Slide 18 reads:
> >"git-commit -a" is like "git-add .; git-commit"
> >
> >But it is incorrect, because "git-commit -a" does not add new files, so
> >it works like "git-add -u .; git-commit".
>
> "git-commit -a" also detects files that have been deleted, whereas
> "git-add" does not.

I just tried "git-add -u ." and it *does* detect deleted files.

$ git-status
# On branch master
nothing to commit (working directory clean)
$ rm oldfile
$ git-status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    oldfile
#
no changes added to commit (use "git add" and/or "git commit -a")
$ git-add -u .
$ git-status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       deleted:    oldfile
#
$ git-commit
Created commit 17e2bba: delete
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 oldfile

So, it works exactly as "git-commit -a" in this case.

Dmitry
