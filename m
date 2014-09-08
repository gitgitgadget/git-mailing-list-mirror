From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "trace.c", line 219: error: identifier redeclared: trace_strbuf
Date: Mon, 08 Sep 2014 11:11:37 -0700
Message-ID: <xmqq7g1enfs6.fsf@gitster.dls.corp.google.com>
References: <893371408.24076.1410031614959.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
	<540B742F.5030700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dev <dev@cor0.com>, git@vger.kernel.org,
	Karsten Blees <karsten.blees@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 08 20:11:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR3Pk-0006Hp-Ah
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 20:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbaIHSLk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2014 14:11:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54959 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891AbaIHSLk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Sep 2014 14:11:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9215E37DA6;
	Mon,  8 Sep 2014 14:11:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XbYCBSArZ/d5
	cPfcgC6hoy2khTE=; b=R3RZzRmRBuK/h4pDbhr3yTODNWL+KOr50u1jWbntVxvl
	7vZf80hw55hwov4STEczwqgqKjOfyQ4gRnbE79MgjX6Vl7dTwA4B9kOW4wGPVfW1
	OcsxLvpyE+ik239BOg8I7BX/v8o50lazn5ijzpdrWGCehF4Aas9IlE3uNFGkLV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=v/YsGg
	t8TXuJRy6rkAwc8gQjOphab2HBgLPiFdctAGZB+hcFFTmfmhKQacjehZYfOC1LSH
	bpCGiPY8SOVArH2PiIsMwsFIUXz5S8rWAEZyT38z1vqAmcNV+1g/WG+R3AT4YP6H
	5Pz4hpfLmPutNTtT2YEah7TOoMszEPVIca+1A=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 86D7A37DA5;
	Mon,  8 Sep 2014 14:11:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 01D0137DA3;
	Mon,  8 Sep 2014 14:11:38 -0400 (EDT)
In-Reply-To: <540B742F.5030700@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 06
	Sep 2014 22:53:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 93EFCDCC-3783-11E4-AFA9-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256665>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The issue was introduced with e05bed96 (trace: add 'file:line' to all
> trace output).
>
> -- >8 --
> Subject: [PATCH] trace: correct trace_strbuf() parameter type for !HA=
VE_VARIADIC_MACROS
>
> Reported-by: dev <dev@cor0.com>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/trace.c b/trace.c
> index 54aaee5..b6f25a2 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -216,7 +216,7 @@ void trace_argv_printf(const char **argv, const c=
har *format, ...)
>  	va_end(ap);
>  }
> =20
> -void trace_strbuf(const char *key, const struct strbuf *data)
> +void trace_strbuf(struct trace_key *key, const struct strbuf *data)
>  {
>  	trace_strbuf_fl(NULL, 0, key, data);
>  }

Thanks.

Will queue on top of kb/perf-trace, hoping to merge it down later.
