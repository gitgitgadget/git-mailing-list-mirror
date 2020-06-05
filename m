Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DA5C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 00:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70489206A2
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 00:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stLLGPnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgFEAcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgFEAcs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 20:32:48 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA22C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 17:32:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i16so7020542qtr.7
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 17:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mmqcMiZbARZSiHzUw5cWL4KFY/hAOcRwNnaCLqw2Sj8=;
        b=stLLGPnqi/eXpLEWYcQl6RqKWIqAeMLwW6D7O65ngs16w+2GTIoEgeQfAvyoyoWW51
         /03BsjqZZVB56mIIUyHzXKMjOSdPIfy14F9NnXO83X35zQ9NGJJYTyQ9/bNdy6j2Insw
         28CpnRSRW21kN/AXOkgWuNuc+aBVqDQ+D7Cc7qrwVE8tkCrlDiFG8hPT+w+ufuV66gSt
         R2twq0MRg3/BXc8WIhGiXx1YVMzh/uU+Ai3wNb+Y2SzxERwt2mwPg969n5upyBjdpNk8
         8e5BYY90w+7HrE93e8iPcbGKY/IEyT5lDgbP6sbrBhsXh2IocrWucimdBLHm2Lqt1s1E
         PGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mmqcMiZbARZSiHzUw5cWL4KFY/hAOcRwNnaCLqw2Sj8=;
        b=pBOI2YjKPT+i1HzSsYe7rUcHzxqeiOhQCtx09xTKFKPY3gPUlEx7CWHO7tN/NKTCc1
         UwDtMNjPBP49ruXpDmW1fDRNlCsi4fXVkEvLVxU4OuKO/XC77mn3eGmXqFKyWDEJag4J
         KEYSA6lVV1Yt7ayc0Be1Ee32sXgjhM0OGL3C6WZeuZn7vj5t0U2CIoDPO52I4soAPk6z
         wtf8mH9YnvYDPjjXgdjej1PRQD/385tyqVVm3B4Id68qfqnJx0HG7JWozYkeBT0hYiwp
         Fu5VNEoKcVm4pigikJBgN2Nqo5L0lmZiIYP5EJYufJ2DEZlm7PkbMTbGRPOduTUN0OC/
         JzrQ==
X-Gm-Message-State: AOAM530jdQZD8DXT7nvnbRsxd2VGYUlSgEVGMnOKFHpFiKDWVwPywORx
        vzxeWYgXOQ9VH45dqxU03AKNCjM+VL4=
X-Google-Smtp-Source: ABdhPJwGDOiSBIqvk/x+CPvUge0r03lZaR08SEhtYVs6OttemBAc5rMbogOG9L36TKL+0QbxZn1NHg==
X-Received: by 2002:a37:a7c5:: with SMTP id q188mr7255964qke.384.1591317165437;
        Thu, 04 Jun 2020 17:32:45 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q32sm6616460qtf.36.2020.06.04.17.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 17:32:44 -0700 (PDT)
Subject: Re: Possible regression for sparse-checkout in git 2.27.0
To:     Shaun Case <warmsocks@gmail.com>, Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CAD3+_6CUX0RPr-dgfUnfGDNNfqu80SYCskioYnu=MS6aJv2dEQ@mail.gmail.com>
 <CABPp-BGvc3GZfFuiXaqDk6391ZexQ7D3x9gr5JK6-L+rDQQ4sg@mail.gmail.com>
 <c1f9d76a-bf39-8508-1f4f-b34be77450a0@gmail.com>
 <CABPp-BHyDUrOLg6-VONewbmXNFHUvKoDXfRTLgg8aEhJFtJLuQ@mail.gmail.com>
 <CAD3+_6AK390F5iVqCmP-FY8MxJtcUoS7HsbunhZ0qNzOdT53CQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0aab7056-7176-01bc-ca7b-01356cbace4c@gmail.com>
