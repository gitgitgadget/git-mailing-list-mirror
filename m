Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B2DC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCFB20758
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iiLbsOIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgERUPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:15:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59775 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgERUPw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:15:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26A4863D05;
        Mon, 18 May 2020 16:15:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dBw5qJmJ0vYB
        iTbr/7hAbDBWXhM=; b=iiLbsOIWywemR490Yc/IDPhZOvFXyBIKQ6G0QIUeiKk4
        dSK006FdzfiRuCH96hYnLCf7XpvLjy4gOfMpf7TyDWyh8C6fzVUPQlKMAkbGmddu
        zanbgJz4hNhZGLiQ4S5aDxF/rUnEh2dhzaJzyuRpkIzCRREDGSMgjDuOqBljgCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P6Z6OW
        kftdwIQEyDSPSoP+lYowM8C48LjRuFVLi1pGkFbwW/g3SEH4GyiBnnMObG/x9yyS
        PQoFE8hcHQPX4BfynrLdoHl+8bDlODESCPamhDBooG1m/fsy0oU1fSvXPmmfRPQC
        S51pGWdZ/58yVT4m0dQDtuYrgw/e1jSHH8Be4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BC5A63D04;
        Mon, 18 May 2020 16:15:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0ADB63D03;
        Mon, 18 May 2020 16:15:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, emaste@freebsd.org, sunshine@sunshineco.com
Subject: Re: [PATCH v3 1/2] t/helper: teach test-regex to report pattern errors (like REG_ILLSEQ)
References: <20200515195157.41217-1-carenas@gmail.com>
        <20200518184416.13882-1-carenas@gmail.com>
        <20200518184416.13882-2-carenas@gmail.com>
Date:   Mon, 18 May 2020 13:15:49 -0700
In-Reply-To: <20200518184416.13882-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 18 May 2020 11:44:15 -0700")
Message-ID: <xmqqwo590zka.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5DADED92-9944-11EA-BC32-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Based-on-patch-by: Junio C Hamano <gitster@pobox.com>

This is sufficiently different from what I suggested that I do not
deserve the above line, I would think.

> +	ret =3D regcomp(&r, pat, flags);
> +	if (ret) {
> +		if (silent)
> +			return ret;
> +
> +		regerror(ret, &r, errbuf, sizeof(errbuf));
> +		die("failed regcomp() for pattern '%s' (%s)", pat, errbuf);

Nice.

> +	}
> +	if (!str)
> +		return 0;
> +
> +	ret =3D regexec(&r, str, 1, m, 0);
> +	if (ret) {
> +		if (silent || ret =3D=3D REG_NOMATCH)
> +			return ret;
> +
> +		regerror(ret, &r, errbuf, sizeof(errbuf));
> +		die("failed regexec() for subject '%s' (%s)", str, errbuf);
> +	}
> =20
>  	return 0;
> +usage:
> +	usage("\ttest-tool regex --bug\n"
> +	      "\ttest-tool regex [--silent] <pattern>\n"
> +	      "\ttest-tool regex [--silent] <pattern> <string> [<options>]");
> +	return -1;
>  }
