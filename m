From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] wrap_in_html(): process message in bulk rather than
 line-by-line
Date: Sun, 02 Dec 2012 01:25:03 -0800
Message-ID: <7vpq2slsb4.fsf@alter.siamese.dyndns.org>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
 <1353841721-16269-9-git-send-email-mhagger@alum.mit.edu>
 <7v7gp4p00u.fsf@alter.siamese.dyndns.org> <50B8B73A.4060801@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Dec 02 10:25:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf5np-0004om-Ua
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 10:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808Ab2LBJZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 04:25:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab2LBJZG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 04:25:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3A2B9661;
	Sun,  2 Dec 2012 04:25:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bbs0LeHbTVoF0QGRx/K6+dMfisw=; b=loMEwt
	S2YHPwcAoJgNWht4496bf0BayVX8T+CJ5LuJUImWmjiPAln0whcl+rpwaQ+0mft5
	1qSFjx3KfR8gE+jZ+b13QOJzHDkf7JjZaLOFSrNTnSkvSJYaK7gqwtDeeLHu1m8P
	QetPTvgGKjsWYg+VLnC1zBsomrLNWG1jReCRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXdnm8qYiiLL70FiUiTbArxdrTnbKjU3
	TB0T0P6DBm8raEKajfhCRh+ZFENerKsH/EgDqBlFgtrnu4wNyedfKYWK3nngBEYB
	oUC61QuO8D7rd5F4f/oYt2x4quGNWeLaCBvEg5EAMoCmAy+BzgzPv3vjIA2AZKxF
	wIvOV7KuAKg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 929419660;
	Sun,  2 Dec 2012 04:25:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06EB1965F; Sun,  2 Dec 2012
 04:25:04 -0500 (EST)
In-Reply-To: <50B8B73A.4060801@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 30 Nov 2012 14:40:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2804957A-3C62-11E2-A783-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211005>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Nevertheless, the old code was even *more* broken because it added a
> "</pre>" regardless of whether the separator line had been seen,...

OK. I'll rewrite the tail-end of the original log message to read:

    The old code would have created invalid output when there was no
    body, emitting a closing </pre> without a blank line nor an opening
    <pre> after the header.  The new code simply returns in this
    situation without doing harm (even though either would not make much
    sense in the context of imap-send that is meant to send out patches).

and squash this in.

Thanks.
