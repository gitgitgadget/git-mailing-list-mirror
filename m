From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 17:47:03 +0100
Message-ID: <vpqfy98660o.fsf@olympe.imag.fr>
References: <vpq64a4bzp1.fsf@olympe.imag.fr>
	<20070214142731.GA1478@moooo.ath.cx> <45D33485.5020906@webdrake.net>
	<17875.14305.910866.273778@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 17:47:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNI0-00035Z-9S
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbXBNQrX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbXBNQrX
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:47:23 -0500
Received: from imag.imag.fr ([129.88.30.1]:62597 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932403AbXBNQrV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:47:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l1EGl3Kn028425
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 14 Feb 2007 17:47:04 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HHNHb-0008CX-QL
	for git@vger.kernel.org; Wed, 14 Feb 2007 17:47:03 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HHNHb-0000pc-Ns
	for git@vger.kernel.org; Wed, 14 Feb 2007 17:47:03 +0100
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <17875.14305.910866.273778@lisa.zopyra.com> (Bill Lear's message of "Wed\, 14 Feb 2007 10\:25\:05 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 14 Feb 2007 17:47:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39677>

Bill Lear <rael@zopyra.com> writes:

> % cat ~/.gitconfig
> [alias]
> 	scp !scp
> 	rcp !rcp
> % git scp -rp . me@remotehost:/directory

[ in this case, I'd prefer using rsync ]

Well, this does not the same as being able to really use git to push.
First, you have no guarantee that the repository will be consistent
during the push. I belive the git repository format is relatively safe
with this regard since git doesn't rewrite data in-place, so the worst
that can happen is probably that someone gets a reference to a
not-yet-uploaded object.

But the real advantage of using the version control system to upload
is to avoid the case of 

$ cd /path/to/dumb/project
$ rsync ./ path:to/very/important/project/

since rsync/scp are not designed to look at the content of the
destination before overriding it. Using git, I believe such
miss-manipulation could lead to having irrelevant data in a
repository, but not to data-loss.

-- 
Matthieu
