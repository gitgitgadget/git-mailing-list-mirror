Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869CCC54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 12:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjA0MLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 07:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjA0MLF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 07:11:05 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9387EFC3
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 04:05:12 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id bk15so13054317ejb.9
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 04:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZHnfjlMfRz6aietKsgWdxlzOzPyythQd2wHthJt4Yk=;
        b=UHeQX3FfzOkzz4qNWKXgM3SqSiIJjXX1hkfNJ+mcCQji6LIVGlunu+qp5Wj9+/LejK
         wF7aS2afzntiu5JnBz/XrFIwXqpLunfP9VkqOk5Cz7qZrXdJBpcA5qr8mdhN4Fm0bxjW
         Dq+/xxVcL82VVjDbgNpobslQ1QHCBlk28UPVr1CUIhBzsi0BBldkiWOlo1IKLSbZOZZa
         J2VMN9wLs4g995eeeDQ5uKlg+jjNnYL485xSQI5fcRb69HjK+cJp3hF6QBCayd74es/P
         kKfTpnBsgjAvCzLd1LV2JOVIs4ozHuRUEc4igDv7MqeLK420BdPgXk0Rd/rGKyG+1ugn
         WrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZHnfjlMfRz6aietKsgWdxlzOzPyythQd2wHthJt4Yk=;
        b=26nTAJ8nF5opsmdt+WHvApuacTxI4S728XhYVtwfoGsrh+KHBaLsN6PTNao4ZtDOs3
         F1TVauKJ9y9iMbP44FifOsGyI7hzAD2laWSLnKnOauNxPH4Uj/IkKLVXQiH+F0qnEs7B
         KdLFZ8AQeXmdCry/cpiqpn4/q6UNvy8NN8WMggXWFf/rNR7MUHXdODikwvFAe/WEkQ0L
         WuDQR894l1/nsrxr/LIWG4p2jv5Ampsur4Ec97nRyFykKpuYYwkrZx05QgaCzb57hAUn
         KXr8u3sI1tXqOiiGGg1Py+BiWpKcg8L3eyWN8p09qJQdUjepaF6KDFHQ5sTLFMajkXZk
         lZpA==
X-Gm-Message-State: AO0yUKX8nqad1QHOI+uqUP2dUVVXkZy89JlBOIJHSsfzqHpNDEVM/ct3
        5UYz+4N7DLiMMU9v3EeqoCWKpQ==
X-Google-Smtp-Source: AK7set/d/e/EJvQ+Q7EBH2AVkrYJWpx62mcy5PpX+mAzgmdeFSuhp327RQwYiGJLOkR/opKPwVDxsw==
X-Received: by 2002:a17:906:3745:b0:87b:d2e4:40d4 with SMTP id e5-20020a170906374500b0087bd2e440d4mr1958054ejc.30.1674820739346;
        Fri, 27 Jan 2023 03:58:59 -0800 (PST)
Received: from [10.45.34.176] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b008720c458bd4sm2119740eju.3.2023.01.27.03.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 03:58:58 -0800 (PST)
Message-ID: <9dda8cde-7c96-a5f1-f271-951f8b348b80@unity3d.com>
Date:   Fri, 27 Jan 2023 12:58:57 +0100
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
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <CABPp-BFtLdRV2zWXn0On0b6mOJgMAatwvUumUxfXfNXo9gc=HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/01/2023 04.25, Elijah Newren wrote:
> On Wed, Jan 25, 2023 at 8:16 AM William Sprent <williams@unity3d.com> wrote:
>>
>> On 25/01/2023 06.11, Elijah Newren wrote:
>>> It looks like Ævar and Victoria have both given really good reviews
>>> already, but I think I spotted some additional things to comment on.
>>>
>>> On Mon, Jan 23, 2023 at 3:46 AM William Sprent via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>>
>>>> From: William Sprent <williams@unity3d.com>
>>>>
>>>> There is currently no way to ask git the question "which files would be
>>>> part of a sparse checkout of commit X with sparse checkout patterns Y".
>>>> One use-case would be that tooling may want know whether sparse checkouts
>>>> of two commits contain the same content even if the full trees differ.
>>>
>>> Could you say more about this usecase?  Why does tooling need or want
>>> to know this; won't a checkout of the new commit end up being quick
>>> and simple?  (I'm not saying your usecase is bad, just curious that it
>>> had never occurred to me, and I'm afraid I'm still not sure what your
>>> purpose might be.)
>>>
>>
>> I'm thinking mainly about a monorepo context where there are a number of
>> distinct 'units' that can be described with sparse checkout patterns.
>> And perhaps there's some tooling that only wants to perform an action if
>> the content of a 'unit' changes.
> 
> So, you're basically wanting to do something like
>     git ls-tree --paths-matching-sparsity-file=<pattern-file> $COMMIT1
>> sparse-files
>     git ls-tree --paths-matching-sparsity-file=<pattern-file> $COMMIT2
>>> sparse-files
>     sort sparse-files | uniq >relevant-files
>     git diff --name-only $COMMIT1 $COMMIT2 >changed-files
> and then checking whether relevant-files and changed-files have a
> non-empty intersection?

Well, the concrete use-case I'm exploring is something along the lines
of using the content hashes of sparse checkouts as cache keys for resource
heavy jobs (builds/tests/etc).

