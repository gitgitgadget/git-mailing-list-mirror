From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: "git archve --format=tar" output changed from 1.8.1 to 1.8.2.1
Date: Thu, 31 Jan 2013 18:41:03 +0100
Message-ID: <20130131174103.GA20111@kroah.com>
References: <20130131172805.GC16593@kroah.com>
 <7vzjzpgswz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org,
	Konstantin Ryabitsev <mricon@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 18:39:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0y6k-0000yz-Gs
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 18:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab3AaRjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 12:39:08 -0500
Received: from mail.kernel.org ([198.145.19.201]:41571 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab3AaRjG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 12:39:06 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9D4CC202CF;
	Thu, 31 Jan 2013 17:39:05 +0000 (UTC)
Received: from localhost (ip-188-118-20-209.reverse.destiny.be [188.118.20.209])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 2BF9020274;
	Thu, 31 Jan 2013 17:39:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vzjzpgswz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215133>

On Thu, Jan 31, 2013 at 09:32:12AM -0800, Junio C Hamano wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > The way we upload the Linux kernel to kernel.org involves creating a tar
> > archive, signing the archive, and then just uploading the signature.
> > The server then checks out the repo based on the tag, generates the tar
> > archive and checks the signature to make sure they match.
> > 
> > A few days ago I released the 3.0.61 kernel, and it turned out that I
> > couldn't upload the kernel release because 'git archive' now creates a
> > binary file that differs from an older version of git.
> > ...
> > Now keeping binary compatibility of tar archive files isn't really a big
> > deal, but, the commit to git that causes this seems a bit odd, is it
> > really needed?  Or can we just fix the version of tar with NetBSD
> > instead?  :)
> >
> > Any ideas?
> 
> How about fixing kup to teach the "let's cheat and let the other end
> run 'git archive', if the resulting archive and GPG signature
> locally created does match, we do not have to transfer the tarball
> itself" trick a fall-back mode that says "but if the signature does
> not match, then transfer the bulk used to create the signature to
> the remote anyway".  This fallback can and should of course be
> useful for the compressed patch transfer.

Ugh, uploading a 431Mb file, over a flaky wireless connection (I end up
doing lots of kernel releases while traveling), would be a horrible
change.  I'd rather just keep using the same older version of git that
kernel.org is running instead.

thanks,

greg k-h
