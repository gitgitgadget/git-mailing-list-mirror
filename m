From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Fri, 13 Aug 2010 19:58:50 +0200
Message-ID: <20100813175850.GD27540@nibiru.local>
References: <20100727122018.GA26780@pvv.org> <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com> <9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com> <AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com> <20100728000009.GE25268@spearce.org> <m3tynjkb90.fsf@localhost.localdomain>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 20:06:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjyeC-0000Yq-6f
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 20:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761879Ab0HMSGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 14:06:23 -0400
Received: from caprica.metux.de ([82.165.128.25]:55949 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752572Ab0HMSGW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 14:06:22 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o7DI61Q7022966
	for <git@vger.kernel.org>; Fri, 13 Aug 2010 20:06:01 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o7DI5c3p022932
	for git@vger.kernel.org; Fri, 13 Aug 2010 20:05:38 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o7DHwotq031031
	for git@vger.kernel.org; Fri, 13 Aug 2010 19:58:50 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m3tynjkb90.fsf@localhost.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153485>

* Jakub Narebski <jnareb@gmail.com> wrote:

> I guess that modern filesystems solve the problem of very many files
> in a single directory somehow (hash tables?).  Perhaps the index file
> could borrow some such mechanism as an extension.
> 
> Index for index?

hmm, if an index gets too large, it could be split into several
ones by an pathname prefix (but not necessarily one per directory)
so when having the subdirs "a", "b", "c", we'll three separate 
index files and a master index telling:

    a/	index.001
    b/	index.002
    c/	index.003

or even:

    a/		index.001
    b/		index.002
    b/foo	index.004
    c/		index.005

this would just add one indirection in the index-lookup by
comparing the key w/ index indice's prefix.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
