From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Unicode: update of combining code points
Date: Wed, 09 Apr 2014 10:30:05 -0700
Message-ID: <xmqqr4561kde.fsf@gitster.dls.corp.google.com>
References: <201404072139.42519.tboegi@web.de>
	<20140407195458.GA3912@google.com>
	<xmqq61mj30tg.fsf@gitster.dls.corp.google.com>
	<534579DD.1060607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 09 19:30:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXwKK-0002Rn-TJ
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 19:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933979AbaDIRaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2014 13:30:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933965AbaDIRaM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Apr 2014 13:30:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 894E7780A9;
	Wed,  9 Apr 2014 13:30:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+iwEkuQgKUiI
	9lJiUSJAwdBX1as=; b=l/v8c29Uepiysr1OcNNqxR+V46sS/OBZMjomjNvDX06/
	L0bGjXYQCys8bk1eZ33wJQmuuCwMhkn4WDq0ScfgJKSUKShSAEzjKA9YwETDoOXV
	bMR/ZuWM9B+ciYPIiYs+8qQPDDAB2okiJF3IkFQDklRtf72/d6a6WnnVmXu47kE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ItTtum
	1P1oCqji/Z83dZcztrKa9vitGxAdRd/vEmnsAjbcG53hw29VSjkz4n9cjABjFoxi
	48j+p/P8QH0+fvSIP0iwm9260CEW1n13WoanFhowgToxC20dog5+4BVQFhX+bJam
	ogNjlUBBGJOki4g3Pjkf/xmAsVJaWGDqPwH8k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70C42780A3;
	Wed,  9 Apr 2014 13:30:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E10337809B;
	Wed,  9 Apr 2014 13:30:07 -0400 (EDT)
In-Reply-To: <534579DD.1060607@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 09 Apr 2014 18:48:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9858B8CC-C00C-11E3-AAD9-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245981>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> How about this as a commit message:
>
> Unicode: partially update to version 6.3
>
> Unicode 6.3 defines the following code points as combining or accents=
,
> git_wcwidth() should return 0.
>
> Earlier unicode standards had defined these code point as "reserved":
> 358--35C
> 487
> 5A2, 5BA, 5C5, 5C7
> 604, 616--61A, 659--65F
>
> Note: for this commit only the range 0..7FF has been checked,
> more updates may be needed.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

Thanks.

I do not think you meant to say that the listed codepoints above are
the only ones that were "reserved".  Rather, the codepoints listed
are what are affected by this hange, and these were all reserved.

Also it may help end-user visible effect like Jonathan asked in his
earlier message.  How about extending it like this?

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
utf8.c: partially update to version 6.3

Unicode 6.3 defines more code points as combining or accents.  For
example, the character "=C3=B6" could be expressed as an "o" followed b=
y
U+0308 COMBINING DIARESIS (aka umlaut, double-dot-above).  We should
consider that such a sequence of two codepoints occupies one display
column for the alignment purposes, and for that, git_wcwidth()
should return 0 for them.  Affected codepoints are:

    U+0358..U+035C
    U+0487
    U+05A2, U+05BA, U+05C5, U+05C7
    U+0604, U+0616..U+061A, U+0659..U+065F

Earlier unicode standards had defined these as "reserved".

Only the range 0..U+07FF has been checked to see which codepoints
need to be marked as 0-width while preparing for this commit; more
updates may be needed.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
