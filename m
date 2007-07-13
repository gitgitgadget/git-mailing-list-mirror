From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] More permissive "git-rm --cached" behavior without -f.
Date: Fri, 13 Jul 2007 20:53:38 +0200
Message-ID: <vpq8x9kp231.fsf@bauges.imag.fr>
References: <vpq8x9k9peu.fsf@bauges.imag.fr>
	<11843484982037-git-send-email-Matthieu.Moy@imag.fr>
	<20070713175737.GA20416@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 13 20:54:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9QHB-0001l2-Vd
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 20:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758472AbXGMSx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 14:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758251AbXGMSx6
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 14:53:58 -0400
Received: from imag.imag.fr ([129.88.30.1]:57602 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753307AbXGMSx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 14:53:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6DIrcSc007022
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 13 Jul 2007 20:53:38 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I9QGo-0006VK-6J; Fri, 13 Jul 2007 20:53:38 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I9QGo-0007DM-3i; Fri, 13 Jul 2007 20:53:38 +0200
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <20070713175737.GA20416@coredump.intra.peff.net> (Jeff King's message of "Fri\, 13 Jul 2007 13\:57\:37 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 13 Jul 2007 20:53:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52411>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 13, 2007 at 07:41:38PM +0200, Matthieu Moy wrote:
>
>> Previously, the index had to match the file *and* the HEAD. With
>> --cached, the index must now match the file *or* the HEAD. The behavior
>> without --cached is unchanged, but provides better error messages.
>
> This does make more sense, but there are still some inconsistencies. Is
> it OK to lose content that is only in the index, or not?

I'd say it isn't OK. At least, that's what the previous git-rm
considered.

> If it is OK, then --cached shouldn't need _any_ safety valve (and after
> all, anything you remove in that manner is recoverable with git-fsck
> until the next prune).
>
> If it isn't OK, then you are not addressing the cases where git-rm
> without --cached loses index content (that is different than HEAD and
> the working tree).

Either I didn't understand your question, or the answer is "yes, I
do.". The behavior without --cached is not modified, except for the
error message, and the previous was to require -f whenever the index
doesn't match the head, *or* doesn't match the file. So, without
--cached, you need to have file=index=HEAD to be able to git-rm.

If I missunderstand you, please, provide a senario where my patch
doesn't do the expected.

-- 
Matthieu
