Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328B8C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 15:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiI1P0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 11:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiI1PZx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 11:25:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902205C9D9
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 08:25:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a41so17740271edf.4
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=OSOvKXUH0QfEaJd5FxJ7KBcSPUi7M9SzWls3rULGxvU=;
        b=aB9i5WbA+t58upnSopQ+h8/2uWfKVMkygsjKYeg3e3ngvBGmSO8+N956a1ZXpRoPkF
         1tge0QUW9bVmBebx/NlH8IJIx6DLgA1kCKfefYn88yc3nLqIT0cCR1ewO/qcSTuJQzX0
         wdSHnt+5708cgEeQuQLzryA5qtBKsxcCGhODPB97SDcMolPC1m/JwlZs3WiPvuSqv9Tp
         MQ6jAUgZn8FyJziUKuzSMxjfKXcr0ChvJmIYnhHeypCu8VGHMdm1vtCAzpb7L4/M6mA+
         CFXlnERGJYsoWt0con7bVqW97G1TTJbZj21Ma25KpvgQdcg+AXZKQuELOBTu4T5rfw97
         bWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=OSOvKXUH0QfEaJd5FxJ7KBcSPUi7M9SzWls3rULGxvU=;
        b=PFZMFoa6aaqvdONj3hbkUVfRAE8KRbGhv/JiFfobsBWNtRl3bgT2e5Ei+wh7F3H6V/
         k4t4vJGZVY/n+b6pI2hJ+LkTjlR+TLSd2ZlMHlffWPjIuaoV1TCvx78iNz5ePus113OD
         8mCFnC8oiuimXu78FFFOTcFYqRtSE4IhiMOTalaPQf7S6+gXFW/kTFHBDW10O0sghic1
         rAAQXvrz3njGZ1T0qZMlFlhcGQOocGw70SEbvL40OMjOxARdJhdkuZnu2PYHBfsBiAj9
         Ia1eksIHxVjGwZs4gt/02lN5xz0OHDAG8vvTQhn4AWjP8nmKc+51P35CASxhgL0w2A7M
         oWWw==
X-Gm-Message-State: ACrzQf1zwXpguqEtwzWLpLtYDanjksKpvLz95PT3w5nPKXU+bXhnXRJH
        U84qg8eE8ADNl+aqx/tucOQ=
X-Google-Smtp-Source: AMsMyM49qPTkr0dlVfKOPOvg6qXck4J7uIJ9t1RZGmpLwIshMmat++XS/2lKkmNq9z6Cazu7pNV5MA==
X-Received: by 2002:aa7:d449:0:b0:457:12e7:c2f6 with SMTP id q9-20020aa7d449000000b0045712e7c2f6mr21359519edr.357.1664378727600;
        Wed, 28 Sep 2022 08:25:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906538300b0077205dd15basm2523508ejo.66.2022.09.28.08.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:25:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odYwA-0011Pd-0K;
        Wed, 28 Sep 2022 17:25:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>
Subject: Re: [PATCH 05/10] evolve: add the change-table structure
Date:   Wed, 28 Sep 2022 17:14:14 +0200
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <2b3a00a6702eb8fb12e45b833ca74155939588ef.1663959325.git.gitgitgadget@gmail.com>
 <3c61e0b3-5526-f42e-48a7-c4465d06ccb3@dunelm.org.uk>
 <220927.865yh8zzux.gmgdl@evledraar.gmail.com>
 <ae031714-ba51-fe39-6351-ebd638840c32@dunelm.org.uk>
 <220927.861qrwzvhe.gmgdl@evledraar.gmail.com>
 <72c4e8c9-62bb-96aa-7b42-d7103b7873eb@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <72c4e8c9-62bb-96aa-7b42-d7103b7873eb@dunelm.org.uk>
Message-ID: <220928.86pmffwmft.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 28 2022, Phillip Wood wrote:

