From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] remote.c: use shorten_unambiguous_ref
Date: Tue, 14 Apr 2009 14:55:14 +0200
Message-ID: <49E487B2.5030606@drmicha.warpmail.net>
References: <1239291182-12860-1-git-send-email-git@drmicha.warpmail.net> <20090410171458.GA26478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 14:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtiC8-00070I-8u
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 14:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbZDNMzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 08:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbZDNMzX
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 08:55:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45741 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751330AbZDNMzX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 08:55:23 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 2CFC0319C21;
	Tue, 14 Apr 2009 08:55:22 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 14 Apr 2009 08:55:22 -0400
X-Sasl-enc: JI0z1UKah6y79fnqX/vHTIrDUm/dPI8C72olO8sKmNOM 1239713721
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6CF605CE3;
	Tue, 14 Apr 2009 08:55:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090414 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090410171458.GA26478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116534>

Jeff King venit, vidit, dixit 10.04.2009 19:14:
> On Thu, Apr 09, 2009 at 05:33:02PM +0200, Michael J Gruber wrote:
> 
>> Use the new shorten_unambiguous_ref() for simplifying the output of
>> upstream branch names. This affects status and checkout.
> 
> Yeah, this is the spot I was thinking about when I mentioned "use it in
> other places" earlier in the thread. So
> 
> Acked-by: Jeff King <peff@peff.net>
> 
>> I haven't seen more obvious place for using shorten_unambiguous_ref().
>> prettify_ref() is a natural candidate but is mostly used for
>> prettyfying refs on the remote side. git branch is covered by Jeff's
>> patch already.
> 
> Hmm. I was thinking we might be able to just do away with prettify_ref,
> but I didn't consider the fact that we need to prettify remote things. I
> think you could still unambiguously prettify the local half of those
> callsites, though.
> 
> Given that the two functions are closely related, should we perhaps
> rename them to
> 
>   const char *shorten_ref(const char *);
>   const char *shorten_ref_unambiguous(const char *);
> 
> ? The implementations are quite different, with prettify_ref not really
> respecting the ref lookup rules, but rather just considering a few
> pre-determined bits of the hierarchy as uninteresting. It shouldn't be
> that hard to have them both use the same implementation, like:
> 
>   const char *shorten_ref(const char *, int unambiguous);
> 
> -Peff

Should I rebase this on top of Bert's newer patch (which has the
signature you suggest)? Currently I don't see any of them in.

Michael
