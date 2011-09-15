From: Jeff King <peff@peff.net>
Subject: Re: [Survey] Signed push
Date: Thu, 15 Sep 2011 13:50:50 -0400
Message-ID: <20110915175050.GA20495@sigill.intra.peff.net>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <CACsJy8Dwu2U-7eEZU-VYmcrA7JwtvUkJS5SywXjZWoE1twchhQ@mail.gmail.com>
 <20110914210512.GA20294@elie>
 <CACsJy8BEES2j8K1v23RQQS=R1vRm1SVizBGFzq0wsDcMvC6Fjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 19:50:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4G5R-0006fC-LC
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 19:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934272Ab1IORux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 13:50:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41307
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934040Ab1IORuw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 13:50:52 -0400
Received: (qmail 23273 invoked by uid 107); 15 Sep 2011 17:51:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Sep 2011 13:51:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2011 13:50:50 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BEES2j8K1v23RQQS=R1vRm1SVizBGFzq0wsDcMvC6Fjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181482>

On Thu, Sep 15, 2011 at 08:42:40AM +1000, Nguyen Thai Ngoc Duy wrote:

> Yes, I think we can do that already. It's just more convenient to
> teach "git fetch/pull" to take pull requests and automatically verify
> them. Some repositories may also want to enforce signing and we can do
> that by setting config file and fetch/pull refuses if pull requests
> are not signed. We can also store the sign as git notes, just like in
> git-push (extra work if it has to be done manually).

Isn't there a human element in the verification? I.e., I see a pull
request, and we can computationally verify that it is signed by some
key. Now assuming GPG's web of trust works, that binds that key to an
email address and a real name. But how is that bound to the repository
you are actually fetching from (or more appropriately, that the commits
mentioned are appropriate to be pulled)?

That is a policy that the human must decide upon seeing "Oh, a pull
request from developer X; I should pull that into my local branch Y",
and which they do implicitly when they manually run the pull command
mentioned in the email.

Another way to think of it is that verifying the identity of the sender
(which GPG does) is only one step. You also need an ACL saying that the
sender is worth pulling from.

So either:

  1. The human is still in the loop, in which case having git-pull
     verify the sender's identity hasn't really done anything (because
     probably their MUA already told them it was really from the
     purported sender, and then they made the ACL decision in their head
     before deciding to pull from you).

  2. The human is not in the loop, and nothing is checking that ACL.

-Peff
