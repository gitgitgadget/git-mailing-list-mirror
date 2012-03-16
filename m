From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Edit a rerere conflict resolution
Date: Fri, 16 Mar 2012 09:42:47 -0700
Message-ID: <7vobrwh4zc.fsf@alter.siamese.dyndns.org>
References: <4F5E4B20.5080709@lyx.org>
 <7vobs1r3kn.fsf@alter.siamese.dyndns.org> <4F636227.2060102@lyx.org>
 <7vaa3gilg7.fsf@alter.siamese.dyndns.org> <4F636700.2090105@lyx.org>
 <7vvcm4h61a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 17:42:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8aEy-0007nv-5k
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 17:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422762Ab2CPQmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 12:42:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685Ab2CPQmu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 12:42:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D98E7620;
	Fri, 16 Mar 2012 12:42:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iwZz2by92DvbrQAOC+GFB+MPKdE=; b=H1qn3S
	KGorDvXGNUQurbeIzrjswguSSKbPBlHumYThZFfqoqrcBBj71OFXheey4VhXFAWl
	x3OXxOBon/aVXWY4Eahfa8kb34JeX2r68cEsmzbSERb4N6hASbjLE4oXFfV2UVB3
	XnQZkIGXV1e3GrG03ZW7CcNfSqUIq7nyBQpFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GdtoAlcksLbE/m184bvooibfz5si62RP
	xFPsdDUbIkg1r3Va3AucEJ0ipZXy3nytKdVi1471iM0GhJmgWyU4GEJGZM1CvVoa
	rhtNwEs1Q4qaWbTxGMVmFKQp3gc2WTKADeU9LK6XtilfSw3NuBLMiRVL7gINOyn6
	fHLth22cy0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43EE4761F;
	Fri, 16 Mar 2012 12:42:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0B7D761D; Fri, 16 Mar 2012
 12:42:48 -0400 (EDT)
In-Reply-To: <7vvcm4h61a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 16 Mar 2012 09:20:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10A9C10A-6F87-11E1-A9E2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193277>

Junio C Hamano <gitster@pobox.com> writes:

> Vincent van Ravesteijn <vfr@lyx.org> writes:
>
>> No, I turned rerere.autoupdate off. Proven in the above by the line
>> "Resolved... " instead of "Staged...".
>
> Yeah, actually I just tried and the procedure works with or without
> autoupdate for me.
>
> So there is something different between our setup (or the nature of the
> conflict), but I do not know what it is offhand.

The last message from me on this topic for now as I'll be a bit too busy,
but a wild guess/hunch: grep NEEDSWORK near rerere.c::handle_cache()?

I suspect that we might need to also update this function to handle "both
sides added, but differently" case, as we do so in check_one_conflict()
these days, but for Vincent's particular case that shouldn't be the cause.
