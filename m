Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAF21F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 18:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbeGKSa2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 14:30:28 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45464 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732583AbeGKSa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 14:30:28 -0400
Received: by mail-ua0-f195.google.com with SMTP id k8-v6so1402846uaq.12
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tKJp9ks9Xv+Fnus/6e8puuSRPd8QgZ4xldsMGKNSSn4=;
        b=hZGi/+Zx22k0Kq0KJNU9H8ynOkHG6RVrh04CCgLgR0RjTrFK8TmWeuXTFdwiKyLyzx
         A/8kCDh3joBaDQl6sdTwkSJ8SSgS7ulf8ywbx5zCKcGPF7g8qjaZLDKTuLNtLGZyOyIm
         xVN0q03yWdDFeGr7vqwKLvcoFMmXydIgbZzL+SH4648TuIw8wdTkOQeWQ8+tzGDic28N
         stDR+GN3R3zDkkTNoit+rdnhIvVEqDmO8GkJbnNpRWvUP45EebervECwcnUqV/UjIeWl
         YQtStZr13kfrfhmiWJBBMQ2QByNcOY6krAyzKDCmr2JqZ9H365OCv/BtN49v48mRQeLm
         +frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tKJp9ks9Xv+Fnus/6e8puuSRPd8QgZ4xldsMGKNSSn4=;
        b=h2ZG3J7AMGIx3YIH2aQ9av97SGXiW53nllFez2xnsIahQZ7ncgzIQL4RyeFqfh8YFs
         UikSuLLM8/YyrbaRPzmhv7L9dzokF2e5FgLmoOvYILKHappMGyqQHRG+C7Cvbpkr6vqm
         lNvtvjO65NT2qdgmL7KHByEG+Qi7IZRS0fx7LXgLYsZqnJaGWBDZ6bjD1jS3k7NNHLcg
         enN8/o60Ml/6eJzj6UQDA52I03HlK5YbZDl2KZsDzXIh0Mz98SBXUR/lU/yRix3Zm0JE
         XRfEpFwKe575EmbChVixpc9l2zlb8HknDFjkzhVVMNruVaXt2wNRIQ3W+hx+9TiFrA4T
         TSyg==
X-Gm-Message-State: APt69E1a1ynf3dEffS/4eVX6cTX7J6Byp3QmXGMvpe9v5GbEXW5d8QxF
        jXO9FKIYTtmZiaN4DqZ3jANfHVUFXYW+nLWeDt0=
X-Google-Smtp-Source: AAOMgpdvj3+ec4Q/XB8TOacAeIj4VPvT+cB0xEcJwSDbHu4bD6m1YdkDNRNfQ6sfCHTu4DJuMf0CZIejoi2E6Y/pMT8=
X-Received: by 2002:ab0:5e8e:: with SMTP id y14-v6mr19093342uag.112.1531333495624;
 Wed, 11 Jul 2018 11:24:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 11:24:55
 -0700 (PDT)
In-Reply-To: <xmqqsh4p3dtk.fsf@gitster-ct.c.googlers.com>
References: <20180711051834.28181-1-newren@gmail.com> <20180711051834.28181-3-newren@gmail.com>
 <xmqqsh4p3dtk.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Jul 2018 11:24:55 -0700
Message-ID: <CABPp-BEzsj6T2eaz-OEi_+CMJetHVsMTBgy6DBfVY26e3M1NoA@mail.gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix directory/file conflict handling in read_index_unmerged()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 10:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>>     The _only_ reason we want to keep a previously unmerged entry in the
>>     index at stage #0 is so that we don't forget the fact that we have
>>     corresponding file in the work tree in order to be able to remove it
>>     when the tree we are resetting to does not have the path.
>> ...
>> So, that's the intended purpose of this function.  The problem is that
>> when directory/files conflicts are present, trying to add the file to the
>> index at stage 0 fails (because there is still a directory in the way),
>> and the function returns early with a -1 return code to signify the error.
>> As noted above, none of the callers who want the drop-to-stage-0 behavior
>> check the return status, though, so this means all remaining unmerged
>> entries remain in the index and the callers proceed assuming otherwise.
>
> Nicely analysed and explained so far.
>
>> ...  The temporary simultaneous appearance of the
>> directory and file entries in the index will be removed by the callers
>> before they attempt to write the index anywhere.
>
> But this part makes me feel a bit uneasy, as I find this "will be
> removed" a bit hand-wavy.  There are two such callers.  "am --skip"
> and "reset".
>
> The former uses am.c::fast_forward_to that calls unpack_trees() to
> two-way merge (aka "switch to the other branch") and these entries
> with CE_CONFLICTED flag get removed in merged/deleted_entry().
>
> "reset" (all variants) call unpack_trees() on the index prepared
> with read_cache_unmerged(), and the unmerged entries that are marked
> with CE_CONFLICTED bit get removed the same way.
>
> So perhaps before "before they attempt to", saying "by calling
> unpack_trees(), which excludes these unmerged entries marked with
> CE_CONFLICTED flag from the resulting index," or something like that
> would help uneasy readers?

Makes sense, I'll include that in my re-roll after waiting a little
bit for any further reviews.
