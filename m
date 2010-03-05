From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Thu, 04 Mar 2010 19:23:14 -0800
Message-ID: <7v7hprh2ot.fsf@alter.siamese.dyndns.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
 <ca433831003041730w7ccbc953kad3b600e7b112e0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 04:25:20 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnO8T-000441-51
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 04:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146Ab0CEDX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 22:23:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab0CEDX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 22:23:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FF1D9FC13;
	Thu,  4 Mar 2010 22:23:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yrsXiU0a+/IG+yEfDj3nlqflBZ4=; b=OunYkn
	VkwaLqX2cEaoI3emCuTWU1Z2HoBpegG0JD1uW0U8/FAnhFRLIbDODfNqfrLxAX5u
	ojVtgGCXm4jUx3PNEHxeeBaCiRpT8aWlsoLUNJc7HRTb8U1zKgrnouHnNt+nQRfQ
	DrENeuixi6hm0sJg0XjGiF2YVMLJ39Lv3mvVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OeFCfFNVhlZ9tjvkrEwa6yePR21RuU7y
	brg/xjMzkC5zjt9CkJWdebOfh7vrPiapGqryrMr7Nj0RVO/T1ddSjlVfjTxVW/KD
	S83/hPmhAU4lOTvudH8B1odYKIla7RgmCHO4jwJa0LW7/+ZMfAShn4SkVqJx40b5
	+OlLizXqqbw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B1ED9FC0B;
	Thu,  4 Mar 2010 22:23:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D48E9FC07; Thu,  4 Mar
 2010 22:23:16 -0500 (EST)
In-Reply-To: <ca433831003041730w7ccbc953kad3b600e7b112e0e@mail.gmail.com>
 (Mark Lodato's message of "Thu\, 4 Mar 2010 20\:30\:50 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 728C246E-2806-11DF-8A6C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141558>

Mark Lodato <lodatom@gmail.com> writes:

> The disagreement is whether --name-only output should be colored or
> not.  In the patch, it is not, which I argue makes more sense.  When
> --name-only is given, the only thing output is filenames.  Having them
> all be the same color adds no information, and I personally find it
> annoying to see one big block of the same color. GNU grep does color
> the filenames with --name-only.  Michael Witten argues that this makes
> the output consistent: whenever it's a filename, it's colored. [1]  He
> also thinks that matching GNU grep's behavior is important.  He didn't
> convince me and I didn't convince him, so it would be nice to have
> more opinions on this.

I don't have a very strong preference, but I would say painting filenames
in --name-only output the same way would make more sense than not doing
so, as it is obviously consistent if we paint the name of the file exactly
the same way whenever we write it at the leftmost column as the hit label,
no matter what options are in effect, e.g. -c, -l, or nothing.

As to the coloring of <foo> in "Binary file <foo> matches", I don't think
it matters very much which way you choose.  That string is an oddball to
begin with---it isn't even prefixed with the filename like normal "hit"
is:

    $ git grep Q t/test4*.png t/Makefile
    Binary file t/test4012.png matches
    t/Makefile:SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
    t/Makefile:     @echo "*** $@ ***"; GIT_CONFIG=.git/config ...
    t/Makefile:     '$(SHELL_PATH_SQ)' ./aggregate-results.sh test-results/t*-*    

and I think it is deliberately made an oddball, i.e. it shouldn't be like
this:

    $ git grep Q t/test4*.png t/Makefile
    t/test4012.png: Binary file t/test4012.png matches
    t/Makefile:SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
    t/Makefile:     @echo "*** $@ ***"; GIT_CONFIG=.git/config ...
    t/Makefile:     '$(SHELL_PATH_SQ)' ./aggregate-results.sh test-results/t*-*    

because if you did so, you cannot tell if t/test4012.png is a binary file,
or it has that matched string anymore (well you can---the string doesn't
have Q, but I think you know what I mean).

That makes me think that it is not even violating consistency if we treat
the <foo> in "Binary file <foo> matches" differently from the usual
filename label at the leftmost column.  We do not have to be consistent
there, as the whole point of the line being an oddball is because it
fundamentally wants to be shown differently.

On the other hand, painting <foo> in the same "filename" color may make it
easier to spot for color-loving people.

IOW, you can argue both ways, and both argument equally makes sense.  That
is why I don't think it matters very much.

And in such a case, it is typically safer to follow existing practices if
there are any.  If GNU paints it, we should.  If GNU doesn't, we probably
shouldn't.
