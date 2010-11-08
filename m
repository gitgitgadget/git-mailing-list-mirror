From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Mon, 08 Nov 2010 11:09:56 -0800
Message-ID: <7vpqufpr7f.fsf@alter.siamese.dyndns.org>
References: <9D675671-693D-4B59-AF2A-0EFE4C537362@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 20:10:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFX6b-00027N-Q9
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 20:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057Ab0KHTKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 14:10:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab0KHTKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 14:10:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3893934A2;
	Mon,  8 Nov 2010 14:10:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Dmj95BDDN+sCxqj1a/JIt7sv1M=; b=phf2dw
	OXYOkhQhbUtvx06tifAdK8mT5lUnpeaKzxQRwR0ldKitA8g4AS1qhMIfC7LHhMdV
	kQOz10ybNjya2GF9GNt9MrQ4z8qwnNJFk3zJElP0Fp7M0tUG3osgztYePwzNX6Wy
	OZFNm38uY7NzDAk0wtPmyVpShx7Ei6UiWDdyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jN+XDr18ZGHkf78UAj3+1s5csUKFhGVQ
	690ibFTVynCCFuq+JlRn8H+A182xamo9lAm+wR/8vs1C9koWkwnD/EDKKISXpssy
	r+j1wYUuhdgklBe0tW+iGuqrl03kWXHClniIxUVcqCInaHp1HqVLv6UPyiDtpZg1
	pXGiXNU7bmA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 14A6934A1;
	Mon,  8 Nov 2010 14:10:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2723D349F; Mon,  8 Nov 2010
 14:10:00 -0500 (EST)
In-Reply-To: <9D675671-693D-4B59-AF2A-0EFE4C537362@sb.org> (Kevin Ballard's
 message of "Fri\, 5 Nov 2010 15\:38\:23 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CAC6BF94-EB6B-11DF-A5F0-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160970>

Kevin Ballard <kevin@sb.org> writes:

> There is one operator that doesn't allow this at all, and that's the commit
> message search (e.g. :/foo). Every character after the :/ is taken to be
> part of the regular expression. This is rather unfortunate as it prevents me
> from doing something like :/foo^ to refer to the parent of the matching commit.
>
> Does anybody have any opinions on changing this operator?

If you mean to change what ":/Merge branch 'kb/blame-author-email'" means,
and make my scripts suddenly start breaking, I would be moderately unhappy.

It is fine if we can enhance the extended SHA-1 vocabulary by introducing
a syntax that used to be illegal, hence there is no chance somebody was
using it for other purposes.

I wonder if we can introduce something like ':( ... )' to group things.
E.g.

    $ git log 'HEAD..:( :/Merge branch 'kb/blame-author-email' )^2'

I haven't visited the particular codepath for some time, so I don't know
offhand how involved the change would be, though.
