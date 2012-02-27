From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: don't assume the merge filter ref exists
Date: Mon, 27 Feb 2012 11:33:49 -0800
Message-ID: <7vk4386pgi.fsf@alter.siamese.dyndns.org>
References: <20120227122609.GA26981@mx.loc>
 <1330355513-22351-1-git-send-email-cmn@elego.de>
 <20120227193044.GD1600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 27 20:34:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S26Kl-0003MD-Cw
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 20:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457Ab2B0Tdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 14:33:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398Ab2B0Tdw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 14:33:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDEE96FDF;
	Mon, 27 Feb 2012 14:33:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gVpYQP36QQtjdVn9UrEce8iV7u4=; b=ZS0KN5
	hQxfkIWmNpxrLp7hnJ+JORXQaix4+V6DpCYrAbOWzjVHRYxKxn3fLmudFjcrGXNr
	vo6F+eUc1hzpmXPtwH7V/Y6xst9WQv8EJNcMXdcRqV3ytZYwkQDcMboIGgPNeTF9
	yI+cRo8uJwhRdSZM16N+YGYMmSo+NIInFxVEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rs1eaRGcmZ3nYoaXC+/KwAqDcBwDncGz
	76M2/LpWD+qZFLsewnkarljzZQw4KToABZl0ew+coooEAR083yEAJBJ1ldCLOTKi
	R0ASnhdKl0g4qDHFF7iwWB2UyFiYtpjae7nWY3IrxVnly3YK/Hmw00bVLOwL09hQ
	+lZ+N8Tn5OE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4A106FDE;
	Mon, 27 Feb 2012 14:33:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C5A16FDD; Mon, 27 Feb 2012
 14:33:51 -0500 (EST)
In-Reply-To: <20120227193044.GD1600@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 27 Feb 2012 14:30:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA353686-6179-11E1-8DF8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191658>

Jeff King <peff@peff.net> writes:

> You would also get NULL if the object exists but is not a commit. Maybe:
>
>   die("object '%s' does not point to a commit", ...)
>
> would be better? It covers the wrong-type case, and is still technically
> true when the object does not exist.

For this particular message I like the above a lot better.  The output
from "git grep -e 'invalid object' -e 'bad object'" seems to show that
the use of both are fairly evenly distributed.
