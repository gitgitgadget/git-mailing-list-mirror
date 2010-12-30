From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: rebase parents, or tracking upstream but removing non-distributable bits
Date: Thu, 30 Dec 2010 15:14:07 -0800 (PST)
Message-ID: <m37heqdfck.fsf@localhost.localdomain>
References: <ord3ojb0yy.fsf@livre.localdomain>
	<20101230205847.GA29012@burratino> <or4o9uc2ny.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Alexandre Oliva <lxoliva@fsfla.org>
X-From: git-owner@vger.kernel.org Fri Dec 31 00:14:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYRhO-0006HN-1r
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 00:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab0L3XOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 18:14:12 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50116 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197Ab0L3XOL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 18:14:11 -0500
Received: by bwz15 with SMTP id 15so12066211bwz.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 15:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=OnuyXZFEWRQrXu6l42FSjCNfV+Kb2XQbM6R+1otZdDI=;
        b=oGYG31MTXzj84H+l/OuHjore/S1YdLA5ouKI856iuGXpKEgjOIrA+JYGeGDFFSpKbP
         +53aRJXGE5VbI7vLFlxPvmfArepni+2lGIZPuBILzeuLLLQ4ewJpKJo1W787jN/6Epgs
         2NSk2jW+xdqGUbEn4KNIJUjimE43is5AMSsUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=TpbkMGLlHZz4ElbFisPquU1KnFCx0q/6mcXCz974Qg9OSBrlr2CSOIsrGQH6+qZnfB
         R6iYEBDegwAwLLJ1ikPq/8nFItg6SEI702LLacEZ9Ndj+zJl5tGJdTqJSqm1OwO2L3oy
         h3NBlhYDmfifUUA8PDdh9f9VN+BIVYuh9J+0E=
Received: by 10.204.116.206 with SMTP id n14mr11221982bkq.65.1293750849468;
        Thu, 30 Dec 2010 15:14:09 -0800 (PST)
Received: from localhost.localdomain (abvk182.neoplus.adsl.tpnet.pl [83.8.208.182])
        by mx.google.com with ESMTPS id a17sm9479307bku.11.2010.12.30.15.14.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Dec 2010 15:14:07 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBUNDX0b005940;
	Fri, 31 Dec 2010 00:13:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBUNDGiA005936;
	Fri, 31 Dec 2010 00:13:16 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <or4o9uc2ny.fsf@livre.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164373>

Alexandre Oliva <lxoliva@fsfla.org> writes:

> On Dec 30, 2010, Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
> > Alexandre Oliva wrote:
> >> Now, it looks like I might be able to pull from upstream if I maintain
> >> manually a graft file that named each upstream commit as an additional
> >> parent of the corresponding local rebase commit that brought it into my
> >> rewritten tree.  Workable, maybe, but this wouldn't help third parties
> >> that used my public repository.
> 
> > Have you looked into "git replace"?
> 
> As far as I could tell, it solves a complementary problem.  IIUC, it
> would enable me to replace objects (say files, trees or commits) in my
> local repository so as to remove objectionable stuff, but when I pushed
> a branch out of it, it would go out with the very stuff I'm not supposed
> to publish.  This is because AFAICT replace objects are not sent over
> the wire.

They are not sent by default, but they (refs/replace/*) can be send as
any other ref.

> 
> Even if they were, I still don't think it would be appropriate to use
> them, for I'm speaking of really different trees.  Publishing a commit
> replacement would, for anyone who had both my public repository and my
> upstream, affect not just the branches I published, but also those in
> upstream, which would be surprising and undesirable.
[...]

I guess what Jonathan had in mind was something like that:
* you have two branches, 'clean' and 'contaminated'
* you want to merge 'contaminated' into 'clean', but you don't
  want people to see history of 'contaminated'
* in your private repository you merge 'contaminated' into 'clear'
  (with --no-ff, just in case), save merge commit, then rewrite
  top commit to be ordinary commit not a merge commit; it would
  bring [redacted] changes but not history
* you replace merge-turned-ordinary commit with a proper merge
  commit
* you don't distribute replacement refs to public repository

Though I think that better solution would be feature-branch based
workflow.  Each feature is developed in seperate feature branch.  If
given feature is sutable for 'clean', you merge it into both 'clean'
and in 'contaminated'.  If it is not, you merge it only into
'contaminated'.

Hopefully that would help develop workflow for you.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
