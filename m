Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456BAC433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 21:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352638AbiEDVbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 17:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347126AbiEDVbT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 17:31:19 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F3E4CD40
        for <git@vger.kernel.org>; Wed,  4 May 2022 14:27:42 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r9-20020a655089000000b003c612b48014so81769pgp.18
        for <git@vger.kernel.org>; Wed, 04 May 2022 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=YMBJ4hINrQNSSwaGRCe26gPOYRapB3aRf1iGj6fBh1g=;
        b=DkldQj6zxQXxFSGNLlZvVv1r0dqaOAP+/nw26NX89X+4VvAYCGR4bisr5HsWhbog2N
         UgUxxKe6GipEO76OJACK90Ed5ND6RMukotPxENGL6eB8FnsZcWZ7P13j79uvsuZVy4fj
         Mb9GtfwdKS2YI7sIgadkxzcju4eL5FzhsXam4dEw7QgSYg5a7tDP/Rb8xW04mVrkHWPM
         8sjdrzlctpbOTFugIUEW8Ll6AstWXLYjBfe8BFOkQKtiNKN1+RIsXQz3KGZGVAkKpP+J
         BJDwgRq5OxQKj8tASfRmdYROQFgW8f25U27SF8P3ST3Dj/on3S1zUxsJe2/gnLNXcbmI
         mKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=YMBJ4hINrQNSSwaGRCe26gPOYRapB3aRf1iGj6fBh1g=;
        b=QzCaAxh/HZXXhY4Q311SZuq50/LXTdsOKbA0wpMbq4MeNaT5z1ce7XVxUxmv3TbU5S
         cdEv4XJP3blxWIitFLdfM/4gX029GXeOMvNZUbyClL3cbrl9FHtdynpHyFrNWKGjxLer
         iw6Ek2ibQi5apdmsTm723t7ap0ET3vF17IR5eQ8tBG8SMpfAHtEe4fejploOSL+4UtqG
         ucPffsN6+ZH6mqeBUh0Oo1a9YWg6Jj2ng14oVd4i+mwrfIBY0IvepQfhod4qqCU6T9c0
         THv9ySMA7C7+WQYKhMHrRj13v7JSIyIlCySAzp53pTW3MuOoYc5qCz6adSAPopQ2QJAB
         /Lvw==
X-Gm-Message-State: AOAM533DybqSTUxbRTQqLZQ95a68V/ZN2E955hAGESBocgUwxoO2vZFm
        UK4hsc8g2qp2dyBXYW3hYJ18R6JWx0hw4uIVF15R
X-Google-Smtp-Source: ABdhPJxvLAN+VLE31JG7EoG5cd8gFZ15drsSQDHqDJxTSZJpTpMJxmJ+w+vvD2IQF97Fv6bn1yHSkJ0s1q2GKVMKP8DO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:2495:b0:15a:a0f7:d779 with
 SMTP id p21-20020a170903249500b0015aa0f7d779mr23443933plw.163.1651699661722;
 Wed, 04 May 2022 14:27:41 -0700 (PDT)
Date:   Wed,  4 May 2022 14:27:38 -0700
In-Reply-To: <20220502170904.2770649-9-calvinwan@google.com>
Message-Id: <20220504212738.162853-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: Re: [PATCH v4 8/8] cat-file: add --batch-command remote-object-info command
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, philipoakley@iee.email, johncai86@gmail.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the patch. I'll limit myself to high-level comments for now,
since the design may need to change if we want to support mixing
remote-object-info with other commands in a --batch-command --buffer
invocation.

Calvin Wan <calvinwan@google.com> writes:
> Since the `info` command in cat-file --batch-command prints object info
> for a given object, it is natural to add another command in cat-file
> --batch-command to print object info for a given object from a remote.
> Add `remote-object-info` to cat-file --batch-command.
> 
> While `info` takes object ids one at a time, this creates overhead when
> making requests to a server so `remote-object-info` instead can take
> multiple object ids at once.
> 
> cat-file --batch-command is generally implemented in the following
> manner:
> 
>  - Receive and parse input from user
>  - Call respective function attached to command
>  - Set batch mode state, get object info, print object info

