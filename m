From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Wed, 06 Mar 2013 12:40:48 -0800
Message-ID: <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 06 21:41:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDL9L-0008Hj-Fn
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 21:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067Ab3CFUkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 15:40:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59386 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab3CFUkv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 15:40:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 779A1B6D5;
	Wed,  6 Mar 2013 15:40:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=suD8Bk0rghxdMkYGR361xqeLBOw=; b=BR8k5q
	6QuCGdf7gubWG4+fYqZtvHgGYWA4wmORlZMxsAariz0cjDnAxrONDIjSh7rsftGy
	FNbJqS7BlQsdXG8gx3EYJFt1S3dXvhVQlxDjWP4hCW8y4dX127Cs1pA+0ScyUMqn
	0XHzc6mOSOVHUgF7RMpDdvwbvHJbElTErL2l8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GvvAHcCYasJkRTY0fDZ7WCYA2B9ECLLj
	XAF633HnnY8CkpO0/GL3btGXEOdKUtNlGCDLuCrRYWXTrhEqgJ8shu4KxPQO4E4C
	amg6lvNhi9P1rX6ZKZhydXSy8s7WtFE+hcspjKs76rzFgI6igHr1Xd7km1mdZZ+M
	C6Qw9qA2VS8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69F7CB6D4;
	Wed,  6 Mar 2013 15:40:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5FD0B6D2; Wed,  6 Mar 2013
 15:40:49 -0500 (EST)
In-Reply-To: <20130306200347.GA20312@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Mar 2013 15:03:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2175AECA-869E-11E2-94B7-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217542>

Jeff King <peff@peff.net> writes:

> then it will produce the output that Uwe expects. While it can be
> misleading,...

Misleading is one thing but in this case isn't it outright wrong?

If you remove <<< ours ||| portion from the combined diff output,
I would expect that the hunk will apply to the base, but that is no
longer true, no?
