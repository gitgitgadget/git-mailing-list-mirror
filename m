From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 15:29:02 +0200
Message-ID: <vpqhcrcebmp.fsf@bauges.imag.fr>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<20070417104520.GB4946@moonlight.home>
	<8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
	<200704171818.28256.andyparkins@gmail.com>
	<20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	<Pine.LNX.4.64.0704181130150.12094@racer.site>
	<alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
	<8b65902a0704181308i41c878ebi88c03a929769ba39@mail.gmail.com>
	<Pine.LNX.4.64.0704191033290.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 15:29:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeWhH-000337-B1
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 15:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766695AbXDSN3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 09:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766694AbXDSN3L
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 09:29:11 -0400
Received: from imag.imag.fr ([129.88.30.1]:58120 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031241AbXDSN3J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 09:29:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l3JDT3Mk029426
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Apr 2007 15:29:03 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HeWh4-0001d5-Vp; Thu, 19 Apr 2007 15:29:03 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HeWh4-0003jr-TO; Thu, 19 Apr 2007 15:29:02 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0704191033290.8822@racer.site> (Johannes Schindelin's message of "Thu\, 19 Apr 2007 10\:37\:49 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 19 Apr 2007 15:29:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45020>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How is that not concurrent? If it really was not, there would be no need 
> to merge.

It can be concurrent, but on different files. Concurrency and merge at
the filetree level, but never within a file. I've worked in a team
where the "corporate" use of a VCS was following this model. Not
locking a file before editing it was considered a mistake.

>> So for such people, I really think raw Git is much more complicated than 
>> CVS/SVN.
>
> I imagine that somebody dedicated enough -- i.e. not me -- could set up 
> some standard aliases which do the CVS/SVN equivalent; we'd probably need 
> to support something like
>
> 	[alias]
> 		ci = commit -a && push origin
>
> which should not be all that hard.

It depends on how you implement that.

There have been a discussion crossposted here and on the bzr ML. The
author of cogito added a similar feature to cogito.

But to emulate the centralized model, you need more than that, you
have to

1) make sure you're up to date with upstream
2) commit
3) push

and to do it correctly, 1) must be checked during all the procedure,
and doing it in a transactional way is not trivial.

bzr has a notion of "bound branches". That is, when you commit to a
bound branch, you also commit to the master branch. And the UI for
that is to use "bzr checkout master-branch". I agree the centralized
model is inferior in general, but there are several cases where this
is handy. One of them being to teach a newbie: "see, learn checkout,
update, commit, add, mv, remove and you know how to use it". Another,
for me, is to avoid forgetting to push ;-).

-- 
Matthieu
