From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Restrict ref-like names immediately below $GIT_DIR
Date: Wed, 19 Oct 2011 13:39:21 -0700
Message-ID: <7vwrc0bts6.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vehyjcckp.fsf@alter.siamese.dyndns.org>
 <20111012021128.GA32149@sigill.intra.peff.net>
 <7v39eyddoc.fsf@alter.siamese.dyndns.org>
 <20111012045004.GA22413@sigill.intra.peff.net>
 <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org> <4E95D60B.5030904@alum.mit.edu>
 <7vr52i9j8g.fsf@alter.siamese.dyndns.org> <4E9609E3.1000300@alum.mit.edu>
 <7v39epft32.fsf@alter.siamese.dyndns.org>
 <7vaa8wdbld.fsf@alter.siamese.dyndns.org> <4E9F33B9.4040803@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:39:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGcvO-0004jA-N0
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 22:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab1JSUj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:39:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33542 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753767Ab1JSUjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:39:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AA094DCA;
	Wed, 19 Oct 2011 16:39:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lU7q4BENS+aO9CNi1xrv/sZ9d2Q=; b=dkIfnl
	KOjcM924lEUNyyAx6upYZGQItdT9A04wHCoXK0JETpi5I5nAl90agxM5+67pfC2Q
	4xmj95XxSxtwUMzwMQuckxkxO1UQwyK+i2f7Aj/KKMkR9xY3PCxwc0ZgpxrA5XmK
	kLgdaRNSlzufwIyOz+EneAXBjFQ2cXjuVwy6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G2HWVNiciPtzFD0gUys8VYpuhtURC/e3
	gziAV2Z5eTEzP/J6B+VMmlGwnWDKm7F2WC0Vk6DQ0cGtPZHzBvgwe698QHPHasIw
	m+J7TbuuZyUaxJ6Uy9L4k016kV+siGGlCYywTGVzhTeo01MpC9+nT0F6WUOjiavr
	Bho7nTFGmWQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 108944DC9;
	Wed, 19 Oct 2011 16:39:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A44C4DC8; Wed, 19 Oct 2011
 16:39:23 -0400 (EDT)
In-Reply-To: <4E9F33B9.4040803@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 19 Oct 2011 22:31:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DD79B96-FA92-11E0-A14C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183947>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I would have preferred this change being applied on top of your first
> patch in jc/check-ref-format-fixup, because moving these functions to
> refs.c makes sense.

Thanks for a quick sanity check, and I agree.
