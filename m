Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC24C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 08:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A155613ED
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 08:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbhGPINi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 04:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbhGPINh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 04:13:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51D8C061760
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 01:10:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t3so11813529edc.7
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=oo2tBnxyYZh+i3tPIYJPNKrEImRG+A9X6HWksleFiHU=;
        b=g4tN88CVgAZbOn8H9zeFHo7InlPHghTf6/qasHH7pjLwmEJGQ4ay5XSm7tBygaWO7C
         Bjsmz8+BlE/xUHkpoPZDwrQxDBqZzP5/dl7VbuDhFFAeuN2NjAx/MfUio03kiCu7pYyB
         kOoinjpXVARiy4qgVpHA6fKebaAoLQxNBYzdNmh3c9ROWgWpCWbgNIDQH4RER6QtqVDq
         6g/sl8ns8ASl2MvFLb+YOAGNET6MpiYBeawyb3RUum6bOoy6oi/+TuGD5JW/vL3zIWlV
         7QCEYbnbQehnYqal5AGbCX9/8zb9t1NLVup7189VyUNsPCz+rfrJ/UDgWo4ElApnihY1
         ZUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=oo2tBnxyYZh+i3tPIYJPNKrEImRG+A9X6HWksleFiHU=;
        b=uSob5pFz4SUzYQ/C+rZNxavSwR8PUOm3aXZ0hwoyakTUCEuP0SRJ7QQiI+vwbWMSzk
         if8uZey/d8p8I+QirGQ8cg8bQVmP1wcXnYnxc25U1hFHVTUPdiq2DCVqxRzZMfM8UWCy
         iUmZb7eRtTSbuo2cfcN/3NzrcBuJV6L35WiUAk4Y2AP1jgiuRVGJHgepAoB6eT4D2Zxi
         AG6XD6ufVJ3Q5KJhIp1Znpz2BjRCVE97fKYazGLVm16vmjRsJXlzpj+JclhIx8hlLZii
         vMhaFtsHswgAijK7qTyAlI0U8gIt4AbKCGslcuAaq3bERdZIlX/Eaj//aauxqgq8TvNm
         d0lg==
X-Gm-Message-State: AOAM531xqnXqWhZUI1Q8rmgvSK7AFNOGvnwGgevzqZAbDhbtXHj8ZaZ7
        krXwy/ur5LCiX36vh6ThbTfCnPhil64=
X-Google-Smtp-Source: ABdhPJx0nI3M6G80B1XEkbtSntHZlq6+Z0uQ8GtFaWASbMb4r9XfoiIE5kGwJhP1tAMjaL2Usmz/pg==
X-Received: by 2002:a50:fe8d:: with SMTP id d13mr13059977edt.14.1626423040172;
        Fri, 16 Jul 2021 01:10:40 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j24sm3384473edv.48.2021.07.16.01.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:10:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrzej Hunt <andrzej@ahunt.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/4] SANITIZE tests: fix memory leaks in t13*config*,
 add to whitelist
Date:   Fri, 16 Jul 2021 09:46:33 +0200
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-2.4-867e8e9a6c-20210714T172251Z-avarab@gmail.com>
 <871ea493-e108-e748-0234-f929690ad2fd@ahunt.org>
 <YPCrvOce5qRWk6Rq@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPCrvOce5qRWk6Rq@coredump.intra.peff.net>
Message-ID: <87wnpqy8zd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Jeff King wrote:

