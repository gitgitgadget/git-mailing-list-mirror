From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Private/public branches/repos workflow
Date: Thu, 05 May 2011 11:35:26 -0400
Message-ID: <201105051535.p45FZQDY019419@no.baka.org>
References: <BANLkTi=TLeePH0JDvnE0XPiCzXFxid9BWQ@mail.gmail.com>
Cc: git@vger.kernel.org
To: Jerome Martin <tramjoe.merin@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 18:07:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI15I-0001vM-TY
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 18:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab1EEQHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 12:07:17 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:57064 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714Ab1EEQHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 12:07:16 -0400
X-Greylist: delayed 1906 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 May 2011 12:07:16 EDT
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id p45FZRHC027900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 5 May 2011 11:35:27 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id p45FZQDY019419;
	Thu, 5 May 2011 11:35:26 -0400
In-reply-to: <BANLkTi=TLeePH0JDvnE0XPiCzXFxid9BWQ@mail.gmail.com>
Comments: In reply to a message from "Jerome Martin <tramjoe.merin@gmail.com>" dated "Thu, 05 May 2011 17:16:34 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172843>


In message <BANLkTi=TLeePH0JDvnE0XPiCzXFxid9BWQ@mail.gmail.com>, Jerome Martin
writes:

    Is there any recommended workflow to achieve the result I am looking
    for ? How are other people doing it ?

Create an orphan branch.  Commit what you want onto it.  Push branch
to a new repo as master.

git checkout <basesha>
git checkout --orphan cleanmaster
git add -A
git commit -m "base of public release"
(mkdir ../newrepo; cd ../newrepo; git init --bare)
git remote add cleanremote ../newrepo
git push cleanremote cleanmaster:master

You can then cherry pick/rebase from previous branches onto
cleanmaster any subsequent commits that you want to keep history for.

Another approach might be to finesse a shallow clone to do what you
want.

					-Seth Robertson
