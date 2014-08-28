From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/6] Add git_env_ulong() to parse environment variable
Date: Thu, 28 Aug 2014 10:13:13 -0700
Message-ID: <xmqqk35sbkra.fsf@gitster.dls.corp.google.com>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
	<1409066605-4851-3-git-send-email-prohaska@zib.de>
	<20140826182125.GC17546@peff.net>
	<xmqq38cjhuje.fsf@gitster.dls.corp.google.com>
	<20140826203158.GA30651@peff.net>
	<xmqq38cihq7w.fsf@gitster.dls.corp.google.com>
	<20140827044621.GA32141@peff.net>
	<xmqqtx4yf0r2.fsf@gitster.dls.corp.google.com>
	<7AD881F3-DDD0-4094-90F3-C3E2F81DF664@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:13:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN3GL-0005Jx-CW
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 19:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbaH1RNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 13:13:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62538 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbaH1RNY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 13:13:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED69735CF4;
	Thu, 28 Aug 2014 13:13:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vlugLYoYfQaX5ODoSN/+FMROxyc=; b=LqCAF1
	HYbR3B6o3RP8o3mJvTgRSpqeB8PE3z0yamkCkZdzmI0BQpt0FLOcyEu/YsIAhmn+
	HWDEvn9K+uMwj83byRKxCDIC3QLOkRErGQ/SwUjrfTzVxB02Sh0SEGJ4QUKbchhd
	Qz8sUT42pCHbi7oqKr5Ny4T/cJ/RMnA+8T0ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ja7z+/cGIJWdfmA1sYy4vmJvNTAEpsoB
	FlTd3BnAu09J76RZOYiRuuWykdx5HWc76Szv3Z5M9lSV/iS1xgZdBD1X82hkGyx0
	3jFb2GduonRRNQuohzgeKl1tmfwm/TJvpIEBBd4C2ItnI7Dfhw/1iq/m12v4tA0p
	EhsW07f/RpA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E1CF335CF3;
	Thu, 28 Aug 2014 13:13:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 79E8035CE7;
	Thu, 28 Aug 2014 13:13:15 -0400 (EDT)
In-Reply-To: <7AD881F3-DDD0-4094-90F3-C3E2F81DF664@zib.de> (Steffen Prohaska's
	message of "Thu, 28 Aug 2014 17:21:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 99243E64-2ED6-11E4-A17B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256104>

Steffen Prohaska <prohaska@zib.de> writes:

>> OK, then let's do that at least for now and move on.
>
> Ok.  I saw that you tweaked my patch on pu.  Maybe remove the outdated
> comment above the function completely:
>
> diff --git a/config.c b/config.c
> index 87db755..010bcd0 100644
> --- a/config.c
> +++ b/config.c
> @@ -1122,9 +1122,6 @@ int git_env_bool(const char *k, int def)
>         return v ? git_config_bool(k, v) : def;
>  }
>
> -/*
> - * Use default if environment variable is unset or empty string.
> - */

Thanks, will do.

>  unsigned long git_env_ulong(const char *k, unsigned long val)
>  {
>         const char *v = getenv(k);
>
> 	Steffen--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
