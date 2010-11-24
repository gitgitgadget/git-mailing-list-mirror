From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send: link against libcrypto for HMAC and others
Date: Wed, 24 Nov 2010 12:01:16 -0800
Message-ID: <7vwro2sd83.fsf@alter.siamese.dyndns.org>
References: <1290606916-14550-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Diego Elio =?utf-8?Q?Petten=C3=B2?= <flameeyes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 21:01:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLLX1-0003cO-NV
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 21:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087Ab0KXUB0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Nov 2010 15:01:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab0KXUBZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Nov 2010 15:01:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D7E02721;
	Wed, 24 Nov 2010 15:01:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3WrBJTxaIPtM
	+81rtQXNVpHrMbo=; b=xWFzQrEH7ffT7887J6akN4ieqs8SqT62F9odV2Do5H54
	Ha/g5GTRVBgHh2pDKaWpxvg1IHFttw+7yNY3PhPwHfOUxb1A2uwxYjWef4znRHvP
	F/q3zEjgTKAteNIXkJV3sWq76QUKBR29JwYtDSmvSmw9rB7XaFI/un06OrDxpZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LpCCUE
	O7IpSL1WiOjStV9pIctnS6j5CTsRVuwOYqdKlCsOA6VJ7nhQlzmvTPkzJoG/7gyq
	ytobNpQfzXDD6PH0oZzMGAmc5qlUlcFFduRAbSPQCkfrtkFrVh2NxhPOxgCdoQ4o
	07ecc0BL+8UNQfrp1HzRedSk3oitIO7whCRY8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 589DC26F7;
	Wed, 24 Nov 2010 15:01:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0A47D26F2; Wed, 24 Nov 2010
 15:01:32 -0500 (EST)
In-Reply-To: <1290606916-14550-1-git-send-email-flameeyes@gmail.com> ("Diego
 Elio =?utf-8?Q?Petten=C3=B2=22's?= message of "Wed\, 24 Nov 2010 14\:55\:16
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4783772-F805-11DF-9D1C-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162076>

Diego Elio Petten=C3=B2 <flameeyes@gmail.com> writes:

> When using stricter linkers, such as GNU gold or Darwin ld, transitiv=
e
> dependencies are not counted towards symbol resolution. If we don't l=
ink
> imap-send to libcrypto, we'll have undefined references to the HMAC_*=
,
> EVP_* and ERR_* functions families.
> ---

Thanks.  Sign-off, please.

>  Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1f1ce04..c8377d4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1927,7 +1927,7 @@ git-%$X: %.o $(GITLIBS)
> =20
>  git-imap-send$X: imap-send.o $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,=
$^) \
> -		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
> +		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
> =20
>  git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GIT=
LIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,=
$^) \
> --=20
> 1.7.3.2
