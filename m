From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Recovering from a bad object
Date: Sun, 18 Sep 2011 21:31:16 +0200
Message-ID: <20110918193116.GB6334@nibiru.local>
References: <BANLkTindTWzeTFKYA3if4HYG3mj+NZX8oQ@mail.gmail.com> <7vy61ywjpa.fsf@alter.siamese.dyndns.org>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 18 21:35:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5N96-0003oL-1n
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 21:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756635Ab1IRTfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 15:35:14 -0400
Received: from caprica.metux.de ([82.165.128.25]:42791 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756598Ab1IRTfN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 15:35:13 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p8IJS1JK020224
	for <git@vger.kernel.org>; Sun, 18 Sep 2011 21:28:01 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p8IJRmcR020178
	for git@vger.kernel.org; Sun, 18 Sep 2011 21:27:48 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p8IJVG9r018729
	for git@vger.kernel.org; Sun, 18 Sep 2011 21:31:16 +0200
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vy61ywjpa.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181630>

* Junio C Hamano <gitster@pobox.com> wrote:

> > The object is likely at kernel.org.
> > Can git go fetch it somehow?
> 
> The protocol is designed specifically to disallow "I guessed that the
> trade secret is contained within an object whose object name is this,
> please feed me that object" kind of requests, so in general no.

Maybe the local side (in some special repair mode) could check if
some of the remote refs (and their referenced graphs) are broken
and refetch them completely. If the remote side(s) got the objects
you're missing (visibile to you), you'll be done after that.

For example:

A local branch "foo" is based on origin/master, somewhere in the
line behind origin/master some objects are broken:

It would find out that origin/master points to broken/missing objects
and refetch it completely afresh (same as it would if they had never
been fetched yet).


Perhaps it's not that hard to implement: just requires a special
git-fetch operation mode that ignores locally existing objects,
and a few lines of shell code that simply fetches the whole remote
to some temporary namespaces (and drop that when done). Ends up in
the same traffic as a fresh clone, but at least runs automatically.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
