From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git bisect old/new
Date: Fri, 15 Jun 2012 14:06:30 -0700
Message-ID: <7v62as9tex.fsf@alter.siamese.dyndns.org>
References: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 <1339541765-2078-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 <7vr4tkhys5.fsf@alter.siamese.dyndns.org>
 <20120613200606.Horde.QkenYnwdC4BP2NaOTf8gvnA@webmail.minatec.grenoble-inp.fr> <CAP8UFD2LBKXuey2w_-0Zy9Thi1DWCgekjCL3RULmHWVK5DXCog@mail.gmail.com> <7vlijper0e.fsf@alter.siamese.dyndns.org> <CABURp0qGUvjtOBp8vQ4LqWsWp-5oi+-2GwVq-edQbUnKzXHR-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	duperrav@minatec.inpg.fr,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	git@vger.kernel.org, Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Peff <peff@peff.net>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 23:11:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfdnH-0001rw-U2
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 23:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993Ab2FOVGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 17:06:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757985Ab2FOVGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 17:06:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 888BF8F66;
	Fri, 15 Jun 2012 17:06:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wFMWIXf84H6Iiuk5RuUy0QJaCe4=; b=LOoiRm
	73uZqrF05w+J3m5ss2XjtP52UXQEqUSd79VY83OoABFn8MKm6YiXhDOmXzEW15I0
	ORoyR7+C+FuN7yBRfAb+rU9oOdWP6MsPXMVAGB5cHWSri9hTa2Qah2PsFKmwCOS2
	zyHEKNyTZ0wCZ34DqkQZ8eZbcRmTWBZsKwjl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JTFPcceLC+J7rL6atXOJoHthUEdNVjA9
	jrXBoq5t7j0odjU+Wm8g8VJwB8dPj5PMsMW3XgXVIGHULBungm9rMm+IDavSeIIW
	tjhGMTxpVX1NlF28op9pB5ScYjdk5RTks3XBvDEFz4jAOoNWWAgKRFj/Iti5dGnj
	SBx+yiPyT/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F5728F65;
	Fri, 15 Jun 2012 17:06:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BC5C8F5C; Fri, 15 Jun 2012
 17:06:31 -0400 (EDT)
In-Reply-To: <CABURp0qGUvjtOBp8vQ4LqWsWp-5oi+-2GwVq-edQbUnKzXHR-A@mail.gmail.com> (Phil
 Hord's message of "Fri, 15 Jun 2012 16:20:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FBA10662-B72D-11E1-A2D8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200098>

Phil Hord <phil.hord@gmail.com> writes:

> Except that most of the work to support <arbitrary1/arbitrary2> is
> already being done in this patch to add <new/old>, but it will need
> re-doing or un-doing to move to arbitrary terms.  Supporting arbitrary
> terms today would save work (the re-doing and the un-doring), if we
> went that way in the future.

You are forgetting that "somebody wrote the code" does not matter
much.  What counds more is that the code is more complex than
necessary to support the case we are immediately interested in,
which means it is much more likely to have undiscovered bugs and
will take more effort to update if we need to change the aspects
other than "arbitrary two tokens" later.  "Somebody wrote the code
already" matters only when we are sure that we want to build on top
of it. In this case, we don't.
