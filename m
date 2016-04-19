From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
Date: Tue, 19 Apr 2016 11:05:14 -0700
Message-ID: <xmqqpotl1nl1.fsf@gitster.mtv.corp.google.com>
References: <20160419151044.27814-1-gitter.spiros@gmail.com>
	<20160419151044.27814-5-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:05:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asa1c-0005Lw-FL
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 20:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbcDSSFS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 14:05:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932209AbcDSSFR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2016 14:05:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 266F813788;
	Tue, 19 Apr 2016 14:05:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Y5kkAZp7mLqu
	P+4ZFc0dUQZF+Ro=; b=NP6OSO5iWkesSRXXDGTd2eRCmZR6dqhCdqvnkw4cgfyB
	Ki6lq6JtRL3MBFZSLsspysBDHN/Z0kuQTu75FvNqIo6zaj3nJsYVT/O4LTYz5A6g
	RV4jUp1x/rdfIOUU4lDiG6duyjPbddO3oWZoPxcdFL0gmZwdwZ1vRHPcpasoDq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kVGHDN
	o5tlprg04rwUGDgGD1LYBLkDrmIhlj2S1GSwLBl1eh+4+g7R20aHYfQLUSsWCKbV
	QzssjJ+3IjiEreoIeUSl4AccQLC1kJvLjppnZIIsShEDzwQ8zLBG9Le55eb6pugR
	+PRoMePeSozHsIkLgBk54rIk+k+35syaLm1Mw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F26713787;
	Tue, 19 Apr 2016 14:05:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 73AB613785;
	Tue, 19 Apr 2016 14:05:15 -0400 (EDT)
In-Reply-To: <20160419151044.27814-5-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Tue, 19 Apr 2016 15:10:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44ADFB2A-0659-11E6-B824-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291897>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Permit the use of the GIT_TRACE_CURL environment variable calling
> the curl_trace and curl_dump http.c helper routine

s/$/./; the patch itself is very concise and the "dump" thing in 3/4
looked sensible.

>
> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>=20
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  imap-send.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/imap-send.c b/imap-send.c
> index 938c691..b371a78 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1444,6 +1444,12 @@ static CURL *setup_curl(struct imap_server_con=
f *srvc)
>  	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
>  		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
> =20
> +	if (trace_want(&trace_curl)) {
> +		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
> +		curl_easy_setopt(curl, CURLOPT_DEBUGFUNCTION, curl_trace);
> +		curl_easy_setopt(curl, CURLOPT_DEBUGDATA, NULL);
> +	}
> +
>  	return curl;
>  }
