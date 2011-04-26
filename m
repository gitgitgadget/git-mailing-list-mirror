From: Jim Meyering <jim@meyering.net>
Subject: Re: "git clone --depth=2 git://git.sv.gnu.org/gnulib" hangs
Date: Tue, 26 Apr 2011 18:02:12 +0200
Message-ID: <87bozt9f23.fsf@rho.meyering.net>
References: <87aafedqjp.fsf@rho.meyering.net>
	<20110426075917.GA26874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEkiY-00083k-Dh
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 18:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab1DZQCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 12:02:21 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:33355 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745Ab1DZQCV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 12:02:21 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 28FFF940048
	for <git@vger.kernel.org>; Tue, 26 Apr 2011 18:02:13 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 91A3C60113; Tue, 26 Apr 2011 18:02:12 +0200 (CEST)
In-Reply-To: <20110426075917.GA26874@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 26 Apr 2011 03:59:17 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172103>

Jeff King wrote:
> On Mon, Apr 25, 2011 at 10:28:10PM +0200, Jim Meyering wrote:
>> We've had a report that this command is hanging:
>>
>>     git clone --depth=2 git://git.sv.gnu.org/gnulib
>
> It might be related to this deadlock which impacts upload-pack on a
> server with pthreads serving a shallow clone:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/170789

Thanks for the pointer.  That looks very promising.

Hoping to be able to test your fix, I rsync'd the offending repository to
a system on which I can experiment safely, but so far have been unable
to reproduce the failure there.  Of course, if my problem is indeed due
to the race condition bug that your patch fixes, it's not surprising
that it is unreproducible in a different environment.

> Unfortunately the fix I posted is not yet in any released version of
> git. It is in the current 'next'.
