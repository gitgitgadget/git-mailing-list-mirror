From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] upload-pack: send the HEAD information
Date: Sun, 08 Sep 2013 10:27:50 -0700
Message-ID: <xmqqli351u7r.fsf@gitster.dls.corp.google.com>
References: <20130906155204.GE12966@inner.h.apk.li>
	<20130906155608.GF12966@inner.h.apk.li>
	<xmqqsixhyhan.fsf@gitster.dls.corp.google.com>
	<20130908071359.GJ14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 10 00:55:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAMc-0004rG-4F
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034Ab3IIWzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:55:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48498 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836Ab3IIWzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 18:55:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2944940322;
	Mon,  9 Sep 2013 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=otPIMuv/k/rHHGEKy69ayt2kIDk=; b=U9ON0EcyTKSoHXErh6P4
	/EbohapDl5nWRiAufdZQE1+tEu+FcM/vR/PMiCVf3blMhKAjrQZ37qahQMGHBjBh
	oYLm5GEL+qpXPX1Tl9XV0PYFgt5OD51ojSDaARAJ9BHckua95Td23wL5o2+x0Atb
	KW2anUgd3PdbBWkxNMrAiBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YPDShAxQY8PuLaj2U0+x7y1GSdqOJIEiHhXgws1O8PIeI5
	HkJYq9aP2ukPqn5l7sXOCEmaGEOCZsvOEFQzoD7NwXW0tkJ0CqPoLrZ2ZcWGJmac
	QWyeDZVa6aC280ffvVkJIYE+HjvfO0Bb5nhcGtGAefUmF4kizmKBaTs6KF8/c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A4C240321;
	Mon,  9 Sep 2013 22:55:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5C3440313;
	Mon,  9 Sep 2013 22:55:06 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DF03BF80-19A2-11E3-A90C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234394>

Jeff King <peff@peff.net> writes:

> It somehow feels a little weird to me that we would output the
> information about refs/foo on the HEAD line.

I see that you realized why the above is not the case in the
downthread; the capability list is not about describing HEAD. The
list happens to be on the line for HEAD merely because HEAD is the
first ref.

Unfortunately, the "read and replace capability if we see one" (not
"read and update capability with newly discovered one on a second
and subsequent capability list") is a restriction imposed by existing
reader side code that are deployed on the wild, so we need to stick
to it until we revamp the protocol in a backward incompatible way
(which has been discussed a few times; websearch for "who speaks
first" in the list archive).
