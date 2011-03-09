From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: fix --max-count when used together with -S or -G
Date: Wed, 09 Mar 2011 14:27:32 -0800
Message-ID: <7vk4g87wvf.fsf@alter.siamese.dyndns.org>
References: <7vvczte7tw.fsf@alter.siamese.dyndns.org>
 <1299703935-639-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110309213824.GA4400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 23:27:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxRrA-0001PY-Gu
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 23:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759Ab1CIW1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 17:27:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab1CIW1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 17:27:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D2E04D51;
	Wed,  9 Mar 2011 17:29:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qnL5fhaLkgqNi7Oy1UzO+Cz0pXM=; b=eFJUdO
	D0I5QRUjjZOnwzOgsSJSzcvi3ZTH7/vNkwUhd2rfk6d79cuoTSt0lAlOGJ3rxHuH
	2M3yBwG8l1gGJwdNbk7JdgCQaWJB178MSsdWW31JCmnc8szIuUl2TatltujXV1aM
	QUIDSCOjPSsWdVHuSyIqdSdyl4K+MM0OIvhRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XfaIEUh/5WK1K2SAeAQ28y2r4jBT6RvU
	TWzaWD4fFYGD1aTIGNjjWmvu+1tzD8O6AIsNCBN0Jknuy7l/OWrumvqFrcAshCy1
	kEqZH7kS8wMdZtYDxAdRFJ8W0gzt7fwAx+kA3xr0Y3l4shKf+OkJqqmrjM+ADty8
	laRYjWfqno0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 280E94D4E;
	Wed,  9 Mar 2011 17:29:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E08834D44; Wed,  9 Mar 2011
 17:29:01 -0500 (EST)
In-Reply-To: <20110309213824.GA4400@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 9 Mar 2011 16:38:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4C216B4-4A9C-11E0-AE1A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168772>

Jeff King <peff@peff.net> writes:

> Hmm. Is this papering over a bigger problem,...

It is not very obvious to me if redefining the semantics of filtering done
by diff (the current definition is it is purely an output phase thing) is
necessarily a good thing. I agree that the interaction between the output
phase filtering and pruning done by the revision walker machinery is a
fine topic to discuss.

But Matthieu's patch is not papering over anything but is a real fix
within the context of the current architecture.
