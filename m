Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9628A1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbdLLTx5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:53:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55934 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751499AbdLLTx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:53:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70D70C814A;
        Tue, 12 Dec 2017 14:53:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2+cYzpFM6XlB
        7FSLT7Bi9J1kLpw=; b=J61umx4xiy4cIDaYw6kOR1aWee/F+7bG8pGfS5Wyakp9
        KFKBW/lcPQfshP9jot8hJqRRCzb6pHsVzpgacia5FVL030oGbTYfdy1ml/uASj/r
        Rjxe1emPOF5IRoIxk33YuuRDbwK0WKvBihELg5I2WXyvQUCeMk34LGG0Ff8XWZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nYN8Ne
        SzLOF09eRc/h5yizplEJXhmw39Q7ESM0aBtcNNOt2fvM8nUc++Su8j0KlvgOqlcn
        vL0Ar12H0/o3XDr96PbnpOQRMw6Z9hdljHkAc9QsGn3ZLX3RAd2YasEYntDtLjVo
        +iAzi1RrD+TyfL9myO0baOHcsPb7yKq8nr/kM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68846C8149;
        Tue, 12 Dec 2017 14:53:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5927C8147;
        Tue, 12 Dec 2017 14:53:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: allow NO_DC_SHA1_SUBMODULE to be set in config.mak
References: <7272c221-c1b6-ca41-3be4-329275e94b8a@ramsayjones.plus.com>
Date:   Tue, 12 Dec 2017 11:53:54 -0800
In-Reply-To: <7272c221-c1b6-ca41-3be4-329275e94b8a@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 12 Dec 2017 12:47:25 +0000")
Message-ID: <xmqqk1xr204t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2FC84128-DF76-11E7-B4B5-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> Could you please add (or squash) this on top of the 'ab/sha1dc-build'
> branch, so that I can build with NO_DC_SHA1_SUBMODULE=3DNoThanks in my
> config.mak.

Makes sense.  The patch looks scary by appearing to move the
includes far to the front of the Makefile, but it in fact is moving
the NO_DC_SHA1_SUBMODULE block slightly down and it is a sensible
and safe move.

I actually think that the block can go even further down, perhaps
close to the run of choices "what variant are we building?" we make
at around we have "ifdef NO_CURL".

=C3=86var?

> diff --git a/Makefile b/Makefile
> index 929b49b04..91bbb0ed8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1042,6 +1042,10 @@ EXTLIBS =3D
> =20
>  GIT_USER_AGENT =3D git/$(GIT_VERSION)
> =20
> +include config.mak.uname
> +-include config.mak.autogen
> +-include config.mak
> +
>  ifndef NO_DC_SHA1_SUBMODULE
>  	ifndef DC_SHA1_EXTERNAL
>  		ifneq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisionde=
tection/lib/sha1.h)
> @@ -1053,10 +1057,6 @@ whatever reason define NO_DC_SHA1_SUBMODULE=3DNo=
Thanks)
>  	endif
>  endif
> =20
> -include config.mak.uname
> --include config.mak.autogen
> --include config.mak
> -
>  ifdef DEVELOPER
>  CFLAGS +=3D $(DEVELOPER_CFLAGS)
>  endif
