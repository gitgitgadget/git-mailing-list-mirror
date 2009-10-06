From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when appropriate to do so
Date: Tue, 06 Oct 2009 11:28:06 +0200
Message-ID: <vpqiqesna6x.fsf@bauges.imag.fr>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	<alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
	<20091005225611.GB29335@coredump.intra.peff.net>
	<alpine.DEB.1.00.0910061111410.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 11:30:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv6NK-0001uG-3S
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 11:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664AbZJFJ3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 05:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756545AbZJFJ3P
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 05:29:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50052 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbZJFJ3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 05:29:14 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n969STJZ011892
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 6 Oct 2009 11:28:29 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Mv6L1-0007ig-5B; Tue, 06 Oct 2009 11:28:07 +0200
In-Reply-To: <alpine.DEB.1.00.0910061111410.4985@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Tue\, 6 Oct 2009 11\:12\:51 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 06 Oct 2009 11:28:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n969STJZ011892
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1255426109.91883@7r42fW15iwhjJJrUuedXNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129614>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 5 Oct 2009, Jeff King wrote:
>
>> Some devil's advocate questions:
>> 
>>   1. How do we find "origin/next" given "next"? What are the exact
>>      lookup rules? Do they cover every case? Do they avoid surprising
>>      the user?
>
> I am sure your strategy would be the same as mine: enumerate all remote 
> branches, strip the remote nickname, and compare.  If there are 
> ambiguities, tell the user and stop.
>
>>   2. What do we do if our lookup is ambiguous (e.g., "origin/next" and
>>      "foobar/next" both exist)?
>
> See above.

One problem with this approach is that if users get used to the
behavior, the command will have great probability to end up in a
user's script, then the script will "work" as long as there is no
ambiguity, and cease to work afterwards. And for the user of the
script, this will sound like "WTF, it was working yesterday and it's
broken now".

So, the good thing with being strict, even if giving advice in case of
failure, is that it teaches the user the reliable way to do.

All that said, I'm not sure how serious this is, but we're in a
"devil's advocate" session, so I'm still allowed to speak ;-).


The other fear I have is to create confusion. Today, it's quite clear
that "next" is not the same as "origin/next". With some DWIMery on top
of this, a naive user may think they are more or less the same, and
then not understand what "git fetch" does and why it's not the same as
"git pull".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
