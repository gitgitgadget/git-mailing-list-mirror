From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: allow use of basic email list in --cc --to and --bcc
Date: Tue, 18 Jun 2013 08:01:14 -0700
Message-ID: <7vip1b8nut.fsf@alter.siamese.dyndns.org>
References: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 18 17:01:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoxPO-0006AO-Me
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 17:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301Ab3FRPBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 11:01:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45112 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754995Ab3FRPBR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 11:01:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCA4626117;
	Tue, 18 Jun 2013 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9+Md+TaOb+Lu4EdupQB7Ksr+NM4=; b=jMRTwT
	aITGqF6YQVZMuS78lHBwGewYwUj/9V3hHrsNGjlDQp2dbHuk17t75k+BJCqueMYb
	L1u8K4pPI2jxQqQQrLktm5ODpE2mrnRsXiz+tdF/OGzR7+Vji5p71QgxIVr/dcnm
	I8Gh45sevw5R16rw+vsDSdD6Yn6JqoFRixls4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L/ifgqNkJvYCFjI4dndvPMhncbkcl0+2
	fajj8QV7FWNzzW2OvK9EZNivvyeGzYTM8ZD2VecEpAAyrSjEi1Ex8mHuVwEixuAr
	PImrKI7cijeE08nWJfZOxzyhZNAfCbAgHvnzz+sRYXwjkWyOHvjba1IjfbetyOgS
	kHnlSbmT8kQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0B6226114;
	Tue, 18 Jun 2013 15:01:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C70126113;
	Tue, 18 Jun 2013 15:01:16 +0000 (UTC)
In-Reply-To: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	(Jorge-Juan Garcia-Garcia's message of "Tue, 18 Jun 2013 11:51:19
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECC2D83E-D827-11E2-BFED-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228246>

Jorge-Juan.Garcia-Garcia@ensimag.imag.fr writes:

> From: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
>
> Make it so that we can use a list of email in flags
> instead of having to use one flag per email address.
>
> The format of email list handled is pretty basic for now:
> 	$ git send-email --to='Foo <foo@example.com>, bar@example.com'
> We thought it would be nice to have a "first-step" version which works
> before handling more complex ones such as:
> 	$ git send-email --to='Foo, Bar <foobar@example.com>'

Doesn't

	git send-email --to='Foo <foo@example.com>' --to='bar@example.com'

work?  If it does, I do not see much point of this change.  If you
are starting from two pieces of information, why combine it into
one, only have the program to split it again, risking to be bitten
by bugs, and changing the code to do so, risking to add new bugs?