So, that would be something along the lines of,

     git ls-tree -r --paths-matching-sparsity-file=<pattern-file> \
     | sha1sum > cache-key

and then performing a lookup before performing an action (which would
then only be done in the context of the sparse checkout). My thinking
is that this only would require git and no additional tooling, which in
turn makes it very easy to reproduce the state where the job took place.


> Would that potentially be better handled by
>     git diff --name-only $COMMIT1 $COMMIT2 | git check-ignore
> --ignore-file=<pattern-file> --stdin
> and seeing whether the output is non-empty?  We'd have to add an
> "--ignore-file" option to check-ignore to override reading of
> .gitignore files and such, and it'd be slightly confusing because the
> documentation talks about "ignored" files rather than "selected"
> files, but that's a confusion point that has been with us ever since
> the gitignore mechanism was repurposed for sparse checkouts.  Or maybe
> we could just add a check-sparsity helper, and then allow it to take
> directories in-lieu of patterns. 

I don't think it necessarily would be better handled by that. But it would
be workable. It would be a matter of collating the output of

   git ls-tree -r <commit>

with

   git ls-tree --name-only -r <commit> | git check-ignore ...

Which is less ergonomic. But it is also a less intrusive change.

Really, the main thing is to expose the sparse filtering logic somehow, and
allow for building tooling on top of it.

> This seems nicer than opening a can of worms about letting every git
> command specify a different set of sparsity rules.

I think you are the better judge of how much of a can of worms that would
be. I don't think it would be too out of line with how git acts in general
though, as we have things like the the 'GIT_INDEX_FILE' env-var.

>> Depending on the repo, it won't necessarily be quick to check out the
>> commit with the given patterns. However, it is more about it being
>> inconvenient to have to have a working directory, especially so if you
>> want use the tooling in some kind of service or query rapidly about
>> different revisions/patterns.
>>
>>>> Another interesting use-case would be for tooling to use in conjunction
>>>> with 'git update-index --index-info'.
>>>
>>> Sorry, I'm not following.  Could you expound on this a bit?
>>>
>>
>> I was imagining something along the lines of being able to generate new
>> tree objects based on what matches the given sparse checkout patterns.
>> Not that I have a specific use case for it right now.
>>
>> I think what I'm trying to evoke with that paragraph is that this
>> enables integrations with git that seem interesting and weren't possible
>> before.
> 
> I'm not sure if it's interesting, frightening, or something else.
> Hard to say without better descriptions of usecases, which we can't
> have if we don't even have a usecase.  I think I'd just strike this
> paragraph.
> 
> [...]

Fair. Will do.

>>>> +       (*d)->pl.use_cone_patterns = core_sparse_checkout_cone;
>>>
>>> Hmm, so the behavior still depends upon the current sparse-checkout
>>> (or lack thereof), despite the documentation and rationale of your
>>> feature as being there to check how a different sparse checkout would
>>> behave?
>>>
>>> I would hate to unconditionally turn cone_patterns off, since that
>>> would come with a huge performance penalty for the biggest repos.  But
>>> turning it unconditionally on wouldn't be good for the non-cone users.
>>> This probably suggests we need something like another flag, or perhaps
>>> separate flags for each mode.  Separate flags might provide the
>>> benefit of allowing cone mode users to specify directories rather than
>>> patterns, which would make it much easier for them to use.
>>>
>> I used 'core_sparse_checkout_cone' because I wanted to allow for the
>> cone mode optimisations, but I also figured that I should respect the
>> configuration. It doesn't change how the patterns are parsed in this case.
>>
>> I agree that it is a bit awkward to have to "translate" the directories
>> into patterns when wanting to use cone mode. I can try adding
>> '--[no]-cone' flags and see how that feels. Together with Victoria's
>> suggestions that would result in having the following flags:
>>
>> * --scope=(sparse|all)
>> * --sparse-patterns-file=<path>
>> * --[no]-cone: used together with --sparse-patterns-file to tell git
>>     whether to interpret the patterns given as directories (cone) or
>>     patterns (no-cone).
>>
>> Which seems like a lot at first glance. But it allows for passing
>> directories instead of patterns for cone mode, and is similar to the
>> behaviour of 'sparse-checkout set'.
>>
>> Does that seem like something that would make sense?
> 
> --sparse-patterns-file still implies patterns; I think that would need
> some rewording.

Yeah. After sleeping on it, I also think that it becomes a difficult
interface to work with, and you'll get different results with the same
patterns whether you pass --cone or --no-cone, which seems error prone
to me.

For better or for worse, both cone and non-cone uses of sparse-checkouts
end up producing pattern files. And those pattern files do unambiguously
describe a filtering of the worktree whether it is in cone-mode or not.

Given that 'ls-tree' is more of a plumbing command, I think it might still
make sense to use the patterns. That would also make the interaction
a bit more logical to me -- e.g. if you want to override the patterns
you have to pass them in the same format as the ones that would be read
by default.

Then maybe it could eventually make sense to expose the translation of
cone-mode patterns as well, e.g.

    git sparse-checkout set --cone --std-out dir1 dir2 dir3

or similar.

> More importantly, though, based on your usecase description, I wonder
> if you might be better served by either extending the check-ignore
> subcommand or adding a similar helper ("check-sparsity"?), rather than
> tweaking ls-tree.
