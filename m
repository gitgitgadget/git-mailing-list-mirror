From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] t4026: test "normal" color
Date: Thu, 20 Nov 2014 10:53:56 -0800
Message-ID: <xmqqwq6p3dq3.fsf@gitster.dls.corp.google.com>
References: <20141120151418.GA23607@peff.net>
	<20141120151609.GC23680@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Baker <bakers@canbytel.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:54:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWrk-0002eV-Ty
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757077AbaKTSx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:53:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756877AbaKTSx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:53:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 35D271F85F;
	Thu, 20 Nov 2014 13:53:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tibovY3srBYzEXvuDreJQhzzINo=; b=SanOUw
	BnsSIOmU7eLuVA1rjsQRpDabUyaiwM6+M2I44DEV73ObWPfGgWxef48sp2t+A28t
	Kbv3uENf5bd2LCnKFYLvGU1x8XuOULNfB98OkjpxarX6+h0xeVBAmU4VCWPiJjN5
	IF8ha4t2nJ2dW2HMiQ14x6JV1ooVRV6pjsADQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pi4TcX2zCIv/puNIzA05NMhgDwRilW/J
	ekTGlIYwkv8MJjfKKAIncEyN1BCUTpeWqcccCnSLDcHzG6smTncoKrpQUZjnQUng
	mmHeVmZNbxgF/kc/dp7GLf0MfCcCJXvUKXrP/H/Qfqo6z+L49M7hZhD3eeI+rXQR
	iNcN1OEWFK8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BB4D1F85E;
	Thu, 20 Nov 2014 13:53:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A781A1F85D;
	Thu, 20 Nov 2014 13:53:57 -0500 (EST)
In-Reply-To: <20141120151609.GC23680@peff.net> (Jeff King's message of "Thu,
	20 Nov 2014 10:16:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9543B73C-70E6-11E4-BF80-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If the user specifiers "normal" for a foreground color, this
> should be a noop (while this may sound useless, it is the
> only way to specify an unchanged foreground color followed
> by a specific background color).
>
> We also check that color "-1" does the same thing. This is
> not documented, but has worked forever, so let's make sure
> we keep supporting it.

YLNTED, really?  I do not object to the conclusion, but I am
mildly surprised ;-)

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t4026-color.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t4026-color.sh b/t/t4026-color.sh
> index 3726a0e..63e4238 100755
> --- a/t/t4026-color.sh
> +++ b/t/t4026-color.sh
> @@ -53,6 +53,14 @@ test_expect_success '256 colors' '
>  	color "254 bold 255" "[1;38;5;254;48;5;255m"
>  '
>  
> +test_expect_success '"normal" yields no color at all"' '
> +	color "normal black" "[40m"
> +'
> +
> +test_expect_success '-1 is a synonym for "normal"' '
> +	color "-1 black" "[40m"
> +'
> +
>  test_expect_success 'color too small' '
>  	invalid_color "-2"
>  '
