From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Repo cleanup problem
Date: Fri, 11 May 2007 10:10:43 +0200
Message-ID: <vpqveezhjb0.fsf@bauges.imag.fr>
References: <9909dee80705110103h5b848490m296c001beecfa1f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 10:10:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmQDG-0000Qj-Bw
	for gcvg-git@gmane.org; Fri, 11 May 2007 10:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbXEKIKv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 04:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbXEKIKv
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 04:10:51 -0400
Received: from imag.imag.fr ([129.88.30.1]:37696 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbXEKIKt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 04:10:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4B8Ah5L023320
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 11 May 2007 10:10:43 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HmQD5-0006G0-4U; Fri, 11 May 2007 10:10:43 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HmQD5-0005Il-2G; Fri, 11 May 2007 10:10:43 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <9909dee80705110103h5b848490m296c001beecfa1f1@mail.gmail.com> (Eugine Kosenko's message of "Fri\, 11 May 2007 11\:03\:32 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 11 May 2007 10:10:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46943>

"Eugine Kosenko" <eugine.kosenko@gmail.com> writes:

> For now I'm looking for a way to remove the garbage commit.

Branch before the garbage commit. Then, you can use git-rebase to
replay the correct history on top of your new branch. Note that
git-rebase will break merging if you already used merge: it does not
"move" your old commits to your new branch, it instead creates new
commits with the same changes at the old ones, in the new branch.

That's probably what you've done already.

Then, to have git-gc remove the old, bad, history, you need to remove
any reference you have to it: branches and tags. git-branch -d and
perhaps git-tag -d will tell you.

See also git-fsck that can point you to dangling objects, which should
then be removed by git-gc.

gitk --all, on the other hand, will show you the commits to which you
have a reference (and their ancestry).

-- 
Matthieu
