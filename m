From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Mon, 28 Oct 2013 08:41:12 -0700
Message-ID: <xmqqeh75h087.fsf@gitster.dls.corp.google.com>
References: <1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com>
	<xmqqeh79jmtr.fsf@gitster.dls.corp.google.com>
	<CAPNngRMP29s9gZg9R987yRd2qJ=UuaMWnFphtQdGDRgG_SCxsQ@mail.gmail.com>
	<87mwlwn4e0.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Milton Soares Filho <milton.soares.filho@gmail.com>
To: Keshav Kini <keshav.kini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 16:41:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaowU-00046b-7g
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 16:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712Ab3J1PlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 11:41:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756006Ab3J1PlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 11:41:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72CC34EBEA;
	Mon, 28 Oct 2013 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0ssdZqwOJBVfywJN+HVvEL4cAvo=; b=MN9Pgi
	+rwrCvLsM8X0zhtcTpGv9N5ER7fLRgM+PCgBJkuwRCIwpCw64/iZ0wbsmUGmHZIx
	WSbUfcGSeqECWr7TJBQ4sDWY8Cocw0V9Ip77XZ8MvBTQdxbNU/7TSL1onz63lAip
	JMyVli9dVcC2WPZkF+mNuOqCoYRu5i36C2cuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e0dtT8yTgcvPOJ9Kpqt0q+QcssG9rpBY
	pF+GwwVD/tLrYjjjZxOIbdWrelxfIZkFh2WB6qXtIO73LODPbpKCiUw0axr+5d8m
	L7i2iMUrlOI7EMGW09p9ZL0XDCSbzaE6sRyYh2JLcNKCv6Ym5XDEwdV3m12TG/V6
	Hj+FQyQJIVM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62E5B4EBE9;
	Mon, 28 Oct 2013 15:41:15 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A62414EBE3;
	Mon, 28 Oct 2013 15:41:14 +0000 (UTC)
In-Reply-To: <87mwlwn4e0.fsf@gmail.com> (Keshav Kini's message of "Fri, 25 Oct
	2013 21:37:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 60E64670-3FE7-11E3-B1B2-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236834>

[administrivia: please avoid culling addresses from To:/Cc: lines]

Keshav Kini <keshav.kini@gmail.com> writes:

> What about just putting an extra blank line after every root commit line
> (possibly except the last one)?  That should make it plenty easy to see
> where the root commits are in --oneline mode.  I think it would actually
> be easier to spot at a glance than replacing `*` with `x` because it
> creates a gap in all columns of the output, rather than only in column
> 1.  Also, this is very subjective but I think it looks kind of ugly to
> use "x" :P

I agree to all of the above, including the ugliness of 'x' ;-)

A "blank" may however be hard to spot, if the range is limited,
though.  For example,

    $ git log --graph --oneline a4..
      * HEAD
     /* a1
    | * a2
    | * a3
    * b1
    * b2
    * b3

where "a4", which is a root, is the sole parent of "a3" and HEAD is
a merge between "a1" and "b1" might produce something like this,
while we may get this from the same history, when shown unlimited:

    $ git log --graph --oneline
      * HEAD
     /* a1
    | * a2
    | * a3
    | * a4
    |
    * b1
    * b2
    * b3

A divider line might make it visually a lot more strong, i.e.

    $ git log --graph --oneline
      * HEAD
     /* a1
    | * a2
    | * a3
    | * a4
    |   ~~~~~~~~~~~~~~~~~~~~~~~
    * b1
    * b2
    * b3

but I am not sure if it is too distracting.
