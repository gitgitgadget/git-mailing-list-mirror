From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Allow git-shell to be used as a ssh forced-command
Date: Sat, 18 Apr 2009 09:46:25 +0200
Message-ID: <vpqzleev1ym.fsf@bauges.imag.fr>
References: <1239916256-10878-1-git-send-email-mh@glandium.org>
	<37fcd2780904170924t61168a49uf1800098cdb1d730@mail.gmail.com>
	<20090417194919.GA7611@glandium.org>
	<37fcd2780904171400uf9d1f36g4d24e02aebf6ac3f@mail.gmail.com>
	<20090417223649.GA1881@glandium.org>
	<20090417224104.GT23604@spearce.org>
	<20090417234425.GC17753@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Apr 18 09:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv5K5-00062b-Kw
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 09:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbZDRHtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 03:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbZDRHtO
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 03:49:14 -0400
Received: from imag.imag.fr ([129.88.30.1]:36595 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbZDRHtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 03:49:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3I7kQeV017661
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 18 Apr 2009 09:46:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lv5Fp-0004Q6-Lf; Sat, 18 Apr 2009 09:46:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lv5Fp-0003JP-Hv; Sat, 18 Apr 2009 09:46:25 +0200
In-Reply-To: <20090417234425.GC17753@glandium.org> (Mike Hommey's message of "Sat\, 18 Apr 2009 01\:44\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 18 Apr 2009 09:46:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116815>

Mike Hommey <mh@glandium.org> writes:

> However, the patch in its current form will definitely break gitosis if
> it doesn't unset SSH_ORIGINAL_COMMAND.

... and any home-made script without knowledge of this feature. If I
wanted to add some restrictions to git-shell, it would seem natural to
me to write a script like

#! /bin/sh

if [ ??? ]; then
	git-shell $whatever
else
	echo "Sorry, forbidden"
	exit 1
fi

(I never did this with Git because I never had to manage any kind of
permission control with it, but I have a script like that for SVN that
adds some argument to the SVN command)

If the command ignores its arguments, and use some other environment
variable instead, then the security hole is not far.

-- 
Matthieu
