From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Thu, 06 Oct 2011 20:44:06 +0200
Message-ID: <4E8DF6F6.3000706@drmicha.warpmail.net>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org> <CAJo=hJvWbjEM9E5AjPHgmQ=eY8xf=Q=xtukeu2Ur7auUqeabDg@mail.gmail.com> <20111006171107.GA10973@elie> <vpqfwj6xceo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 06 20:44:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBsvZ-0002UZ-Ue
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759026Ab1JFSoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:44:12 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44634 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754609Ab1JFSoK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 14:44:10 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 59C25285AC;
	Thu,  6 Oct 2011 14:44:10 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 06 Oct 2011 14:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=nQC2mUeSgHQX3w7aPcqDwL
	ZtBek=; b=RoCUQWFodtZvB+gFBaH4mc9y67jumxg5YEUqScqeVXpWfVb4E5y8Lm
	LsyRbnASgrN4DOPdOlRaubTsXfSkweqCcvFt4sj1pmeI+56Tc5vNEb8qQdA3Ne8N
	ovpLCfusxFKOoRq0klAzhDUQTXZbSTZlK9Xz3IYV3y+9rC4YLWV70=
X-Sasl-enc: 4xAue6fSICr3wdeYbUvrN8dX2WXIBQ64khKCDRUybZ/r 1317926650
Received: from localhost.localdomain (p548596C7.dip0.t-ipconnect.de [84.133.150.199])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4733D7E090E;
	Thu,  6 Oct 2011 14:44:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <vpqfwj6xceo.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183014>

Matthieu Moy venit, vidit, dixit 06.10.2011 19:22:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> I probably missed some earlier discussion (so please forgive me this),
> 
> (same here)
> 
>> What happens if my old key is compromised and I want to throw away the
>> signatures and replace them with signatures using my new key?
> 
> With the patch we're discussing, signatures are part of history, hence
> can't be modified after the fact without rewritting them.
> 
> *But*, by design, unless sha1 itself is compromized (in which case Git
> would need to change to another hash function, that would be no fun),
> signing the tip of every branch is sufficient to sign the whole history.
> 
> So, your old signatures would remain there, and your new signature, for
> new commits, would be added on top.
> 
>> How does this relate to the "push certificate" use case, which seemed
>> to be mostly about authenticating published branch tips with
>> signatures that are not necessarily important in the long term?
> 
> I'm wondering how this feature would fit in a typical flow, indeed.
> Usually, I hack for a while, and when I'm happy enough, I push. But I
> don't take the decision of what to push at commit time, so if the idea
> is to sign only a few commits (i.e. the ones you push), then you should
> decide this at commit time ("hmm, I should commit --gpg-sign this time
> because I'm going to push this one").
> 
> If the idea is to sign every commit, then there should be a config
> option so that we don't have to type it every time.
> 

Same concerns here. You can always

git commit --amend --gpg-sign

the commit at the tip, of course, and can even set things up to have
push do this or remind you thereof.

I really liked the signatures as notes (because I feel those signatures
are attachments after the fact, not part of the commit) but can see how
distributing and merging them is non-trivial, and similarly checking
them at a point in time when they are not in a notes tree yet.

Michael
