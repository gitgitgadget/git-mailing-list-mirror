From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/41] builtin/rm.c: use warning_errno()
Date: Tue, 03 May 2016 12:58:42 -0700
Message-ID: <xmqqa8k6ncb1.fsf@gitster.mtv.corp.google.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 21:58:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axgT5-0002lo-0K
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 21:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195AbcECT6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 15:58:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755072AbcECT6q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2016 15:58:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40A6C17A54;
	Tue,  3 May 2016 15:58:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nYkymD2U2pLJ
	nnj4P2P5FsIzwyM=; b=rX/Nnhg26fulG2gv/ub7GziQ69uIQHQTwer+c0ncmDvy
	FybrqrfNj8eM83dU70BQoMgKlH033YVxTE05ynG3XrC8iIE495RAd5qQ5iabAs9Y
	LU7mx7X0v2e9OfUo5PDdQ96sTi6zm9gKcMHbt0w8E8thzIS11PAmRs/2/0XAY8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZsS0Cs
	dUaShkpKdZx56adEThqsKuAOsbJTO6/LDnuwEOYW52MgoC6lddHtGUazkEEq7yoX
	0gfGYagS/MRq63jXSxp8VWsCGS2CzG7XHpYQs4qC0MqRM2HqQd3qM/jJjY7//18Q
	9BhkZriGBPBXfNf6K80ZRj0+L9CEZIfkcSpcw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 36D5F17A53;
	Tue,  3 May 2016 15:58:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D82517A50;
	Tue,  3 May 2016 15:58:44 -0400 (EDT)
In-Reply-To: <1462277054-5943-12-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 3 May
 2016 19:03:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 71020F0C-1169-11E6-B50E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293447>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/rm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 8829b09..13b9639 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -152,7 +152,7 @@ static int check_local_mod(unsigned char *head, i=
nt index_only)
> =20
>  		if (lstat(ce->name, &st) < 0) {
>  			if (errno !=3D ENOENT && errno !=3D ENOTDIR)
> -				warning("'%s': %s", ce->name, strerror(errno));
> +				warning_errno("'%s'", ce->name);
>  			/* It already vanished from the working tree */
>  			continue;

Not a new problem with this patch, but this would say

    warning: 'Makefile': Permission denied.

or whatever error we may happen to have hit.

I think we show strerror(errno) as an additional explanation and
there must be something _else_ that is the primary thing we would
want to say, e.g.

    warning: cannot remove 'Makefile': Permission denied.

Without that primary message from us, it looks somewhat wrong.
