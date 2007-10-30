From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/3] faster inexact rename handling
Date: Tue, 30 Oct 2007 01:29:22 -0700
Message-ID: <7vlk9lm2e5.fsf@gitster.siamese.dyndns.org>
References: <20071030042118.GA14729@sigill.intra.peff.net>
	<alpine.LFD.0.999.0710292156580.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Andy C <andychup@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:30:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImmTx-0001eS-6R
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 09:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbXJ3I3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 04:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbXJ3I3c
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 04:29:32 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:45574 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbXJ3I3b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 04:29:31 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7B6392F0;
	Tue, 30 Oct 2007 04:29:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2BB798E67B;
	Tue, 30 Oct 2007 04:29:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 30 Oct 2007, Jeff King wrote:
>>
>>   - no improvement on smaller datasets. Running "git-whatchanged -M
>>     --raw -l0" on the linux-2.6 repo takes about the same time with the
>>     old and new code (presumably the algorithmic savings of the new code
>>     are lost in a higher constant factor, so when n is small, it is a
>>     wash).
>
> Have you compared the results? IOW, does it find the *same* renames?
>
> I'm a bit worried about the fact that you just pick a single (arbitrary) 
> src/dst per fingerprint. Yes, it should be limited, but that seems to be a 
> bit too *extremely* limited. But if it gives the same results in practice, 
> maybe nobody cares?

If it always gives the same results in practice, obviously
nobody can even notice.

However, merging this series to 'pu' breaks rebase-merge test
t3402 among other things.
