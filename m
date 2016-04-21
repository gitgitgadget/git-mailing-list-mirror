From: Junio C Hamano <gitster@pobox.com>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 09:59:13 -0700
Message-ID: <xmqqzismsxsu.fsf@gitster.mtv.corp.google.com>
References: <20160421113004.GA3140@aepfle.de> <87lh473xic.fsf@linux-m68k.org>
	<CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 18:59:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atHwn-0000t7-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 18:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbcDUQ7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 12:59:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752145AbcDUQ7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 12:59:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2AA213E24;
	Thu, 21 Apr 2016 12:59:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=935jglUQiE+qwRq/GzTMfzUNOf8=; b=l7YXSC
	HYVhIltxFhWjCNh5C+wXP5I6OLb7A2276VomF6Lm5W2JkmPPQu2nuPvjSZy8IHXM
	zVxsEqmNHP/ID0EPX6pgvcZ/eD6HBSENPNxWjptwVkNaKWOIbY5gkRd03q3Umlx2
	IeAo85A6sPsdqXcbkN7C+iQ0x6tqwseNCtUqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FRWVthFk2NaWXxbZHVv+ssWeQljzDAuP
	qIQAEw0z4iPl/V+YQYSFHncxzVUclMemoLkc+ILO42SW3kHqpU1od/HBllUb88PW
	lZ6WMfXy2lbyzJ2B1FA3hPqE70VeqF6s/b6yjXAhiGqOmcre0DwL+Pwgv5Y7PjJc
	/awgmTroCdM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 996C013E23;
	Thu, 21 Apr 2016 12:59:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0841A13E21;
	Thu, 21 Apr 2016 12:59:14 -0400 (EDT)
In-Reply-To: <CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 21 Apr 2016 09:36:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60DCEA60-07E2-11E6-A078-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292126>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That commit aed06b9 can also be described as
>
>     v3.13-rc7~9^2~14^2~42
>
> so describing it as 'v4.6-rc1~9^2~792' is clearly not closer in any way.

I seem to recall that name-rev had an unexplained heuristics to
strongly avoid following second parent changes (I see two ^2 in the
path from 3.13-rc7 above).

> However did git decide to use that further-away name? That looks odd.
>
> I'm wondering if it's because of the new root commit we have, and that
> confuses the distance calculation somehow? That came in somewhat
> recently (mid March) with the GPIO pull.
