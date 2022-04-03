Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E04C433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 22:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376547AbiDCWXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 18:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiDCWXN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 18:23:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA6524F1C
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 15:21:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A91E11865B1;
        Sun,  3 Apr 2022 18:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=T/QcEty6W4Wi
        pSc3fkYQgSMTzkZgF9mcHOH+FxPitBw=; b=TX8tdxZ2FcCz0lAWLxNrbPeqXmgH
        wSGtJ+VpQ7Ncq+CwniyGtlMbT5SRbhbVNkUFOIhh2Ax33AlVNLSy1H4+yKopIuQe
        ka/QZVIQiSnMZlsbbV/lxMAaqbw5oj4kpkc3kYraTMc1nd5OM1byFeZMnBl3GSJw
        +5F4o33YdHmLN60=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1D6A1865AF;
        Sun,  3 Apr 2022 18:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0CA3B1865AE;
        Sun,  3 Apr 2022 18:21:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 4/6] i18n: factorize "foo does not take arguments"
 messages
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
        <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
        <6221c37145c22a79bc1598be1e82be50d61636cc.1648915853.git.gitgitgadget@gmail.com>
        <220403.86sfqukz67.gmgdl@evledraar.gmail.com>
Date:   Sun, 03 Apr 2022 15:21:15 -0700
In-Reply-To: <220403.86sfqukz67.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 03 Apr 2022 16:39:43 +0200")
Message-ID: <xmqqr16du7tw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 60B99350-B39C-11EC-8D08-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Apr 02 2022, Jean-No=C3=ABl Avila via GitGitGadget wrote:
>
>> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>>
>> The messages are split into the ones for ref-filter which deal with
>> atoms and scalar which has an option.
>
> I see the git-for-each-ref manpage doesn't really refer to these
> consistently, but I tihnk s/atom/format/g or s/atom/name/g would be lot
> more obvious, especially in the context of how these are already
> discussed in the manpage.

I do not necessarily think so, even though "atom" is a word that
directly faces those who wrote the code in for-each-ref.c that have
been moved to ref-filter.c and not the end users.

These are only parts of a string that is given to --format=3D..., so
"format" makes it more confusing than even the original.

I can buy

    '%(objectype)' in format does not take arguments

though.  If you did not find a specific word to refer to these
"field names" that the documentation consistently uses, it is a way
to clarify which '%(objecttype)' we are referring to, without having
to commit to a single word.

Or we can call them "field names" like the documentation calls them,
which would make it into

    field name '%(objecttype)' does not take arguments

which is not too bad, but I somehow find the former (i.e. "X in
format string does not take arguments") probably the easiest to
follow, if you want to change the original.

Just my 2 yen.

>> @@ -317,7 +317,7 @@ static int objecttype_atom_parser(struct ref_forma=
t *format, struct used_atom *a
>>  				  const char *arg, struct strbuf *err)
>>  {
>>  	if (arg)
>> -		return strbuf_addf_ret(err, -1, _("%%(objecttype) does not take arg=
uments"));
>> +		return strbuf_addf_ret(err, -1, _("the atom '%s' does not take argu=
ments"), "%(objecttype)");
>>  	if (*atom->name =3D=3D '*')
>>  		oi_deref.info.typep =3D &oi_deref.type;
>>  	else
