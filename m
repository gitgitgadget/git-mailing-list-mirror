From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and arguments
Date: Fri, 14 Feb 2014 13:46:58 -0800
Message-ID: <xmqqfvnlgyel.fsf@gitster.dls.corp.google.com>
References: <xmqq38jqsnc2.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Nq-LkE=FW5dnBZKKd7-ORJPo1BFs3sY+MLGxuXEWuTw@mail.gmail.com>
	<xmqqa9dxr09k.fsf@gitster.dls.corp.google.com>
	<20140214.224133.484636406629780362.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: christian.couder@gmail.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	sunshine@sunshineco.com, dan.carpenter@oracle.com, greg@kroah.com,
	peff@peff.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 14 22:47:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEQbJ-0002hz-G4
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 22:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbaBNVrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 16:47:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbaBNVrH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 16:47:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A23FC6DD75;
	Fri, 14 Feb 2014 16:47:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gXsj1T7AT3GF2apn0PAg3C/f3W4=; b=JahFgE
	aBlQsD9co1eY3s5QvCKKc2dASlY69Mh88U9HXXGeeDgle5DrTBRVU97Bnw06sDei
	gqkZah3hKwS1UqfT20JqOF4C/u70kX6agJX4HwE/PR8Gr/f2YQtc+VevxmLcRrqw
	ac1SnCsIzRphmQagKcZHLpK+IWtp2htWpjq/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LNcc0F8oDAn+/w6LauRhDeOJO8YPvG5m
	dmI4hymoenFDO3d5r6m3GydMes9s4CglMnw3eQzrdZ0hdd/V5DI48N48nvdiQ6Mw
	i1gDoN60W1RwjUbU5fM+3vkKphRfVe8xR6DB6z7lh/DoIBbGPjajXVvRLJBAg+Cy
	Xs0E9Y1PCW8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E49D6DD74;
	Fri, 14 Feb 2014 16:47:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 954D46DD72;
	Fri, 14 Feb 2014 16:47:03 -0500 (EST)
In-Reply-To: <20140214.224133.484636406629780362.chriscool@tuxfamily.org>
	(Christian Couder's message of "Fri, 14 Feb 2014 22:41:33 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8A8D9F3E-95C1-11E3-8185-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242150>

Christian Couder <chriscool@tuxfamily.org> writes:

> For example some people might want:
>
>     if_exists = overwrite
>     if_missing = add
>
> while others might want:
>
>     if_exists = overwrite
>     if_missing = do_nothing
>
> and I don't see how we can say that with just:
>
>     action = do_Y_if_X_and_Z

Yes, but then we go back to my original question: why exists and
missing are so special, and why there aren't two kinds of exists
(i.e. "there exists an entry with the same <key, value>" vs "there
exists an entry with the same <key>").  I would have understood your
"this is not too hard to understand for users" if you had three
(i.e. "missing", in addition to these two flavours of "exists"), but
with only two, I do not see how it is useful in a hypothetical
situation like above.

For example, how would you express something like this only with
"if-exists" vs "if-missing"?

	if_exists_exactly = ignore
        if_exists_with_different_value = append
        if_missng = prepend_to_the_beginning
