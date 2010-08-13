From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree packing)
Date: Fri, 13 Aug 2010 19:31:48 +0200
Message-ID: <20100813173147.GB27540@nibiru.local>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 19:41:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjyG0-0004s5-VT
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 19:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761915Ab0HMRlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 13:41:23 -0400
Received: from caprica.metux.de ([82.165.128.25]:58821 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755404Ab0HMRlX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 13:41:23 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o7DHf1TC021919
	for <git@vger.kernel.org>; Fri, 13 Aug 2010 19:41:01 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o7DHewui021908
	for git@vger.kernel.org; Fri, 13 Aug 2010 19:40:58 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o7DHVmAw012701
	for git@vger.kernel.org; Fri, 13 Aug 2010 19:31:48 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153482>

* Elijah Newren <newren@gmail.com> wrote:

Hi folks,


as I'm doing many backups via git (eg. hourly sql dumps), I'd 
like to cut off the history (eg. at the n'th past commit)
and reclaim the space - both on local and remote side (even
differently).

So let me propose another approach: fake-root's

Fake-roots are special refs that declare certain commit objects
as root-commits). Each time git walks down the history, it checks
whether the current commit is an fake-root and so treats it as
having no ancestor. That should be generic enough let everything
else (commit, push, gc, etc) work as usual.

The only tricky point is when to update remote fake-roots: the
remote should not cut off my local repo (unless explicitly asked).
So remote fake-roots should only be imported if the local/receiving
side has not the dropped commits anymore.

hmm, maybe it's even more wise to get one step back in history
and introduce fake-empty's (which also have no parents) instead
of fake-root's ? A fake-empty is imported as soon as the original
object is missing.


Of course, it's important that this feature has to be explicitly
enabled (maybe even on per-remote basis) to prevent security flaws.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
