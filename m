From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] sparse: Fix mingw_main() argument number/type errors
Date: Sun, 28 Apr 2013 12:31:11 -0700
Message-ID: <7v38uaqwow.fsf@alter.siamese.dyndns.org>
References: <517C24D3.8080802@ramsay1.demon.co.uk>
	<517C6DEF.2050305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Apr 28 21:31:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWXJl-0000OL-VI
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 21:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448Ab3D1TbO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Apr 2013 15:31:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756392Ab3D1TbN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Apr 2013 15:31:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 165AA1A487;
	Sun, 28 Apr 2013 19:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2U2EB5wbSSrV
	qD/JeDxdKbgTCzw=; b=Wc9g366rSTy3CJjdjS58DL9yGC1H6UG78ZcVqHbRAauS
	n1Uw173Pb8x3a7p0bZIWa3r8hQZBHoBiuD1tIoPz5ChWBHL7MMqdf1FhFvoevkln
	o6xFsr7JanZphgEXUh7oa/qeIxhgSPdNusev1DnCRgaCbrYYL5qnSTy5QfjngSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LNfwAC
	Dy54b20GaW3RJmUe2P3Zi9z9COLYADobnLc+aIraODHsuVPrvSHQ+vViaMnTbl//
	l7OAwFt2d83Xzsss2KUg4zjjdcyaxch0zrftU84EnphMsOd/G6A5d+ZxRe1Gsuj4
	98pCVGowpCl1TWRrS10n4RFIqn09ZXrK+0aO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CE491A486;
	Sun, 28 Apr 2013 19:31:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 865041A483;
	Sun, 28 Apr 2013 19:31:12 +0000 (UTC)
In-Reply-To: <517C6DEF.2050305@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Sun, 28 Apr 2013 02:31:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F78AF66-B03A-11E2-919D-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222747>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Why not take the opposite direction with a patch like this?
> ...
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 389ae01..74e7b87 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -452,11 +452,11 @@ int xwcstoutf(char *utf, const wchar_t *wcs, si=
ze_t utflen);
> =20
>  void mingw_startup();
>  #define main(c,v) dummy_decl_mingw_main(); \
> -static int mingw_main(); \
> +static int mingw_main(int, const char **); \
>  int main(int argc, const char **argv) \

But traditionally main is declared like=20

	int main(int argc, char *argv[]);

without const, no?
