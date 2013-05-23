From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Thu, 23 May 2013 10:37:43 -0700
Message-ID: <7vli75fvh4.fsf@alter.siamese.dyndns.org>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
	<519C7431.8050208@drmicha.warpmail.net>
	<7vy5b7j7kc.fsf@alter.siamese.dyndns.org>
	<519DEA50.4030407@drmicha.warpmail.net>
	<7vr4gxhi8y.fsf@alter.siamese.dyndns.org>
	<519E366A.5040504@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 23 19:37:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfZSa-0005Ap-Ew
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 19:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758340Ab3EWRhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 13:37:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757992Ab3EWRhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 13:37:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39F0D208BC;
	Thu, 23 May 2013 17:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=auoV2FEq+WNEAp3DHvd30VPfO2k=; b=kItZuv
	HmKBWjbmXb14nHNv5/g7bhc+8wcSzSSCUShCMQwXmMwrIPNl9SS3zyc/w5HeHiLw
	T5u4XeJmPkhy73uEO5JmEjEWOOwUOfvtOmA8nymID/x9toO3O64s1PSC8x0F1uW7
	oDEu1GD5kOKnD3PC5Cc80raLVWB2FYCbKEsdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D/oLBYrU8+qWYJzeV8hFTKHgZ6IQtEEm
	JAqUi5LMUo6C6eH77T215DQplnm+rHiEhobHDPqPtDis/HjxKncYyEJ3k46EPdaX
	81zX9PR7bZRmBWbDw1KfCsF/64ZTFrmTb4+aoHM92p+QMsSJ7HdhrCHhPLDXeo3E
	FkFK371c1A0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31304208BB;
	Thu, 23 May 2013 17:37:47 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6FAB208BA;
	Thu, 23 May 2013 17:37:46 +0000 (UTC)
In-Reply-To: <519E366A.5040504@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 23 May 2013 17:31:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B30710C-C3CF-11E2-99E7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225273>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Well, if we decide "showing blobs with textconv is fundamentally
> different from showing diffs with textconv" then "--textconv" should not
> apply any textconv filters on blobs unless the user has specified them
> using a separate attribute (different from "diff").

I had an impression that the ship has already sailed wrt to "diff"
being pretty much interchangeable as "text" (or "non binary") in the
attribute system long time ago.

> Therefore, I hesitate introducing the behavior of the current series.
> For me, it would introduce something of a "mixed beast".
>
> I wouldn't hesitate introducing "textconv on by default for blobs the
> same as for diffs",

I would.  But I wouldn't for "the user asks for --textconv, the user
expects the blob shown with mangling", which sounds like a good
thing to do.

And there is anything wrong to refine later where exactly that
textconv filter is defined.  At this moment, "diff.textconv" is the
only place the user could even contemplate setting one, and there is
no risk for confusion.  "blob.textconv" can be introduced much later
when some users actually want to have a pair of different filters,
at that point "diff.textconv" will become a backward compatiblity
fallback for that filter.
