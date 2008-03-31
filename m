From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Auto detaching head options (update) (Re: Working copy revision
 and push pain)
Date: Sun, 30 Mar 2008 18:53:56 -0700
Message-ID: <7vy77zslor.fsf@gitster.siamese.dyndns.org>
References: <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com>
 <alpine.LSU.1.00.0803231519380.4353@racer.site> <47E66DAA.4080807@jwatt.org>
 <alpine.LSU.1.00.0803231555380.4353@racer.site> <47E6765D.2020103@jwatt.org>
 <alpine.LSU.1.00.0803231658460.4353@racer.site>
 <20080325192552.GC4857@efreet.light.src>
 <20080325232424.GB5273@coredump.intra.peff.net>
 <7v3aqde2wn.fsf@gitster.siamese.dyndns.org>
 <20080329082757.GA4920@efreet.light.src>
 <20080329084743.GA19200@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Watt <jwatt@jwatt.org>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 31 03:55:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg9En-0006TE-Bl
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 03:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbYCaByL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 21:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbYCaByK
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 21:54:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbYCaByJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 21:54:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 962161514;
	Sun, 30 Mar 2008 21:54:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BFBD41513; Sun, 30 Mar 2008 21:53:58 -0400 (EDT)
In-Reply-To: <20080329084743.GA19200@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 29 Mar 2008 04:47:43 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78541>

Jeff King <peff@peff.net> writes:

> On Sat, Mar 29, 2008 at 09:27:57AM +0100, Jan Hudec wrote:
>
> I like the fact that it deals with both these cases, and I think it can
> cover even more. It is a general safety valve for "somebody changed this
> ref while you weren't looking."
>
>> Besides whith the update above, I no longer propose to keep any new
>> information -- just to add a safety-check.
>
> And I like that, too. But I am a little worried that the information
> will not be sufficient. You are asking for a consistency guarantee of
> HEAD and HEAD@{0} that comes from using current porcelain.

While I too find the proposal attractive as a concept, I am sorry to say
that it would not work even with the current set of Porcelain (fwiw, when
the index-base extension was done, the approach based on HEAD reflog would
not have worked either).  This is because 605fac8 (update HEAD reflog when
branch pointed to by HEAD is directly modified, 2007-03-21) made gremlin
updates to the current branch tip to also update the reflog of HEAD.

If we revert that commit, we may be able to.
