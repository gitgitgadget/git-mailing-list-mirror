Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483F6C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 18:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383038AbiEESRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 14:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383044AbiEESRM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 14:17:12 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CD35D644
        for <git@vger.kernel.org>; Thu,  5 May 2022 11:13:31 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id h10-20020a056830400a00b00605e92cc450so3430934ots.11
        for <git@vger.kernel.org>; Thu, 05 May 2022 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KFakNu1UXaO3uy50evb5iOyi5umF65ZyL9vULIk1FM=;
        b=Y6e87sYtsYEZulPa3JnVGxbXWxNTJQjjdqjgqjzjfLgmUblUFg56xlVuq962/MPo9i
         QPgRWSxA1G+Msr0OxNktQWDcx7ft/8NCYZ6jDuNYhC6ldsaEOumAG812QZ9H01qMasqG
         A88EbW0wolLD/mb5xSOWWIpjOCstJJaxrJ94i/S8K5t2fczaRM2UP8kSFiXyrEmfXnbI
         zUoTy3MZ9sISe8PHy2T5WxXw5fZ6pvdQViBBJvc7BtyyN98JcjWOEUA0HXsEOy4D7Qtv
         0q3415IK8PJUAwvvYXaMTQ6qVSWgUQDxiEkc0OOHoPAfhdEBeyZZWw6ZjgZExo86XGL4
         LUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KFakNu1UXaO3uy50evb5iOyi5umF65ZyL9vULIk1FM=;
        b=NEYfU7/Ecc9UvMBR26ANg7cIwrwH0xuwGeUsBnDfDK2uerqSHW5scxTfvhQdwBczHw
         DDhb+08uSD9G/Sy8fX8uRjZy0q6Adn1SBzjgvcIKDfktHwnMvj7JAOrWvBuku1MBFW9U
         9Ncba7J6tZwG1Tv3f8CHCP2GAnvw5OsQGQKrJDP0AKSSuAG8tEjmUopuPnWIM3hOnoN8
         2hW2kdbKeYZAMN+7AXvt/3cK5p3mdVP1/KNEX1q9SDThBkjxgjuHPFU4n2Ybj7FlZBCw
         6MaVPyZo8V7ALyLVAYRVrhQ/bLrHOHciSc801rcG+sV6uBRs1Ee3Rk9kfuGsXQN6Ccdt
         qKhg==
X-Gm-Message-State: AOAM531XiwZJ4Zk4HBAfUQ4csATPXpuDVGFTRBf/vgu5tM+7PoFJLk0G
        qlI7miUqpS5D9LtFosOfBMJQkUnzkURcH6Q1m6u84Q==
X-Google-Smtp-Source: ABdhPJyX5wbsXH5l6C5aMIh4qySdYyqECY6nXX6fGfjaf3N9ZZ3EHr44vZsDHnLJ4gMi/sc9kaibz+Zl+KHOK+qi7Z4=
X-Received: by 2002:a05:6830:2449:b0:605:f1ed:38b1 with SMTP id
 x9-20020a056830244900b00605f1ed38b1mr9619142otr.130.1651774410424; Thu, 05
 May 2022 11:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220502170904.2770649-9-calvinwan@google.com> <20220504212738.162853-1-jonathantanmy@google.com>
In-Reply-To: <20220504212738.162853-1-jonathantanmy@google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 5 May 2022 11:13:19 -0700
Message-ID: <CAFySSZCL-ccVK+ZOU5=X4fB3-eu=Cmu-MGpT1cMW+bqmdRcF9w@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] cat-file: add --batch-command remote-object-info command
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.email,
        johncai86@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> You mention below that this only works in --buffer mode, so I don't
> think that this is relevant.

It works in non-buffer mode as well. I meant that if you wanted to use
`remote-object-info` with another option, then --filter is the only
one that it works with. I tried to match the documentation for
--batch-command that says something similar:

--batch-command=<format>
Enter a command mode that reads commands and arguments from stdin. May
only be combined with --buffer, --textconv or --filters

> What happens if remote-object-info is mixed with other commands?
It works with other commands. The idea is that you would enter a line like:

remote-object-info <remote> <oid> <oid> ... <oid>

rather than

remote-object-info <remote> <oid>
remote-object-info <remote> <oid>
remote-object-info <remote> <oid>

since each invocation of remote-object-info would cause another round
trip to the server.

> Hmm...I would have expected the information to appear in the same data
> structure used to store other command invocations like "contents",
> "info", and "flush", not separately like this. This design doesn't seem
> to support mixing commands.

Here's an example of how it works with other commands. Let's say I
call git cat-file --batch-command --buffer and input the following:

remote-object-info remote1 oid1 oid2 oid3
contents oid4
info oid5
remote-object-info remote2 oid6 oid7 oid8
flush

This would result in the following:

(call transport and store info in separate structure)
info oid1 (using passed in object-info)
info oid2
info oid3
contents oid4
info oid5
(call transport and store info in separate structure)
info oid6
info oid7
info oid8

> Rather than store a pointer like this (and thus needing to keep track of
> the lifetime of the memory pointed to by this pointer), if we only need
> to know whether this queued_cmd is a remote-object-info call, we can
> just use "unsigned is_remote_object_info : 1".

OK

>> @@ -565,9 +639,49 @@ static const struct parse_cmd {
>>  } commands[] = {
>>       { "contents", parse_cmd_contents, 1},
>>       { "info", parse_cmd_info, 1},
>> +     { "remote-object-info", parse_cmd_info, 1},
>>       { "flush", NULL, 0},
>>  };

