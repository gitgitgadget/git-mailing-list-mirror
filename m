Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2896C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 13:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999CA61263
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 13:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhFANm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 09:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhFANmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 09:42:25 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2F9C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 06:40:43 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id p67-20020a4a2f460000b0290245cdf2d1a4so293998oop.8
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JR23OeIXyq3jm5x/bPrfkcsifF7/z1mwQRNlvcEqi1g=;
        b=csqLLXqy51+MH7SuDwS95zmlXFZCWlfcNq8IL1tfr9hGpSRajtsatYY/pEYmvcxqBf
         4xqYdWKQi1nc64G7rlB8cy86m8kbYU4oFay9fNYGV72qSoSgzcNBAdJjTEzXGQ6SSA+B
         nECXoPv8GAVfmZxVhknLy9QNgcKR1doghqAG+vj3L/S8EF8XlK+bcWsHllMs90aiSn4u
         uCjQjk2Phtn7kv4vdXF+tZoyLh2ofesp5ZnbCt3hGoc3y155V3T5PspqGag+HLOMMbF6
         NWGp7Zfhiv94B76g/eXYfu9u/b0MpBcwSTBC4nSubLHZVlfPvh8AU4nX8GS2w4+iW6II
         /ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JR23OeIXyq3jm5x/bPrfkcsifF7/z1mwQRNlvcEqi1g=;
        b=iLRDv9cSeASVi+gDyIzd80zcPY/2BlG94LHQhCqztL3SjaAs+SBW0/bCJb1JxJLUDJ
         aIHSxdKvzcdWV6u3VZhEAOHQhc+eNoklGyHih3losTUOLZuA0iQHB+jFVQ3WykBcWeBp
         uPN2/XXmOoPxq8q6s3v3fDTx0EtbGM6AnvvExWJvxXAZpOOalcELpujnh/eKkjBbi3id
         OjlNX4E4aRg+/myUcTqnI82d9pMb26kuGGRUC6LetmE0+yUqPkPB5z9R8RMjY5b6M/MO
         TmoMjTQa2EUTBx1IN6gAkTfZzsf7+0w7ymQvaa8MOsHuVaLErAReBtsBRawgGZpmolSM
         Plfg==
X-Gm-Message-State: AOAM532GzKOKdWLWbqxey6kAtmm/4NXzcV6rYx9SuBdH5NLSX84sylxD
        /oXld/rbOapeYXLqfjuLzg9nnQp6y5QjLw==
X-Google-Smtp-Source: ABdhPJzfLojRtpctulhPE6ZmjxaYT2U8Haw/Ofu1mdyA8uLYTHGnxzr05JwHZJFVgjLW9gXie5jDTQ==
X-Received: by 2002:a4a:6142:: with SMTP id u2mr20297216ooe.9.1622554842198;
        Tue, 01 Jun 2021 06:40:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e430:c189:dec7:db39? ([2600:1700:e72:80a0:e430:c189:dec7:db39])
        by smtp.gmail.com with ESMTPSA id 14sm1399231otf.51.2021.06.01.06.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 06:40:41 -0700 (PDT)
Subject: Re: Removing Partial Clone / Filtered Clone on a repo
To:     Tao Klerks <tao@klerks.biz>
Cc:     git@vger.kernel.org
References: <CAPMMpoim38J3=4pd0_fM2h=DN_PrEE_Osg2duU5Ur8WUZ5S1Pg@mail.gmail.com>
 <032cabb2-652a-1d88-2e12-601b40a4020c@gmail.com>
 <CAPMMpohOuXX-0YOjV46jFZFvx7mQdj0p7s8SDR4SQxj5hEhCgg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0b57cba9-3ab3-dfdf-5589-a0016eaea634@gmail.com>
Date:   Tue, 1 Jun 2021 09:40:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPMMpohOuXX-0YOjV46jFZFvx7mQdj0p7s8SDR4SQxj5hEhCgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2021 9:16 AM, Tao Klerks wrote:
> On Tue, Jun 1, 2021 at 12:39 PM Derrick Stolee <stolee@gmail.com> wrote:
> 
>> Could you describe more about your scenario and why you want to
>> get all objects?
> 
> A 13GB (with 1.2GB shallow head) repo is in that in-between spot where
> you want to be able to get something useful to the user as fast as
> possible (read: in less than the 4 hours it would take to download the
> whole thing over a mediocre VPN, with corresponding risk of errors
> partway), but where a user might later (eg overnight) want to get the
> rest of the repo, to avoid history inconsistency issues.

As you describe below, the inconsistency is in terms of performance,
not correctness. I thought it was worth a clarification.

