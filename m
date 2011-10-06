From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Thu, 06 Oct 2011 19:22:55 +0200
Message-ID: <vpqfwj6xceo.fsf@bauges.imag.fr>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
	<CAJo=hJvWbjEM9E5AjPHgmQ=eY8xf=Q=xtukeu2Ur7auUqeabDg@mail.gmail.com>
	<20111006171107.GA10973@elie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:23:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrfP-0003JI-Fa
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758736Ab1JFRXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:23:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33099 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758813Ab1JFRXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:23:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p96HKI8q001343
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 Oct 2011 19:20:18 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RBrep-0004rN-M5; Thu, 06 Oct 2011 19:22:55 +0200
In-Reply-To: <20111006171107.GA10973@elie> (Jonathan Nieder's message of "Thu,
	6 Oct 2011 12:11:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Oct 2011 19:20:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p96HKI8q001343
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1318526422.62507@0AHQhchf8Ox2UMCYX+LEAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182989>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I probably missed some earlier discussion (so please forgive me this),

(same here)

> What happens if my old key is compromised and I want to throw away the
> signatures and replace them with signatures using my new key?

With the patch we're discussing, signatures are part of history, hence
can't be modified after the fact without rewritting them.

*But*, by design, unless sha1 itself is compromized (in which case Git
would need to change to another hash function, that would be no fun),
signing the tip of every branch is sufficient to sign the whole history.

So, your old signatures would remain there, and your new signature, for
new commits, would be added on top.

> How does this relate to the "push certificate" use case, which seemed
> to be mostly about authenticating published branch tips with
> signatures that are not necessarily important in the long term?

I'm wondering how this feature would fit in a typical flow, indeed.
Usually, I hack for a while, and when I'm happy enough, I push. But I
don't take the decision of what to push at commit time, so if the idea
is to sign only a few commits (i.e. the ones you push), then you should
decide this at commit time ("hmm, I should commit --gpg-sign this time
because I'm going to push this one").

If the idea is to sign every commit, then there should be a config
option so that we don't have to type it every time.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