Date:   Thu, 4 Jun 2020 20:32:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <CAD3+_6AK390F5iVqCmP-FY8MxJtcUoS7HsbunhZ0qNzOdT53CQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2020 4:50 PM, Shaun Case wrote:
> Hi Elijah, Derrick,
> 
> On Thu, Jun 4, 2020 at 12:27 AM Elijah Newren <newren@gmail.com> wrote:
>>
>> Hi,
>>
>> On Wed, Jun 3, 2020 at 8:36 AM Derrick Stolee <stolee@gmail.com> wrote:
>>>
>>> On 6/3/2020 12:37 AM, Elijah Newren wrote:
>>>> I think it'd be more natural to run
>>>
>>>>   git clone --filter=blob:none --sparse
>>>> https://github.com/r-spacex/launch-timeline.git
>>>
>>>> in place of the combination of
>>>
>>>>   git clone --filter=blob:none --no-checkout
>>>> https://github.com/r-spacex/launch-timeline.git
>>>>   git sparse-checkout init --cone
>>>
>>>> since the --sparse flag was added just for this kind of case -- to do
>>>> a clone but start with only a few things checked out.  It's easier, is
>>>> the route we're moving towards, and as a bonus also happens to work.
>>>
>>> Just one warning: the --sparse option in "git clone" does not currently
>>> enable core.sparseCheckoutCone, so running "git sparse-checkout init --cone"
>>> afterwards is a good idea, or else your "git sparse-checkout (set|add)"
>>> commands will not behave the way you expect.
> 
> Ok, great.  My production script now does this:
> 
> git clone --filter=blob:none --sparse <URL>
> git sparse-checkout init --cone
> git sparse-checkout add <PATH1>
> git sparse-checkout add <PATH2>
> [ ... ]
> 
> ... and everything works as expected in 2.26.2 and 2.27.0. Perfection!
> 
> See below for why I was doing it the other way.
> 
>>> (I think that I will propose a change in behavior to make it do so during
>>> this release cycle.)
> 
> That sounds good to me.  Could you also consider adding an error
> message for git sparse-checkout init, if something unexpected follows?  My
> rationale is that my script initially contained this:
> 
>      git sparse-checkout init cone
> 
> Note the missing "--" in front of cone.  This failed silently, so I
> thought I was in
> cone mode, but wasn't.  An error message would have helped.  Your proposal,
> having it happen automatically, would too.

Yes, this is probably a bug that's my fault. The option parser should
be more strict in the "init" case.

>>>> A bit of a side note, or a few of them, but this command of yours is broken:
>>>>   git sparse-checkout set README.md
>>>> because --cone mode means you are specifying *directories* that should
>>>> be checked out.
> 
> Thank you for pointing this out.  This is a surprise.  I'm migrating some large
> Subversion repos and workspace setup scripts to git (thus the interest
> in partial
> cloning and sparse checkouts), and svn has the ability to sparse checkout
> individual files as well as directories, so I expected it to work the
> same way in git.
> 
> Is this limitation a design decision, a technical limitation, a
> planned feature?  It
> seems to be fairly popular in svn, and  there is even more interest
> for it in git:
> 
> https://stackoverflow.com/questions/122107/checkout-one-file-from-subversion
> https://stackoverflow.com/questions/2466735/how-to-sparsely-checkout-only-one-single-file-from-a-git-repository

There are a couple reasons why this is tricky in Git.

The first is due to the .gitignore syntax. The syntax allows exact
matches for _directories_ using a trailing slash "/". For example,
we can match everything in A/B/C with the pattern

	A/B/C/

This would match the files in A/B/C/ and its subdirectories, but will
not match a file A/B/C.txt or A/B/C1/. There is no equivalent matching
for files, so A/B/C _will_ match a file A/B/C and A/B/C.txt. Whether this
matters to you or not depends on your file structure.

The second is how the pattern-matching works for cone mode. Everything
is based on prefix matches of directories, but also that if a directory
is included, then all of its parent directories are included, but not
recursively. All files contained directly in one of the parent directories
are included automatically. Thus, if A/B/C/ is recursively added, then
A/B/X.txt, A/Y.txt, and Z.txt all match in cone mode. This allows us some
significant performance gains by allowing us to stop walking trees when
we reach a directory that isn't one of these "parent" directories. We
know that A/D/ is not in our list of "parents" so we don't need to look
in there.

