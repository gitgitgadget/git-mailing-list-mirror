From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: fsck option to remove corrupt objects - why/why not?
Date: Thu, 16 Oct 2014 13:59:13 +0200
Message-ID: <vpqmw8w6x9q.fsf@anie.imag.fr>
References: <20141015234637.9B4FC781EFB@mail110.syd.optusnet.com.au>
	<543F0DAE.2050205@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ben Aveling <bena.001@optusnet.com.au>
X-From: git-owner@vger.kernel.org Thu Oct 16 13:59:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xejib-0004XD-74
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 13:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbaJPL7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 07:59:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60772 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbaJPL7a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 07:59:30 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s9GBxCvs025630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Oct 2014 13:59:12 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s9GBxDbF031823;
	Thu, 16 Oct 2014 13:59:13 +0200
In-Reply-To: <543F0DAE.2050205@optusnet.com.au> (Ben Aveling's message of
	"Thu, 16 Oct 2014 11:13:34 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 16 Oct 2014 13:59:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s9GBxCvs025630
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1414065555.70942@otYIWjjEcc2CeA7RyXQBVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Aveling <bena.001@optusnet.com.au> writes:

> And that seems sensible to me - the object is corrupt, it is unusable,
> the object graph is already broken, we already have big problems,
> removing the corrupt object(s) doesn't create any new problems, and it
> allows the possibility that the damaged objects can be restored.

Removing completely may remove a chance to restore the corrupt object
(rather unlikely, but I can imagine fine binary file surgery to un-break
a broken object file).

But we could move them out of Git's object directory (a bit like
.git/lost-found, we could have .git/corrupt). For unpacked objects, it's
trivial (just mv them in the directory). For packed objects, I don't
know what happens in case they are corrupt. That would solve essentially
any problem that you can solve by removing the file, but it makes the
operation reversible.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
