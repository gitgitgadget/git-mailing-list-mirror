Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0403C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 01:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKKBHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 20:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKKBHI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 20:07:08 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBEA47334
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 17:07:06 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id q10-20020a170902f34a00b00186c5448b01so2477253ple.4
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 17:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sINeAj6fMnIwPw52moq602MUFNsr4FxcP3LLHMjia0k=;
        b=koBzJX4qanvuoUYAJ6OWqtrD/KDeFyTC71FL6Y7OPin1B116BrwW3L2+YjHY3N3nuN
         AiIIp701wn0w6fy1hcEdeUM2RFII+dOVV0TVeiweIBA75JjJK82+4YkxHVNGiVo6qi8C
         TJpAjDtBOazd/fdqYHk5w6ueqIE7V4IP2MokZ3z1sqI4e0CPyWR4R+YuSVha7213KOgW
         f3ct++tYRdnYSbqC4yBK5HkFBTR1O/lMNFjmjlvvO+dPHgIbC1Ccz4PxyOnT8vEkxsuK
         XZaftS060TpWPPuv9S76mVVrXXgWDgeF7UKuCI9cP1LWK6MlafZrjL+7BqGPpM5KU1pi
         XyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sINeAj6fMnIwPw52moq602MUFNsr4FxcP3LLHMjia0k=;
        b=6zz5WGvTAb1pGjiYfN+EMJj9g77QojM9f/PTnOfw6iO3qYTBynWQx2IgzWqy/FrthR
         i31utRti8Q7QKFw0PMFO4SparB6NM+NxN91uNcZvFk4cP/tes+u2pQxEYo7l2eR3ZYMy
         EZLscyL20m0R2HQ05JGWRGmLCexH61lJR+EKpNnmFSBiCXz+Bo5XBIqXJqiz7TO0NHt0
         Ra5XxoIdRdmTH7yQmQ5/TPGsp8LX/agjsMgqemBsycBB8fhUyfKz+HbamlmX/fZX1Jj2
         LufI9/L3U8JsAmyzKYMzse/5NbGD5lRBKCbMAclZzOjAWx9ByGRRFHpOYp5P2XaJ2fL2
         E3RA==
X-Gm-Message-State: ANoB5pmQE22oKDjdvN8EyqBBQIXoAsiwd4PxN9iZtITzZt3Ncv918Zy6
        ITnlOnsz3nmjW9vRSWtlumFO972xL7JbAw==
X-Google-Smtp-Source: AA0mqf6kneWR9WW5di5sNbO9ZyoTt7aeHR06/SPNcGjfKE8AFdQ6J89MJU/FAwQnmaZtRCjmJa/1iBH+AUSyCw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:c58e:b0:20a:eab5:cf39 with SMTP
 id l14-20020a17090ac58e00b0020aeab5cf39mr123219pjt.1.1668128825734; Thu, 10
 Nov 2022 17:07:05 -0800 (PST)
Date:   Thu, 10 Nov 2022 17:07:04 -0800
In-Reply-To: <221110.86zgcznjah.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com> <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <kl6ltu373ae5.fsf@chooglen-macbookpro.roam.corp.google.com> <221110.86zgcznjah.gmgdl@evledraar.gmail.com>
Message-ID: <kl6l5yfm2taf.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rereading this series and thinking about this some more, let's go with
your approach, primarily because it avoids global state.

From this series, it seems that it's not that hard to make this change
and support whatever use cases we currently have.

This does make it more tedious to add more "--super-prefix" in the
future, but that's a good push for us to do more things in-process
and/or be more principled about passing context objects through the call
stack instead of relying on globals.

