From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: sync() slowdown
Date: Mon, 26 May 2008 18:09:59 +0200
Message-ID: <vpq1w3p59ns.fsf@bauges.imag.fr>
References: <20080526142607.GA3082@kali.thurne.chezwam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastien Gross <seb-git@chezwam.org>
X-From: git-owner@vger.kernel.org Mon May 26 18:12:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0fJN-0000Kq-QD
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 18:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbYEZQLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 12:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbYEZQLr
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 12:11:47 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:54291 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677AbYEZQLq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 12:11:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m4QG9xv6017199;
	Mon, 26 May 2008 18:09:59 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1K0fGp-0002gA-5B; Mon, 26 May 2008 18:09:59 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1K0fGp-0005MY-2z; Mon, 26 May 2008 18:09:59 +0200
In-Reply-To: <20080526142607.GA3082@kali.thurne.chezwam.org> (Sebastien Gross's message of "Mon\, 26 May 2008 16\:26\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 26 May 2008 18:09:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82940>

Sebastien Gross <seb-git@chezwam.org> writes:

> I think this might be useful if you repack many repositories.
> If you call the sync command before looping the repacks I guess this
> could be equivalent (modulo changes done in repositories during that
> time).

I suppose git-repack does something like

write_new_data();
sync();
delete_old_data();

And if you remove the "sync" and your system crashes (or you eject
your USB key, or ...) while "delete_old_data" is done, but
"write_new_data" hasn't been sync-ed to the hard disk, you're in
trouble.

If you repack many repositories, I guess the first time is expansive,
but the next ones pay only for what they just did.

My 2 cents,

-- 
Matthieu