> On 27/09/2022 16:28, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Sep 27 2022, Phillip Wood wrote:
>>=20
>>> On 27/09/2022 14:50, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> On Tue, Sep 27 2022, Phillip Wood wrote:
>>>>
>>>>> On 23/09/2022 19:55, Stefan Xenos via GitGitGadget wrote:
>>>>>> +/**
>>>>>
>>>>> We tend to just use '/*' rather than '/**'
>>>> No, we use both, and /** is correct here. It's an API-doc syntax,
>>>> see
>>>> e.g. strbuf.h.
>>>> It's explicitly meant for this sort of thing, i.e. comments on
>>>> public
>>>> structs in a header & the functions in a header (and struct members,
>>>> etc.).
>>>
>>> We don't do that consistently, we don't mention them in
>>> CodingGuidelines and we don't use anything that processes API-doc
>>> comments. It would be a lot simpler and it would be consistent with
>>> our coding guidelines just to use the same style everywhere. That
>>> would avoid problems where this series uses API-doc comments for
>>> in-code comments in .c files and where single line comments in header
>>> files do not use the API-doc syntax.
>> Yes, this isn't documented in CodingGuidelines (but FWIW is in
>> various
>> commit messages).
>> I'm pointing out that this isn't a mistake, but the preferred style
>> for
>> new API docs.
>
> It seems a bit a stretch to call it the preferred style, however I had
> thought all our uses were historic but that's not the case.

FWIW that claim of mine comes from my (admittedly fuzzy recollection of)
history, around the time that this was being worked out (e.g. where API
docs should live, they used to mostly be in Documentation/technical/,
now they're mostly in *.h) we ended up with this mention in CodingGudieline=
s:

 - When you come up with an API, document its functions and structures
   in the header file that exposes the API to its callers. Use what is
   in "strbuf.h" as a model for the appropriate tone and level of
   detail.

I.e. at some point we decreed strbuf.h as a best-practice model to
follow. I think every one of my own use of "/**" has come after reading
that file...

But patches to make it more explicit are most welcome. FWIW I think I
looked into that once, but couldn't find a canonical reference for what
this syntax is even called.

Hrm, looking a bit more I see it's probably JavaDoc (at least Emacs
highlights it as such). A grep of:

	git grep '^ \* @' -- '*.[ch]'

Shows that we make almost no use of the meta-syntax (i.e. "tags":
https://en.wikipedia.org/wiki/Javadoc#Table_of_Javadoc_tags)

> Chris if you want to use '/**' style comments for the API docs then
> please do so consistently and do not use them elsewhere.
>
>> At least Emacs knows how to highlight these differently, which is the
>> main use I personally get out of them, I don't know what other use-cases
>> there are for them...
>
> I've come across them in projects that use gtk-doc or other
> documentation generators where it is necessary to distinguish=20
> 'documentation' from 'code comments'. I don't think they add much
> value if one is not generating documentation from the source, it is
> just one more thing for contributors to remember.

I for one find it very useful these "API docs" are shown differently in
my editor, even if I'm not using some fancier (and hypothetical) "make
javadoc" target.

I.e. you can ideally skim the *.h file and see at a glance what's an
implementation comment v.s. API doc comment.

Except that even for the supposed role model of strbuf.h we forgot in
some cases, and should have the below applied to it, oh well... :)

diff --git a/strbuf.h b/strbuf.h
index 76965a17d44..46549986ae3 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -492,7 +492,7 @@ int strbuf_getline_lf(struct strbuf *sb, FILE *fp);
 /* Uses NUL as the line terminator */
 int strbuf_getline_nul(struct strbuf *sb, FILE *fp);
=20
-/*
+/**
  * Similar to strbuf_getline_lf(), but additionally treats a CR that
  * comes immediately before the LF as part of the terminator.
  * This is the most friendly version to be used to read "text" files
@@ -610,7 +610,7 @@ static inline struct strbuf **strbuf_split(const struct=
 strbuf *sb,
 	return strbuf_split_max(sb, terminator, 0);
 }
=20
-/*
+/**
  * Adds all strings of a string list to the strbuf, separated by the given
  * separator.  For example, if sep is
  *   ', '
@@ -653,7 +653,7 @@ int launch_editor(const char *path, struct strbuf *buff=
er,
 int launch_sequence_editor(const char *path, struct strbuf *buffer,
 			   const char *const *env);
=20
-/*
+/**
  * In contrast to `launch_editor()`, this function writes out the contents
  * of the specified file first, then clears the `buffer`, then launches
  * the editor and reads back in the file contents into the `buffer`.
@@ -693,7 +693,7 @@ static inline void strbuf_complete_line(struct strbuf *=
sb)
 	strbuf_complete(sb, '\n');
 }
=20
-/*
+/**
  * Copy "name" to "sb", expanding any special @-marks as handled by
  * interpret_branch_name(). The result is a non-qualified branch name
  * (so "foo" or "origin/master" instead of "refs/heads/foo" or
@@ -707,7 +707,7 @@ static inline void strbuf_complete_line(struct strbuf *=
sb)
 void strbuf_branchname(struct strbuf *sb, const char *name,
 		       unsigned allowed);
=20
-/*
+/**
  * Like strbuf_branchname() above, but confirm that the result is
  * syntactically valid to be used as a local branch name in refs/heads/.
  *
