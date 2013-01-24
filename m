From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] push: introduce REJECT_FETCH_FIRST and
 REJECT_NEEDS_FORCE
Date: Thu, 24 Jan 2013 09:19:30 -0800
Message-ID: <7vvcamcxct.fsf@alter.siamese.dyndns.org>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358978130-12216-1-git-send-email-gitster@pobox.com>
 <1358978130-12216-4-git-send-email-gitster@pobox.com>
 <20130124065842.GC610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Chris Rorvick <chris@rorvick.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 24 18:19:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyQSz-0000f9-A8
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 18:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657Ab3AXRTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 12:19:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658Ab3AXRTf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 12:19:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C435B69C;
	Thu, 24 Jan 2013 12:19:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DMIwEqgO7BAU6bYaRybJi4n28QM=; b=ZjZBfL
	ZVfmUebG5u1n3r6P5aDoMUpW+svK0DG31F3f+PWshSY5mqmajWSGMIls8NkZ9TEu
	DjzP9k1xJqAEyQfhGLjgttds5W/kbGUOSrssFVAhs5DdRb+SSD9uEd6OFwajPYm7
	GR4vqdkAvYbBhqW8e/P/M89rY4CJGxyEyQij4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hMFenVKekMF94mmJefBgUM+V1+wxiKLZ
	MuHCyn/zIS2YITuIiI0Qr2kYObtZPUwT2NISGhM6Io4cu1poQa8+a5gKj5JSfGym
	KZ+WaSMonUANWQFxNG7mPHvzeqKlvcG72XNa3bDKxKciLdSiVyi7AeaaiHlltDUa
	LWHj2oKHcOQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE91FB69B;
	Thu, 24 Jan 2013 12:19:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D588B68E; Thu, 24 Jan 2013
 12:19:33 -0500 (EST)
In-Reply-To: <20130124065842.GC610@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Jan 2013 01:58:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38BCDF64-664A-11E2-83E6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214433>

Jeff King <peff@peff.net> writes:

> I wonder if we can reword it to explain more about why we do not have
> the object, without getting too inaccurate. Something like:
>
>   Updates were rejected because the remote contains objects that you do
>   not have locally. This is usually caused by another repository pushing
>   to the same ref. You may want to first merge the remote changes (e.g.,
>   'git pull') before pushing again.
>
> I was also tempted to s/objects/work/, which is more vague, but is less
> jargon-y for new users who do not know how git works.

After all this is "hint", and there is a value in being more
approachable at the cost of being less accurate, over being
impenetrable to achieve perfect correctness.

> Also, how should this interact with the checkout-then-pull-then-push
> advice? We make a distinction for the non-fastforward case between HEAD
> and other refs. Should we be making the same distinction here?

Possibly, but I am not among the people who cared most about the
distinction there; with the default behaviour switching to 'simple',
that distinction will start mattering even less, I suspect.
