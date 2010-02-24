From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shortlog: do not stall when there is no input
Date: Wed, 24 Feb 2010 11:31:39 -0800
Message-ID: <7vvddmmnvo.fsf@alter.siamese.dyndns.org>
References: <201002242020.27801.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 20:31:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMxc-0001rL-2B
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757757Ab0BXTbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 14:31:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757675Ab0BXTbp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 14:31:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CE089C313;
	Wed, 24 Feb 2010 14:31:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mnpxr57+/U7h8Jl5DgWeTUYHnog=; b=nNCuPb
	GR3/SKHnVKCGlsggWmu7e5H2BYvmeSMokLyaUB7hKq2yexwwuoviKlbibBgt2+39
	JXdid4o+3Xs50RJCA1jD1Yo3XgxPUhWVodPBlboBo96kBShdLNLWzqSP0e4IA+x9
	eUiGcW9zrOoHz07jCDBaYtjaSO7HZd5D97mFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XaVAU0U1iqfJObcmMjo15lK53JKCSFBS
	EaC1vPrLtnMudKhohG09eYck+4gwZ9n6kmAVmlUPfO4B0lnO9lXVZKHDWZMRQGCe
	l4QjHPi6JAZYgDKyXP8aaNnJKFQoLAMG/abl4rG9K6RNnLHfgp/wUnEBZfcd0adI
	14mDLxjyaSI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B9829C30E;
	Wed, 24 Feb 2010 14:31:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 770B29C30D; Wed, 24 Feb
 2010 14:31:40 -0500 (EST)
In-Reply-To: <201002242020.27801.barra_cuda@katamail.com> (Michele Ballabio's
 message of "Wed\, 24 Feb 2010 20\:20\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3CDC9538-217B-11DF-B159-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140979>

Michele Ballabio <barra_cuda@katamail.com> writes:

> A simple "git shortlog" outside of a git repository used to stall
> waiting for an input. Fix this by testing with isatty() before
> calling read_from_stdin().

I'd actually prefer doing what "git commit" does.  Give a helpful hint
that it is waiting for input from the standard input, but do read from
standard input as the program is instructed to do.

That way people who drive the program with expect will not be broken ;-)
but that is a minor point.
