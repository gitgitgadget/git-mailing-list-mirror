Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA2AC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 14:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiESOqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 10:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239936AbiESOqE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 10:46:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B225338D8C
        for <git@vger.kernel.org>; Thu, 19 May 2022 07:46:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f9so10519290ejc.0
        for <git@vger.kernel.org>; Thu, 19 May 2022 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=sFTSyldIXWQCez9U4lhbppb+m4nmISSnqUM+yBzYft8=;
        b=bfTXWrAAx0Wa74SlpvKdehlhq+8EjoJYnnYZLZqIqyaDyGdgWRU39ugBQrFkiVh89e
         NPrXBUBS6B75JCJ4nERrSWEE3NCH0Y8vk7GhYqFwwrlhi2s/tiQdXjZXwAa8Gz//Qddy
         lCe5yG5jZnOo4tZkXg1K2XcsdF+c1RS4fRm6DhvVEWHFUuOkOpOy+zqxi8KOXA26MWVZ
         x/Z3KM7dVO8XyHYB6p22rYwpsW2TAFzJXMYrjMUmNSfnI0ozlSdPs1JUwCFCqKr6VATG
         SJFfn1kyzq5KeQV7Ow9uYCIyUL6ToEoT//agA6Hr+fkU2TGIl7XhJhjrgUa+qWM/qz+p
         1Nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=sFTSyldIXWQCez9U4lhbppb+m4nmISSnqUM+yBzYft8=;
        b=SQBh2XugPXdA/5rvVwBwuq0LgBQGfkxIk/Kt4AlmGPgnQE2s/sHuXyem2AfKiUBBwF
         GsVT48uBPY72xxjo7SQ60YcRbjfngFrDJKGVB7aef5JqGinwdJe2Pyo5bKFWA7SDckDn
         7SrCW2e9Zyw7e+oK6mfClRh2UjR5hXDtv/XDnSesJdLddNXhj0YMcAGCQjl1gVFFsj2o
         yeWT4h9cbMaxdLziidGCtxWLc7kg1R7EkHgw5S5RFsAdOGAn+af6kCV9dJh7UudthAAu
         53tOeScwbYibanQJp49Xo8D0+7aUb5Op5qzHZe1MffjtcNFIDeSg0mG+fYYFf4CGO6TQ
         eQ/Q==
X-Gm-Message-State: AOAM533GSU9ozkTR9h0dObQd0ov1WTvp10u/PwqlQkyq2Bw/oD14GaK5
        Bd7ic1hZvSvxf/G2k4wZFkQ=
X-Google-Smtp-Source: ABdhPJy/p/y7Rj8vRAMmEe77PiNeKAJWRAddHMtPM3mR+7O2wG06Schm2NDKgr3oWpywkDYvEAe1wQ==
X-Received: by 2002:a17:906:4795:b0:6fe:69f4:bcb3 with SMTP id cw21-20020a170906479500b006fe69f4bcb3mr4829990ejc.526.1652971560120;
        Thu, 19 May 2022 07:46:00 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ay5-20020a170907900500b006f3ef214dccsm2091482ejc.50.2022.05.19.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 07:45:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrhPa-002CDR-HQ;
        Thu, 19 May 2022 16:45:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH v2 0/9] Incremental po/git.pot update and new l10n workflow
Date:   Thu, 19 May 2022 16:41:01 +0200
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-1-worldhello.net@gmail.com>
 <220519.864k1l6c2j.gmgdl@evledraar.gmail.com>
 <CANYiYbEj_G=Zm4ybLB=DhwXSMo7jFC+rf57m=vnFObbgOnqzrg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CANYiYbEj_G=Zm4ybLB=DhwXSMo7jFC+rf57m=vnFObbgOnqzrg@mail.gmail.com>
Message-ID: <220519.865ym14m3d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, Jiang Xin wrote:

> On Thu, May 19, 2022 at 6:39 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Thanks a lot for picking this up. I left some detailed comments on
>> individual commits.
>>
>> My own latest WIP version of an approximation of this topic was
>> https://github.com/avar/git/tree/avar/Makefile-incremental-po-git-pot-ru=
le,
>> which is what I used for some of the range-diffs.
>>
>> (I think the first E-Mail I sent had a range-diff against the latest
>> version I found in your fork, but I found that was probably the v1
>> version, but I think those comments applied to your v2 (which I read
>> on-list))
>>
>> Aside from differences already noted I spotted that your "make pot" ends
>> up with a po/git.pot that has a header, but I omitted it in
>> mine. Perhaps that explains some of the headers in 8/9? I.e. we don't
>> need the header on po/git.pot, perhaps that explains the difference
>> noted in my comment in 8/9?
>>
>> Also: shouldn't "make clean" remove the generated po/git.pot and
>> po/git-core.pot? I see you added it to "distclean", maybe that's better
>> (or maybe that's from a version of mine...).
>>
>> Just from some last minute testing I think you want this squashed in
>> (and move that "sed" to the "init" and/or "update" of the individual
>> po/XX.po files):
>>
>>         diff --git a/Makefile b/Makefile
>>         index 65a7558261a..57db37db556 100644
>>         --- a/Makefile
>>         +++ b/Makefile
>>         @@ -2778,14 +2778,7 @@ $(LOCALIZED_PERL_GEN_PO): .build/pot/po/%=
.po: %
>>                 $(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
>>                         -o$@ $(XGETTEXT_FLAGS_PERL) $<
>>
>>         -.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
>>         -       $(call mkdir_p_parent_template)
>>         -       $(QUIET_XGETTEXT)$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
>>         -               -o - /dev/null | \
>>         -       sed -e 's|charset=3DCHARSET|charset=3DUTF-8|g' >$@ && \
>>         -       echo '"Plural-Forms: nplurals=3DINTEGER; plural=3DEXPRES=
SION;\\n"' >>$@
>>         -
>>         -po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
>>         +po/git.pot: $(LOCALIZED_ALL_GEN_PO)
>>                 $(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
>>
>>          .PHONY: pot
>>
>> I.e. we can just msgcat po/git.pot without the header. For both
>> "po-init" and "po-update" that seems to do the right thing for me...
>
> Benefits of having a header for "po/git.pot" file:
> 1. Have a nice field "Project-Id-Version: Git" in the head of a new
>     generated po file.
> 2. We can identify the base version of "po/git.pot" by inspecting
>     the "POT-Creation-Date" field in the header of a po file.

For 1: Yes, we should have a header, I'm saying we don't need it for
po/git.pot, just po/XX.po, and not having it in po/git.pot makes things
a bit simpler, since when you "msgmerge" it you only worry about merging
the content, not the header.

The header you can then create with msginit, which in both our versions
we'd "sed" or otherwise correctly invoke msginit to add the correct
fields.

For 2: I think that having such fields in a world where everyone uses
version control (and the git project certainly does) is rather useless,
they're there in the PO format because it pre-dates version control
being ubiquitous.

The time-related fields I left in I left there because it seemed that
some PO tooling (e.g. Emacs's po-mode) insists on it.

Anyway, this is all small potatoes. I only pointed this out because when
I was hacking this up & debugging it I found it much easier to deal with
being able to piece together things with just msgcat, which we can do
with po/git.pot if it doesn't have a header.

But for adding the header we either need to msgcat a header file (which
an early version of my patches did), or just skip it and have it only
added for the XX.po files.

I think it's simpler just to omit it :)
