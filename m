From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC][PATCH] Re: git-rm isn't the inverse action of git-add
Date: Fri, 13 Jul 2007 19:36:25 +0200
Message-ID: <vpq8x9k9peu.fsf@bauges.imag.fr>
References: <46893F61.5060401@jaeger.mine.nu>
	<20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46895EA4.5040803@jaeger.mine.nu>
	<20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<vpq7ipittl2.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707022205210.4071@racer.site>
	<vpqoditkc23.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707031308170.4071@racer.site>
	<vpqir91hagz.fsf@bauges.imag.fr>
	<20070704200806.GA3991@efreet.light.src>
	<vpqd4z7q820.fsf@bauges.imag.fr> <vpqfy3yajbj.fsf_-_@bauges.imag.fr>
	<Pine.LNX.4.64.0707081855300.4248@racer.site>
	<vpq1wfi8wjl.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707082240510.4248@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
	Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 13 19:37:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9P4w-0000Xz-AV
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 19:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164AbXGMRhO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 13:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756174AbXGMRhO
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 13:37:14 -0400
Received: from imag.imag.fr ([129.88.30.1]:36088 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755886AbXGMRhL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 13:37:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6DHaPro022410
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 13 Jul 2007 19:36:25 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I9P45-0004sQ-Rv; Fri, 13 Jul 2007 19:36:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I9P45-0006jP-Np; Fri, 13 Jul 2007 19:36:25 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,  Jan Hudec <bulb@ucw.cz>, Yann Dirson <ydirson@altern.org>, Christian Jaeger <christian@jaeger.mine.nu>
In-Reply-To: <Pine.LNX.4.64.0707082240510.4248@racer.site> (Johannes Schindelin's message of "Sun\, 8 Jul 2007 22\:49\:10 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 13 Jul 2007 19:36:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52404>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > However, if some of the files are of the first kind, and some are of 
>> > the second kind, you happily apply with mixed strategies.  IMO that is 
>> > wrong.
>> 
>> I'm not sure whether this is really wrong. The things git should
>> really care about are the index and the repository itself, and the
>> proposed behavior is consistant regarding that (either remove all
>> files from the index, or remove none).
>
> Well, I think it is wrong for the same reason as it is wrong to apply the 
> changes to _any_ file when one would fail.  And since "git apply" shares 
> my understanding, I think "git rm" should, too.

OK, I've been thinking about it for some time (not having time to hack
can be good, it lets time for thinking instead ;-) ).

I'm actually still not convinced that my proposal was wrong, but I
think we disagree because we disagree on what is a "failure". I
consider leaving the file in the working tree to be just a safety
precaution, not a failure, and to me, it's OK to do that only for the
files that need it.

Fixing my patch by just "applying the same strategy to all files"
would be wrong: leaving _all_ the files on disk when just one has
local modifications is very misleading, and if the user notices it
after running the command, he or she does not always have an easy way
to get back to a clean situation (re-running the same command with -f
wouldn't work for example).

So, I went a shorter way from the current semantics:

* Allow --cached in more situations, so that -f is really needed in
  very particular situation (as I mentionned above, forcing -f too
  often means the -f gets hardcoded in the fingers, and makes it
  useless).

* Better error message, which points to --cached in addition to -f.

That's very close to what bzr does, BTW.

Drawback: it still doesn't solve the "rm isn't the inverse of add".

The patch is quite straightforward, and will be in a followup email.

-- 
Matthieu
