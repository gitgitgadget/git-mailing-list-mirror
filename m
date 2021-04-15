Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37425C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 17:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E406115B
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 17:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhDORm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:42:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50125 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbhDORm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 13:42:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA48A12241F;
        Thu, 15 Apr 2021 13:42:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=D7seFLxRZIE9
        EIKkgSb4DaRCMLQ=; b=TI5++STaTomu+24AOUo9baxrGD7kQbyVzN7kGMmSEuP/
        rOz+d9VbzAWkKlpB0dQDp6rKhacU+XbemKgO5Ti37VjfXpvncw+5gEUayT4wo34S
        TuKxGcR/sve8rjlpyXFxMvtjJuaL7+9f6J+wTzBfPuXbdIz5WxXYWvDhrb/Rozs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fK9uSL
        MflVfWjp+8iioIFeJffOuSluBGuNd/sKgyVsFjNPAm1jrXTjOJSjFCgTCKyKrzYA
        Sie7DwRd5tQidsbqoUlxPn5mxgDLHD1OevYEnczPqFvYqaFKoxfeGlEBO8IpSV5x
        gRW29QbzkgEIi/yxwNArXNGZyVuATX3sDdTq8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D236D12241E;
        Thu, 15 Apr 2021 13:42:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1573A12241A;
        Thu, 15 Apr 2021 13:42:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v9 2/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
        <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <7f645ec95f48a206311973ee45578ba14ac58b7f.1618245568.git.gitgitgadget@gmail.com>
        <xmqqsg3vb51n.fsf@gitster.g>
        <CAP8UFD1r2kUaKbjFcRn_FGxz5=hvwY+DHdmPKR61cNdHzBe26A@mail.gmail.com>
        <CAOLTT8TB9UF5z-51pLxdkRUxo5-w2+_U_e1wpDAdzBBmT3Og7w@mail.gmail.com>
        <xmqq35vum1rn.fsf@gitster.g>
        <CAOLTT8TNK55AprX2tezoX4YjWV31RRyLWc9NJOvidRqqSgBpQQ@mail.gmail.com>
        <xmqqv98oy5bh.fsf@gitster.g>
        <CAOLTT8TVAvk_Hdcd27jHz5wWOR6xEMuCeQvDfu48qVDFPN666A@mail.gmail.com>
Date:   Thu, 15 Apr 2021 10:41:57 -0700
In-Reply-To: <CAOLTT8TVAvk_Hdcd27jHz5wWOR6xEMuCeQvDfu48qVDFPN666A@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 15 Apr 2021 23:32:54 +0800")
Message-ID: <xmqqh7k7savu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E192B368-9E11-11EB-B961-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8815=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:33=E5=86=99=E9=81=93=EF=BC=9A
>>
>> So far, I haven't heard anything that indicates it is a useful
>> behaviour for .command, so my preference is to get rid of the
>> behaviour when we introduce .cmd to deprecate .command; yes, until
>> we get rid of .command, the behaviour between the two would be
>> inconsistent but that is unavoidable when making a bugfix that is
>> backward incompatible.
>>
>> When (and only when) anybody finds a credible use case, we can add a
>> mechanism to optionally turn it on (e.g. .runMode).
> ...
> Perhaps such a modification can meet our temporary needs!
>
> @@ -721,9 +738,10 @@ static void process_command_line_args(struct
> list_head *arg_head,
>         char *cl_separators =3D xstrfmt("=3D%s", separators);
>
>         /* Add an arg item for each configured trailer with a command *=
/
>         list_for_each(pos, &conf_head) {
>                 item =3D list_entry(pos, struct arg_item, list);
> -               if (item->conf.cmd || item->conf.command)
> +               if (item->conf.command)
>
> I'm so busy today that I probably haven't had time to put this into a
> patch today,
> If this solution is reasonable, I will send a new version of the patch =
tomorrow.
> As you said, first solve the misfeature, and we can add [trailer.runMod=
e] later.

I am perfectly fine (or rather I'd be happy) to wait for a while to
see such a patch, as it would be a good idea to give time to those
who do have need for this extra/empty execution to chime in.  So,
there is no need to rush.

Thanks.
