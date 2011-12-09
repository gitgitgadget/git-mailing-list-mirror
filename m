From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/13] credential helpers
Date: Fri, 09 Dec 2011 10:00:44 -0800
Message-ID: <7vzkf1fwvn.fsf@alter.siamese.dyndns.org>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <7v7h29fkfy.fsf@alter.siamese.dyndns.org>
 <20111207064231.GA499@sigill.intra.peff.net>
 <7vmxb2hhne.fsf@alter.siamese.dyndns.org>
 <20111209022913.GA2600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 09 19:00:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ4kg-0002Zo-29
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 19:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab1LISAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 13:00:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41913 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab1LISAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 13:00:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61FBB71C4;
	Fri,  9 Dec 2011 13:00:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YGhOrKp+7pnP0Zo7jD8/QrMuwwo=; b=HGxutw
	/Fzo0gb46WOk/vtfPKdRgP80e6HrWROI+zKnnvJQc5I4oBuZcc1FvKOEpVK3YzVs
	ImJ/BGOtBzF2tBXHUbCCQJEjh6qUXBTn34c9mgHkTbyICh2s0xLommaU8b+/TNKO
	eAsW7GKBP3xXOmLEG7r+inGW8EQdHgxw4pUz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cQoUOXVvAEyjv7C13tsvhj3rJcJdfQY/
	6xryHA6dEqcBB3bdRur5WXf14vCGqQww2fea3qvol0MYrk+/ZH8aAvqH8PrVDBA3
	FFYZ6JG+YMhiWZ6w9vWkDgaf1qwFw9+xcM2ErGJ3eow4o1qtalzqdCLX7KunNlWI
	vrmWAOsu5x4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59B6A71C3;
	Fri,  9 Dec 2011 13:00:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDBA571C2; Fri,  9 Dec 2011
 13:00:45 -0500 (EST)
In-Reply-To: <20111209022913.GA2600@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 8 Dec 2011 21:29:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7EBE5BE-228F-11E1-AFD8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186657>

Jeff King <peff@peff.net> writes:

> It works, and it detects truncated output both ways properly (I know
> because I had to update every test, since the old output was missing the
> end-of-credential marker).
>
> It makes me a little sad, because the original format (relying on EOF)
> was so Unix-y.

It saddens me, too.  A reasonable middle ground would be to stop treating
an empty input as "no restriction" but "never matches".

I suspect that it is far more likely for a helper to fail (due to
configuration errors, for example) before it produces any output than
after it gives some but not all output lines.
