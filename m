Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E3AC54EED
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 15:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbjA3P2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 10:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbjA3P2P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 10:28:15 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DEC10AB2
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 07:28:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so32810349ejc.4
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 07:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rDmflLCg8CG9DBtilxXwsN41i9aimTiEEcXVqxvuTM=;
        b=ttLL9ebQd5JaWhkJ2BFFGhYAVXnIzKtsy/abJ7TBLw9woR/sWiW3qjgPxvtf1n7IwJ
         NK4FtEH5hj9t5fMt73YrhRzCkqXksZGUB9J9+AmtUWFdNJhCReAeEYvjOS32ipIeRJB0
         UlMQAhlaOzI8dPr+keC7LItfd5gp1ltirCa/JSfjhq5i7lamf5S5V2sNFACHcj0G4xDu
         DVOzd808lS5/u6HzvrRTKrRkGt8D2nhth9iwTIxl6Txy/DODG9t/2w2MCxmGkzh7A9si
         HvUc5iHtv+7zNjpF4gPq6ztXlLSkTHKPqmmTzaND88tNV76HyjUoKuupW7yt94zg+Ef4
         8Mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rDmflLCg8CG9DBtilxXwsN41i9aimTiEEcXVqxvuTM=;
        b=GIbZpn7bTttQtKZpfqKDZnhIg4ox9LozYZM3cRaFf4r7ZWLbIEPPCnTz8ZecF6Q206
         GsrE2Bs/GABOv31iHjRhmQ5KT0zTOl0pYzPU2WmaRMxS9Ne8Oax2/qwz2xclEM3aYp06
         tzEVDOj32oHUgG7lwIqosJ3Ojv8EIxAGLB8FBdsfoYG0zv+CeyVnVrqBm/wT91rnh1wF
         ggQlTIf4/8fMn0WG63wGF+LNYjByJspGBHAde5LaIIfafuD+SGJ8dfA9iPzisDG/UsAZ
         FZehaUfk1vRJZSpt6y8HSa5sPxMa0frOtWB+xJvceMbzntodnV1clDnez9CSmZ73ZaNA
         xyeA==
X-Gm-Message-State: AO0yUKUJeDHujNgLXsBieTQftLPocYvWDy3hUPlUBu7Axiu5Cbpq4k4o
        X8n1beSVbM9SUCjagn2tlURb/Q==
X-Google-Smtp-Source: AK7set8nBLXMGgy4Oa5Hxpup45bYHEMpiIlafgLj2TvZtMhpEdbeXVtPJOQtzWVwOmfRHJM2A52Y5A==
X-Received: by 2002:a17:906:2298:b0:885:23bc:3174 with SMTP id p24-20020a170906229800b0088523bc3174mr8276403eja.70.1675092491311;
        Mon, 30 Jan 2023 07:28:11 -0800 (PST)
Received: from [10.45.35.154] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906a18900b0088519b92074sm3180298ejy.128.2023.01.30.07.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 07:28:10 -0800 (PST)
Message-ID: <2fd448af-cdd8-92ca-f714-472aac9c6db1@unity3d.com>
Date:   Mon, 30 Jan 2023 16:28:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
 <CABPp-BExS8UGfGzT+w9R_p0sY+_=A0-nRzU5QTOKwfBSmX6c3A@mail.gmail.com>
 <18c94f70-4adf-1b4a-8777-206804c419e6@unity3d.com>
 <CABPp-BFtLdRV2zWXn0On0b6mOJgMAatwvUumUxfXfNXo9gc=HA@mail.gmail.com>
 <9dda8cde-7c96-a5f1-f271-951f8b348b80@unity3d.com>
 <CABPp-BGs2wG6a3oR8dmT9dkeakoiZ+w-Tf=4A-GXeDVkJ9QNMA@mail.gmail.com>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <CABPp-BGs2wG6a3oR8dmT9dkeakoiZ+w-Tf=4A-GXeDVkJ9QNMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/01/2023 17.45, Elijah Newren wrote:
