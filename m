From: Salikh Zakirov <salikh@gmail.com>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Tue, 25 Dec 2007 22:08:11 +0900
Message-ID: <477100BB.6020301@gmail.com>
References: <200612241807.kBOI746w008739@laptop13.inf.utfsm.cl> <476E42BF.1010300@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Tue Dec 25 14:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J79WV-0008OI-Lx
	for gcvg-git-2@gmane.org; Tue, 25 Dec 2007 14:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbXLYNIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2007 08:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbXLYNIQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Dec 2007 08:08:16 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:43154 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbXLYNIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2007 08:08:15 -0500
Received: by wx-out-0506.google.com with SMTP id h31so619964wxd.4
        for <git@vger.kernel.org>; Tue, 25 Dec 2007 05:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=hlR9jbpOwNkKTrIdLUqSum03qrHiuUP9+hayG0Q1r3c=;
        b=fXSIXhBTgyyKS33Lm91NFck0l42QLjmTfiYAvd3GrPp0cEXyLpL74DU5rXANzovEI2KwR6lKFxg/eTBXYaLWzKdLE4CQGFqxpIpXYW8V/v+DZRm1ED0RewEpMrknmCQ8tGNVojlgodoSjBX/TS3n2pIaowRdg//vlQxAVzDysZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cf7ZGkxXdS537GO0E1HjgVtVwUVfreg3npeC3B/1Cv+qbOeWyWtL9/MiWaJ4guRMSeh69YwLXVvn4EsjG8saoLh1fNH3DXe4ay+Qe/vIt+vtN8sS60whCtBEX5Cw5nLh04JKFpedkqRgg3upMrREj42SIcOADLXAc6eytSXy6qg=
Received: by 10.70.76.18 with SMTP id y18mr3901911wxa.53.1198588095024;
        Tue, 25 Dec 2007 05:08:15 -0800 (PST)
Received: from ?221.115.75.108? ( [221.115.75.108])
        by mx.google.com with ESMTPS id h35sm21811369wxd.20.2007.12.25.05.08.13
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Dec 2007 05:08:14 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071205)
In-Reply-To: <476E42BF.1010300@garzik.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69233>

Jeff Garzik wrote:
> The kernel hacker's guide to git has received some updates: 
> http://linux.yyz.us/git-howto.html

I have some comments on the contents, though  I need to warn, 
that  I've been following git development for about year and a half now,
and I am not a kernel hacker, so my comments may have wrong bias.

>     Obtain a diff between current branch, and master branch
> 
> In most trees with branches, .git/refs/heads/master contains the
> current 'vanilla' upstream tree, for easy diffing and merging. (in
> trees without branches, 'master' simply contains your latest changes)
> 
> $ git diff master..HEAD

IMHO, syntax 'git diff master HEAD' is preferable, in order to avoid
confusion with 'git log master..HEAD' usage, which has quite different
meaning, roughly expressible as

  git diff `git merge-base master HEAD` HEAD

for getting one big diff of the changes in HEAD since master)

> (this is equivalent to git diff HEAD, when used with HEAD branch)

This seems incorrect to me, as 'git diff master HEAD' compares two
revisions, while 'git diff HEAD' compares working tree with HEAD revision.

Besides, expression 'HEAD branch' is misleading, because HEAD is not a branch by itself,
but rather a link to the latest state of the current branch.
