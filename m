From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Sat, 8 Dec 2007 16:29:22 +0100
Message-ID: <20071208152922.GB30270@elte.hu>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 16:30:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J11d1-0006eL-68
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 16:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbXLHP3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 10:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbXLHP3o
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 10:29:44 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:33937 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbXLHP3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 10:29:43 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1J11cU-0006fq-QX
	from <mingo@elte.hu>; Sat, 08 Dec 2007 16:29:41 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 37A9F3E2166; Sat,  8 Dec 2007 16:29:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200712080636.12982.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67556>


* Christian Couder <chriscool@tuxfamily.org> wrote:

> > Right now i have this silly git-bisect-diff script:
> >
> > git-log -p "`git-bisect log | grep good | tail -1 | cut -d' ' 
> > -f3`".."\ `git-bisect log | grep bad | tail -1 | cut -d' ' -f3`"
> >
> 
> Tell us if you have other scripts or suggestions related to 
> git-bisect.

i have scripts around "git-bisect run" (which are custom to my test 
environment so not generally applicable), but perhaps it would be useful 
to extend it a little bit to have automatic support for "build error 
bisection". 99% of the FOSS packages that developed under git can be 
built via "make". So could you perhaps add fully automatic bisection 
support that is driven by doing "make" in the current repository?

Currently, in the Linux kernel, if i do this:

 $ git-bisect run make -j64 kernel/

it fails with:

 running make -j64 kernel/
   CHK     include/linux/version.h
   CHK     include/linux/utsrelease.h
   CALL    scripts/checksyscalls.sh
 bisect run failed:
 bisect_good exited with error code 1

although the command "make -j64 kernel/" returns with 0.

i have to write a script around "make -j64 kernel/" to get this to work 
- it would be nice to have this "out of box".

	Ingo
