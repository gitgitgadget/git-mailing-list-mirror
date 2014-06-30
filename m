From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] replace: add --graft option
Date: Sun, 29 Jun 2014 23:37:13 -0700
Message-ID: <xmqqr426zyw6.fsf@gitster.dls.corp.google.com>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
	<20140604194353.23903.89933.chriscool@tuxfamily.org>
	<xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
	<CAP8UFD2u-DReCv2ZXhAzH_UMW5P--+a=AKS-N88xE6zmdWBLqQ@mail.gmail.com>
	<CAP8UFD344NFECqtO-uK-2wHA7XEko3XMJWuhW9+KGBdaiqGq+w@mail.gmail.com>
	<CAPc5daWBycdmKBZXGhhy4_649p_JFfGf7RQbqa08XA1hL9mFTg@mail.gmail.com>
	<CAP8UFD25k4X0vVUDDTOj_XDqmShz-aHXFLKD5bruUYYLX6awow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 08:37:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1VDQ-0004HD-W9
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 08:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbaF3GhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 02:37:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54545 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbaF3GhU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 02:37:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 475611D4FF;
	Mon, 30 Jun 2014 02:37:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wOA9j5bfpDXNxggprM7bAuaKyDo=; b=lFKTbU
	YXwKryEf1/lUSX8A6TG7CT0lwnu1HwtO7DrCK4xt1a/3/QEcmrPv/E5TxJZzcFvJ
	mJSDXGJ1vrFjYiesISDl2sDCK6Agf1Umvmi1X//lQeUhCwsQDlx9d69Z9Q49WrCz
	gwefya6Ddw+Q9wZEWwTBxfpgBcDAWKPBn4Lao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZKHHBFQ8xi6X4aEvOEJLc6cuV6wBg1VU
	f5yvl9rsnYQ58nsGhWY8UmW23bF25gJtB3nE8zHwAbOZKUASxll9heYV0EVHUTKE
	pFCUFiJoSMVIQcq6+amLZHl+LFzcCvWehT0qLy7G1hTxZP3vVPOL9GI5PnfHvI/n
	sXPrF8ERh8I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 381E31D4FE;
	Mon, 30 Jun 2014 02:37:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6226C1D4FD;
	Mon, 30 Jun 2014 02:37:06 -0400 (EDT)
In-Reply-To: <CAP8UFD25k4X0vVUDDTOj_XDqmShz-aHXFLKD5bruUYYLX6awow@mail.gmail.com>
	(Christian Couder's message of "Sun, 29 Jun 2014 08:34:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F43654D4-0020-11E4-BBEE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252654>

Christian Couder <christian.couder@gmail.com> writes:

> Now, after having read the recent thread about "git verify-commit", I understand
> that you also want me to drop the signature of a tag that was merged, because
> such signatures are added to the commit message.

Huh?  I am not sure if I follow.  Perhaps we are talking about
different things?

When you are preparing a replacement for an existing commit that
merges a signed tag, there are two cases:

 - The replacement commit still merges the same signed tag; or

 - The replacement commit does not merge that signed tag (it may
   become a single-parent commit, or it may stay to be a merge but
   merges a different commit on the side branch).

In the former, it would be sensible to keep the "mergetag" and
propagate it to the replacement; it is a signature over the tip of
the side branch being merged by the original (and the replacement)
merge, and the replacement will not affect the validity of the
signature at all.  In the latter, we do want to drop the "mergetag"
for the parent you are losing in the replacement, because by
definition it will be irrelevant.
