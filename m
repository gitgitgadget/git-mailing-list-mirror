From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Whitespace and '&nbsp'
Date: Thu, 26 May 2011 14:57:43 -0700
Message-ID: <7vzkm9unu0.fsf@alter.siamese.dyndns.org>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 26 23:58:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPiZ2-000891-0W
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756503Ab1EZV5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 17:57:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab1EZV5v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 17:57:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6D745B06;
	Thu, 26 May 2011 17:59:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ccK1cM0Kpp7F2l6pxwHgciegrF0=; b=D0/Fky
	VqYs4Wdzqz9JXSDuCKH0YFXlB3TK9+dRqQKjcKxacektzzNe9cJA+sARXy6eJjIK
	wkQiupPIHKAy6SHrqWpqITatB4Rd0hDe4S90+sANeRi41cTlhiPJM6/zGCu6vYva
	gMGCo7CyC63/kZmE38qTVNuCwHL17GKF6ktl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ixkvyv6CaUC8Gw+PAFM+0WH0TlMFS1/s
	StPRbRsw+izHaf5Iy+/Zl+eaOWm9jAc5pNsIY97u4RLkibktYWhxH7Pjy7nnlxxf
	3FHY0hRziDYAxbEIDUq0hSHHYnalIvJwX+P0GfMgOzrPEKWzsKYMpVTAHwhRsrjH
	93KaaMuQ6qg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A36865AFC;
	Thu, 26 May 2011 17:59:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A5F815AFA; Thu, 26 May 2011
 17:59:52 -0400 (EDT)
In-Reply-To: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com> (Linus
 Torvalds's message of "Thu, 26 May 2011 14:12:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D996FF4-87E3-11E0-9421-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174582>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I just got a patch that had a hidden &nbsp in it (unicode: u00a0,
> utf-8: \0302\0240) and sad to say my terminal window shows no
> indication of that what-so-ever. It looks exactly like a regular
> space, except gcc won't actually accept it.

I have been annoyed by these &nbsp; in mailing list traffic in general,
not just in patches.  In my MUA, they are shown as inverted whitespace.

We could certainly add a new whitespace error class (nbsp?) to diagnose
and fix to "git apply".  I do not think people deliberately put these
things to their editor, so there probably is no urgent need to add the
same diagnosis to "git diff", but these days they tend to share the common
code, so that may come for free.

But in the longer term, I think we should find what MUA causes this
breakage and yell at them. It might be some mail relays, but I am not sure
where these come from.  I often see alternating real whitespace and nbsp
in "> " indented quotes.
