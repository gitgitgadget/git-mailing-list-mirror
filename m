From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] teach sha1_name to look in graveyard reflogs
Date: Sun, 22 Jul 2012 13:53:19 -0700
Message-ID: <7vzk6rplfk.fsf@alter.siamese.dyndns.org>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213326.GB20385@sigill.intra.peff.net>
 <7vtxx3tlyb.fsf@alter.siamese.dyndns.org>
 <20120720155341.GD2862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Muranov <alexey.muranov@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 22 22:53:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St39c-0003qQ-SJ
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 22:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612Ab2GVUxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 16:53:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab2GVUxX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 16:53:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E96658801;
	Sun, 22 Jul 2012 16:53:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/ugYSSN7qMDB7HBBFHpUvzDIFjw=; b=etCaUv
	85cCHadOAb9c7Z4CMxNBjYpTEl9I1GhOOC1XcH9x/Qj/n6UjmVqCS6nHCDY8vXTB
	fD6obHoQ6dFcXRxeyocDjWbYg9vrq5SbQnol9g+dUvGzwGIKrg+Ar83VmEzUUrhG
	Sh/W2Mv2hiABrmqFsUkUs/lQV5dquTurefZpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kgXldqimNSEWy5tCgfzSO25ayAjb2pvT
	cBNaQpi+P5rX3BQISRKHazyVTr/J0/62Rx6PDQ9eiUodxkIGGt5jBHNoZGFS4Ig6
	X8qQNTIWnQM50S+BIxPCQBy6n7W2e8Exi0+P65JNmn8Hs+PvYnn3Aoxp5YU8Nczm
	JlRcsjrmLQI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D60008800;
	Sun, 22 Jul 2012 16:53:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B30987FF; Sun, 22 Jul 2012
 16:53:21 -0400 (EDT)
In-Reply-To: <20120720155341.GD2862@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 20 Jul 2012 11:53:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 460426D4-D43F-11E1-A853-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201862>

Jeff King <peff@peff.net> writes:

> But what _should_ it show for such an entry? There is no commit to show
> in the reflog walker, but it would still be nice to say "BTW, there was
> a deletion even here". Obviously just skipping it and showing the next
> entry would be better than the current behavior of stopping the
> traversal, but I feel like there must be some better behavior.

Like showing an entry that says "Ref deleted here", which should be
easy to do by creating a phoney commit object and inserting it to
the queue the reflog walker uses, I would guess.