You mention below that this only works in --buffer mode, so I don't
think that this is relevant.

> In --buffer mode, this changes to:
> 
>  - Receive and parse input from user
>  - Store respective function attached to command in a queue
>  - After flush, loop through commands in queue
>     - Call respective function attached to command
>     - Set batch mode state, get object info, print object info
> 
> Notice how the getting and printing of object info is accomplished one
> at a time. As described above, this creates a problem for making
> requests to a server. Therefore, `remote-object-info` is implemented in
> the following manner:

If you do want this command to work with --buffer and without, probably
clearer to replace "Notice" with "Notice that when cat-file is invoked
both without --buffer and with it". (Having said that, it makes sense to
me to only make it work with --buffer - making one request per OID would
probably not be something that the user would want.)

>  - Receive and parse input from user
>  If command is `remote-object-info`:
>     - Get object info from remote
>     - Loop through object info
>         - Call respective function attached to `info`
>         - Set batch mode state, use passed in object info, print object
>           info
>  Else:
>     - Call respective function attached to command
>     - Parse input, get object info, print object info
> 
> And finally for --buffer mode `remote-object-info`:
>  - Receive and parse input from user
>  - Store respective function attached to command in a queue
>  - After flush, loop through commands in queue:
>     If command is `remote-object-info`:
>         - Get object info from remote
>         - Loop through object info
>             - Call respective function attached to `info`
>             - Set batch mode state, use passed in object info, print
>               object info
>     Else:
>         - Call respective function attached to command
>         - Set batch mode state, get object info, print object info
> 
> To summarize, `remote-object-info` gets object info from the remote and
> then generates multiples `info` commands with the object info passed in.
> It cannot be implemented similarly to `info` and `content` because of
> the overhead with remote commenication.

What happens if remote-object-info is mixed with other commands?

> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index 24a811f0ef..0d9e8e6214 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -115,6 +115,10 @@ info <object>::
>  	Print object info for object reference `<object>`. This corresponds to the
>  	output of `--batch-check`.
>  
> +remote-object-info <remote> [<object>]::
> +	Print object info for object references `<object>` at specified <remote>.
> +	This command may only be combined with `--buffer`.

Here you mention that we need --buffer.

> @@ -253,13 +258,14 @@ newline. The available atoms are:
>  
>  `objectsize:disk`::
>  	The size, in bytes, that the object takes up on disk. See the
> -	note about on-disk sizes in the `CAVEATS` section below.
> +	note about on-disk sizes in the `CAVEATS` section below. Not
> +	supported by `remote-object-info`.
>  
>  `deltabase`::
>  	If the object is stored as a delta on-disk, this expands to the
>  	full hex representation of the delta base object name.
>  	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
> -	below.
> +	below. Not supported by `remote-object-info`.

OK - makes sense that these are not supported by remote-object-info,
because the remote may not even store objects in delta format.

> @@ -32,11 +35,14 @@ struct batch_options {
>  	int unordered;
>  	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
>  	const char *format;
> +	int use_remote_info;
>  };
>  
>  #define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
>  
>  static const char *force_path;
> +static struct object_info *remote_object_info;
> +static struct oid_array object_info_oids = OID_ARRAY_INIT;

Hmm...I would have expected the information to appear in the same data
structure used to store other command invocations like "contents",
"info", and "flush", not separately like this. This design doesn't seem
to support mixing commands.

> @@ -538,6 +611,7 @@ typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
>  struct queued_cmd {
>  	parse_cmd_fn_t fn;
>  	char *line;
> +	const char *name;
>  };

Rather than store a pointer like this (and thus needing to keep track of
the lifetime of the memory pointed to by this pointer), if we only need
to know whether this queued_cmd is a remote-object-info call, we can
just use "unsigned is_remote_object_info : 1".

> @@ -565,9 +639,49 @@ static const struct parse_cmd {
>  } commands[] = {
>  	{ "contents", parse_cmd_contents, 1},
>  	{ "info", parse_cmd_info, 1},
> +	{ "remote-object-info", parse_cmd_info, 1},
>  	{ "flush", NULL, 0},
>  };

Double parse_cmd_info?
