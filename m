Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA76C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8206197C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhC1G2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 02:28:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64841 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhC1G2J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 02:28:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81203B9839;
        Sun, 28 Mar 2021 02:28:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=J5e8Wq+0TbL3
        w326MVqEf7q003k=; b=cixAN9EKkXSG9VCi7sPrUQ901izi6gzjZP7w7iHWNr0Y
        K7ZMsok6DcPc3Sp4BeSD/Nm4gOZMDV5oSvb6OqzfRmqCNW+UlgB9ZXfUqv5kgHps
        Qevc0bP90Y85V7JTHuSeXjwXUlR/mTTQeQQkM6vUkpiF6acFgzB972gqoZHgplQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vRaBDg
        YI1OTcfiQeJeuZqBaolVG/Mbb72qDIagMvzZYPECTsyZys2iFpDxK3JjxpSwYiam
        AVVzrRu2dwS2EgJ8Rt+i/sUoNkrvjvB4vZqk0msdlGtdJguEId1GVwAZ/X1ha/vL
        AwtYTD4fDQBa1IYasc5ox0ixO74eVHpJseNRc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67E11B9838;
        Sun, 28 Mar 2021 02:28:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E044B9837;
        Sun, 28 Mar 2021 02:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] Documentation/Makefile: make $(wildcard <doc deps>)
 a var
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
        <patch-2.6-fdc55a86cf4-20210326T103454Z-avarab@gmail.com>
Date:   Sat, 27 Mar 2021 23:28:06 -0700
In-Reply-To: <patch-2.6-fdc55a86cf4-20210326T103454Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 26 Mar
 2021 11:36:47 +0100")
Message-ID: <xmqq7dlrokqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C27C8076-8F8E-11EB-9025-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor the wildcard we'll scan for "include" directives into a
> single INCLUDE_TARGETS_TXT variable for readability, consistency.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 0ba7564be93..7313956d73f 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -3,6 +3,7 @@ MAN1_TXT =3D
>  MAN5_TXT =3D
>  MAN7_TXT =3D
>  HOWTO_TXT =3D
> +INCLUDE_TARGETS_TXT =3D
>  TECH_DOCS =3D
>  ARTICLES =3D
>  SP_ARTICLES =3D
> @@ -45,6 +46,9 @@ MAN7_TXT +=3D gitworkflows.txt
> =20
>  HOWTO_TXT +=3D $(wildcard howto/*.txt)
> =20
> +INCLUDE_TARGETS_TXT +=3D $(wildcard *.txt)
> +INCLUDE_TARGETS_TXT +=3D $(wildcard config/*.txt)
> +
>  ifdef MAN_FILTER
>  MAN_TXT =3D $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)=
)
>  else
> @@ -287,7 +291,7 @@ docdep_prereqs =3D \
>  	mergetools-list.made $(mergetools_txt) \
>  	cmd-list.made $(cmds_txt)
> =20
> -doc.dep : $(docdep_prereqs) $(wildcard *.txt) $(wildcard config/*.txt)=
 build-docdep.perl
> +doc.dep : $(docdep_prereqs) $(INCLUDE_TARGETS_TXT) build-docdep.perl
>  	$(QUIET_GEN)$(RM) $@+ $@ && \
>  	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
>  	mv $@+ $@

While this may not break anything per-se, I find the name of the new
macro not quite intuitive.

The build-docdep script opens $(wildcard *.txt) itself (without
getting them fed from Makefile) to find what other files are used
via "include::", and then it recursively scans more files that are
used via "include::" to build dependencies.  Makefile assumes the
"include::" chain would pull in $(wildcard config/*.txt) files, but
this assumption may not prevent other *.txt files from getting
pulled in (not a new problem introduced by this patch).

I am not sure what these *.txt files involved in the process should
be called, but "include targets" sounds something else.  Na=C3=AFvely, I
would say "we rebuild documentation dependency any time any source
text file changes", so if this were called "ALL_TXT" or something
like that, I wouldn't have such a reaction.

Thanks.