Let me know what I can add to this effort besides reviewing :)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Nov 09 2022, Glen Choo wrote:
>
>> Thanks for the series! I haven't fully figured out where I stand on
>> this, but I can share some initial thoughts and comparisons to my RFC.
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> An RFC alternative to Glen's [1], and what I *thought* he might be be
>>> going for in the earlier discussion[2].
>>>
>>> The difference is that in Glen's there's no "git --super-prefix", but
>>> rather each set of commands still using it ("submodule--helper",
>>> "read-tree" etc.) geit their own command-level option.
>>
>> Yes, and a secondary intent was to give exact definitions and a shared
>> implementation to the command-level options instead of having each new
>> command figure out what to do every time a similar use case pops up.
>
> ... (more below)...
>
>>>
>>> But it still works substantially the same, in that we're juggling a
>>> global variable that we set, and read out later somewhere down the
>>> stack.
>>
>> Yes, intentionally so. I was under the assumption that the various
>> prefixes would still be used, and that adding them to commands will be a
>> necessary evil, so it was better to have them share a single
>> implementation.
>
> I'm not sure I understand what you mean here exactly, but as an example
> that might clarify things: In my "foreach" patch:
> https://lore.kernel.org/git/RFC-patch-3.8-4858e2ad0ed-20221109T192315Z-av=
arab@gmail.com/
>
> I'm making use of "OPT__SUPER_PREFIX()" to share the things that need to
> be shared, and after that we ferry the "super_prefix" from
> module_foreach() down through "struct foreach_cb" to
> "runcommand_in_submodule_cb()", and that's all the places we need it.
>
> With how OPT_SUBCOMMAND() works we'd need a file-level static variable
> (or similar) if we took the "--super-prefix" in the
> cmd_submodule__helper() instead, which we could do, and it would have
> pretty much the same effect.
>
> But I don't really see the advantage in any one individiual case. Isn't
> it just trading that one repeated "OPT__SUPER_PREFIX()" line for more
> clarity about who needs what?

The other concern I had was that we'd have to repeat the "super_prefix"
field in all of the command options structs, and then pass them down
through all of the call chain that would need it. Or even worse, create
new structs for call chains that didn't have them.

But, since want to move away from global state altogether, the "effort
saving" of having a global will end up causing more headache for us in
the future, so we should just bite the bullet now, especially since this
series shows thats it's not _that_ hard.

> We can be sure it's just clone/update/foreach/status/sync/absorbgitdirs,
> because if the others are invoked with the --super-prefix they'll die().
>
> Which aside from the specific approaches in either of our topics is, I
> think, a really nice thing to have. I.e. it makes reasoning about the
> code easier if we can confidently say "this is a feature with global
> effect, but it only has an impact on this subset of stuff".
>
> Which is an aspect of your proposed RFC that I don't like in
> isolation. I.e. if/when we're going to do the eventual refactoring that
> I've done in my RFC we'd need to reason that we need to change "foreach"
> and not "create-branch" or whatever, which the current whitelisting
> really helps us with.

Fair. I also had the same worries, which is probably a sign of smelly
code.

