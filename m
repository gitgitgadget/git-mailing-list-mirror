From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor
 of bad rev
Date: Thu, 10 Jul 2008 13:02:09 -0700
Message-ID: <7vd4llpkxq.fsf@gitster.siamese.dyndns.org>
References: <20080710054152.b051989c.chriscool@tuxfamily.org>
 <alpine.DEB.1.00.0807101201210.3135@eeepc-johanness>
 <200807102126.37567.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:03:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH2Ms-00036s-MI
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 22:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875AbYGJUCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 16:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758843AbYGJUCY
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 16:02:24 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758755AbYGJUCX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 16:02:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D1B72602A;
	Thu, 10 Jul 2008 16:02:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EEA1F2601D; Thu, 10 Jul 2008 16:02:11 -0400 (EDT)
In-Reply-To: <200807102126.37567.chriscool@tuxfamily.org> (Christian Couder's
 message of "Thu, 10 Jul 2008 21:26:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1BD3C1F2-4EBB-11DD-BF5E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88003>

Christian Couder <chriscool@tuxfamily.org> writes:

> Yeah, in that case...
>
>> The whole idea of "bisect" relies on that idea, that any ancestor of a
>> good commit is good.  Otherwise you'd have to check the commits one by
>> one, not in a bisecting manner.

Didn't we already discuss this at length?

> No, you just need to check that the merge bases between the bad rev on one 
> side and each good rev on the other side are good too. And if that is the 
> case, then you can be sure that bisection will point to a first bad commit.
>
> So the choice is between a simple and fast but not fully reliable bisect, or 
> a more complex and slower but fully reliable bisect.

I have not looked at your implementation, but I do not think:

 - The current one is not "fully reliable"; the user needs to know what
   he is doing.  You might call it "prone to user errors".

 - "Test this merge-base before going forward, please" will add typically
   only one round of check (if you have more merge bases between good and
   bad, you need to test all of them are good to be sure), so it is not
   "slower nor more complex".
