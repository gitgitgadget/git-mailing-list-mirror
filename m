From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 03 Sep 2008 15:46:14 +0200
Message-ID: <48BE9526.9030104@op5.se>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <200809022339.20123.johan@herland.net> <20080902214428.GA20355@sigill.intra.peff.net> <200809030945.08619.johan@herland.net> <20080903131507.GC12936@coredump.intra.peff.net> <20080903133446.GA6967@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 15:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kashi-0006sq-HD
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 15:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbYICNqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 09:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbYICNqT
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 09:46:19 -0400
Received: from mail.op5.se ([193.201.96.20]:55909 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbYICNqS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 09:46:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1D0FD1B80089;
	Wed,  3 Sep 2008 15:51:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w-S6tC-DTyT4; Wed,  3 Sep 2008 15:51:46 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.181])
	by mail.op5.se (Postfix) with ESMTP id A34A61B80079;
	Wed,  3 Sep 2008 15:51:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080903133446.GA6967@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94794>

Jeff King wrote:
> On Wed, Sep 03, 2008 at 09:15:07AM -0400, Jeff King wrote:
> 
>> Hrm. I thought we decided on a message like:
>>
>>   Previous HEAD position was 1234abcd
>>
>> when leaving the detached HEAD state, but it seems to have disappeared.
>> Maybe with the move to builtin-checkout (sorry, I don't have time to
>> bisect right at this second). Was that intentional?
> 
> OK, I lied. I did have time to bisect it.
> 
> It never worked in builtin-checkout, and I am a bit suspicious of the
> code (and comment) below. Why would we not want to show such a message
> if moving to a branch (as long as it is not a _new_ branch)? The patch
> below makes more sense to me.
> 
> ---
> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index b380ad6..b2c7d3c 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -386,12 +386,12 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
>  	}
>  
>  	/*
> -	 * If the new thing isn't a branch and isn't HEAD and we're
> +	 * If the new thing isn't isn't HEAD and we're

"isn't isn't"

>  	 * not starting a new branch, and we want messages, and we
>  	 * weren't on a branch, and we're moving to a new commit,
>  	 * describe the old commit.
>  	 */

Apart from the typo above, this patch makes a whole lot of sense.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
