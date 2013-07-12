From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] wt-status: use "format" function attribute for status_printf
Date: Fri, 12 Jul 2013 09:10:30 -0700
Message-ID: <7vfvvjoj2h.fsf@alter.siamese.dyndns.org>
References: <20130710001659.GA11643@sigill.intra.peff.net>
	<20130710002328.GC19423@sigill.intra.peff.net>
	<7vmwpvt28j.fsf@alter.siamese.dyndns.org>
	<20130710052859.GA5339@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 12 18:10:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxfvc-0006mW-I4
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 18:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932912Ab3GLQKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 12:10:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59859 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932699Ab3GLQKf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 12:10:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 814F83020F;
	Fri, 12 Jul 2013 16:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+dXed5uEbRhBhBYC6ZNd3rwvB6U=; b=bcHdJK
	NH9qtfgm6Xs3qMqpIjKuP/LJB2w3Lg5MtDzyAARXdpq/ppt1VPqiFV4Iflh9/HF4
	nKRt/L7dCiPR9BeU/K3aebFOuA8E3T1cu1D/traICQnHw5uncIh1A/F0afpgvunH
	cCC+ylY/xjaexrpMKZYckbkawcvym0hDUZOCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kPpOvuwOIRcEeO+91kDrIFPK136vPZn7
	/Lg7W5Ie5TmDSuInjZ+gv2amKQygATXIzSgWyvXmgBPhtG/7HxO7NdJWLwuIttjG
	//X2ex8O3QYYIUKKFGqzKy/2Kzkgnt1jzBkibd+WJ7nCt6UhT+9TNEhozo5uei4O
	nU7CBsM7yvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75F693020E;
	Fri, 12 Jul 2013 16:10:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D58F93020C;
	Fri, 12 Jul 2013 16:10:31 +0000 (UTC)
In-Reply-To: <20130710052859.GA5339@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 10 Jul 2013 01:28:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93A6D482-EB0D-11E2-969E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230202>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 09, 2013 at 10:26:04PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> ...
>> > I'm torn on this one. It really does provide us with more compile-time
>> > safety checks, but it's annoying that "-Wall -Werror" will no longer
>> > work out of the box.
>> 
>> Yeah, that is a show-stopper for me X-<.
>
> You can "fix" it with -Wno-zero-format-length, so the hassle is not
> huge. But I am also inclined to just drop this one. We have lived
> without the extra safety for a long time, and list review does tend to
> catch such problems in practice.

I am tempted to actually merge the original one as-is without any of
the workaround, and just tell people to use -Wno-format-zero-length.
