From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 07 Feb 2011 07:48:42 +0100
Message-ID: <vpqbp2ojq5x.fsf@bauges.imag.fr>
References: <4D4DEDC4.4080708@hartwork.org>
	<20110206051333.GA3458@sigill.intra.peff.net>
	<4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr>
	<7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
	<20110207055314.GA5511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 07:49:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmKut-000229-V9
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 07:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab1BGGtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 01:49:39 -0500
Received: from mx2.imag.fr ([129.88.30.17]:55616 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302Ab1BGGti (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 01:49:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p176mgrU009085
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Feb 2011 07:48:42 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PmKtv-0004ZW-6u; Mon, 07 Feb 2011 07:48:43 +0100
In-Reply-To: <20110207055314.GA5511@sigill.intra.peff.net> (Jeff King's message of "Mon\, 7 Feb 2011 00\:53\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 07 Feb 2011 07:48:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p176mgrU009085
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297666126.69588@jhHLaruf1ACULcwcmo11AQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166237>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 06, 2011 at 09:50:37PM -0800, Junio C Hamano wrote:
>
>> As it takes pathspecs (think "git add -u this-file"), it fundamentally
>> shouldn't be tree-wide.  I think the original implementation didn't take
>> pathspecs and was mistakenly done as tree-wide operation, but I think it
>> was fixed rather quickly.
>
> Is "git add -p" broken, then? It takes pathspecs relative to the current
> directory, but "git add -p" without arguments operates from the root,
> not from the current subdirectory.

It's not just "git add -p". Take "git log", "git status", "git
commit", "git diff" ... well, most Git commands taking pathspecs
optionally:

git foo   => tree-wide
git foo . => the . acts as a path limiter

and this is the right thing to do. Making "git foo" equivalent to "git
foo ." makes it hard to recover the tree-wide behavior from a
subdirectory (git foo ../../../).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
