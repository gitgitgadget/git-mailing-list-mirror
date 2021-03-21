Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D1C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 17:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EEE6192D
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 17:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCURZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 13:25:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54508 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhCURZP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 13:25:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EE5D1261F3;
        Sun, 21 Mar 2021 13:25:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=c3I9akn8chmk
        HWXEAQgda661cOI=; b=iTd/pMJ+VMqXkUPgdJurmFmdw1RxtY9rOCX/4jNoKmAl
        w20kcGLUfjbYelSWhFTltZBSKz8b8ubm86/6lD/j0mWawDNvuvT3PjDjr79+NNIJ
        hiK22418iOMxpf0TzhXvO3DdtzDgyPXBfxrkbOLFdwIe+1Kl2N05p+6MIMoZYeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=w7G01b
        A0ovEDPrqdanybfrJQEzKQFAfgsgT4GJfUEbbHhoudRRmr/Rw2IhYKwr+Fb0Iyg4
        F2sWvhBWWs/WPzDTT3OwzQWlFIPfD4dm5mxFk7SCPv7Iim1vh0lZA8pbV1ZDD7UT
        i/xdIcm4UEmve1+v6nn4Zt2cgPThRnnDVMJlI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47F211261F2;
        Sun, 21 Mar 2021 13:25:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 920C61261F1;
        Sun, 21 Mar 2021 13:25:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Kleber_Tarc=C3=ADsio_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Kleber =?utf-8?Q?Tarc=C3=ADsio?= <klebertarcisio@yahoo.com.br>
Subject: Re: [PATCH] fix null pointer dereference
References: <pull.983.git.git.1616323936790.gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 10:25:09 -0700
In-Reply-To: <pull.983.git.git.1616323936790.gitgitgadget@gmail.com>
 ("Kleber
        =?utf-8?Q?Tarc=C3=ADsio?= via GitGitGadget"'s message of "Sun, 21 Mar 2021
 10:52:16
        +0000")
Message-ID: <xmqqft0oberu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6422F164-8A6A-11EB-A6E2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kleber Tarc=C3=ADsio via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Kleber=3D20Tarc=3DC3=3DADsio?=3D <klebertarcisio@yaho=
o.com.br>
> Subject: Re: [PATCH] fix null pointer dereference

Thanks, but see Documentation/SubmittingPatches for general guidelines.
Our commit title begins with "<area>:" so that when this change is
buried among hundreds of other commits in "git shortlog --no-merges",
the readers can tell what it is about.

	Subject: [PATCH] submodule-helper: avoid unchecked malloc()

perhaps.

> The malloc function can return null when the memory allocation fails. T=
his commit adds a condition to handle these cases properly. https://cwe.m=
itre.org/data/definitions/476.html

Overlong line.  Also when you can say something without forcing
readers to refer to external material, do so (and if you do not
think you can, try harder ;-).

In this case, I think you do not need to say
anything more than

	submodule-helper.c::submodule_summary_callback() calls
	malloc() and uses the returned value without checking for
	NULLness.  Use xmalloc() instaed.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 9d505a6329c8..92349d715a78 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1215,6 +1215,8 @@ static void submodule_summary_callback(struct dif=
f_queue_struct *q,
>  		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
>  			continue;
>  		temp =3D (struct module_cb*)malloc(sizeof(struct module_cb));
> +		if (!temp)=20
> +			die(_("out of memory"));

And this should be just

- 		temp =3D (struct module_cb*)malloc(sizeof(struct module_cb));
+ 		temp =3D (struct module_cb*)xmalloc(sizeof(struct module_cb));

without any "check and die" on its own.

Note that if this were a new code that adds a call to xmalloc(),
competent reviewers would say it should be spelled more like so:

 		temp =3D xmalloc(sizeof(*temp));

to lose unnecessary cast and to prepare for future evolution of the
code (e.g. the type of 'temp' may change from 'struct module_cb' to
somethng else).  But for this "malloc is wrong, use xmalloc instead"
fix, we do not mix such a code improvement in the same patch.

Thanks.

