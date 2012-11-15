From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Thu, 15 Nov 2012 08:56:37 -0800
Message-ID: <7vvcd6954q.fsf@alter.siamese.dyndns.org>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003640.GH17819@sigill.intra.peff.net>
 <CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
 <20121115083315.GA23377@sigill.intra.peff.net>
 <CAMP44s2NBGDRLUKhBTU+kNy7Fyn8T6qm3nneSbS4rrNN1oPgdw@mail.gmail.com>
 <20121115104345.GA32465@sigill.intra.peff.net>
 <20121115111334.GA1879@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:56:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ2kI-00060C-Un
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 17:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768462Ab2KOQ4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 11:56:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768427Ab2KOQ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 11:56:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B233A4B2;
	Thu, 15 Nov 2012 11:56:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h1fomZCRuzjo0v8XGqN7A0FPl7U=; b=AJRiRH
	O4yDFwK/w17LtMPiaaVJT2qDkbuo8QwuGYRjbTiMH0koB6gzdG4dswVv8fnJ//jI
	XrOToFCb13mMKmP+DoU20+NkE1TFoLdQsOscz8VLaWYXlrrtfi0OEAS/oZrkFLvx
	IA18hbBjrAtMHzZ+/7njhgCSuO7k2d2FrknxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iWlWupD7E7U/56cpRblt//64sxUtVZ0e
	sIzGuOtiZfwZ3g4mSuG0t/mOLEJi+mCPe4wQdKZarvSd1nmxuy5o9GHymYpB4wjA
	ICJpfF/tnmoyE+hr5JfjvR2ZFPjWndAWaATyV7xuFW/VWTdszPbrtCjrsTL+XHug
	PWafvgQNOh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09067A4B1;
	Thu, 15 Nov 2012 11:56:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5536EA4B0; Thu, 15 Nov 2012
 11:56:39 -0500 (EST)
In-Reply-To: <20121115111334.GA1879@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 15 Nov 2012 03:13:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C77CD00-2F45-11E2-AFA4-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209831>

Jeff King <peff@peff.net> writes:

> I think a much more compelling argument/commit message for your
> suggested patch would be:
>
>   We currently prompt the user for the "From" address. This is an
>   inconvenience in the common case that the user has configured their
>   identity in the environment, but is meant as a safety check for when
>   git falls back to an implicitly generated identity (which may or may
>   not be valid).
>
>   That safety check is not really necessary, though, as by default
>   send-email will prompt the user for a final confirmation before
>   sending out any message. The likelihood that a user has both bothered
>   to turn off this default _and_ not configured any identity (nor
>   checked that the automatic identity is valid) is rather low.

This somehow reminds me of the first paragraph of f20f387 (commit:
check committer identity more strictly, 2012-07-23).

I never use "send-email driving format-patch" workflow myself, but I
suspect there are people among who do so who are using --compose to
do the cover letter of their series.  Does the "confirmation as the
last step" help them, or would they have to retype their message?