> On Fri, Jan 27, 2023 at 3:59 AM William Sprent <williams@unity3d.com> wrote:
>>
>> On 26/01/2023 04.25, Elijah Newren wrote:
>>> On Wed, Jan 25, 2023 at 8:16 AM William Sprent <williams@unity3d.com> wrote:
>>>>
>>>> On 25/01/2023 06.11, Elijah Newren wrote:
>>>>> It looks like Ævar and Victoria have both given really good reviews
>>>>> already, but I think I spotted some additional things to comment on.
>>>>>
>>>>> On Mon, Jan 23, 2023 at 3:46 AM William Sprent via GitGitGadget
>>>>> <gitgitgadget@gmail.com> wrote:
>>>>>>
>>>>>> From: William Sprent <williams@unity3d.com>
>>>>>>
>>>>>> There is currently no way to ask git the question "which files would be
>>>>>> part of a sparse checkout of commit X with sparse checkout patterns Y".
>>>>>> One use-case would be that tooling may want know whether sparse checkouts
>>>>>> of two commits contain the same content even if the full trees differ.
>>>>>
>>>>> Could you say more about this usecase?  Why does tooling need or want
>>>>> to know this; won't a checkout of the new commit end up being quick
>>>>> and simple?  (I'm not saying your usecase is bad, just curious that it
>>>>> had never occurred to me, and I'm afraid I'm still not sure what your
>>>>> purpose might be.)
>>>>>
>>>>
>>>> I'm thinking mainly about a monorepo context where there are a number of
>>>> distinct 'units' that can be described with sparse checkout patterns.
>>>> And perhaps there's some tooling that only wants to perform an action if
>>>> the content of a 'unit' changes.
>>>
>>> So, you're basically wanting to do something like
>>>      git ls-tree --paths-matching-sparsity-file=<pattern-file> $COMMIT1
>>>> sparse-files
>>>      git ls-tree --paths-matching-sparsity-file=<pattern-file> $COMMIT2
>>>>> sparse-files
>>>      sort sparse-files | uniq >relevant-files
>>>      git diff --name-only $COMMIT1 $COMMIT2 >changed-files
>>> and then checking whether relevant-files and changed-files have a
>>> non-empty intersection?
>>
>> Well, the concrete use-case I'm exploring is something along the lines
>> of using the content hashes of sparse checkouts as cache keys for resource
>> heavy jobs (builds/tests/etc).
>>
>> So, that would be something along the lines of,
>>
>>       git ls-tree -r --paths-matching-sparsity-file=<pattern-file> \
>>       | sha1sum > cache-key
>>
>> and then performing a lookup before performing an action (which would
>> then only be done in the context of the sparse checkout). My thinking
>> is that this only would require git and no additional tooling, which in
>> turn makes it very easy to reproduce the state where the job took place.
>>
>>
>>> Would that potentially be better handled by
>>>      git diff --name-only $COMMIT1 $COMMIT2 | git check-ignore
>>> --ignore-file=<pattern-file> --stdin
>>> and seeing whether the output is non-empty?  We'd have to add an
>>> "--ignore-file" option to check-ignore to override reading of
>>> .gitignore files and such, and it'd be slightly confusing because the
>>> documentation talks about "ignored" files rather than "selected"
>>> files, but that's a confusion point that has been with us ever since
>>> the gitignore mechanism was repurposed for sparse checkouts.  Or maybe
>>> we could just add a check-sparsity helper, and then allow it to take
>>> directories in-lieu of patterns.
>>
>> I don't think it necessarily would be better handled by that. But it would
>> be workable. It would be a matter of collating the output of
>>
>>     git ls-tree -r <commit>
>>
>> with
>>
>>     git ls-tree --name-only -r <commit> | git check-ignore ...
>>
>> Which is less ergonomic. But it is also a less intrusive change.
>>
>> Really, the main thing is to expose the sparse filtering logic somehow, and
>> allow for building tooling on top of it.
>>> This seems nicer than opening a can of worms about letting every git
>>> command specify a different set of sparsity rules.
>>
>> I think you are the better judge of how much of a can of worms that would
>> be. I don't think it would be too out of line with how git acts in general
>> though, as we have things like the the 'GIT_INDEX_FILE' env-var.
> 
> I agree you've got a reasonable usecase here.  The integration you've
> described sounds like something that could be independently composable
> with several other commands, and you alluded to that in your commit
> message.  But is adding it to ls-tree the best spot?  If we add it
> there, then folks who want to similarly integrate such capabilities
> with other commands (archive, diff, grep, rev-list --objects, etc.),
> seem more likely to do so via direct integration.  We already have a
> very large can of worms to work on to make commands behave in ways
> that are limited to sparse paths (see
> Documentation/techncial/sparse-checkout.txt, namely the "behavior A"
> stuff).  As can be seen in that document, what to do for limiting
> commands to sparse paths is obvious with some commands but has lots of
> interesting edge cases for others (even with years of experience with
> sparse checkouts, we had 3- and 4- way differing opinions on the
> intended behavior for some commands when we started composing that
> document a few months ago).  If we had jumped straight to
> implementation for some commands, we would have likely painted
> ourselves into a corner for other commands.  Adding another layer of
> specifying an alternate set of sparsity rules will likely have
> interesting knock-on effects that we should think through for all the
> commands to ensure we aren't painting ourselves into a similar corner,
> if we go down this route.
> 
> However, in the cases that sparse-checkout.txt document was
> addressing, the behavior fundamentally needs to be integrated into all
> the relevant commands to get user experience right.  In your case, you
> merely need a separate tool to be able to compose the output of
> different commands together.  So, exposing whether sparsity rules
> would select various paths in a single separate command (maybe git
> check-ignore, or a new sparse-checkout subcommand, or maybe just a new
> subcommand similar to check-ignore) would avoid a lot of these issues,
> and give us a single place to extend/improve as we learn about further
> usecases.

