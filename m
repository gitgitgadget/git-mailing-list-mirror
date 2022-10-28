Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD797ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 03:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiJ1DCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 23:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiJ1DCS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 23:02:18 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D29C09BC
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 20:02:17 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g11so2791761qts.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 20:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrzdoGq8LdKGpx4ittr6zLmeArmK+qvdMrf1cD4eJS4=;
        b=lxKVBTVPVNEIHsq8BLXFbjT7FfEb5A9VTcpPsBlIyw7oJnevvJG+J4PzIR9xzW5Qp9
         Vxj0KVgwDuSKLWeXjAAGWNk+Z7zwYT52znEFRy9UoWeHniZcBwJlXo+s39A6IHNpfqor
         vV1TwUSpZSp674PQrVGvPL8pLR0TvSSeyKh5bXbB1b0W3kSUSi1XKJnduSYjUvmC453o
         xYMPwhkWjYlPTeHJw3UTnb2qF+VYY3xO324pIeDXNnbpyjgtrsXjYrm7/hwPi07p8fWF
         awFYlKW9GxLAWmw3yosMygqZqtOE+EUpqkvXlLm8LhtAhheRge5kZ8muKtEmdexIhEG1
         uPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrzdoGq8LdKGpx4ittr6zLmeArmK+qvdMrf1cD4eJS4=;
        b=h0awRi0JNZqo3KenkE4mcqqgRZHmnBCsX/wCAdTljAmHWdxLdISuGJ6xQ8OMAxbP4b
         rh10r9ksPsLqplkNXVLDNRI9ZBtCtOKxlpZORfX93ffLBRh9MpHt89H8EuhD1A8pY7Wh
         vf/oCu9dHnaO4kWUIa4lS71bJglRWucj/3gfzpoANIIuM4Lfs6qGYXH310Tf6INd6Rt1
         NqpqVDYPiGJQaM++E4DDE2xitLbfest8ktnzorb2/jjQhnAlO+voTaLlenwGSUpdirGI
         E6SiXT2iYxUuJFKTcCJ+ffpJqQyX1SJBoRRZXAHZ+O1oDGNHEIYT6G6xfCKbB1OGind2
         z0SA==
X-Gm-Message-State: ACrzQf1A8kFHNSI80qofwaxO3yqubNtmbEtd/QpzGuvZDv7/oHGzet+K
        nAoXeXnTx5C6l40x2f2mIc0=
X-Google-Smtp-Source: AMsMyM51QiipYqaMUKDI3bu19y9d/ec7wgT4SO7N0/c0GluVOUePacftjOKbCeSWL+2f73PfMsxyDw==
X-Received: by 2002:ac8:7d4c:0:b0:399:b8eb:749e with SMTP id h12-20020ac87d4c000000b00399b8eb749emr42792714qtb.446.1666926136477;
        Thu, 27 Oct 2022 20:02:16 -0700 (PDT)
Received: from [10.37.129.2] (pool-96-242-185-150.nwrknj.fios.verizon.net. [96.242.185.150])
        by smtp.gmail.com with ESMTPSA id w187-20020a3794c4000000b006ee957439f2sm2097371qkd.133.2022.10.27.20.02.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2022 20:02:16 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
Date:   Thu, 27 Oct 2022 23:02:14 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <08A5BC44-24D9-4C8F-A61A-41983A13553A@gmail.com>
In-Reply-To: <221026.8635badbz5.gmgdl@evledraar.gmail.com>
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
 <20221025224224.2352979-5-gitster@pobox.com>
 <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
 <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
 <221026.8635badbz5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On 26 Oct 2022, at 7:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Oct 26 2022, Jeff King wrote:
>
>> On Wed, Oct 26, 2022 at 04:43:32AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>>
>>>
>>> On Tue, Oct 25 2022, Junio C Hamano wrote:
>>>
>>>> During the initial development of the fsck-msgids.txt feature, it
>>>> has become apparent that it is very much error prone to make sure
>>>> the description in the documentation file are sorted and correctly
>>>> match what is in the fsck.h header file.
>>>
>>> I have local fixes for the same issues in the list of advice in our
>>> docs, some of it's missing, wrong, out of date etc.
>>>
>>> I tried to quickly adapt the generation script I had for that, which
>>> works nicely, and by line count much shorter than the lint :)
>>
>> Yeah, my instinct here was to generate rather than lint. If you make a=

>> mistake and the linter hits you over the head, that is better than
>> quietly letting your mistake go. But better still is making it
>> impossible to make in the first place.
>>
>> The downside is added complexity to the build, but it doesn't seem too=

>> bad in this case.
>
> Yeah, it's not, I have local patches to generate advice-{type,config}.h=
,
> and builtin.h. This is a quick POC to do it for fsck-msgids.h.
>
> I see I forgot the .gitignore entry, so it's a rough POC :)
>
>> (I had a similar thought after getting hit on the head by the recent
>> t0450-txt-doc-vs-help.sh).
>
> Sorry about that. FWIW I've wanted to assert that for a while, and to d=
o
> it by e.g. having the doc *.txt blurbs generated from running "$buildin=

> -h" during the build.

If we wanted to go this route of generating the docs from the code (which=
 sounds
like a better long term solution), how would this work? Would we print ou=
t the
list of message ids in builtin/fsck.c and write it to
Documentation/fsck-msgids.txt ?

