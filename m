From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Wed, 12 Mar 2008 16:20:23 -0700
Message-ID: <7vtzjb34y0.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
 <7vskywadum.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803112234470.2947@xanadu.home>
 <7vbq5k77z0.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803121153160.1656@racer.site>
 <alpine.LFD.1.00.0803121143170.2947@xanadu.home>
 <FE263BF7-9948-463C-B9B2-833B068EB10B@ai.rug.nl>
 <alpine.LSU.1.00.0803121705330.1656@racer.site>
 <20080312170155.GB11236@coredump.intra.peff.net>
 <B27EC8CF-482D-499B-B4E0-019049926C93@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:21:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZaG0-0004zS-38
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 00:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbYCLXUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 19:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbYCLXUd
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 19:20:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYCLXUc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 19:20:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AEED922EB;
	Wed, 12 Mar 2008 19:20:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F2A0422EA; Wed, 12 Mar 2008 19:20:25 -0400 (EDT)
In-Reply-To: <B27EC8CF-482D-499B-B4E0-019049926C93@ai.rug.nl> (Pieter de
 Bie's message of "Wed, 12 Mar 2008 23:50:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77023>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> On Mar 12, 2008, at 6:01 PM, Jeff King wrote:
>
>> On Wed, Mar 12, 2008 at 05:05:51PM +0100, Johannes Schindelin wrote:
>>
>>>> I'd really like it to be at least 2 weeks
>>>
>>> Could you back that up with an explanation, as to why?
>>
>> I assume it's "because I wouldn't want to lose work I had done within
>> the last two weeks." Yes, I know that this expiration is actually
>> after
>> the reflog has already expired
>
> Ah, I hadn't realised that. Then I don't really care, one week sounds
> fine too. 2 weeks just seemed a bit short, as the default reflog is 30
> days. But if it's 2 weeks after the 30 days, that should be more than
> enough

Wasn't the default 90 days?

In any case, after 90 days, my reading of the code is that these loose
ones become unreachable, and when we look at their timestamps, we notice
that they are already more than 2 weeks old, and they will immediately be
removed.

So it won't be "2 weeks after X", either.