I do think that 'ls-tree' is ultimately (eventually?) the right place for
something like this. But you do make some good points about it perhaps being a
bit early.

> 
> [...]
>>>> I agree that it is a bit awkward to have to "translate" the directories
>>>> into patterns when wanting to use cone mode. I can try adding
>>>> '--[no]-cone' flags and see how that feels. Together with Victoria's
>>>> suggestions that would result in having the following flags:
>>>>
>>>> * --scope=(sparse|all)
>>>> * --sparse-patterns-file=<path>
>>>> * --[no]-cone: used together with --sparse-patterns-file to tell git
>>>>      whether to interpret the patterns given as directories (cone) or
>>>>      patterns (no-cone).
>>>>
>>>> Which seems like a lot at first glance. But it allows for passing
>>>> directories instead of patterns for cone mode, and is similar to the
>>>> behaviour of 'sparse-checkout set'.
>>>>
>>>> Does that seem like something that would make sense?
>>>
>>> --sparse-patterns-file still implies patterns; I think that would need
>>> some rewording.
>>
>> Yeah. After sleeping on it, I also think that it becomes a difficult
>> interface to work with, and you'll get different results with the same
>> patterns whether you pass --cone or --no-cone, which seems error prone
>> to me.
>>
>> For better or for worse, both cone and non-cone uses of sparse-checkouts
>> end up producing pattern files. And those pattern files do unambiguously
>> describe a filtering of the worktree whether it is in cone-mode or not.
> 
> Back when cone mode was introduced, I objected to reusing the existing
> pattern format and/or files...but was assuaged that it was just an
> implementation detail that wouldn't be exposed to users (since people
> would interact with the 'sparse-checkout' command instead of direct
> editing of $GIT_DIR/info/sparse-checkout).  It's still a performance
> penalty, because we waste time both turning directory names into
> patterns when we write them out, and when we read them in by parsing
> the patterns to see if they match cone mode rules and if so discard
> the patterns and just build up our hashes.  The patterns are nothing
> more than an intermediary format we waste time translating to and
> from, though once upon a time they existed so that if someone suddenly
> started using an older (now ancient) version of git on their current
> checkout then it could still hobble along with degraded performance
> instead of providing an error.  (We have introduced other changes to
> the config and git index which would cause older git clients to just
> fail to parse and throw an error, and even have defined mechanisms for
> such erroring out.  We could have taken advantage of that for this
> feature too.)
> 
> Anyway, long story short, if you're going to start exposing users to
> this implementation detail that was meant to be hidden (and do it in a
> way that may be copied into several commands to boot), then I
> definitely object.