>
> But when I suggested that I gathered That Junio wasn't up for that
> approach, it does have its downsides thorugh. E.g. to build the docs
> you'd now have to compile C code, and e.g. that git-scm.com publisher
> written in Ruby would have to compile the code to generate its docs.
>
> Or we could do it the other way around, and scape the *.txt for the *.c=

> generation, but then we need to run a new script for building
> builtin/*.o. Also possible, and I think eventually both are better than=

> what t0450-txt-doc-vs-help.sh's doing now, but that was a less invasive=

> change than both...
>
>>> Having to exhaustively list every *.c file that uses fsck.h is a bit =
of
>>> a bother, but we have the same with the other generated *.h's, so it
>>> shouldn't be too bad.
>>
>> It feels like this could be made much shorter by having a separate
>> fsck-msgs.h and not including it from fsck.h. Only fsck.c and mktag.c
>> need the actual list. It would probably have to stop being an "enum",
>> though.
>
> Yes, that would make it shorter, but C doesn't have forward decls of
> enums, so we'd need to make it "int", ....
>
>> Another alternative is to generate the doc from the code, rather than
>> the other way around.
>
> *nod* :)
>
>>> +# Unfortunately our dependency management of generated headers used
>>> +# from within other headers suck, so we'll need to list every user o=
f
>>> +# fsck.h here, but not too bad...
>>> +FSCK_MSGIDS_H_BUILTINS =3D fsck index-pack mktag receive-pack unpack=
-objects
>>> +$(foreach f,$(FSCK_MSGIDS_H_BUILTINS:%=3Dbuiltin/%),$f.sp $f.s $f.o)=
: fsck-msgids.h
>>> +FSCK_MSGIDS_H_LIBS =3D fetch-pack fsck
>>> +$(foreach f,$(FSCK_MSGIDS_H_LIBS),$f.sp $f.s $f.o): fsck-msgids.h
>>
>> I don't understand the "used within other headers" part here. Computed=

>> dependencies will get this right. It's only the initial build (before =
we
>> have any computed dependencies) that needs to know that the C files in=

>> question depend on the generated file. But that is true whether they d=
o
>> so directly or indirectly.
>
> I forgot the full story, but luckily I wrote it down in the WIP commits=

> :) FWIW if you want to scour that it's mainly:
>
> 	https://github.com/avar/git/commit/a00f1cb9ea5 # add advice-type.h
> 	https://github.com/avar/git/commit/9e080923a11 # generate 'struct advi=
ce
>
> Also, before generating builtin.h I've got e.g. this:
>
> 	https://github.com/avar/git/commit/5a5360d0134 # just check with 'make=
' that any file is sorted
>
> To actualy generate it, very WIP:
>
>         http://github.com/avar/git/commit/cf1d02fa6b2
>
> Anyway, in partial summary, why (and sorry this got so long):
>
>  * Yes, once we build e.g. fsck.o we have the full dependency tree,
>    yay....
>  * ...but only for gcc & clang, but we support other compilers.
>  * ...for other compilers (or gcc & clang without the dep detection
>    enabled) what should this do:
>
> 	make file-that-does-not-use-generated-header.o
>
>    It sucks a bit to have e.g. every *.o depend on command-list.h, when=

>    we only use it in 1-2 places, ditto the other headers.
>
>    The approach I took to this was to manually list headers that had
>    "small uses" (1-10), but say that all of *.h dependend on running th=
e
>    *.sh to generate some "widely used" headers.
>
>    E.g. if we generate builtin.h we'll either need that, or add
>    builtin/%.o as a dependency, with a manual listing of the handful of=

>    uses outside of that subdirectory.
>
>  * .... or just not care about any of that, i.e. to have all of our *.s=
h
>    run on the "first build" no matter what, which certainly simplifies
>    things, but once you have e.g. 5-10 generated headers doing e.g.:
>
> 	make grep.o
>
>    and having it build command-list.h or whatever is a bit noisy, but
>    it's a trade-off of manually maintaining deps v.s. not.
>
>  * Our "COMPUTED_HEADER_DEPENDENCIES" only happens when you build the
>    *.o, but we have *.sp and *.s targets too. I have some local changes=

>    *to generalize that, so we e.g. get proper dependencies for building=

>    **.s files.
>
>  * We also have e.g. "make hdr-check", which works just fine now, but
>    it's becausue we have no *.h file that uses another generated *.h
>    file.
>
>    Actually, I suspect the posted WIP change is broken in that regard
>    (but doing this for real on my topic branch works), i.e. we need to
>    start caring about deps for those auxiliary targets.
>
>  * I may be wrong (I'm just looking at some old "here be dragons" note
>    of mine), but I think there's also an edge case where the dependency=

>    graph of .depend.d/* is correct *once you've always had it*, but if =
a
>    file now e.g. depends on foo.h, and I make foo.h include a new
>    foo-generated.h things go boom.
>
>    That issue (it if even exists, sorry, I'm blanking on the details)
>    was solvable by just doing a "make clean", and building again,
>    i.e. once we had re-built once we were OK, it was only a problem wit=
h
>    an older checkout with an existing build pulling new sources.
>
>    Still, I wanted to not make that case annoying either if I added a
>    generated header...
