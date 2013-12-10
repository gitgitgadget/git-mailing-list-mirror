From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] subtree: support split --rejoin --squash
Date: Tue, 10 Dec 2013 14:46:38 -0800
Message-ID: <xmqqk3fctjch.fsf@gitster.dls.corp.google.com>
References: <1B2468D5-F0B7-4D11-8710-A3A7C8D66215@gmail.com>
	<1386440485-3092-1-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, greened@obbligato.org, amdmi3@amdmi3.ru,
	john@keeping.me.uk, techlivezheng@gmail.com, apenwarr@gmail.com
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Tue Dec 10 23:46:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqW4l-0002D2-76
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 23:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776Ab3LJWqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 17:46:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37496 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab3LJWqm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 17:46:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 712635A854;
	Tue, 10 Dec 2013 17:46:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zZNtfN4OWfDxv8VMJ9Ke4k0v6sA=; b=heWTux
	HJn7nBRm3et0pzNvvcd6/J0hhzb5atBygQ0MMLagC5pUuT0oa992dKdfWuj35wdj
	lychG0ExsNl4kG+6n9t9tHllZyTZb+oNaTg2hCcTr8gf2EjFanXvtaPzWH6JGE8j
	1ynmkHRsE/OGOniYAlRlkbWej5aG1TYXcTHHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UcgeVl3qgEORyWtx/99TloIalufFwLlc
	5B2pUufJvuMAPbkox4TQVIkFiWGy+pxX2iq5nCJpS6CVEYir+2u7aPwzbpQTDqhR
	zDAnJfADtKYCnQzcnC5DM38NzITi4K8ws/s9VkDHyy4tV3EBNMWztI8BlI08bmxq
	B+b0FeU2Y8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C6F75A853;
	Tue, 10 Dec 2013 17:46:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B5045A851;
	Tue, 10 Dec 2013 17:46:40 -0500 (EST)
In-Reply-To: <1386440485-3092-1-git-send-email-mmogilvi_git@miniinfo.net>
	(Matthew Ogilvie's message of "Sat, 7 Dec 2013 11:21:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EF535AAC-61EC-11E3-87A8-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239159>

Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:

> Allow using --squash with "git subtree split --rejoin".  It
> will still split off (and save to --branch) the complete
> subtree history, but the merge done for the "--rejoin" will
> be merging a squashed representation of the new subtree
> commits, instead of the commits themselves (similar to
> how "git subtree merge --squash" works).
>
> Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> ---
>
> I can think of a couple of possible objections to this patch.
> Are these (or any others) worth fixing?
>
> 1. Perhaps someone want the saved subtree (--branch) to have
>    a squashed representation as well, as an option?  Maybe we
>    need two different --squash options?  Something
>    like "--rejoin-squash"?
> 2. It could definitely use some automated tests.  In fact,
>    pre-existing --squash functionality is hardly tested at
>    all, either.
>       See patch 4 comments for a script I use to help with
>    mostly-manual testing.

As I am totally uninterested in "git subtree" (sorry!), I'll queue
these three patches as-is so that others who are interested and
motivated to work on polishing it can take a look at them more
easily.

Thanks.