Alright. Fair. I think with that additional context, I agree. I was coming from
a "this is a common format to both cone and non-cone modes" not a "this is a
leftover implementation detail from now-deprecated use cases" which is the vibe
I'm getting here.

I still think it would be unfortunate to have a single input parameter that
takes both kinds of specifications and interprets them either as cone or non-
cone depending on config and/or a flag. With cone mode specifications like
'a/b/c' being valid gitignore patterns there's no way of knowing whether the
user actually is supplying a pattern or accidentally supplied a directory in
non-cone mode.

With that in mind, I'd probably suggest something along the lines of having
'ls-tree' only accept cone-mode specifications (e.g. --cone-rules-file or so) to
avoid having the non-cone/cone distinction spread outside the 'sparse-checkout'
command. But that would be leaving non-cone users behind, and I guess we are not
quite there yet.
  
>> Given that 'ls-tree' is more of a plumbing command, I think it might still
>> make sense to use the patterns. That would also make the interaction
>> a bit more logical to me -- e.g. if you want to override the patterns
>> you have to pass them in the same format as the ones that would be read
>> by default.
> 
> No, sparsity specification should be provided by users the same way
> they normally specify it (i.e. the way they pass it to
> `sparse-checkout {add,set}`), not the way it's stored via some hidden
> implementation detail.
> 
> I'd make an exception if you ended up using `git check-ignore` because
> that command was specifically written about gitignore-style rules, and
> git-ignore-style rules just happen to have been reused as-is for
> non-cone-mode sparse-checkout rules.  But if you go that route:
>     (1) you have to frame any extensions to check-ignore as things that
> are useful for gitignore checking, and only incidentally useful to
> sparse-checkouts
>     (2) you'd have to forgo any cone-mode optimizations
> Going the check-ignore route seems like the easiest path to providing
> the basic functionality you need right now.  If your usecases remain
> niche, that might be good enough for all time too.  If your usecases
> become popular, though, I expect someone would eventually tire of
> using `check-ignore` and implement similar functionality along with
> supporting cone-mode in a `git check-sparsity` or `git sparse-checkout
> debug-rules` command or something like that.

I guess that would be workable. But I would only want to use the command with
cone-mode patterns, so losing the cone-mode optimisations would be suboptimal.

If the 'ls-tree' path isn't the best way forward right now, do you think it
would be viable to add a subcommand along the lines of 'debug-rules/check-rules'
to sparse-checkout?

Then

     git ls-tree -r HEAD | git sparse-checkout debug-rules

would output only the path that match the current patterns. And

     <...> | git sparse-checkout debug-rules --rules-file <file> --[no]-cone

would be equivalent to setting the patterns with

    cat <file> | git sparse-checkout set --stdin --[no]-cone

before running the command above.

Then all the cone/no-cone pattern specification stuff is still contained within
the 'sparse-checkout' command and the documentation for the sub-command would
reside in the sparse-checkout.tx file next to all the caveats and discussion about
sparse-checkout.


