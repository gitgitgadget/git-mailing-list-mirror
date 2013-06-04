From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] prompt: don't scream continuation state
Date: Mon, 03 Jun 2013 22:59:08 -0700
Message-ID: <7v8v2qa02b.fsf@alter.siamese.dyndns.org>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-2-git-send-email-artagnon@gmail.com>
	<87r4gjzi3d.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0=LzUe0k7rWcrbiiTZNOOGg+=SsQB3u2F2ysjb5AJ=qZw@mail.gmail.com>
	<20130603211556.GB23224@sigill.intra.peff.net>
	<CALkWK0=5XecaMpPPQgvJZTwR2QUUWVqbZK5p7af9R1HjA0U=OQ@mail.gmail.com>
	<20130604043836.GA3931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 04 07:59:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjkH6-0004iu-CL
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 07:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758219Ab3FDF7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 01:59:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50743 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab3FDF7K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 01:59:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4557C1FCF0;
	Tue,  4 Jun 2013 05:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BmpA0QqQZb2dPW2ps5XSbK4FFF0=; b=CvqbM8
	z6bLfNFE0ALEVlWymPduYTPosro3pSBErr03dFtDBBnHVO6RSwjk7GcvrJ3YIvEd
	ph4NXEs7jrBQ5rkpoWG64puceIoXJeCb5hSgpy7BBbUIdUc7Q4LnMWQN099UpQ/c
	JzTW19XHot1aCMNbxBmBjzu0klFuaFl8zQEXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=migYLeH3IN7soWvLqlpMr1X0lsapXSAl
	cicRbNya9E5XT3vrLuVMiUbVx8rIm5r2CWmF0cuu1MZX48kAdUBicf+WH+IiNQmw
	N3wHJe8ZsWSIdnHoGSjzg8XgbU6Az6XzkfBQZR5RKD84Yck0I1jYYA9N72DBxel1
	seA4vh+cviA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B5881FCEF;
	Tue,  4 Jun 2013 05:59:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B49BF1FCEC;
	Tue,  4 Jun 2013 05:59:09 +0000 (UTC)
In-Reply-To: <20130604043836.GA3931@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 4 Jun 2013 00:38:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFB31002-CCDB-11E2-A1B0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226316>

Jeff King <peff@peff.net> writes:

> Even better, we can hit a middle ground by abstracting away some of the
> complexity.

The latter half of __git_ps1 is already fairly nice; w/i/s/u/c/p and
friends can serve as the basis of such an abstraction, even though r
does want to be separated further.

I tried the GIT_PS1_SHOW* variables several times, but every time I
did so, I eventually had to give up because I simply couldn't read
and/or remember what */+#/$/% line noises meant.  If we had a custom
"collect these pieces and form the final presentation" mechanism, I
could easily replace these with mnemonic letters that can be more
easily memorable.
