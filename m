From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug: Git submodules can get into broken state
Date: Thu, 04 Apr 2013 11:30:41 -0700
Message-ID: <7vmwtei1wu.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1304041758140.965@lap-x201.fen.aptivate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Wilson <chris+gitscm@aptivate.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:31:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNowL-0000JI-JW
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761086Ab3DDSao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:30:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41172 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760989Ab3DDSao (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:30:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 452D113ACC;
	Thu,  4 Apr 2013 18:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L4n6FKkAyhZXZxX8tyJ3T1Kh3Qg=; b=oR3DYL
	ogzS6DaC08/EYffYBaGhB8gMtUZIMXLgZXUP9zLl+gXqGwyZ61pEcw8TgkiiNewY
	N+t0IRGaRnbcHzGXZI+ne1yo+nyZR1mSzfLtzzu/6sj+YT78HnAS3rAVakViYVhc
	kApigCGTFGlLw3I8Vr3ZRSx6gJqXnE7zlc0kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yX3WK6n7GTVE4JPBsFE5xSiaaogGRuLz
	RG0nUQBi8vgoAhgoCht/gtK4lywfLHLX6GXHUYI9oryWtRNaE3A2TQlzX6o3h2NF
	g2BBuNAmXvmewfU+lHwDqmpKH6Be9E+WXMYlxc27/vfheD0JgZX9wF55C+UDY5Kh
	TkKdpYq5psk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39ADC13AC9;
	Thu,  4 Apr 2013 18:30:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B378A13AC8; Thu,  4 Apr
 2013 18:30:42 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.02.1304041758140.965@lap-x201.fen.aptivate.org>
 (Chris Wilson's message of "Thu, 4 Apr 2013 18:10:17 +0100 (BST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C20504D0-9D55-11E2-BB22-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220055>

Chris Wilson <chris+gitscm@aptivate.org> writes:

> If your git repo's .gitmodules contains a URL that you don't have
> access to (for example you download someone else's code and it
> references a submodule using their writable git@github.com URL) then:
>
> * git submodule init will add them to .git/config, with the wrong URLs.
>
> * git submodule update will fail to check out the repos, leaving an
> empty directory for the first one, and nothing for the others.
>
> This state is broken (wrong URLs in .git/config), and AFAIK there's
> nothing you can do to check out these submodules without either:
>
> (a) manually hacking them out of .git/config, or

I do not think updating the config is "hacking", but is a perfectly
normal thing to do for a submodule user who wants to use a custom
URL different from what is recorded in .gitmodules (even when the
URL in .gitmodules is _working_, you may have a closer mirror you
would prefer to use, for example).  It is how the configuration is
designed to be used, if I am not mistaken.

So I do not see any breakage here.
