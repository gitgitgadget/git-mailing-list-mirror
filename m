From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-options: detect attempt to add a duplicate short option name
Date: Thu, 04 Sep 2014 10:24:20 -0700
Message-ID: <xmqqegvruwmz.fsf@gitster.dls.corp.google.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
	<1409753034-9459-3-git-send-email-johan@herland.net>
	<xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com>
	<xmqq1trsxzgy.fsf_-_@gitster.dls.corp.google.com>
	<54077A3E.20703@web.de> <xmqqoauwwh2c.fsf@gitster.dls.corp.google.com>
	<54078C2C.5020503@web.de>
	<xmqqbnqwwds2.fsf@gitster.dls.corp.google.com>
	<540802F5.1070708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 04 19:24:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPalo-00035l-2c
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 19:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbaIDRYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2014 13:24:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58128 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754387AbaIDRYW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 13:24:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B93C37F4E;
	Thu,  4 Sep 2014 13:24:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=V1Vws0cwXMBc
	hDRKBB83jNAVDQc=; b=g37MRbZYdYw9cmjxJzvg1j4ZgmsbVx4xSvi7wmwTA6uz
	uFtLqr9VYU9CP3K8GGGtoMUMK/SWjrTpHhlpyGun1i0bay5cDz9pUTOFBulF9XrA
	czp3oqoqNoL+KDoa0OoOG3xQCXo8+/CJhkHihCz4FxYAx2gzLePcX6JBzy1rvf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qEwpoQ
	B6YWTU6Te/IYwUFw2qhAaA/5ecQ8jgOkP5VZFLfaXAWu7Aduk+8RPwAQdW2s+G4K
	7fuXJ728E0Vk1SZqS7xMvc4SD8jAAl5iYIgYDfdaTqK6Ne6KaA+3uqRu2eg6QwOL
	bdqC2eQyxgAQSuevz1dX7mGC96HJ8tKpzEbqA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 303DF37F4D;
	Thu,  4 Sep 2014 13:24:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9828037F4C;
	Thu,  4 Sep 2014 13:24:21 -0400 (EDT)
In-Reply-To: <540802F5.1070708@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Thu, 04
	Sep 2014 08:13:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4F130666-3458-11E4-8204-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256453>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> Not quite, as an opt with long name is reported with the long name
>> only, which is not very nice when the problem we are reporting is
>> about its short variant.
>
> Perhaps something like the patch below helps, here and in general?

Excellent.  Not just this particular case, but we would show both
when both are available.

Thanks; will reroll.

>  parse-options.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index b7925c5..f1c0b5d 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -14,8 +14,12 @@ static int parse_options_usage(struct parse_opt_ct=
x_t *ctx,
> =20
>  int optbug(const struct option *opt, const char *reason)
>  {
> -	if (opt->long_name)
> +	if (opt->long_name) {
> +		if (opt->short_name)
> +			return error("BUG: switch '%c' (--%s) %s",
> +				     opt->short_name, opt->long_name, reason);
>  		return error("BUG: option '%s' %s", opt->long_name, reason);
> +	}
>  	return error("BUG: switch '%c' %s", opt->short_name, reason);
>  }
