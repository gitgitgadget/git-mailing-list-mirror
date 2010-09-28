From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: mirroring and development with three levels of repositories?
Date: Tue, 28 Sep 2010 19:37:11 +0200
Message-ID: <20100928173710.GA31419@nibiru.local>
References: <AANLkTinFiOA6Grzk16W2D=k8Xt+EgTanrS7iryW2evop@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 19:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0eDG-0004NV-SO
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 19:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab0I1RnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 13:43:13 -0400
Received: from caprica.metux.de ([82.165.128.25]:37501 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754407Ab0I1RnL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 13:43:11 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o8SHi1EB014868
	for <git@vger.kernel.org>; Tue, 28 Sep 2010 19:44:03 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o8SHhqiF014842
	for git@vger.kernel.org; Tue, 28 Sep 2010 19:43:52 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o8SHbBWH000619
	for git@vger.kernel.org; Tue, 28 Sep 2010 19:37:11 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTinFiOA6Grzk16W2D=k8Xt+EgTanrS7iryW2evop@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157449>

* John Clemens <clemej@gmail.com> wrote:

> Short question:
> It it possible for a bare repository to have both local (company-wide) and
> remote (mirroring upstream) branches, as well as serving those branches to our
> devs? If so, how?

Yes. Just set up the proper remotes in the config files (same as w/
non-bare repos). The main problem for you might be that the hub-repo's
remotes wont show up as remotes in it's clones - that's because per
default only remote's refs/heads/* namespace is mapped into local's
refs/remotes/*.

Most convenient would probably doing this in the local hub repo.
Add a proper fetch statement in the upstream remote's config section.
Suppose the upstream's remote name is "origin":


[remote "origin"]
    url = ...
    fetch = +refs/heads/*:refs/heads/origin/*
    fetch = +refs/tags/*:refs/tags/origin/*

This will make the upstream's heads and tags as they were pushed
to the hub repo directly, but with the "origin/" prefix.

> $ git clone http://local-server/local-mirror.git
> Initialized empty Git repository in /home/clemej/git/local-mirror/.git/
> warning: remote HEAD refers to nonexistent ref, unable to checkout.

What does the refs/HEAD file tell in the local mirror repo ?
 

cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