...
> With the filtered clone there are still little edge-cases that might
> motivate a user to "bite the bullet" and unfilter their clone,
> however: The most obvious one I've found so far is "git blame" - it
> loops fetch requests serially until it bottoms out, which on an older
> poorly-factored file (hundreds or thousands of commits, each touching
> different bits of a file) will effectively never complete, at
> 10s/fetch. And depending on the UI tooling the user is using, they may
> have almost no visibility into why this "git blame" (or "annotate", or
> whatever the given UI calls it) seems to hang forever.

I'm aware that the first 'git blame' on a file is a bit slow in the
partial clone case. It's been on my list for improvement whenever I
get the "spare" time to do it. However, if someone else wants to work
on it I will briefly outline the approach I was going to investigate:

  During the history walk for 'git blame', it might be helpful to
  collect a batch of blobs to download in a single round trip. This
  requires refactoring the search to walk the commit history and
  collect a list of (commit id, blob id) pairs as if we were doing
  a simplified history walk. We can then ask for the list of blob id's
  in a single request and then perform the line-by-line blaming logic
  on that list. [If we ever hit a point where we would do a rename
  check, pause the walk and request all blobs so far and flush the
  line-by-line diff before continuing.]

This basic idea is likely difficult to implement, but would likely
dramatically improve the first 'git blame' in a blobless clone. A
similar approach could maybe be used by the line-log logic
(git log -L).

> You can work around this "git blame" issue for *most* situations, in
> the case of our repo, by using a different initial filter spec, eg
> "--filter=blob:limit=200k", which only costs you an extra 1GB or so...
> But then you still have outliers - and in fact, the most "blameable"
> files will tend to be the larger ones... :)

I'm interested in this claim that 'the most "blameable" files will
tend to be the larger ones.' I typically expect blame to be used on
human-readable text files, and my initial reaction is that larger
files are harder to use with 'git blame'.

However, your 200k limit isn't so large that we can't expect _some_
files to reach that size. Looking at the root of git.git I see a
few files above 100k and files like diff.c reaching very close to
200k (uncompressed). I tend to find that the files in git.git are
smaller than the typical large project.
 
> My working theory is that we should explain all the following to users:
> * Your initial download is a nice compromise between functionality and
> download delay
> * You have almost all the useful history, and you have it within less
> than an hour
> * If you try to use "git blame" (or some other as-yet-undiscovered
> scenarios) on a larger file, it may hang. In that case cancel, run a
> magic command we provide which fetches all the blobs in that specific
> file's history, and try again. (the magic command is a path-filtered
> rev-list looking for missing objects, passed into fetch)
> * If you ever get tired of the rare weird hangs, you have the option
> of running *some process* that "unfilters" the repo, paying down that
> initial compromise (and taking up a bit more HD space), eg overnight

Partial clone is all about tradeoffs: you get faster clones that
download missing objects as needed. The user behavior dictates how
many objects are needed, so the user has the capability to adjust
that need. The fewer objects needed locally, the faster the repo
will be.

Your concern about slow commands is noted, but also blindly
downloading every file in history will slow the repo due to the
full size of the objects on disk.

I think there is merit to your back-filling history idea. There
are likely benefits to the "download everything missing" concept,
but also it would be good to design such a feature to have other
custom knobs, such as:

* Get only "recent" history, perhaps with a "--since=<date>"
  kind of flag. This would walk commits only to a certain date,
  then find all missing blobs reachable from their root trees.

* Get only a "cone" of history. This could work especially well
  with sparse-checkout, but other pathspecs could be used to
  limit the walk. 

...
> Of course, if unfiltering a large repo is impractical (and if it will
> remain so), then we will probably need to err on the side of
> generosity in the original clone - eg 1M instead of 200k as the blob
> filter, 3GB vs 2.5GB as the initial download - and remove the last
> line of the explanation! If unfiltering, or refiltering, were
> practical, then we would probably err on the size of
> less-blobs-by-default to optimize first download.

I'm glad that you have self-discovered a workaround to handle
these cases. If we had a refiltering feature, then you could even
start with a blobless clone to have an extremely fast initial
clone, followed by a background job that downloads the remaining
objects.

> Over time, as we refactor the project itself to reduce the incidence
> of megafiles, I would expect to be able to drop the
> standard/recommended blob-size-limit too.

My experience working with large repos and partial clone is
similar: the new pain points introduced by these features make
users aware of "repository smells" in their organization and
they tend to self-correct by refactoring the repository. This
is a never-ending process as repos grow, especially with many
contributors.

Thank you for sharing your experience!

-Stolee
