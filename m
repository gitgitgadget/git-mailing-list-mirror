From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sun, 06 Sep 2009 22:07:01 -0700
Message-ID: <7v1vmj9wcq.fsf@alter.siamese.dyndns.org>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
 <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
 <20090905084641.GA24865@darc.dnsalias.org>
 <20090907090713.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>,
	SZEDER Gbor <szeder@ira.uka.de>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 07:07:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkWRp-0001Iz-CT
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 07:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536AbZIGFHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 01:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbZIGFHM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 01:07:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257AbZIGFHL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 01:07:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BDCE28073;
	Mon,  7 Sep 2009 01:07:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=HamvtffaN4xuzr4g58RXH+G9WLI=; b=WO9NrFCUpYaRMdeHqyYP64o
	Uk/CWS8JJFA4UQpWlh8Lfqr4Ub0VamBKR15rLpoeEE0RJbaI8m8yXI+zFZsfR3VM
	omjsdKnjjkMzxRbbH15RUlVKYnneVmdEwN3M64T0Fp9GqtERgLKZBU1Jl1EnvXHx
	Kj5eDH8xjl241obAV5XM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=K+iTETB0PuQNBTOuCvNV7QlVyM23H1L4S6jO1WSsPgcpGBjoT
	JK5/xQ9jaMOTuj4pXScAV0LhUoke8a8C/GVynmwnX8RWxT7nmiiTjKhP2ItY8IRb
	MPm0NuQdoHf7ycTB2dahrsecWPhjIhpYbBmWJA2tBirhz/CYxXci7IGy/A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BFA328070;
	Mon,  7 Sep 2009 01:07:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B76C2806E; Mon,  7 Sep
 2009 01:07:03 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B859B42-9B6C-11DE-A298-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127885>

Nanako Shiraishi <nanako3@lavabit.com> writes:

[jc: sometimes but not always your messages have looooooooooooooong lines.
please line-wrap for readability. I learned to type W Q so often I do not
complain but other people would find them irritating.]

> The default behavior for 'git-grep' has already been discussed in
> length, and I don't think it is likely to change. See
>
>   http://thread.gmane.org/gmane.comp.version-control.git/111519/focus=111717

Interesting.

The first message in that thread lists things we have scheduled for 1.7.0
but it has another item.  It is an off-topic for the thread, but we might
want to resurrect the "core.quotepath defaults to false" proposal, before
it gets too late for 1.7.0.

As to "grep", I am open to the proposal to make git commands consistent by
letting them operate on everything when no path argument is given, if grep
is really the single odd-man out remaining after changing the "add -u" and
"add -A" to work on the whole tree from subdirectories when given no paths.

> The original design for the other two in your list was to be a whole
> tree operation. This commit broke it.
>
>   2ed2c22 "git-add -u paths... now works from subdirectory".
> ...
> I think it is a good idea to fix this as an old regression in the maint
> branch. You don't have to introduce "git add -a". In fact the -a option
> was explicitly rejected when "git add -A" option was added with this
> commit.

Geez, you are good at digging things up.

It is very tempting to follow the suggestion above, but I suspect that,
even though it may be a regression from historical point of view, some
people who are used to the current behaviour may look at the corrected
one as a regression.  We've had the change by 2ed2c22 for a long time.

I dunno.
