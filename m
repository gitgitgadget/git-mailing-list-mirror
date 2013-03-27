From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Composing git repositories
Date: Wed, 27 Mar 2013 13:18:58 -0700
Message-ID: <7vppyklhot.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
 <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org>
 <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <20130327192630.GF28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:19:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKwom-0002sq-Qu
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab3C0UTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:19:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224Ab3C0UTB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:19:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62EA5C000;
	Wed, 27 Mar 2013 16:19:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V6cJPUSnB9bIphG64LLVAHVmOcU=; b=UcYDDB
	wnGk+JOq9DBUrOfmtnJx1/uYMpbqcMSp4tlnDg9gIq7lHqW6HoOCJw/yh/i8a4uV
	kxj9pC3OcZv/kEouTAcad9sJ0Pu6L5jeNj2aPijEb8BXDB5jzkFu2hSn7D0r3Xbw
	Tb97dhSzKM+ayIIP7/6r9aBMMc+kHdw71lnG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x7PencFd0m2qaVgkXV7mgpshE9VGOfSL
	mZrUuGI+lHTndnc9CX4Li/3DSVqKcb+1vnIpL7DCpazHXbpNDcRphlAenK7886e8
	U2BKMFLRleJ5Piaoh5++E/MCRZ4IUOvy0Uwh2tOsiwYxUfo9lc0ZnVa2zIUJ1p56
	SOuRUSMwmiw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58ACFBFFA;
	Wed, 27 Mar 2013 16:19:00 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A92D6BFF8; Wed, 27 Mar 2013
 16:18:59 -0400 (EDT)
In-Reply-To: <20130327192630.GF28148@google.com> (Jonathan Nieder's message
 of "Wed, 27 Mar 2013 12:26:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F343610-971B-11E2-B83D-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219323>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>>                        Even then, working with one worktree embedded
>> inside another is something git never designed for: it explains why I
>> have to literally fight with git when using submodules
>
> Do you mean that you wish you could ignore subrepository boundaries
> and use commands like
>
> 	git clone --recurse-submodules http://git.zx2c4.com/cgit
> 	cd cgit
> 	vi git/cache.h
> 	... edit edit edit ...
> 	git add --recurse-submodules git/cache.h
> 	git commit --recurse-submodules
> 	git push --recurse-submodules
>
> , possibly with configuration to allow the --recurse-submodules to be
> implied, and have everything work out well?
> ...
> I think something like that is a goal for submodules in the long
> term,...

As you hinted with "complications" below, I have to wonder what
should happen when the above "git add" touches anything outside
"git" subdirectory.

But such an administrative details (the project boundary is
primarily not an implementation detail but is a social issue) aside,
I agree that overall it would be a good user experience.

I however do not see the implementation detail of having (or not
having) separate $GIT_DIR for component projects having anything to
do with the goal of that ideal.

Where and how do you envision the metainformation about the
component projects are stored in such a clone?  It does not have to
be cgit/.git, but you would need to somehow store things we store in
$GIT_DIR for cgit itself and git in the current system.  If you pick
one location to store both, I would imagine that it would still be
somewhere under the cgit directory.

As I said in another thread, your top-level may be only a part in
somebody else's project, and what you consider just a part of your
project may be the whole project to somebody else.  If you pick one
location to store both for the above clone, e.g. cgit/.git (it could
be cgit/.ram-git or any other name), embedding it in a yet larger
project (perhaps having both cgit and gitolite to give a one-stop
solution for hosting services) later would face the same issue as
Ram seemed to be complaining.  It needs to address what happens when
that cgit/.git (or whatever name) gets in the way in the scope of
the larger project.  That is why I said Ram's rant, using subjective
words like "elegant", without sound technical justification, did not
make much sense to me.
