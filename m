From: Michel Lespinasse <walken@google.com>
Subject: Passing original commit sha1(s) to prepare-commit-msg hook
Date: Mon, 12 Jul 2010 03:49:28 -0700
Message-ID: <20100712104928.GA22305@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 12 12:51:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYGbV-0002kd-Vs
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 12:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab0GLKti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 06:49:38 -0400
Received: from smtp-out.google.com ([74.125.121.35]:28514 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab0GLKth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 06:49:37 -0400
Received: from hpaq3.eem.corp.google.com (hpaq3.eem.corp.google.com [172.25.149.3])
	by smtp-out.google.com with ESMTP id o6CAnZFS025119
	for <git@vger.kernel.org>; Mon, 12 Jul 2010 03:49:35 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1278931775; bh=fKVENnc4egE5Q82+q4WTR+2+Jnc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=Ft8op1uqHvAid5IsGI51KziKtY/7aVGB2CSqHq/z3JvPWmGiAsvBSo/KAg/ckAwEF
	 FkUyzKr/VR5/aKbaDgPgQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=date:from:to:subject:message-id:mime-version:content-type:
	content-disposition:user-agent:x-system-of-record;
	b=oGnF+9SciXAvoKQVWA4MHlFtZ4H0H/efNetwp1aJ/KSZVr3Zy1AhFvTdOr6I5hCBr
	cPE5LCpHRSneyePCWBYyQ==
Received: from pxi11 (pxi11.prod.google.com [10.243.27.11])
	by hpaq3.eem.corp.google.com with ESMTP id o6CAnXp2016353
	for <git@vger.kernel.org>; Mon, 12 Jul 2010 03:49:34 -0700
Received: by pxi11 with SMTP id 11so2003686pxi.7
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 03:49:33 -0700 (PDT)
Received: by 10.142.144.16 with SMTP id r16mr11492873wfd.259.1278931773150;
        Mon, 12 Jul 2010 03:49:33 -0700 (PDT)
Received: from google.com (studio.mtv.corp.google.com [172.22.65.142])
        by mx.google.com with ESMTPS id k25sm4390148rvb.16.2010.07.12.03.49.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 03:49:32 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150810>

Hi,

I would like to use a prepare-commit-msg hook to automatically edit commit
comments when a rebase is done, using information from the original
commit. For example:

- Adding a commit message line indicating that the commit is a rebase of
  the original commit(s),
- Adding comments based on information stored in git notes on the original
  commit(s).

Currently (I'm using git 1.7.1) the old->new commit sha1 information is
passed to the post-rewrite hook; however by then it is too late to do
anything with commit messages. During "git rebase" the applypatch-msg hook
is called with the original commit sha1 in
.git/rebase-apply/original-commit, and during "git rebase -i" the
prepare-commit-msg hook is called with current status of the rebase
available in .git/rebase-merge/done; however relying on this would seem
very fragile to me.

Would there be support for the idea of making the original commit sha1
information available to commit message hooks ? And if so, any advice how
I should go about implementing this ? (I have little experience with git
codebase).

Thanks,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
