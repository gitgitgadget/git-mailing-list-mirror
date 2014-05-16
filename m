From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] t4205, t6006: Add failing tests for the case when i18n.logOutputEncoding is set
Date: Fri, 16 May 2014 11:49:40 -0700
Message-ID: <xmqqfvk9a797.fsf@gitster.dls.corp.google.com>
References: <cover.1400254654.git.Alex.Crezoff@gmail.com>
	<c4c360c3e6760128ae1326b7463da7130b01a7e9.1400254654.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 21:02:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlNP2-0007Wg-L3
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 21:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbaEPTCk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 15:02:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63991 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757760AbaEPTCk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 15:02:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8688A13653;
	Fri, 16 May 2014 15:02:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=X5jTqj561qhS
	12cO7Gt9zjUFD4U=; b=CdakHCJ1cAEeVCPlXLcJrwc6rt3XvA+zRBs5k5Vh71sG
	gTeHqZUSebiLuMG66IMVxbJ0ENTiIsyfJLvW0lZ6hGKxbL9QuiPSrPBKJmoWOuBS
	4pE5OuPK0u4AmQTMHjCWU5OeAVv05IJozrO6+kzqXEVpHn3mmmMPPVjw5Z1D7Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jJCrMg
	oFoISlpb8sFUaYZaSqIALhTW0m3D9u1XOtOmIC0GQRkQ7sfAR+WBhBdU8SU0sTl1
	cZvbNIXCv4pJPxsxBr0XJpbNvUAUs6B50+4RheMqd1vimNOEbmmtm+jNf/PGIIcv
	LlKAX1n0cEaPrcQ3HL4FPs5nn7vnJnHvEQntE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7962B13652;
	Fri, 16 May 2014 15:02:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF0A417CC2;
	Fri, 16 May 2014 14:49:41 -0400 (EDT)
In-Reply-To: <c4c360c3e6760128ae1326b7463da7130b01a7e9.1400254654.git.Alex.Crezoff@gmail.com>
	(Alexey Shumkin's message of "Fri, 16 May 2014 19:40:32 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D708B78A-DD2A-11E3-8CEB-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249412>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> Pretty format string %<(N,[ml]trunc)>%s truncates subject to a given
> length with an appropriate padding. This works for non-ASCII texts wh=
en
> i18n.logOutputEncoding is UTF-8 only (independently of a printed comm=
it
> message encoding) but does not work when i18n.logOutputEncoding is NO=
T
> UTF-8.
>
> There were no breakages as far as were no tests for the case
> when both a commit message and logOutputEncoding are not UTF-8.
>
> Add failing tests for that which will be fixed in the next patch.
>
> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
> ---
>  t/t4205-log-pretty-formats.sh | 169 ++++++++++++++++++++++++++++++++=
++++++++++
>  t/t6006-rev-list-format.sh    |  75 ++++++++++++++++++-
>  2 files changed, 242 insertions(+), 2 deletions(-)
>
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-forma=
ts.sh
> index 2a6278b..6791e0d 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -153,6 +153,19 @@ EOF
>  	test_cmp expected actual
>  '
> =20
> +test_expect_success 'left alignment formatting. i18n.logOutputEncodi=
ng' '
> +	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%<=
(40)%s" >actual &&
> +	# complete the incomplete line at the end
> +	echo >>actual &&

Would it change the meaning of the test if you used tformat: instead
of format: (or --format=3D"%<(40)%s")?  If it doesn't, it would make
it unnecessary to append an extra LF and explain why you do so.

> +	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&

It is minor but many existing uses of iconv in our tests spell these
as UTF-8 and ISO8859-1 in uppercase.  I vaguely recall there was a
portability concern to favor the ones that are used in existing
tests, but probably it no longer matters (I see you added the
lowercase one with de6029a2 mid last year), so I am fine if these
stay lowercase.

> +	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%<=
(1)%s" >actual &&
> +	# complete the incomplete line at the end
> +	echo >>actual &&

Likewise for all the other "--pretty=3Dformat:" followed by an echo.

Thanks.
