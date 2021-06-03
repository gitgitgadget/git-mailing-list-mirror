Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8B4C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 05:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F94561360
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 05:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFCFja (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 01:39:30 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:37578 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFCFja (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 01:39:30 -0400
Received: by mail-io1-f46.google.com with SMTP id q7so5089694iob.4
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 22:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QXFFj1Vzn/QKwK038qtAziMT5OWIMHyXrFZMXhNjdT8=;
        b=GuMyh/lJql8PrqE4ZhkUF5F0onC78VdqXJDwnxyUxMqtLAFnx7OGOe9i/zH1yvTUEj
         j6vXTv3MSS96nScg6NZ3hqWzaTKpL9Cr6Waz6Nf2bqfIoy19eY+EmpMOZrKHMbap7Oz9
         0F6BLGfCEBvj0ULF9FomEI/VgbvN1Qn0Supy9HJSmU734HKVz8nKj0k+QxzNvcUAgSoz
         VqiDsfM5N5o7Hp7lsNjlQyd3bvHe1DhRjJQW6Hq9oGCcx2uu5v9QqzVzQOPwbTZV7ITm
         kkGEVbX3b6sMfUsw8MCWiqIHPUF6edBvRac2Vp/okWebB/5LFqjJH0epMY6w7knqH7qI
         QGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QXFFj1Vzn/QKwK038qtAziMT5OWIMHyXrFZMXhNjdT8=;
        b=YSIukAxg2EC7bnzFiB6YwDZcr2cve8PyEBZQyteGDaEND/GUX/ZaPouKfN99qrbhYH
         InV/1fpqE8WjKbsa2Sf+VPu1s7asHF7Z+ecj7f5kgYh3dgS2re85T/l0V64fG2CcO2u7
         HbxYshjARSus1nYHfO23wUSC2iczzqv/Bzr0jSMBwAwNwi3ocREDy4GWacYurdh7/pbX
         YQggcsEsJHrfP107u7ipmS54b5iUHBvnZQiv2zFq78oNXREAXu0VpHElQOO8RN/dslSD
         5pQpNM7Or439YfH7SSNHAFYQDJp5iPKfEIuLpopLdkpEyivI9BoEykFGISOK4MbnCsA9
         Nr2Q==
X-Gm-Message-State: AOAM533EDmzAbEMzcak1waV6nt6Nx5TIGvlCNhrgd5vUdj2I8M55o9PU
        tEwu4i9Kjw56lcBagum4gRV76dGiR6ZLVUxyTdE=
X-Google-Smtp-Source: ABdhPJyl0TTVQY4xj12X0PuB3oDL44khjtCkg6c/n7W2rdWMBzi8JqxOdM1jiFDyhcpdVR5SAIoRHwedUtEDUjgDtlQ=
X-Received: by 2002:a5d:89c5:: with SMTP id a5mr29031486iot.172.1622698593422;
 Wed, 02 Jun 2021 22:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
 <5a94705cdbc101169488919e35613d723e6ec581.1622558243.git.gitgitgadget@gmail.com>
 <xmqqsg1z65b8.fsf@gitster.g>
In-Reply-To: <xmqqsg1z65b8.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 3 Jun 2021 13:36:21 +0800
Message-ID: <CAOLTT8TiyAtJfcrPoBF6SECfaKOTKt24NSOtTmf84JwHrU8g1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] ref-filter: add %(raw) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=883=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8810:38=E5=86=99=E9=81=93=EF=BC=9A
>
>
> These two hunks
>
>  - hoists up the code that sets 'arg' to optional string after
>    "<atom>:" and counts how long the "<atom>" is in 'atom_len'; the
>    change causes the counting done even when the same placeholder is
>    already used elsewhere (in which case we do not have to do such
>    counting);
>

I admit that I am doing repetitive work here.

>  - inserts the early return to reject use of "raw" atom when
>    language specific quoting is used.
>
> It probably makes it easier to understand if the former is split
> into a separate commit, but at the same time a series with too many
> small steps is harder to manage, so let's keep them in a single
> change.
>
> But I do not think we want to add the new change at this location,
> at least for two reasons:
>
>  * The posted patch checks '!arg' to avoid rejecting "raw:size",
>    which would not scale at all.  What if you wanted to later add
>    "raw:upcase", which you must reject?
>

Yeah, the code here makes "raw" lack of scalability. Especially we
want to add "%(raw:textconv)" and "%(raw:filter)" later.

>  * We do have enumerated constants for each atom types, but this
>    early check and return does string comparison.
>

Note that at this time we must compare strings... parse_ref_filter_atom()
passes string form of the atom. Code block A also requires comparing string=
s.

-------------------
Code block A:

        for (i =3D 0; i < used_atom_cnt; i++) {
               int len =3D strlen(used_atom[i].name);
               if (len =3D=3D ep - atom && !memcmp(used_atom[i].name, atom,=
 len))
                       return i;
       }
-------------------

All the following replies are based on such a fact:
We will reuse used atoms as much as possible.

Think about this situation:

$ git for-each-ref --format=3D"%(raw)" --sort=3D"raw" --python

Since we specified --sort=3D"raw",`parse_sorting_atom()`
will be called in parse_opt_ref_sorting(), but at this time
we haven't parsed --<lang> yet. So format->quote_style =3D=3D 0,
we cannot refuse  --<lang> at this time, and a "%(raw)" atom
item will be added to used_atom, when we use `verify_ref_format()`
to call `parse_sorting_atom()` for the second time, we already have
raw atom item in used_atom, in Code Block A we directly returned,
We can't refuse --<lang> too after Code Block A. So as a last solution,
we refuse --<lang> with "%(raw)" before Code Block A.

> Where it belongs is either after "Is the atom a valid one?" loop
> where 'atom_len' is used to locate the placeholder's atom in the
> table of valid atoms [*], or inside raw_atom_parser().
>
>     Side note: If you read the original code, you would notice that
>     there already is a similar "this is a valid atom that appear in
>     the valid_atom[] table, but unallowed in this situation" check
>     done with .source !=3D SOURCE_NONE conditional.  One downside is
>     that until calling raw_atom_parser(), you do not know if
>     RAW_BARE or RAW_LENGTH is requested.
>

Yes, but we need to pay attention to it is below Code Block A.

> If we do inside raw_atom_parser(), it would probably look like this:
>
> +static int raw_atom_parser(const struct ref_format *format, struct used_=
atom *atom,
> +                               const char *arg, struct strbuf *err)
> +{
> +       if (!arg)
> +               atom->u.raw_data.option =3D RAW_BARE;
> +       else if (!strcmp(arg, "size"))
> +               atom->u.raw_data.option =3D RAW_LENGTH;
> +       else
> +               return strbuf_addf_ret(err, -1, _("unrecognized %%(raw) a=
rgument: %s"), arg);
> +
> +       if (atom->u.raw_data.option =3D=3D RAW_BARE && format->quote_styl=
e)
> +               return strbuf_addf_ret(err, -1,
> +                                      _("--format=3D%%(raw) cannot be us=
ed with ...")...);
> +
> +       return 0;
> +}

It's same, "*.parser()" is below Code Block A.

After all, the reason why this must be done here is the ref-filter
original logic
has not considered rejecting a format atom and an option.

Thanks.
--
ZheNing Hu
