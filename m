From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Tue, 13 Mar 2012 14:35:47 +0100
Message-ID: <vpqaa3kfwss.fsf@bauges.imag.fr>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
	<20120312183725.GA2187@sigill.intra.peff.net>
	<vpqy5r44zg7.fsf@bauges.imag.fr>
	<7vehswljxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 14:37:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7RvF-0000hw-LP
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 14:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893Ab2CMNhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 09:37:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57160 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885Ab2CMNhj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 09:37:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2DDVkRb003033
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Mar 2012 14:31:46 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S7RtE-00027K-Ef; Tue, 13 Mar 2012 14:35:48 +0100
In-Reply-To: <7vehswljxi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 13 Mar 2012 06:17:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 13 Mar 2012 14:31:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2DDVkRb003033
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332250307.38213@nGLd5ODqYd4OOmkeUqoiuw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193024>

Junio C Hamano <gitster@pobox.com> writes:

> I actually think the "pull before push again" was written with only
> CVS style non-branching workflow in mind, in other words, only to
> help somebody who works on his master against the central master.

It doesn't have much to do with branching/non-branching. You may use
branches, and still work collaboratively on them. There was an example
above in the same thread:

  http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694

There are also cases like "I pushed from my laptop and I'm back to my
desktop", or "the content has been edited from GitHub's web interface".

Actually, I hardly see a case where "pull before push again" (with or
without --rebase or such) is wrong for a beginner.

> Pushing 'current' from a branch 'topic' forked from either 'master'
> or 'origin/master' will create a new branch 'topic' at the central
> repository. But that is straightforward and understandable. The user
> will see what happened in the feedback from the command, and there
> is no need for the user to be experienced enough to know the mapping
> of @{upstream} to understand why it happened.  "I am on 'topic' and
> I pushed, I created 'topic' there".  Very simple explanation exists.

Very simple explanation exist for what "push" does, but not for "the
global picture of what push and pull do". And really, the case "Git
prevents me from pushing, I don't know what to do" is a problem for
people who don't get the whole remote/branch/upstream/... things.

Actually, I'm starting to wonder if the whole "upstream" thing should
not be deactivated by default, and replaced with a simpler mechanism
like "pull.default", similar to what "push.default" does today. Then,
users could set "pull.default=current", and "git pull" would pull a
branch with the same name remotely. Or users could set
"pull.default=upstream" and get what Git does today.

But that's a much larger change, then ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
