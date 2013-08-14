From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Tue, 13 Aug 2013 18:44:08 -0700
Message-ID: <7vmwolujvb.fsf@alter.siamese.dyndns.org>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
	<7veh9z1gym.fsf@alter.siamese.dyndns.org>
	<CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
	<CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com>
	<7vk3jpy1qt.fsf@alter.siamese.dyndns.org> <520AC9A8.4030104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, David Jeske <davidj@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 03:44:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Q8L-0002rV-LE
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 03:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997Ab3HNBoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 21:44:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758878Ab3HNBoP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 21:44:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E3862CDAC;
	Wed, 14 Aug 2013 01:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1F65rSJ9usB0GKVib94i4weAFFQ=; b=hWgU/A
	dLX3dpWTJqmdJ5m+bOKdl5AscKQjerUlW2qn902BeycGFPGSPhYlJAFT31gOob13
	+S9xPAkdj2wHdX0HsP0ycsy1HKYVi2aeS14jZIFJ7AwE+xG6RIc/KA5/O6qlVL9l
	5cmgE47Zm4NSpKxQ1m/BVMk6uAw+/5Lt/dXtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A9OyyKUCXWJfZRe4tv8lTE3f+HW0WSgH
	SDeNVpbheOLjnhfsJF3ST8HUvuAHT08ZgWz1GqNjVLpmVOfMGIlORqU29OOrkQ+m
	fhPXe0kG1ELE83SzX3dg7o42ziPIZCj3gVgKtYPIzmJI4n5bah45ysnobc2SH36z
	iXfExcxd7os=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E15682CDAB;
	Wed, 14 Aug 2013 01:44:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 753B42CD9B;
	Wed, 14 Aug 2013 01:44:10 +0000 (UTC)
In-Reply-To: <520AC9A8.4030104@gmail.com> (Sitaram Chamarty's message of "Wed,
	14 Aug 2013 05:34:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03F72C80-0483-11E3-8A3D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232257>

Sitaram Chamarty <sitaramc@gmail.com> writes:

>     # all reflog entries that are not on a branch, tag, or remote
>     d1 = !gitk --date-order $(git log -g --pretty=%H) --not --branches --tags --remotes
>     # all dangling commits not on a branch, tag, or remote
>     d2 = !gitk --date-order $(git fsck | grep "dangling.commit" | cut -f3 -d' ') --not --branches --tags --remotes
>
> (Apologies if something like this was already said; I was not following
> the discussion closely enough to notice)

Yup.

A potential problem is that the output from "log -g --pretty=%H" or
"fsck | grep dangling" may turn out to be humongous.  Other than
that, they correctly compute what you want.
