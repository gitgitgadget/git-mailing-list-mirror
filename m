From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Wed, 25 Mar 2015 13:25:07 -0700
Message-ID: <xmqqr3sc25b0.fsf@gitster.dls.corp.google.com>
References: <1427174429-5876-1-git-send-email-pyokagan@gmail.com>
	<1427174429-5876-3-git-send-email-pyokagan@gmail.com>
	<vpqbnjivi2n.fsf@anie.imag.fr>
	<CAPig+cQ-yLnjrsB1E-7=UXfGzuJHat6YtfS8EVRNP2dcjj_6TA@mail.gmail.com>
	<xmqqwq252grl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 21:25:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yarrd-0004rP-FX
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 21:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbbCYUZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 16:25:16 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751212AbbCYUZP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 16:25:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61C36428F4;
	Wed, 25 Mar 2015 16:25:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ahefyan0jQM8YwSzb/h4JdRq89k=; b=rSkXlO
	YGSJXN05Rvd7iaR8N93+vn2jhAmn+OpHWz1wxSprnk0/AKgEW+xG9pj9JqKxMeEc
	oDi+6Wqph5Lm4uDMLkRRwTXFYou5XmF9jgzxnmTE0wx6Fl/gdM1GxXqduwMgnHL0
	Q27Zy259fO9K87vrRBuAAWI428BwWxDvuebXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xLil0d+on30I+HDT6uCnYoe4heYvQnMx
	at9yqb6vFX5UUB9+KI9D2cUuZ9HZYfe/cOcduTACCAT//hQamzcJP/P8sKSFjixX
	WRB7k3JdNu3203y2RaUert4Lshcdm+pWP8gH4XNe7XI0LwBh/RCKjBrQvh3BMCj1
	zHO6ZPBso5M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59F22428F3;
	Wed, 25 Mar 2015 16:25:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF003428F0;
	Wed, 25 Mar 2015 16:25:08 -0400 (EDT)
In-Reply-To: <xmqqwq252grl.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 25 Mar 2015 09:17:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07F81E50-D32D-11E4-868A-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266299>

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, Mar 24, 2015 at 5:52 AM, Matthieu Moy
>> ...
>>> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>>
>> With the POSIXPERM issue[1] addressed (if necessary), patch 3/3 is also:
>>
>> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>
> THanks for a review.  Paul, the 3-patch series is already in 'next',
> so please fix these up with a follow-up patch.
>
> Thanks.

I've already queued the following and merged it to 'next'.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 25 Mar 2015 13:23:21 -0700
Subject: [PATCH] t0302: "unreadable" test needs POSIXPERM

Noticed and fixed by Eric Sunshine, confirmed by Johannes Sixt.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0302-credential-store.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 4e1f8ec..0979df9 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -75,7 +75,7 @@ test_expect_success 'get: use xdg file if home file has no matches' '
 	EOF
 '
 
-test_expect_success 'get: use xdg file if home file is unreadable' '
+test_expect_success POSIXPERM 'get: use xdg file if home file is unreadable' '
 	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
 	chmod -r "$HOME/.git-credentials" &&
 	mkdir -p "$HOME/.config/git" &&
-- 
2.3.4-462-gc8eeafd
