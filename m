From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-archive and tar options
Date: Thu, 14 Jul 2011 16:30:24 -0700
Message-ID: <7vwrfk1lv3.fsf@alter.siamese.dyndns.org>
References: <ivla29$liu$1@dough.gmane.org>
 <20110714015656.GA20136@sigill.intra.peff.net>
 <4E1F2468.6080409@lsrfire.ath.cx>
 <20110714172718.GA21341@sigill.intra.peff.net>
 <7vei1s36bl.fsf@alter.siamese.dyndns.org>
 <20110714212502.GA29848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 15 01:30:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhVMW-0006ae-Cs
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 01:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590Ab1GNXa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 19:30:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932558Ab1GNXa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 19:30:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EA3A4587;
	Thu, 14 Jul 2011 19:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eJ2PQ7jcU/Qc54RnfGybdgP3QWo=; b=danEqC
	zwIWhM9SznohD0Z7//bj4iwRtTN2ddENi9aQm+4c3DoOqRaCNUN8gU9Jjr8O8IyZ
	D4Hf+N+a7DZKnUpEmAnoSa8LWCoAEMOzwya8p2js7dpr2Oqf9RduA5/TMyinO8q4
	89gvJtdlXn9MVU2HABaKXK8F8rwJB4gwc9Trs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BhmG4gaglzWc6Bx3sZA1EQrobxxAzf4H
	vlKgIC7gzzVUCjgNIdWtx+tfnY7gGCrwtu+WogbzsOBIODgvhfuHLr3AriHRgeiU
	LvgGreC+r2Deoyzv+eZbdArdTh9d0gwpQFYZD+4P9xQOBjSj7fvC67Sm2eUdtg0N
	SaZnN2R0/AY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 355D24586;
	Thu, 14 Jul 2011 19:30:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B837E4585; Thu, 14 Jul 2011
 19:30:25 -0400 (EDT)
In-Reply-To: <20110714212502.GA29848@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 14 Jul 2011 17:25:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 407E157A-AE71-11E0-AC67-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177184>

Jeff King <peff@peff.net> writes:

>> Why?
>> 
>> The tree you are writing out that way look very different from what is
>> recorded in the commit object. What's the point of introducing confusion
>> by allowing many tarballs with different contents written from the same
>> commits with such tweaks all labelled with the same pax header?
>
> See my later message. I think it depends on how the embedded id is used.
> Is it to say "this represents the tree of this git commit"? Or is it to
> help people who later have a tarball and have no clue which commit it
> might have come from?

People, who have no clue which part of the subtree was extract and what
leading path was added, would still have to wonder where the tree came
from even with the embedded id. Without your patch, if the tarball has an
embedded id, wouldn't they at least be able to assume it is the whole
thing of that commit? If you label a randomly mutated tree with the same
label, you cannot tell the genuine one from manipulated ones.

Not that I have strong opinions on this, either, but that is what I meant
by "_introducing_" confusion.
