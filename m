From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git push default behaviour?
Date: Thu, 08 Mar 2012 19:35:51 +0100
Message-ID: <vpq1up3aqk8.fsf@bauges.imag.fr>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
	<1331203321.21444.13.camel@beez.lab.cmartin.tk>
	<CAFsnPqpoBLHoshgv0MsUUStA3Q=niM8hP9yaHr+rSQvh-JWHZA@mail.gmail.com>
	<7vlinbdkb0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeremy Morton <jeremy@configit.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 19:36:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5iCZ-0004fQ-6R
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 19:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973Ab2CHSga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 13:36:30 -0500
Received: from mx2.imag.fr ([129.88.30.17]:46558 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286Ab2CHSg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 13:36:29 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q28IW6E0008915
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Mar 2012 19:32:06 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S5iBs-00081j-57; Thu, 08 Mar 2012 19:35:52 +0100
In-Reply-To: <7vlinbdkb0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 08 Mar 2012 10:22:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Mar 2012 19:32:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q28IW6E0008915
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1331836328.34635@HYpEuFeqA4TmnY28jIAhvw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192629>

Junio C Hamano <gitster@pobox.com> writes:

> If you publish to your own repository
> and let others pull, the behaviour is not dangerous at all with or
> without --force (well, --force brings its own danger but that does
> not have anything to do with which branches are pushed).  If you
> default to 'current' in such a workflow, you risk forgetting to
> push, which is the more dangerous option between the two.

Forgetting to push a branch is a danger, but far less dangerous than
what "push --force" can do in a shared repository.

In a shared repository, there's actually a race condition that you
cannot avoid AFAICT:

$ git push
 # get an error about non-fast-forward on branch A, but no other.
 # thing "it's OK, I do want to do a forced update on A".
$ git push --force

If someone else did a push between my first push and the "push --force",
then the other user's push is discarded.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
