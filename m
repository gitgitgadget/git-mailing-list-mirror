From: Junio C Hamano <gitster@pobox.com>
Subject: Re: auto merge bug
Date: Tue, 05 Mar 2013 07:44:13 -0800
Message-ID: <7vtxopvoky.fsf@alter.siamese.dyndns.org>
References: <CAOFaZ+5F1BcWNU=AkcnS53bQt1VfAfsFjp9EvRCL=7kYiU1ejg@mail.gmail.com>
 <20130305090326.GC13552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Krmpotic <david.krmpotic@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 05 16:44:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCu2q-0002Y0-EQ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 16:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009Ab3CEPoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 10:44:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756702Ab3CEPoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 10:44:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47FDFB625;
	Tue,  5 Mar 2013 10:44:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ru+397hQ3O/f/AKdeRRemUoPoUE=; b=ToPZ8P
	lXfKLsu2mqUvtcJvjjOeyIFiChWuzafwWlrXeXsLB4lEtkeQci4D8/8A6Dmn3/0O
	yHROJVluO6oBNadgZ7egbSgMJOTIPO07kNJ0MHUksiqIjfVtTFioYZE3Yg5ujsvF
	j1J1/OgHE3F51Vf5E93smkolHkSaFZ4i7oiJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DuL7RFfLzr0z3SOYuEYWgt+GYla0k8Ns
	DP4qJQU9qYGfxZHBZI+H5MPDcU093/ej6mZmK8tTKNdrOOrCznxTkVHkIlZ3L6nB
	Kc1pyNQCVVCe2WLX4fbPZYAUxEONJxY1+OGiYvh1XOHO+Bsxoybgmfpyy+yAt5d5
	t704Km2PsEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A7EBB623;
	Tue,  5 Mar 2013 10:44:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AADAAB622; Tue,  5 Mar 2013
 10:44:14 -0500 (EST)
In-Reply-To: <20130305090326.GC13552@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Mar 2013 04:03:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 884C0912-85AB-11E2-A245-2F862E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217454>

Jeff King <peff@peff.net> writes:

> I think the merge will produce the results you are looking for. This
> would have to be configurable, though, as it is a regression for
> existing users of "union", which would want the duplicate-line
> suppression (or maybe not; it will only catch such duplicates at the
> beginning and end of the conflict hunk, so maybe it is sane to always
> ask "union" to keep all lines).

The original use-case example of "union" was to merge two shopping
lists (e.g. I add "bread" and "orange juice" to remind me that we
need to buy these things, while my wife adds "bread" and "butter").

We do not necessarily want to end up with a shopping list to buy two
loaves of bread.  When the user verifies and fixes up the result, we
can keep the current behaviour and those who want to re-dup can add
one back, or we can change the behaviour to leave the duplicates and
those who do not want to see duplicates can remove them manually.

Given that the caveat you quoted already tells the user to verify
the result and not to use it without understanding its implications,
I think it technically is fine either way (read: keeping duplicates
is not a clearly superiour solution). So let's leave it as-is.
