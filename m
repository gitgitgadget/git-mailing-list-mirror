Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D65C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 11:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiJDLWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 07:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiJDLWB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 07:22:01 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501F252AF
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 04:21:58 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id z9-20020a4a4909000000b0047651b95fbdso8570831ooa.5
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ISfQzfOXz4RKgZosgBFveZKlexFo7NAquy+jaC8FoVs=;
        b=GsIuM+qaUJBZ+9d0iv981kUUhxqstXZmHLfUDKEg0C/vcxjEPBPcz9BiY1zjubUZtK
         a1xQ+6hGHKbexOlyWrSdhczL0jD2rzRjbtHl1MrdhbUqlu+/JxcFg87V3q/zhOeheY1c
         4ndtan5PyoHv6qOI5soNi0KYcrBfqbgeHH7w58vPfKK9ldiXLCmsDzFJ3lIrflt9Wfxx
         /0lnUekRSqyXMTqMtVYbHwPK3G34VBfV5/1Qk6wvhia1c63sUNneUiE2nUfbrkG6KryG
         YfmHbWJCmH0yhW1pcFt+Nn7iOyV17hgd3lg+2dmWUOsxyo31po38kvXUJsxCXyuQur+W
         HA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ISfQzfOXz4RKgZosgBFveZKlexFo7NAquy+jaC8FoVs=;
        b=50NJ0Szug8HLlH3IkmoUk23AVqoTdalHC1BhAMLeWMGV6Wyn/vGvfXSRBha7SmVxux
         uqJ+4lXZ/RAiVXO/Pz53kRruWKgk3/UFjc9O/Gd5QP14vE+wNhd7aun8t8zug0VPJluW
         wCDot6XjmWtvM5jdLQN3Ad+/Dg595cuvDFzqFIQ0QYMYiLws22fS+8uroF0V7cMmE8vU
         LI97HFWsfvhW8YbKW56qZZi98hsfT1590SFsDB+/SMNjXIiZANU9583udyisRU8tuGnp
         KTojjPYKrCsSnOArEkIQetLJF43RH3GDi/P27YU8fz/NbY49YWWUR3Gx7UPvwLhz30Dn
         Ab9A==
X-Gm-Message-State: ACrzQf1TwsR8beoIk/mGc2RpvW0KrcfZpjDOGMwYwVHgXfLl2FraNhMo
        KziDiy4jeLn5Ta0ZsBXx43eo+1n3zjNACXdSWndeG+va
X-Google-Smtp-Source: AMsMyM6bFcXN3kcBfPDJ7Anh70ymWY/OebG6sMq/B+KEviS7wLRPLecOOe91iCYBy33nxxaJnMGrYUKiqPA6C7UnU20=
X-Received: by 2002:a05:6830:1211:b0:659:81ae:924b with SMTP id
 r17-20020a056830121100b0065981ae924bmr9623617otp.356.1664882517615; Tue, 04
 Oct 2022 04:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <2e9a4a9bd819785404e8a5343385f4fb2bc06109.1663959325.git.gitgitgadget@gmail.com>
 <e7278794-428d-4aff-e91b-d2e6527f142d@gmail.com>
In-Reply-To: <e7278794-428d-4aff-e91b-d2e6527f142d@gmail.com>
From:   Chris P <christophe.poucet@gmail.com>
Date:   Tue, 4 Oct 2022 13:21:46 +0200
Message-ID: <CAN84kKmsFiGm2W+74aBbe=fXjDeK05ujCxNF+wTHGEjEkQwjDw@mail.gmail.com>
Subject: Re: [PATCH 04/10] evolve: add support for parsing metacommits
To:     phillip.wood@dunelm.org.uk
Cc:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christophe Poucet <poucet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > This patch adds the get_metacommit_content method, which can classify
> > commits as either metacommits or normal commits, determine whether they
> > are abandoned, and extract the content commit's object id from the
> > metacommit.
> > diff --git a/Makefile b/Makefile
> > index cac3452edb9..b2bcc00c289 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -999,6 +999,7 @@ LIB_OBJS += merge-ort.o
> >   LIB_OBJS += merge-ort-wrappers.o
> >   LIB_OBJS += merge-recursive.o
> >   LIB_OBJS += merge.o
> > +LIB_OBJS += metacommit-parser.o
>
> There seems to be a problem with the indent here

