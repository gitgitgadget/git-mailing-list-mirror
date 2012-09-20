From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pretty: support placeholders %C+ and %C-
Date: Thu, 20 Sep 2012 09:47:46 -0700
Message-ID: <7vy5k4bpzh.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
 <1348143976-4506-1-git-send-email-pclouds@gmail.com>
 <1348143976-4506-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 18:48:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEjuy-0008W5-S7
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 18:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab2ITQrw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Sep 2012 12:47:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41999 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914Ab2ITQru convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Sep 2012 12:47:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51E6597FB;
	Thu, 20 Sep 2012 12:47:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9y4tzsSuVhM9
	AcUJBdj8AqaICOk=; b=raCVDDSrqvDzQB7ndPe5n61XqvrwpdZ3BHx1mtbGSMnX
	jg9n8JXTJkP0LEC51txYeLag1bkoD5fCYGEEcCBNo87De/BKZz+xLZbzjp6bABKp
	aHVKEogv/G2xy3l5xiMaSqaxHe6YSgLByltmGm0mIQGr2b/etVi7TCOgzNpS6QU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hkDv71
	pJc+t8yqBbYl3t+qYVGVI3RLu5J+GfAZYfu55fSFfDZGeb7brPw3a1WNQjTllPxo
	QZtr2qPnDLif8+9MOJknTD31tZg5EFTV27Zg693rsa8Ck78KFzWQvU9Q0iLw1h2m
	bq37y+u1NmMwIo7YoIkXtwmmBNW+r9XnNuC1I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FFB497FA;
	Thu, 20 Sep 2012 12:47:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82E3E97F8; Thu, 20 Sep 2012
 12:47:48 -0400 (EDT)
In-Reply-To: <1348143976-4506-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 20 Sep
 2012 19:26:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8F2172A-0342-11E2-80E6-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206053>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> %C+ tells the next specifiers that color is preferred. %C- the
> opposite. So far only %H, %h and %d support coloring.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/pretty-formats.txt |  2 ++
>  pretty.c                         | 13 ++++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-=
formats.txt
> index e3d8a83..6e287d6 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -142,6 +142,8 @@ The placeholders are:
>  - '%Cblue': switch color to blue
>  - '%Creset': reset color
>  - '%C(...)': color specification, as described in color.branch.* con=
fig option
> +- '%C+': enable coloring on the following placeholders if supported
> +- '%C-': disable coloring on the following placeholders

OK, so typically you replace some format placeholder "%?" in your
format string with "%C+%?%C-", because you cannot get away with
replacing it with "%C+%? and other things in the format you do not
know if they support coloring%C-".

If that is the case, does it really make sense to have %C-?

It smells as if it makes more sense to make _all_ %? placeholder
reset the effect of %C+ after they are done (even the ones that they
themselves do not color their own output elements), so that you can
mechanically replace "%?" with "%C+%?".

I dunno.
