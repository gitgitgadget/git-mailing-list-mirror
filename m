From: demerphq <demerphq@gmail.com>
Subject: Re: Question with git push
Date: Tue, 23 Dec 2008 18:37:47 +0100
Message-ID: <9b18b3110812230937p3c53f778h508746a3df72610e@mail.gmail.com>
References: <5591393c0812230859n3b50b1f9k36153f40dd75ff57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Vincent Craven" <paul@cravenfamily.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:39:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFBDn-0001Vc-MO
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 18:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbYLWRhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 12:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbYLWRht
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 12:37:49 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:36118 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYLWRht (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 12:37:49 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1682068qwe.37
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 09:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WZhc3TyF2afEDWJQkk3pKE9+mOKe3hk8L90hFv2qXm0=;
        b=Qc2Pv80J/vGwuNM13qpFXCEeKiekmTriZOSJCNusCGwf6M7oI2YU/1CUukf1ZyPIkr
         6I3EKBmDrTiaSkAobkhRyROW8JE/ksjfjv/M1FRcqNpWrvwJNN0R673K9oZjLNVbKhsD
         kY7xvG7FPwr7dgn6KDnEnRO1eNnDiHXgpBh7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=u+5DPL1vHAlBHeQ9ZiRK3+pvai5Eh3jR1WBGa8fcndMWBknO0HdLB7hZVqGsHqUE/C
         Hw42/YepdFVhbqr8w2i8+geDSIu5iWlCd4RkrTEGZkiKjdYbyTldfRzr5uc6ob6Wn27N
         9sOQ0+AHd0I3LVGEUy3LUzVrhnwOYgjbpFxw0=
Received: by 10.214.181.2 with SMTP id d2mr7792105qaf.380.1230053867270;
        Tue, 23 Dec 2008 09:37:47 -0800 (PST)
Received: by 10.214.116.17 with HTTP; Tue, 23 Dec 2008 09:37:47 -0800 (PST)
In-Reply-To: <5591393c0812230859n3b50b1f9k36153f40dd75ff57@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103838>

2008/12/23 Paul Vincent Craven <paul@cravenfamily.com>:
> If I do a 'git push' to another repository, my changes are reverted
> the next time that repository is updated, unless I do a hard reset on
> the remote repository first.

Or just git checkout -f

> Of course, then I would lose my changes
> in the remote repository. What is the correct way of handling this?

I think the general practice is not to push to non-bare repositories
unless you and the owner of the repository can coordinate things. This
either means you push and then tell them, or they set up a
post-receive hook (and understand the consequences of doing so). Of
course often you are both of these people and coordination is easy.

The post-receive hook would go in .git/hooks and would effectively execute:

  git checkout -f

on push. However this also means that the working directory will be
unilaterally updated every time someone pushes. Not something you want
to do in a truely shared non-bare repo.
Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
