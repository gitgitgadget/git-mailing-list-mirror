Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5901DC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F62620643
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="acOR1igp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbgERSUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 14:20:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60785 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgERSUO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 14:20:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10991C8BB0;
        Mon, 18 May 2020 14:20:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U5dPihrV+YFGaacqCv0hvXAOCIc=; b=acOR1i
        gpzc7ulUDW4p818vIO9hQc6QiV0Xrc5epJMFxUxcMG0FNC0AkeANoEFF/jN92+13
        EPPxzZ3hoeqMZBvXi2lvu5jhGsJuZWm+9WeCDNVIty1DkNmTDcZY2k9yu1XL86Gd
        eV0Qww8JPe19YdM62oU/pLW/Huv6rBZxB/4Ks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A2q1t6oKwbq1x2D0sCsugMQYfp847yUV
        N4cE0bMrfcxKShCtpw0bsPm39I0rZHmwG8HawFlyh188WoXLh7aClbUUsuaoGJIw
        FxSuHMvOfmqx/PVhemq+SgVJtFFZmz0hZ8VhoXucoGp2PYpcop+neVwXu1ZoUbZ1
        2btTVpMC6ug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08622C8BAF;
        Mon, 18 May 2020 14:20:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 45F8BC8BAC;
        Mon, 18 May 2020 14:20:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Darren Tucker <dtucker@dtucker.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/7] Redirect grep's stderr top null too.
References: <20200518100356.29292-1-dtucker@dtucker.net>
Date:   Mon, 18 May 2020 11:20:07 -0700
In-Reply-To: <20200518100356.29292-1-dtucker@dtucker.net> (Darren Tucker's
        message of "Mon, 18 May 2020 20:03:50 +1000")
Message-ID: <xmqq367x3y20.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34E5C3A4-9934-11EA-A89B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Darren Tucker <dtucker@dtucker.net> writes:

> Subject: Re: [PATCH 1/7] Redirect grep's stderr top null too.

Our patch title typically looks like

	area: title without initial Capitalization and full stop

Perhaps

	Subject: autoconf: redirect grep's stderr to null

> Prevents pollution of configure output on platforms that don't have
> grep -a.

Our log message typically describes the state without this patch in
the current tense to highlight the problem being solved, and then
orders the person who is updating the system to "make the codebase
like so", e.g.

	When the tested platform's 'grep' does not support the '-a'
	option, an error message would be given to its standard
	error stream, polluting the output.

	Redirect the error message to /dev/null, in addition to the
	standard output, to squelch it.

or something along that style.

Thanks.

>
> Signed-off-by: Darren Tucker <dtucker@dtucker.net>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index 66aedb9288..4effc82b76 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -526,7 +526,7 @@ if test -n "$ASCIIDOC"; then
>  	esac
>  fi
>  
> -if grep -a ascii configure.ac >/dev/null; then
> +if grep -a ascii configure.ac >/dev/null 2>&1; then
>    AC_MSG_RESULT([Using 'grep -a' for sane_grep])
>    SANE_TEXT_GREP=-a
>  else
