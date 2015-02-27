From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] versionsort: support reorder prerelease suffixes
Date: Fri, 27 Feb 2015 13:37:50 -0800
Message-ID: <xmqqvbinhw7l.fsf@gitster.dls.corp.google.com>
References: <CAPc5daVJJcC--mwq0PfAczge3zG44ToDKP853FkyZ3x1KUfsig@mail.gmail.com>
	<1424947441-19134-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 22:38:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRSbe-0002I1-T1
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 22:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbbB0Vhy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2015 16:37:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754632AbbB0Vhx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2015 16:37:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B3CE3B876;
	Fri, 27 Feb 2015 16:37:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bh0Fv6Wf2Kxm
	upiVPpFddOZzsPc=; b=TcGbmmxA09qjq4JB2r1wys3mcfsgK7Yr/JjbXtP78j9Q
	HVdCHKgy7bBctVqsS3Kdti15hZ7RTvSaTVZ3X4j1JKmBBbdtts06zDj5bSQlD8cQ
	ahOtaPUcU8mpOkdMoIr67caIcTwmtvVD+FSm1r1RRnYdUT4I/y63mOT+9o7mnZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=O5mgCx
	NXgEs35E3D8XlPSM52GDJ8xm79F8p8NMK25qNZ8XYFo4MyQb+Xevsy9xjnE8MfZ9
	RupOMkOIAS/9skGRxdYXGs6/QJYFFPpG6hA10tgAKW3QpBDZlUxTDgi7yQprIRup
	vC+DnGzct4KllbSwT+MNsZJlhpKchyE3862Jg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 22D793B875;
	Fri, 27 Feb 2015 16:37:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B5413B874;
	Fri, 27 Feb 2015 16:37:52 -0500 (EST)
In-Reply-To: <1424947441-19134-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 26
 Feb 2015 17:44:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E2351DD0-BEC8-11E4-AD27-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264508>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Second round. Looking better. We can do
>  "1.0-pre12 < 1.0-rc0 < 1.0 < 1.0-post1" too but it relies on
>  config key's loading order, a bit iffy.
>
>  Documentation/config.txt |  7 +++++++
>  t/t7004-tag.sh           | 28 +++++++++++++++++++++++++++
>  versioncmp.c             | 50 ++++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 85 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 04e2a71..8e078df 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2539,6 +2539,13 @@ user.signingkey::
>  	This option is passed unchanged to gpg's --local-user parameter,
>  	so you may specify a key using any method that gpg supports.
> =20
> +versionsort.prereleaseSuffix::
> +	When version sort is used in linkgit:git-tag[1], prerelease
> +	tags (e.g. "1.0-rc1") may appear after the main release
> +	"1.0". By specifying the suffix "-rc" in this variable,
> +	"1.0-rc1" will appear before "1.0". One variable assignment
> +	per suffix.

I think the last half-sentence want to mean that

	[versionsort]
                prereleaseSuffix =3D -pre
        	prereleaseSuffix =3D -rc

is the supported way to write, and not

	[versionsort]
        	prereleaseSuffix =3D -pre -rc

but it probably is unclear unless the reader already knows what it
is trying to say.  The reader also needs to learn somewhere how the
order of the entries affects the result.

> +	if (i1 =3D=3D -1 && i2 =3D=3D -1)
> +		return 0;
> +	if (i1 >=3D 0 && i2 >=3D 0)
> +		*diff =3D i1 - i2;
> +	else if (i1 >=3D 0)
> +		*diff =3D -1;

p1 is a prerelease and p2 is not, so p1 comes before p2.

> +	else /* if (i2 >=3D 0) */
> +		*diff =3D 1;

and the other way around.

The math makes sense, I think.
