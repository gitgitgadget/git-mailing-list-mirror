From: Francis Moreau <francis.moro@gmail.com>
Subject: question about a merge result
Date: Thu, 30 Apr 2009 14:21:07 +0200
Message-ID: <38b2ab8a0904300521m9e31867j7848135acfae0faa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 14:21:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzVGR-0004CP-1k
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 14:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332AbZD3MVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 08:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbZD3MVK
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 08:21:10 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:57026 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbZD3MVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 08:21:09 -0400
Received: by fxm2 with SMTP id 2so1776239fxm.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 05:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=K17fOXkwiYDL78MPIsc1V/m9WmFMCxYCuRi4DZeDyjo=;
        b=Ne4gOu5cpC4U/aVYfzNdD+nqnGtlFYltyy3aAfEJOVGuLF9jpBrx/uXbE5SbK5wmcd
         g5nvE72lKtz6FQVqMa6dKyaostW5fDOytLtskAYX/ad2tlpk2K7qISnnIiNUM2qkPzeF
         rrlchw6lp6zgLHNfowPbXoHx5/yZ9MWAZILBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ND04DpdXiA6yzWToah3I/hGw2QlXbOFITGbYtCFhwXhW75If808LnA/6lhsRnKaRh2
         KzIuY+VLpX4owWA28xbow2mASZ4bqyMfzj1s4qWxwJeuVeCLI25EAY2sKAzjPUh6M2os
         tvLajdBEZncdygW8Fpo25p+EwBhrB8lG24Fhc=
Received: by 10.103.91.2 with SMTP id t2mr926296mul.52.1241094067526; Thu, 30 
	Apr 2009 05:21:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118014>

Hello,

I'm a little bit confused about a merge I have done and the result
suprised me. Thinking about it I'm still not convinced what should be
the result.

Here's the use case:

$ mkdir test-git && cd test-git
$ date > A
$ date > B
$ git init
$ git add .
$ git commit -m "Init"

So far I just created a repo with 2 files A and B

$ git branch b1
$ git rm B
$ git commit -m "remove B"

Now I created a branch 'b1' and remove B file in master branch

$ git checkout b1
$ git rm B
$ git commit -m "remove B"
$ git revert HEAD

Now on 'b1' I did the same as master but I thought that removing B was
a bad idea so I revert the previous commit

$ git checkout master
$ git pull . b1
$ ls B
ls: cannot access B: No such file or directory

So merging 'b1' into master removed the B file even if in branch 'b1'
I restored it.

Could anybody explain me why this is the correct behaviour and why not
file 'B' is not restored as it was done in branch 'b1' ?

thanks
-- 
Francis
