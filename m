From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd "git diff" breakage
Date: Mon, 31 Mar 2014 11:30:55 -0700
Message-ID: <xmqq7g7a6x0g.fsf@gitster.dls.corp.google.com>
References: <CA+55aFxYBDXs8mGQ3weR2PSOdMgOzMXPT=uWstL4c4BKnykkdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:31:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUgz9-0007nT-01
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 20:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbaCaSa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 14:30:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56441 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299AbaCaSa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 14:30:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A5B877F29;
	Mon, 31 Mar 2014 14:30:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cy4OwsXPNELDVDBl16cv+3z62GQ=; b=uemdDt
	Sx7zi0F5rVdGFG2mTC47pdw7RCJ9FSHtwxrYLo4gkZef8K2iAY3J0y6LKoh9+Iwk
	rqc45IAV+P3MY4csOX7mLz1MDVew0TlaaWocDfh7adisn+7g5sLkHAJRQr5U9hua
	LAgJ+9DUZs175UbQ5AbS6tzkNyXZ+RownCh4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjGGxTgK12bi61zQVcsd5VIxmFARz24Z
	Bk0AYgQbW+WrbiwpEw+3ctuIV1usXoFdYu3s5xidszehCxnbb7IswG7BxCwooxLK
	/6ssLGtBaFGW/M/r2KCdxu4yfMx5R816hNFZdSnHn0uAFoV/3xRByWqHPJhQPjN0
	XycsZwTGvsM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 881F377F28;
	Mon, 31 Mar 2014 14:30:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E881277F27;
	Mon, 31 Mar 2014 14:30:56 -0400 (EDT)
In-Reply-To: <CA+55aFxYBDXs8mGQ3weR2PSOdMgOzMXPT=uWstL4c4BKnykkdA@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 31 Mar 2014 11:05:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 999E39B6-B902-11E3-888A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245505>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I hit this oddity when not remembering the right syntax for --color-words..
>
> Try this (outside of a git repository):
>
>    touch a b
>    git diff -u --color=words a b
>
> and watch it scroll (infinitely) printing out
>
>    error: option `color' expects "always", "auto", or "never"
>
> forever.
>
> I haven't tried to root-cause it, since I'm supposed to be merging stuff..
>
>                 Linus

Hmph, interesting.  "outside a repository" is the key, it seems.
And I can see it all the way down to 1.7.3 (at least).
