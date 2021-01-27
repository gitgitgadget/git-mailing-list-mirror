Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4CAC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926C02070C
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbhA0D64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:58:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64246 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404943AbhA0Bac (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 20:30:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E611AE43C;
        Tue, 26 Jan 2021 20:29:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tvjBTnH+LvF5
        gq5hJcMENtwAUYg=; b=mIZLpI9z0GSWU8oMZsU7Q0tMrZXN6HQ7cEoCkH5E/gCa
        dWPvvswHsTP41dEAIErDEC/awq9SgGLt6s3VCu+k2Hg23ARmNiehaoD4r5wiWAET
        qsyyl7QO9AVnSU4P5Xbx115NYl+324zd/BEamqNhm/2cdEKpvYH2ly3Hq9hWzL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=opeYts
        qfp3xUQR6M6Q6wsSvcgl/7d6JiCwq/qSxBxOoGnbBrcnmu3OrlHCeK5h7z+Bpr3/
        XBaH2WfkkkqZjNevq+fkKq7XFnnjGIIBTDqJ9MIC5mPBdz/gvUMuTBDibMaTEWIs
        zf4sJQSF4gmYgKiJdTMSCPC0a/Dwa53TlUFlU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66891AE43B;
        Tue, 26 Jan 2021 20:29:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9C0EAE439;
        Tue, 26 Jan 2021 20:29:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] Makefile: refactor assignment for subsequent change
References: <20210126160708.20903-1-avarab@gmail.com>
        <20210126160708.20903-2-avarab@gmail.com>
Date:   Tue, 26 Jan 2021 17:29:49 -0800
In-Reply-To: <20210126160708.20903-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 26 Jan 2021 17:07:05 +0100")
Message-ID: <xmqqa6svyxo2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 25E210EC-603F-11EB-A676-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor a multi-line assignment into a form that'll lend itself
> better to having "ifdef" split it up in a follow-up commit.

Hmph, it would do even better to start with an empty definition
without treating the first one specially, i.e. ...

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 4edfda3e009..36c7b8fa08b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -656,10 +656,10 @@ clean-perl-script:
>  clean-python-script:
>  	$(RM) $(SCRIPT_PYTHON_GEN)
> =20
> -SCRIPTS =3D $(SCRIPT_SH_GEN) \
> -	  $(SCRIPT_PERL_GEN) \
> -	  $(SCRIPT_PYTHON_GEN) \
> -	  git-instaweb
> +SCRIPTS  =3D $(SCRIPT_SH_GEN)

... if this becomes ...

SCRIPTS =3D
SCRIPTS +=3D $(SCRIPT_SH_GEN)

... instead, no?

> +SCRIPTS +=3D $(SCRIPT_PERL_GEN)
> +SCRIPTS +=3D $(SCRIPT_PYTHON_GEN)
> +SCRIPTS +=3D git-instaweb
> =20
>  ETAGS_TARGET =3D TAGS
