From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/checkout: DWIM with -f -b
Date: Sun, 20 Jun 2010 17:09:32 -0700
Message-ID: <7vfx0htfer.fsf@alter.siamese.dyndns.org>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
 <1277051592-4552-2-git-send-email-rctay89@gmail.com>
 <1277051592-4552-3-git-send-email-rctay89@gmail.com>
 <1277051592-4552-4-git-send-email-rctay89@gmail.com>
 <7vvd9dtt54.fsf@alter.siamese.dyndns.org>
 <20100620201137.GA8502@coredump.intra.peff.net>
 <7vpqzltnp3.fsf@alter.siamese.dyndns.org>
 <20100620211605.GA2559@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 21 02:09:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQUaA-0001y5-Kp
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 02:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662Ab0FUAJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 20:09:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859Ab0FUAJl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 20:09:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F30ABD853;
	Sun, 20 Jun 2010 20:09:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nPAEHx1mXkwxnHpsyYHOfftr2vM=; b=id4BHr
	jkEoCUuglk64DHFIsbE9MoJtaYzIv3TZJndnK8XwWgA3hp2+UW4Wixy+Cmk2I+fv
	SUF4Af1UTCYNmxOMj5z5gCEeFHnX0XPAfuHx1s7QapKZWhRZ+1i3mRJPxiZkWvmU
	5DY1Tjxy4A9LQuxrrCz8MXLjhdJW0793AqhP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XYN3sMTnrP/4hUWBpbvGPw0BXTGkYmDA
	p4XLaJGqHcTiwSgaSWeLhpVaXLTFcYL9clCk8+heCU6izyQotde7wUc+Ebp/3GSG
	x+gyIYoYyPYjP6rToUvDYVlUpel+J375if6cMpQJo4CTGqT3Gp+vC94e3CywYwl8
	IdyOmrVVJ6o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A10EBD851;
	Sun, 20 Jun 2010 20:09:37 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6A55BD850; Sun, 20 Jun
 2010 20:09:33 -0400 (EDT)
In-Reply-To: <20100620211605.GA2559@sigill.intra.peff.net> (Jeff King's
 message of "Sun\, 20 Jun 2010 17\:16\:05 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 477CDBCA-7CC9-11DF-8D92-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149409>

Jeff King <peff@peff.net> writes:

> ...  For your workflow, I
> doubt it matters, but it is potentially destructive.

Yes; I thought the implication of "-f" to be destructive would be a
justification enough, but I agree with you that conflating the two may be
a bad idea.  When a user says "git checkout -f -b jch" after seeing the
command without "-f" fail due to existing "jch", it is quite clear that
the user wants to clobber the history of existing "jch" branch (why else
would he giving "-f"), but it is not a justification to clobber local
changes he has in the index and the work tree.
