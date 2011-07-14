From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-archive and tar options
Date: Thu, 14 Jul 2011 14:23:10 -0700
Message-ID: <7vei1s36bl.fsf@alter.siamese.dyndns.org>
References: <ivla29$liu$1@dough.gmane.org>
 <20110714015656.GA20136@sigill.intra.peff.net>
 <4E1F2468.6080409@lsrfire.ath.cx>
 <20110714172718.GA21341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 23:24:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhTOA-00017R-LB
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 23:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab1GNVXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 17:23:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754613Ab1GNVXM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 17:23:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBA274EE6;
	Thu, 14 Jul 2011 17:23:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kI56ryT5Vc9worufT52V6omiHEM=; b=ek2ui0
	OgzUTc3iHD3PFhff48IbJRHdDjOELYB2rIpfAE/WHlWqQVSwbsw8hxep4qteUCII
	ykg0TF0yrDrm/W62gidbgRFHpr/Me/r4e4IGV9Z9qNgTbsF8NG3pcHDxODmYkI/j
	m/XgO9Lq5dL4EQZjx2dTI0JD/mieVnlNcjUTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IkHMXTk0R+Ag162T/xduPP1oWrbCdQJf
	gtMEJulQuX8CutHOyn7PQ3SoX6WQHvRHO1Tc+u/WY453mwVAI6J3+JNRBStHlCjb
	gvpk1yyYDR2VP+MD76u9ePvr0EeZQ2OlqLsz07YSZCoc2J8VB1E0GDrLhlgL4TE8
	eiZq0tRuDVM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D31084EE5;
	Thu, 14 Jul 2011 17:23:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6596C4EE3; Thu, 14 Jul 2011
 17:23:11 -0400 (EDT)
In-Reply-To: <20110714172718.GA21341@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 14 Jul 2011 13:27:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A127E78-AE5F-11E0-8228-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177178>

Jeff King <peff@peff.net> writes:

> Couldn't you also do:
>
>   git archive --prefix=$prefix HEAD:$subdir >my.tar
>
> ? I guess that loses the pax header with the commit sha1 in it, though,
> because you are feeding a straight tree instead of a commit.
>
> We didn't when git-archive was written, but these days we have
> get_sha1_with_context to remember incidental things about an object we
> look up. It should perhaps remember the commit (if any) we used to reach
> a treeish, and then the above command line could still insert the pax
> header.

Why?

The tree you are writing out that way look very different from what is
recorded in the commit object. What's the point of introducing confusion
by allowing many tarballs with different contents written from the same
commits with such tweaks all labelled with the same pax header?
