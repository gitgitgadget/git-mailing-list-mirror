Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3758FC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353266AbiBCSL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353260AbiBCSLu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:11:50 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B74C06173D
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:11:49 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id k25so11218609ejp.5
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BuKummvssMdOJesJ+JyA51lGJM2S2aXVHsd/qb7ZBcQ=;
        b=ZL3oyviEUv75GutG9e3TlIT8rvrCfKT5Q0rUpoqTfVOtqDtKDONaL4J5EdRy+T2rp4
         1w1Vaaei0uTdAPfRyPm39PRHRDL+Ybk27sJ4Qqa0EUne4vRjoZT8uWRhOI/DpCKefDLA
         5d4ja0PuNbXEwzrnAgHJtzow/+mMLfT5rxja8lXWOiRUu6DGOthxaoEfZ4Nv2ZMpjxFo
         +Eisy/RwmcRCQ6Ab1V5tdK6XeupnJOOKqmHCY34nvVyYtVmL+jCt36vJXeuHcHG1qcce
         a2ObmmRa30N/NNris9INPTghxY0dZarwXpsrQJ4NTmdLF6XG821zSFiw2ETh7jPUVNzo
         FYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BuKummvssMdOJesJ+JyA51lGJM2S2aXVHsd/qb7ZBcQ=;
        b=iJtiSs1R08EknfyB675cReWz2hUP7Z2Jw2rXOAr+kBo5IfXuG10woSW8uwtgW6Pl6M
         5gjxhqomaMGH2+leFVA8dbwv7x6YGHZjVZsIQMbw/2L1JLCTv7Q1yc6h/lg90eY/Qwab
         +3haYCIRzq6qvfrrSSjZQ/X2hu30rfgvs/h6Lmf6cGylOAbXzuBaOA7kRgAsQT8GKd9Q
         5+X/hii5m0++aYDYQw/u27HfxjIw7rc3wYxKhESWlylTCWY9+802gevnvYfV6dxUzETW
         wRr1a8aOgRE5eJwAdYpdFrWTM0BlgsAlQgM+zQLTF60lduCJlACizWzl1HYyz82w1Q0I
         LYuA==
X-Gm-Message-State: AOAM532RiJG75klKxwaFOH5djYONnrwhzqRDX4u/YaZDLRfQtcHg/u41
        24ZkmT84VgDAbp09YoCmU0E=
X-Google-Smtp-Source: ABdhPJwh/lN2tPFG4tJf8km0xTmqxyCM8l5qPbqXfifNS/QFSQtSkPvVc2hY0jaP+ZGDFmKWHsygiA==
X-Received: by 2002:a17:906:58c2:: with SMTP id e2mr30645460ejs.180.1643911908376;
        Thu, 03 Feb 2022 10:11:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z5sm16924133eja.20.2022.02.03.10.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:11:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFgaB-0057nW-AM;
        Thu, 03 Feb 2022 19:11:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     =?utf-8?Q?'Jean-No=C3=ABl?= Avila' <avila.jn@gmail.com>,
        git@vger.kernel.org
Subject: Re: [Question] Translation Dictionary
Date:   Thu, 03 Feb 2022 19:06:32 +0100
References: <016401d81547$728834e0$57989ea0$@nexbridge.com>
 <0c47248d-13b8-9d80-b03f-8ac6fd4ac91e@gmail.com>
 <220203.86sft05kzm.gmgdl@evledraar.gmail.com>
 <02f101d81901$c1ac8400$45058c00$@nexbridge.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <02f101d81901$c1ac8400$45058c00$@nexbridge.com>
Message-ID: <220203.86y22r4y70.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, rsbecker@nexbridge.com wrote:

> On February 3, 2022 4:55 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Feb 03 2022, Jean-No=C3=ABl Avila wrote:
>> > I guess not all git translators are subscribed to the mailing list, as
>> > they mostly interact with Jiang. I put them in cc.
>> >
>> > For French, I try to maintain a glossary of terms in the header of the
>> > `fr.po` file, available here:
>> > https://github.com/git/git/blob/master/po/fr.po
>>=20
>> I started trying to come up with something similar for the Icelandic tra=
nslation I
>> plan on getting to any day now (for ~11 years and counting).
>>=20
>> I think it would be a really good addition to git to move this list into=
 a built-in or an
>> option for "git help", something like:
>>=20
>>     git i18n-terms
>>=20
>> Or:
>>=20
>>     git help --common-terms
>>=20
>> It would help users that use a non-English a lot, since they could use i=
t as a
>> reliable cheatsheet, and it would clearly help translators, since it cou=
ld be one of
>> the first things they'd translate, to anchor themselves when it comes to
>> translating blob/tree/commit/tag etc.
>>=20
>> If you're interested I can help you come up with that. Basically it woul=
d be some
>> "static" array with that table as C code with strings marked with N_(). =
We could
>> then add optional explanations as in
>> gitglossary(7) (and even eventually generate that documentation from that
>> code).
>
> Yes, I would like to investigate doing this. I have some experience
> with different translation approaches, so it does make sense to
> me. The question is where to start. From a framework standpoint, it
> would be nice to have the terms externalized and searchable (as in git
> glossary [term]... or perhaps more completely git glossary --grep=3Dterm
> --language=3Dfr --iso=3Dfr_CA [term]...). I can also see some provisioning
> for phrases, "upstream remote" comes to mind as one that gave me a
> headache earlier in the week, and potentially usage - in Jean-No=C3=ABl
> list, prefacing "to" to a term implies it is a verb rather than a noun
> but we might want to consider a more normalized approach to managing
> usage, bearing in mind that this is a very large "rabbit hole". I
> would even suggest that gitglossary(7) might ultimately be deprecated
> particularly on systems without 'man(1)'.
>
> Help would definitely be appreciated in getting this started. I have a to=
pic branch at github where I am planning on keeping this stuff visible.

If you do:

    make command-list.h

We end up with something similar to what I have in mind. That one
happens to be generated, but we could just stick this in help.c for
now. I.e.:

	struct i18n_term {
	        const char *term;;
	};

	static struct i18n_term i18n_terms[] =3D {
		{ N_("3-way merge") },
		{ N_("#NN") },
		{ N_("a commit") },
		[...],
		NULL,
	};

I.e. just a copy of the list at
https://github.com/git/git/blob/master/po/fr.po. The help.c library has
some examples that should be easy to follow e.g. how "git help --guides"
calls list_guides_help(), which iterates a similar variable.

For --language=3D* etc. you can do that with just LANGUAGE=3D<...> (i.e. via
standard libintl) features. I think for this we could just stick with
that.

And instead of --grep you can pipe to grep(1) :)

This can always be made fancier later, and we can expand "struct
i18n_term" with some category labels or whatever, e.g. for core data
types (blob, tree, tag, commit) v.s. core concepts (merge, rebase,
commit, pull, push) etc.
