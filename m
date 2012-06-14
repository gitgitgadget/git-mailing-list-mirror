From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fixup! 8e00b48 don't allocate struct wt_status_state
 dynamically
Date: Thu, 14 Jun 2012 10:13:54 -0700
Message-ID: <7vy5nperzh.fsf@alter.siamese.dyndns.org>
References: <7vk3zag6jg.fsf@alter.siamese.dyndns.org>
 <20099.6449254037$1339662032@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 14 19:14:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfDcQ-0006IS-8y
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 19:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129Ab2FNRN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 13:13:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62130 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756037Ab2FNRN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 13:13:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28AFC8205;
	Thu, 14 Jun 2012 13:13:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7wWYtDodQw12wvD+IsVHYo0m8uo=; b=W9bIda
	S3kC3IomqhJhrRsEBuwe9ivr1/dB7xM7Uj1XET7YMUsbSKDsRGSeqTbLOuVGr4g2
	vAmkLH5bIh3x+WayKSFuBeLEgQcOsoBmTNjwBb3oB8mnPAMxTV2fbuTbZUVGZrAz
	Ux+zZ5J5vj7RBxgAS5P+Xtifkglst4M+VB+0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JhuI8RWeMIT6wj4A3+9FTmeOyH26t0kX
	SE8Gg2cezV45SNqmS5SjcfvP4F2Xd911oOd0jhBcLTFYR6NOlxtALbyo4B2oYWxm
	l8mYoEapWVh5uGMFRX0s3T1Randk3LJTC5vmcjaTuxeVZuXt76R4UdaIGSg+Lc1o
	G3JC4nMm64M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20CB18203;
	Thu, 14 Jun 2012 13:13:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FAE58201; Thu, 14 Jun 2012
 13:13:55 -0400 (EDT)
In-Reply-To: <20099.6449254037$1339662032@news.gmane.org> (y.'s message of
 "Thu, 14 Jun 2012 10:20:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 527612C4-B644-11E1-9F29-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200020>

y@imag.fr writes:

> From: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> The common
>
> void function() {
> 	struct wt_status_state *state = calloc(...);
> 	...
> 	free(state);
> }
>
> is essentially a less efficient, and more error prone way of allocating a
> variable on the stack (plus, the calloc should have been a xcalloc).
> Replace it with an on-stack variable.
>
> While we're there, also replace the individual initializations of fields
> with memset(..., 0, ...).
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>
> (BTW, I didn't find a way to have both --autosquash-compliant and
> meaningfull titles)
>
>  wt-status.c | 49 +++++++++++++++++++++----------------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)

Thanks; much better.
