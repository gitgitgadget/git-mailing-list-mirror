From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] Use character class for sed expression instead of \s
Date: Thu, 25 Oct 2012 18:28:10 +0200
Message-ID: <5089689A.9070301@web.de>
References: <508935CB.9020408@web.de> <1351180699-24695-1-git-send-email-bdwalton@gmail.com> <C2AB6973-7BC2-45A4-836E-BB1FAAE7501C@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ben Walton <bdwalton@gmail.com>, tboegi@web.de, peff@peff.net,
	bosch@adacore.com, git@vger.kernel.org
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 18:28:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRQIE-0000Dr-AJ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 18:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935858Ab2JYQ2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 12:28:14 -0400
Received: from mout.web.de ([212.227.17.12]:55804 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932945Ab2JYQ2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 12:28:13 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0Lb29N-1Sye3O0MDh-00l3jj; Thu, 25 Oct 2012 18:28:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <C2AB6973-7BC2-45A4-836E-BB1FAAE7501C@gernhardtsoftware.com>
X-Provags-ID: V02:K0:v3Le9SMmLhpF0IOhWB7lJhDe3iUkoTY+brtUSFeZg58
 oXe4bTpKuQ/V9WMMryThk3b6eSqIhm7sxJPEr2upS4RfYmmvHF
 THNNCeuPCuPWxdIUDxkcNEFRBUu3CLjvwoMOFDjAdVHz2gfzo4
 +wazNjqJAz9q/Yj2Gn2zPnBhAThRTSE+93PEw22qsWb4rwXPKp
 a8SfIBpA5D6yyC9bbLlbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208408>

On 25.10.12 18:00, Brian Gernhardt wrote:
> 
> On Oct 25, 2012, at 11:58 AM, Ben Walton <bdwalton@gmail.com> wrote:
> 
>> Sed on Mac OS X doesn't handle \s in a sed expressions so use a more
>> portable character set expression instead.
>>
>> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> 
> Acked-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> 
> I have an identical change sitting in my git.git, I've just been too distracted by other things to commit and send it.
> 
> ~~ Brian Gernhardt

Much nicer, indeed.

BTW: While we are talking CVS: (I installed a fresh version)
cvs --version
Concurrent Versions System (CVS) 1.11.23 (client/server)


And t9200 fails:
git checkout t9200-git-cvsexportcommit.sh
tb@birne:~/projects/git/git.pu/t> ./t9200-git-cvsexportcommit.sh
cvs [init aborted]: Cannot initialize repository under existing CVSROOT: `/Users/tb/projects/git/git.pu/t/trash directory.t9200-git-cvsexportcommit'
FATAL: Unexpected exit with code 1

The following fixes it, but there are possibly better solutions.
Any comments/suggestions ?

diff t9200-git-cvsexportcommit.sh t9200-git-cvsexportcommit.tb.sh
28,29c28
< mkdir "$CVSROOT" &&
< cvs init &&
---
> (cvs init || mkdir "$CVSROOT" && cvs init ) &&
