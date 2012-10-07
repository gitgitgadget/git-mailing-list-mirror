From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Sun, 07 Oct 2012 13:51:21 -0700
Message-ID: <7vr4paovjq.fsf@alter.siamese.dyndns.org>
References: <201210051420.q95EKjj3008300@netbook1.inf.utfsm.cl>
 <op.wlp1lws70aolir@keputer> <7vsj9ssgcp.fsf@alter.siamese.dyndns.org>
 <20121005225758.GA1202@sigill.intra.peff.net>
 <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
 <20121006131200.GB11712@sigill.intra.peff.net>
 <7vvcenqx39.fsf@alter.siamese.dyndns.org>
 <20121006183026.GA3644@sigill.intra.peff.net>
 <CAOTq_pu=xWF7q3QobxSerkkbV56n5o+CPQSyHg8onwv73v25+A@mail.gmail.com>
 <20121006190753.GA5648@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Conrad Irwin <conrad.irwin@gmail.com>,
	Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 07 22:51:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKxp2-0007G0-3F
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 22:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044Ab2JGUvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 16:51:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45918 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab2JGUvY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 16:51:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F17089594;
	Sun,  7 Oct 2012 16:51:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6z86m7mh3krxAP5FbqGMZRmdYrI=; b=anp6a9
	63G6kfj1HrG4BxEaOfOtiH8TI+YG8MKeGH/aJUdUI1/UY4n0494XlfE2hk6rOpEU
	ZLMEDdOGXSxuTz4KcJ0rMDRxlXFrfVKj+8b0In1iY9het94a4+hXZ5f36tE2fQPb
	VzLk60KrgalMZuB8Se+KuXacVQm+8rZhhcUoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DvTP3I1Pt9NYb5BXXJLA4Iv+9dezCveP
	WgbgxRCL1eU2sVU1j0IwzXZmO5ca7/noNSODikMWtGgCK5r8TtGSNeHt3uJZyFtu
	u3EFJYSlkrzfcih5p684jjZyTblCYE+4/MDln0ziByIFLsD16z1Sc1IHfnPmw8eP
	NoVJo6b+spg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF03C9593;
	Sun,  7 Oct 2012 16:51:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AABD9592; Sun,  7 Oct 2012
 16:51:23 -0400 (EDT)
In-Reply-To: <20121006190753.GA5648@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 6 Oct 2012 15:07:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C102DD9A-10C0-11E2-A019-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207195>

Jeff King <peff@peff.net> writes:

> Yes. The more we talk about it, the more turned off I am by the idea.
> Above I posed my questions as "what _should_ we do when...". And I still
> think we _should_ default to --only with interactive, if we can find
> sane semantics. But until we can find them, it obviously does not make
> sense to enable it, and the whole discussion is stalled. And we must
> come up with an interim solution that is the least bad.
>
> Which is obviously one of:
>
>   1. Keep defaulting to "--include", as that is what we have been doing.
>
>   2. Forbid the cases where it would matter (i.e., when the index and
>      HEAD differ).
>
> The former is more convenient, but the latter is safer against
> future breakage. I'm OK either way, but option (1) clearly needs a
> documentation update.

Yeah, I agree with the reasoning.  This is an unessential feature
that is with the problem for a long time, so let's go the route #1
first before we do anything else.