>
>> (As an aside, when you remove git-submodule.sh, I wonder if we should
>> split up submodule--helper along this dual-use line? e.g. the ones that
>> are entrypoints could be moved to "builtin/submodule.c", and the
>> implementation details can stay in "builtin/submodule--helper.c". Or
>> maybe you're already one step ahead of me here :))
>
> Yes, I'm ahead of you there.
>
> The ones that are purely internal, such as "push-check" etc. are still
> going to be invoked as "submodule--helper push-check".
>
> Before my RFC topic here I was planning on having both a "foreach" and
> "submodule--helper-foreach", as seen in:
> https://lore.kernel.org/git/221104.86wn8bzeus.gmgdl@evledraar.gmail.com/
>
> That was because I:
>
>  1. Didn't want to make "foreach"'s "--super-prefix" interface "public",
>     which it isn't now, as it's a purely internal thing we're trying to
>     eventually get rid of.
>  2. Didn't want to list all of "submodule--helper" as accepting it, as
>     some of it doesn't need it (e.g. "push-check").
>
> So having a "git submodule foreach" *not* accept it and it then
> recursing to an internal "git submodule--helper-foreach" which did
> accept it seemed like the least sucky thing to do.
>
> But if I rebase those patches on my RFC topic here we can invoke both as
> just "git submodule foreach".
>
> Pedantically, that's also exposing a "private" interface to the
> public. But:
>
>  * I'm listing it as OPT_HIDDEN, so we're not showing it outside fo
>    --help-all.

IMO I think OPT_HIDDEN is good enough, so yes, let's avoid having
"submodule foo" and "submodule--helper foo".

>  * More importantly, you need to provide that specific flag, it's not
>    accepting it "at a distance" via an env variable, which was the main
>    thing I was being paranod about.
>
>    Or rather. Even if *I knew* that "read-tree" or whatever wasn't
>    invoking a hook, which then invoked "submodule foreach" down the
>    line, and that "foreach" was slurping up the env var, I wanted to
>    leave it in a state where the next maintainer of this code didn't
>    have to worry about that.

Agree.

>> [1] https://lore.kernel.org/git/20221109004708.97668-2-chooglen@google.c=
om/
>>
>>>  * There's no passing of the "super_prefix" as a global, instead we
>>>    pass it all the way along until we recurse to ourselves. For
>>>    "submodule--helper" this is quite straightforward.
>>>
>>>  * Then in 8/8 we're left with just "read-tree" needing the remaining
>>>    "--super-prefix", and we likewise don't pass it as a global, but
>>>    instead add it to the "struct unpack_trees_options", which will
>>>    pass it all the way down into unpack-trees.c and entry.c, until
>>>    we're going to recursively invoke another "read-tree".
>>
>> I worry a little about two "necessary evils":
>>
>> - (As stated earlier) we may have to add "--super-prefix" or similar to
>>   more commands
>> - We may need to read "--super-prefix" from many parts of the code,
>>   since many parts might print paths.
>>
>> Having globals makes both of these cases easier, and is quite a bit
>> closer to the original implementation of "--super-prefix" (so your
>> characterization of only getting to a halfway point is accurate). This
>> was mostly to stave off opposition that it would tedious to add new
>> per-command "--super-prefix"-es, but if nobody else cares, maybe it's ok
>> to get of the globals.
>>
>> If we do want to pass a context object around, we probably have to be
>> more principled about it (e.g. in 8/8 I notice that checkout_stage()
>> doesn't receive the context object and we resort to passing NULL
>> instead), but we'd want that anyway if we want Git to move towards being
>> more library-like.
>
> Quick aside: Yes, that unlink_entry(ce) in builtin/checkout.c is now
> unlink_entry(ce, NULL).
>
> The API had only 3 users, and two potentially cared about the
> super_prefix. So I just amended the existing function, we could also add
> a unlink_entry_sp() or whatever.

I definitely prefer modifying the existing function in place since it
avoids accidental omissions of the super prefix.

My original diagnosis is wrong though, that checkout_stage() caller
is passed "struct checkout", so there is a super_prefix available.

>
>> It's quite likely that if any new "--super-prefix"-es are added, they
>> would be added by a Googler (even the original ones were ;)), so I can
>> probably go through the roadmap and figure out how costly these extra
>> "--super-prefix"-es might be.
>
> I don't really see that happening, but let me just grant that point for
> the sake of argument:=20
>
> Next month we're going to add a new "--super-prefix"-like use, and we're
> going to want some combinatino of a global, setenv()/getenv() etc. back,
> because it's the "sparse" code or whatever, and it'll be daunting to
> pass the state through 30 levels of callstack, we'll want to bypass it.
>
> I still don't see how it follows that we'd want to keep any of structure
> for this, which I think my series shows none of the current code needs.
>
> We can easily add such functionality back, adding a global variable
> isn't hard, and I think if anything such a future future would benefit
> from having to explain why it needs global state to do this sort of
> thing, when these other commands and sub-commands don't.

Yeah, I think the stakes of removing the global variable weren't as
high as I originally thought.
