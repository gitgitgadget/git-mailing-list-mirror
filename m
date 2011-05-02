From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Mon, 02 May 2011 22:14:56 +0200
Message-ID: <vpq62pssvun.fsf@bauges.imag.fr>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>
	<20110429223433.GA3434@sigill.intra.peff.net>
	<m2k4ecy6rv.fsf@igel.home> <7vfwp0uwu4.fsf@alter.siamese.dyndns.org>
	<m21v0kw1es.fsf@igel.home> <4DBE6E77.3030703@drmicha.warpmail.net>
	<BANLkTinxszGhtYobuvci5Yi8eTHW+pi2wA@mail.gmail.com>
	<4DBE8FD8.90303@drmicha.warpmail.net>
	<7v7ha9ngsf.fsf@alter.siamese.dyndns.org>
	<4DBEEEAA.3000004@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 02 22:15:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGzWa-00024w-Ux
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 22:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab1EBUPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 16:15:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47519 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965Ab1EBUPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 16:15:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p42KErUg026723
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 May 2011 22:14:53 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QGzWC-0000T4-Ci; Mon, 02 May 2011 22:14:56 +0200
In-Reply-To: <4DBEEEAA.3000004@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 02 May 2011 19:49:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 02 May 2011 22:14:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p42KErUg026723
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1304972097.90972@2h2KG5ym8JiXjv9vcWy3Yg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172628>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> I thought we already ruled out ~n because many shells think ~n is a path.
>
> You have, apparently ;)
>
> unquoted ~0 conflicts, but unquoted ~n conflicts only when you use pushd
> (and the stack has n entries; or n+-1, I can't count either...).

The problem is that it makes the behavior rather unpredictible for
non-expert:

git log ~2 # great
pushd
git log ~2 # still great
pushd
git log ~2 # WTF ?

so we can't teach new users the ~N syntax without quoting if we don't
want them to get bad surprises later. \~N is not terribly bad, but I
don't think it has a big added value compared to HEAD~N.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