> On Wed, Jul 14, 2021 at 08:57:37PM +0200, Andrzej Hunt wrote:
>
>> > @@ -1331,8 +1336,10 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>> >   	if (!strcmp(var, "core.attributesfile"))
>> >   		return git_config_pathname(&git_attributes_file, var, value);
>> > -	if (!strcmp(var, "core.hookspath"))
>> > +	if (!strcmp(var, "core.hookspath")) {
>> > +		UNLEAK(git_hooks_path);
>> >   		return git_config_pathname(&git_hooks_path, var, value);
>> > +	}
>> 
>> Why is the UNLEAK necessary here? We generally want to limit use of UNLEAK
>> to cmd_* functions or direct helpers. git_default_core_config() seems
>> generic enough that it could be called from anywhere, and using UNLEAK here
>> means we're potentially masking a real leak?
>> 
>> IIUC the leak here happens because:
>> - git_hooks_path is a global variable - hence it's unlikely we'd ever
>>   bother cleaning it up.
>> - git_default_core_config() gets called a first time with
>>   core.hookspath, and we end up allocating new memory into
>>   git_hooks_path.
>> - git_default_core_config() gets called again with core.hookspath,
>>   and we overwrite git_hooks_path with a new string which leaks
>>   the string that git_hooks_path used to point to.
>> 
>> So I think the real fix is to free(git_hooks_path) instead of an UNLEAK?
>> (Looking at the surrounding code, it looks like the same pattern of leak
>> might be repeated for other similar globals - is it worth auditing those
>> while we're here?)
>
> This is a common leak pattern in Git. We do something like:
>
>   static const char *foo = "default";
>   ...
>   int config_cb(const char *var, const char *value, void *)
>   {
>           if (!strcmp(var, "core.foo"))
> 	          foo = xstrdup(value);
>   }
>
> So we leak if the variable appears twice. But we can't just call
> "free(foo)" here. In the first call, it's pointing to a string literal!
>
> In the case of git_hooks_path, it defaults to NULL, so this works out
> OK. But it's setting up a trap for somebody later on, who assigns it a
> default value (and the compiler won't help; it's a "const char *", so
> the assignment is fine, and the free() would already be casting away the
> constness).
>
> I see a few possible solutions:
>
>   - instead of strdup'ing long-lived config values, strintern() them.
>     This is really leaking them, but in a way that we hold on to the old
>     values. This is actually more or less what UNLEAK() is doing under
>     the hood (saving a reference to the old buffer, even the variable is
>     overwritten).
>
>   - find a way to tell when a string comes from the heap versus a
>     literal. I don't think you can do this portably without keeping your
>     own separate flag. We could abstract away some of the pain with a
>     struct like:
>
>        struct def_string {
>                /* might point to heap memory; const because you must
>                 * check flag before modifying */
>                const char *value;
>                int from_heap;
>        }
>
>        /* regular static initialization is OK if you don't want a default */
>        #define DEF_STRING_INIT(str) { .value = str }
>
>        static void def_string_set(struct def_string *ds, const char *value)
>        {
>                if (ds->from_heap)
>                        free(ds->value);
>                ds->value = xstrdup(value);
>                ds->from_heap = 1;
>        }
>
>     The annoying thing is all of the users need to refer to
>     git_hook_path.value instead of just git_hook_path. If you don't mind
>     a little macro hackery, we could get around that by declaring pairs
>     of variables. Like:
>
>       #define DEF_STRING_DECLARE(name, value) \
>       const char *name = value; \
>       int name##_from_heap
>
>       #define DEF_STRING_SET(name, value) do { \
>               if (name##_from_heap) \
>                       free(name); \
>               name = xstrdup(value); \
>               name##_from_heap = 1; \
>       } while(0)
>
> I can't say I _love_ any of that, but I think it would work (and
> probably we'd adapt our helpers like git_config_pathname() to take a
> def_string. Or I guess just have a def_string_free() which can be called
> before writing into them).
>
> But maybe there's a better solution I'm missing.

Instead of: "int from_heap" in your "def_string" I think we should just
use "struct string_list_item". I.e. you want a void* here. Why?

<Digression>

I have an unsent series for handling some more common cases in the
string-list API. I started writing it due to a very related problem,
i.e. that we conflate "string init dup/nodup" with "do we want to
free?".

We (ab)use the "strdup_strings" in a few places to free that sort of
thing at the end if we have heap-allocated strings, but ones we did not
strdup ourselves, e.g. this in merge-ort.c (not picking on Elijah (CC'd)
here, it's common in lots of places, and this one was pretty much lifted
from merge-recursive).

        opti->paths_to_free.strdup_strings = 1;
        string_list_clear(&opti->paths_to_free, 0);
        opti->paths_to_free.strdup_strings = 0;

So I improved the string-list and strmap free functions so you can
instead do:

    string_list_clear_strings((&opti->paths_to_free, 0);

And that along with some other changes allows you to clear (or not) any
combination of the string, util, or have a callback function of your own
run (but be ensured to run all of those before we get to any of the
other freeing).

</Digression>

You must be thinking what any of this has to do with heap strings in C,
well one common case you've not discussed is that we sometimes do the
equivalent of, with string-list.h or not (somewhat pseudocode);

	void add_to_list(struct string_list *list, char *on_heap_now_we_own_it)
	{
		char *ptr = on_heap_now_we_own_it;
		char *mydup = xstrdup("foo");

	        ptr++; /* skip first byte */
		string_list_append(list, ptr);
		string_list_append(list, mydup);
	}

And:

        struct string_list list = STRING_LIST_INIT_NODUP;
        /* other stuff here, we get strings from somewhere etc. */
        add_to_list(list, some_string);

So now you're left with needing to free both at the end, but we since we
did ptr++ there we can't free() that (we'd need to free(ptr - 1), but
how to keep track of that?).

Well, tying this back to my clear() improvements for string-list.h I
thought a really neat solution to this was:

    string_list_append(list, ptr)->util = on_heap_now_we_own_it;
    string_list_append(list, mydup)->util = mydup;

I.e. by convention we store the pointer we need to free (if any) in the
"util" field.

And then if you get a string not from the heap you just leave the "util"
as NULL, and at the end you just free() all your "util" fields, and it
just so happens that some of them are the same as the "string" field.

We're not in the habit of passing loose "string_list_item" around now,
but I don't see why we wouldn't (possibly with a change to extract that
bit out, so we could use it in other places).

The neat thing about doing this is also that you're not left with every
API boundary needing to deal with your new "def_string", a lot of them
use string_list already, and hardly need to change anything, to the
extent that we do need to change anything having a "void *util" is a lot
more generally usable. You end up getting memory management for free as
you gain a feature to pass arbitrary data along with your items.
