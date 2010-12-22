From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Rebasing multiple branches
Date: Wed, 22 Dec 2010 15:36:55 +0100
Message-ID: <20101222143654.GA4829@nibiru.local>
References: <4D10AE5B.2080700@gmail.com> <4D10B44D.5090309@viscovery.net>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 22 15:41:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVPsr-0000ij-TZ
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 15:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab0LVOlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 09:41:37 -0500
Received: from caprica.metux.de ([82.165.128.25]:41436 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752750Ab0LVOlg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Dec 2010 09:41:36 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oBMEb16Y029382
	for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:37:03 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oBMEavFX029359
	for git@vger.kernel.org; Wed, 22 Dec 2010 15:36:57 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oBMEatch013285
	for git@vger.kernel.org; Wed, 22 Dec 2010 15:36:55 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4D10B44D.5090309@viscovery.net>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164087>

* Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 12/21/2010 14:40, schrieb Leonid Podolny:
> >         B--o--o--o--o--o--o  <--branch A
> >        /                   \
> > o--o--A--o--E  <--master    C--o--o--o--D  <--branch C
> >        \                   /
> >         C--o--o--o--o--o--o  <--branch B
> > 
> > I would like to rebase all three branches A, B and C onto commit E,...
> 
> git rebase master A
> git rebase master B
> git merge A
> git rebase -i HEAD C
> 
> The last rebase I propose as interactive so that you can remove those
> commits before D~3 that you have already rebased, because they are likely
> to conflict unnecessarily, and you would --skip them anyway.

Why not this way ?

git checkout D
git rebase -p -i D~3 --onto C'

(C' is the merged branch of A' and B').


So:

git checkout branch_A -b rebasing_A
git rebase master			# rebase old A to master
git checkout branch_B -b rebasing_B
git rebase master			# rebase old B to master
git checkout -b rebased_merge
git merge rebasing_A			# we're on B', merge in A'
git checkout branch_C
git rebase -p -i C --onto rebased_merge # set D~3..D ontop of it


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
