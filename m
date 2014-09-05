From: John Keeping <john@keeping.me.uk>
Subject: Re: git rebase: yet another newbie quest.
Date: Fri, 5 Sep 2014 23:13:36 +0100
Message-ID: <20140905221336.GB701@serenity.lan>
References: <87a96ecqe9.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 00:22:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ1tL-0006hW-On
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 00:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbaIEWV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 18:21:59 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:58539 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbaIEWV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 18:21:57 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Sep 2014 18:21:57 EDT
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3729B6064F2;
	Fri,  5 Sep 2014 23:13:42 +0100 (BST)
X-Quarantine-ID: <QrwVwN40mBBB>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QrwVwN40mBBB; Fri,  5 Sep 2014 23:13:41 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id A91B26064CC;
	Fri,  5 Sep 2014 23:13:41 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 9FC08161E3D6;
	Fri,  5 Sep 2014 23:13:41 +0100 (BST)
X-Quarantine-ID: <lWPAG8c9v0SV>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lWPAG8c9v0SV; Fri,  5 Sep 2014 23:13:41 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 5312F161E279;
	Fri,  5 Sep 2014 23:13:37 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <87a96ecqe9.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256546>

On Fri, Sep 05, 2014 at 02:28:46PM +0400, Sergey Organov wrote:
...
> # Then I realize I need more changes and it gets complex enough to
> # warrant a topic branch. I create the 'topic' branch that will track
> # 'master' branch and reset 'master' back to its origin (remote
> # origin/master in original scenario).
> 
> git checkout -b topic
> git branch --force master origin_master

This line is the problem, because the purpose of the `--fork-point`
argument to `git rebase` is designed to help people recover from
upstream rebases, which is essentially what you create here.  So when
rebase calculates the local changes it realises (from the reflog) that
the state of master before this command was before you created the
branch, so only commits after it should be picked.

For the case when the upstream of a branch is remote, this is normally
what you want.