> Double parse_cmd_info?

See above for why remote-object-info becomes info



On Wed, May 4, 2022 at 2:27 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Thanks for the patch. I'll limit myself to high-level comments for now,
> since the design may need to change if we want to support mixing
> remote-object-info with other commands in a --batch-command --buffer
> invocation.
>
> Calvin Wan <calvinwan@google.com> writes:
> > Since the `info` command in cat-file --batch-command prints object info
> > for a given object, it is natural to add another command in cat-file
> > --batch-command to print object info for a given object from a remote.
> > Add `remote-object-info` to cat-file --batch-command.
> >
> > While `info` takes object ids one at a time, this creates overhead when
> > making requests to a server so `remote-object-info` instead can take
> > multiple object ids at once.
> >
> > cat-file --batch-command is generally implemented in the following
> > manner:
> >
> >  - Receive and parse input from user
> >  - Call respective function attached to command
> >  - Set batch mode state, get object info, print object info
>
> You mention below that this only works in --buffer mode, so I don't
> think that this is relevant.
>
> > In --buffer mode, this changes to:
> >
> >  - Receive and parse input from user
> >  - Store respective function attached to command in a queue
> >  - After flush, loop through commands in queue
> >     - Call respective function attached to command
> >     - Set batch mode state, get object info, print object info
> >
> > Notice how the getting and printing of object info is accomplished one
> > at a time. As described above, this creates a problem for making
> > requests to a server. Therefore, `remote-object-info` is implemented in
> > the following manner:
>
> If you do want this command to work with --buffer and without, probably
> clearer to replace "Notice" with "Notice that when cat-file is invoked
> both without --buffer and with it". (Having said that, it makes sense to
> me to only make it work with --buffer - making one request per OID would
> probably not be something that the user would want.)
>
> >  - Receive and parse input from user
> >  If command is `remote-object-info`:
> >     - Get object info from remote
> >     - Loop through object info
> >         - Call respective function attached to `info`
> >         - Set batch mode state, use passed in object info, print object
> >           info
> >  Else:
> >     - Call respective function attached to command
> >     - Parse input, get object info, print object info
> >
> > And finally for --buffer mode `remote-object-info`:
> >  - Receive and parse input from user
> >  - Store respective function attached to command in a queue
> >  - After flush, loop through commands in queue:
> >     If command is `remote-object-info`:
> >         - Get object info from remote
> >         - Loop through object info
> >             - Call respective function attached to `info`
> >             - Set batch mode state, use passed in object info, print
> >               object info
> >     Else:
> >         - Call respective function attached to command
> >         - Set batch mode state, get object info, print object info
> >
> > To summarize, `remote-object-info` gets object info from the remote and
> > then generates multiples `info` commands with the object info passed in.
> > It cannot be implemented similarly to `info` and `content` because of
> > the overhead with remote commenication.
>
> What happens if remote-object-info is mixed with other commands?
>
> > diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> > index 24a811f0ef..0d9e8e6214 100644
> > --- a/Documentation/git-cat-file.txt
> > +++ b/Documentation/git-cat-file.txt
> > @@ -115,6 +115,10 @@ info <object>::
> >       Print object info for object reference `<object>`. This corresponds to the
> >       output of `--batch-check`.
> >
> > +remote-object-info <remote> [<object>]::
> > +     Print object info for object references `<object>` at specified <remote>.
> > +     This command may only be combined with `--buffer`.
>
> Here you mention that we need --buffer.
>
> > @@ -253,13 +258,14 @@ newline. The available atoms are:
> >
> >  `objectsize:disk`::
> >       The size, in bytes, that the object takes up on disk. See the
> > -     note about on-disk sizes in the `CAVEATS` section below.
> > +     note about on-disk sizes in the `CAVEATS` section below. Not
> > +     supported by `remote-object-info`.
> >
> >  `deltabase`::
> >       If the object is stored as a delta on-disk, this expands to the
> >       full hex representation of the delta base object name.
> >       Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
> > -     below.
> > +     below. Not supported by `remote-object-info`.
>
> OK - makes sense that these are not supported by remote-object-info,
> because the remote may not even store objects in delta format.
>
> > @@ -32,11 +35,14 @@ struct batch_options {
> >       int unordered;
> >       int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
> >       const char *format;
> > +     int use_remote_info;
> >  };
> >
> >  #define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
> >
> >  static const char *force_path;
> > +static struct object_info *remote_object_info;
> > +static struct oid_array object_info_oids = OID_ARRAY_INIT;
>
> Hmm...I would have expected the information to appear in the same data
> structure used to store other command invocations like "contents",
> "info", and "flush", not separately like this. This design doesn't seem
> to support mixing commands.
>
> > @@ -538,6 +611,7 @@ typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
> >  struct queued_cmd {
> >       parse_cmd_fn_t fn;
> >       char *line;
> > +     const char *name;
> >  };
>
> Rather than store a pointer like this (and thus needing to keep track of
> the lifetime of the memory pointed to by this pointer), if we only need
> to know whether this queued_cmd is a remote-object-info call, we can
> just use "unsigned is_remote_object_info : 1".
>
> > @@ -565,9 +639,49 @@ static const struct parse_cmd {
> >  } commands[] = {
> >       { "contents", parse_cmd_contents, 1},
> >       { "info", parse_cmd_info, 1},
> > +     { "remote-object-info", parse_cmd_info, 1},
> >       { "flush", NULL, 0},
> >  };
>
> Double parse_cmd_info?
