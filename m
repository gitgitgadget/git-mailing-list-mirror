From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] "git push": tellme-more protocol extension
Date: Thu, 20 Mar 2008 21:47:01 -0700
Message-ID: <7viqzgu1iy.fsf@gitster.siamese.dyndns.org>
References: <7vd4ppyggv.fsf@gitster.siamese.dyndns.org>
 <20080321023303.GE1613@coredump.intra.peff.net>
 <7vy78cu2kt.fsf@gitster.siamese.dyndns.org>
 <20080321042821.GA5453@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:47:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcZAW-0000iJ-GC
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 05:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbYCUErM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 00:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYCUErL
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 00:47:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbYCUErK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 00:47:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 63800253B;
	Fri, 21 Mar 2008 00:47:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 391C72539; Fri, 21 Mar 2008 00:47:04 -0400 (EDT)
In-Reply-To: <20080321042821.GA5453@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 21 Mar 2008 00:28:21 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77709>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 20, 2008 at 09:24:18PM -0700, Junio C Hamano wrote:
>
>> So a potential improvement might be to ask for "tellme-more" only if we do
>> not know any of the refs the receiver showed us; my patch does it if there
>> is at least one unknown instead.
>
> You can still get cases where doing this is more expensive than your
> patch, because A..B is very small but shared_tag..A is very large. I'm
> not sure which is more likely in practice.

Oh, I have a few fix-ups since I sent the patch, but I am not planning to
experiment with _your_ protocol myself.  Debugging one protocol extension
a week is painful enough ;-)

And tellme-more does not send _every_ commit.  The sender asks only about
the refs it does not know about, and the receiver sends densely near the
tip and then walks sparsely as it goes deeper, so the traffic wouldn't be
so bad.  Latency might be a different story, though.
