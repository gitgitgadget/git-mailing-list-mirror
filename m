From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/6] t9001: check email address is in Cc: field
Date: Wed, 08 Jun 2016 10:34:14 -0700
Message-ID: <xmqqinxjmvop.fsf@gitster.mtv.corp.google.com>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130142.29879-3-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:43:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAhN3-0001Oh-TY
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 19:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbcFHReU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 13:34:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753793AbcFHReT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 13:34:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FDF61F034;
	Wed,  8 Jun 2016 13:34:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AijF+hPq5Be8V8sEmTPuvl1mVv8=; b=mF2j61
	1UPFteBj5FfyVxNYhC9wCR5yR+mk7LTh8YfzXMK/Cf7L3I2b3ZijkWKufBnnTRFQ
	JDhMDnTzemYMSS28+CJDnGbBV/mrEhc4mZTKGxEUrspYw4UakRwUoZIvkoasZMbW
	2wHI+YY6SrRyHjXZIUPbKVYFSQs4sy/3AMgKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZMCMZz4m3dU7id+2Q/EYtPAxs1jJUeNo
	FjBo0L5q540Jf1SdnhboCS5IPw2Gw77RtQkZJPHcmm/9qBY0q0bAvkXMBUc41BRU
	5N915VWLZyhJn991Itw3y66D6y+ecUbly2a3YFaUkB8QEBzJY6rQXXETsEkRoSLT
	jSYiYGvKHJE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 869211F02E;
	Wed,  8 Jun 2016 13:34:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D46061F020;
	Wed,  8 Jun 2016 13:34:16 -0400 (EDT)
In-Reply-To: <20160608130142.29879-3-samuel.groot@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 15:01:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39857D28-2D9F-11E6-8649-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296817>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> Check if the given utf-8 email address is in the Cc: field.
>
> Signed-off-by: Tom RUSSELLO <tom.russello@grenoble-inp.org>
> Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
> Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
> ---
>  t/t9001-send-email.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 56ad8ce..943e6b7 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -888,8 +888,8 @@ test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
>  	--to=nobody@example.com \
>  	--smtp-server="$(pwd)/fake.sendmail" \
>  	outdir/*.patch &&
> -	grep "^	" msgtxt1 |
> -	grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
> +	cc_adr=$(awk "/^Cc: /{flag=1}/^Subject: /{flag=0} flag {print}" msgtxt1) &&
> +	echo "$cc_adr" | fgrep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
>  '

This still depends on that the output has Cc: before Subject: and
there is no other header that can have an address on it.  E.g.

	To: a@example.com
        Cc: b@example.com
        X-foo: <<whatever address you are looking for>>
        Subject: [PATCH] A sample patch

would still say that the address is _on_ the CC: list.

I do not usually do awk, but I think you should be able to avoid
capturing output from it, echoing and then grepping, which is way
too ugly.  Perhaps you can start from something like below?

#!/bin/sh
awk '
	BEGIN { in_cc = 0 }
	/^[Cc][Cc]: / {
		sub("^[Cc][Cc]: *", "")
		in_cc = 1
	}
	/^[^ 	]*:/ {
		in_cc = 0
	}
	/^$/ { exit }
	in_cc {
		sub("^ *", "")
		sub(", *$", "")
		print
	}
' <<\EOF
To: a@example.com
Cc: b@example.com,
    c@example.com,
    d@example.com
X-foo: e@example.com
Subject: [PATCH] A sample patch

Cc: foo@example.com
EOF