I'm not sure I follow, there's not indentation on that line?
>
> >   LIB_OBJS += midx.o
> >   LIB_OBJS += name-hash.o
> >   LIB_OBJS += negotiator/default.o
>
>  > diff --git a/metacommit-parser.h b/metacommit-parser.h
>  > new file mode 100644
>  > index 00000000000..1c74bd6d699
>  > --- /dev/null
>  > +++ b/metacommit-parser.h
>  > @@ -0,0 +1,19 @@
>  > +#ifndef METACOMMIT_PARSER_H
>  > +#define METACOMMIT_PARSER_H
>  > +
>  > +#include "commit.h"
>  > +#include "hash.h"
>  > +
>  > +/* Indicates a normal commit (non-metacommit) */
>  > +#define METACOMMIT_TYPE_NONE 0
>  > +/* Indicates a metacommit with normal content (non-abandoned) */
>  > +#define METACOMMIT_TYPE_NORMAL 1
>  > +/* Indicates a metacommit with abandoned content */
>  > +#define METACOMMIT_TYPE_ABANDONED 2
>
> Is it possible to define these as an enum? It would make the signature
> of get_meta_commit_content() nicer.
>
>  > +struct commit;
>
> What's this for? We're including commit.h above.

Forgot to remove this as I added the include commit.h later.

>
>  > +extern int get_metacommit_content(
>  > +    struct commit *commit, struct object_id *content);
>
> > diff --git a/metacommit-parser.c b/metacommit-parser.c
> > new file mode 100644
> > index 00000000000..70c1428bfc6
> > --- /dev/null
> > +++ b/metacommit-parser.c
> > @@ -0,0 +1,110 @@
> > +#include "cache.h"
> > +#include "metacommit-parser.h"
> > +#include "commit.h"
> > +
> > +/*
> > + * Search the commit buffer for a line starting with the given key. Unlike
> > + * find_commit_header, this also searches the commit message body.
> > + */
>
> There is no explanation in the code or commit message as to why this
> function is needed. The documentation added in the first commit says
> that "parent-type" header is a commit header. I think the answer is that
> this series does not implement that header but uses the commit message
> instead. That's perfectly fine for a proof of concept but it is
> precisely the sort of detail that should be described it the commit
> message and probably flagged up in the cover letter.

I admit I thought I thought this was part of the header because it
shows up before
the blank line before the commit title.

How do I make this a commit header?

>
> > +static const char *find_key(const char *msg, const char *key, size_t *out_len)
> > +{
> > +     int key_len = strlen(key);
> > +     const char *line = msg;
> > +
> > +     while (line) {
> > +             const char *eol = strchrnul(line, '\n');
> > +
> > +             if (eol - line > key_len && !memcmp(line, key, key_len) &&
> > +                 line[key_len] == ' ') {
> > +                     *out_len = eol - line - key_len - 1;
> > +                     return line + key_len + 1;
> > +             }
> > +             line = *eol ? eol + 1 : NULL;
> > +     }
> > +     return NULL;
> > +}
> > +
> > +static struct commit *get_commit_by_index(struct commit_list *to_search, int index)
> > +{
> > +     while (to_search && index) {
> > +             to_search = to_search->next;
> > +             index--;
> > +     }
> > +
> > +     if (!to_search)
> > +             return NULL;
> > +
> > +     return to_search->item;
> > +}
>
> This function is a useful utility for struct commit_list and should live
> in commit.c. It could be used to simplify object-name.c:get_parent() for
> example.

Done.  I'll defer cleaning up get_parent to a potentially later change to avoid
muddying up this change too much.

>
> > +/*
> > + * Writes the index of the content parent to "result". Returns the metacommit
> > + * type. See the METACOMMIT_TYPE_* constants.
> > + */
> > +static int index_of_content_commit(const char *buffer, int *result)
>
> I found the signature confusing as it is returning an int but that is
> not the index. Switching to an enum for the metacommit types would
> clarify that.

Done.

>
> > +{
> > +     int index = 0;
> > +     int ret = METACOMMIT_TYPE_NONE;
> > +     size_t parent_types_size;
> > +     const char *parent_types = find_key(buffer, "parent-type",
> > +             &parent_types_size);
> > +     const char *end;
> > +     const char *enum_start = parent_types;
> > +     int enum_length = 0;
> > +
> > +     if (!parent_types)
> > +             return METACOMMIT_TYPE_NONE;
> > +
> > +     end = &parent_types[parent_types_size];
> > +
> > +     while (1) {
> > +             char next = *parent_types;
> > +             if (next == ' ' || parent_types >= end) {
> > +                     if (enum_length == 1) {
>
> if enum_length != 1 then there is an error in the parent-type header and
> we should probably bail out.
>
> > +                             char first_char_in_enum = *enum_start;
>
> It's not just the first character, it's the only character, do we really
> need such a long variable name? (how about just calling it "type")

Done.

> I'll try and take at look at the next couple of patches later in the week.

Thank you for all the reviews!

-- simply chris