What does this have to do with file matches? If we include A/B/C.txt as
a file, then we will need to match all sibling files in A/B/! This is
very similar to matching A/B/* or even A/B/C/*.

This idea was brought up and debated shortly after 2.25.0 released [1]

[1] https://lore.kernel.org/git/CADSBhNbbO=aq-Oo2MpzDMN2VAX4m6f9Jb-eCtVVX1NfWKE9zJw@mail.gmail.com/

>>>> Currently, this gives no error, it instead silently
>>>> drops you back to non-cone mode, which seems bad to me.
>>>> sparse-checkout should provide some kind of error -- or at very least
>>>> a warning -- when you make that mistake.
> 
> Agreed.
> 
> I'm going to leave the following here for context, but please scroll down.
> 
>>>> Now let's talk about the commit in question that changed behavior
>>>> here.  The point of sparse-checkout is never to switch branches or
>>>> checkout new commits; all it does is update which paths are in the
>>>> current working directory.  A related point to this is it should never
>>>> add or remove entries from the index and shouldn't change any hashes
>>>> of files in the index.  It used to violate this, at first via an
>>>> implementation that was literally invoking `git read-tree -mu HEAD` in
>>>> a subprocess, and then later using internal code equivalent to
>>>> invoking that command in a subprocess.  But by violating the
>>>> leave-index-entries-alone mandate, it left folks who were in the
>>>> middle of a rebase and wanted to update their sparse-checkout to
>>>> include some more directories in their working tree in a precarious
>>>> spot -- if they didn't update, then they didn't have the files
>>>> necessary to build, and if they did forcibly update via `git read-tree
>>>> -mu HEAD` then their staged changes would all get wiped out.  I spent
>>>> some quality time helping users recover their files and teaching them
>>>> about the git storage model.
>>>>
>>>> So that brings us back to your original question.  When you said
>>>> --no-checkout, it means that there is no commit checked out and the
>>>> index is empty.  update_sparsity() is correctly toggling the
>>>> SKIP_WORKTREE bits for the existing index entries that don't match the
>>>> sparsity patterns, and it is correctly calling check_updates().
>>>> check_updates() is correctly checking for files currently in the index
>>>> which have toggled to being needed in the current worktree so that it
>>>> can issue downloads related to promisor packs.  The problem is just
>>>> that there aren't any index entries to begin with, so there are no
>>>> SKIP_WORKTREE bits to update, and thus no files that need to be
>>>> downloaded.
>>>>
>>>> It seems a bit risky to make sparse-checkout start doing
>>>> checkout/switch behavior and adding entries to the index.  There's a
>>>> couple ways forward.  One, we could decide this is a special edge or
>>>> corner case where we allow it: if the index is completely empty, then
>>>> there's no data to lose and thus we could make `git sparse-checkout
>>>> init [--cone]` in that one case use the old 'read-tree -mu HEAD'
>>>> logic.  Alternatively, we could just require users to run 'git reset
>>>> --hard' at the end of your script.
>>>>
>>>> Stolee: Thoughts?
>>>
>>> I agree that using "--sparse" instead of "--no-checkout" is the
>>> best way forward for now, but I'll classify that as a workaround
>>> and not necessarily the end of the conversation.
>>
>> Agreed.
> 
> Agree too.  I also agree that Elijah's changes are necessary, and will save me
> a ton of headaches going forward.  I don't want them backed out.
> 
> So, it seems --sparse instead of --no-checkout is what I should have been doing
> from the beginning, I had to fiddle a bit to get what I had working,
> by following
> some online resources and experimenting, and what I ended up with working
> satisfactorily was --no-checkout, with 2.26.2.
> 
> Why?
> 
> Perhaps the messaging has inadvertently become a little muddled.  I started
> by working on getting partial cloning working; when I searched, these are the
> resources I found and followed:
> 
> https://about.gitlab.com/blog/2020/03/13/partial-clone-for-massive-repositories/
> https://github.blog/2020-01-13-highlights-from-git-2-25/
> https://stackoverflow.com/questions/4114887/is-it-possible-to-do-a-sparse-checkout-without-checking-out-the-whole-repository
> https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/
> https://docs.gitlab.com/ce/topics/git/partial_clone.html
> 
> The first four mention --no-checkout, but do not mention --sparse.  The last one
> actually gives proper guidance, but by the time I came across it, I had the
> --no-checkout method working and I came away not even realizing --sparse
> exists.  Perhaps I'm the only one who went down this path.  If not, the
> --no-checkout case may be a bit more common than you might expect.

There's a good reason for this. In v2.25.0, the "--sparse" option was
present but broken. See [1] for the fix which was released in v2.26.0
as 47dbf10d8 (clone: fix --sparse option with URLs, 2020-01-24).

[1] https://lore.kernel.org/git/4991a51f6d5d840eaa3bb830e68f1530c2ee08e4.1579900782.git.gitgitgadget@gmail.com/

>>> In general, the commit in question is doing something extremely
>>> valuable for common situations, like rebase that you mention.
>>> I also think that this change in behavior is warranted by the
>>> clear warning placed at the top of the docs [1]:
>>>
>>>         THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE
>>>         BEHAVIOR OF OTHER COMMANDS IN THE PRESENCE OF SPARSE-
>>>         CHECKOUTS, WILL LIKELY CHANGE IN THE FUTURE.
>>>
>>> [1] https://git-scm.com/docs/git-sparse-checkout#_description
> 
> Got it.  Consider your butts covered.  :)

:D

Thanks,
-Stolee

