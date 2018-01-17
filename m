Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67491F404
	for <e@80x24.org>; Wed, 17 Jan 2018 00:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeAQARK (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 19:17:10 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:37395 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeAQARJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 19:17:09 -0500
Received: by mail-oi0-f45.google.com with SMTP id e144so11939204oib.4
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 16:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g3XfWxB+nXspwXARvi7iyDaPTYKbXzEVoj10v2mf8k4=;
        b=s/+3qc+Z59TreJ3eKe6aDaowTF2G1Q1qtbI6z0AlsqqJ6b09Kk3mo+fuWG/tru7ia+
         zbzRgPX8r8ZG7tmPezk6WMBCtq32BUySNIm9bbnqMva0R7wElFDQ6UDlxtCtyhmY12O6
         SHN2/OWpU+wFeTu6elmS6w+zp83cSM1eXEZpKZk5pHtDJYoVyZ/ZA8H4s5r1TtbKk7Hj
         X/SEukfs5eg0Z9tExt5Plnwzq9h77BC02VkbxAC4QyrZoms/2OJ8d9QiCyRS1s62sUoi
         ves3iQrQKC5IWywrgixsHFYSppegG6nta2XNZdv/eayVNSNEyCqbe/UUIib4TIHj7yPn
         ydIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g3XfWxB+nXspwXARvi7iyDaPTYKbXzEVoj10v2mf8k4=;
        b=eUvtPQgLM91fdB6vzvrkVN5OatMDpZX7XJhkbSdBLNCq/FcD6jxYelOxLhsWRLXeEh
         WEN2q9ycFzCE5M1FQxVAi5uCyy1u8sHhNAz+1efb872yDDKjRNBSwMFCQl/2rqP1SpsD
         1Z/3UyN1RrFyG91OPE2GBdNPFW4CZLiQUcCMD9iMM0jeFQ/Lw2TiM8qsHPm2uZ1yhlgA
         dihdO1mHHUVVlmPraK9Yn4qqm41HPoFG65K3UQAmdA51iG7b3X2gLipYqXJm6bQC5vS0
         8wZUvx2G3TqTV+NpkAY2pm90PvqZoJhgAXMpI/r81p6Wplq5uvMh4vkS/3VUSmgdBnmS
         AL6g==
X-Gm-Message-State: AKwxyte/VlRxZY9+m2jRhjKPnyKrvryMCPE50o3UocYHxTImLfp/BAKL
        lTeXtHsXZgP5B9P3wEwNdQcO2EadHSVqEgEAbTA=
X-Google-Smtp-Source: ACJfBoshBwgaNpD0cbZKHf/pjd+KGO5oKwxyQN/bCFxolAfPOL4oxusH4j+toxM/RAHMb93VXLY4ZqT3U7rgyWFGNao=
X-Received: by 10.202.60.134 with SMTP id j128mr101322oia.268.1516148228705;
 Tue, 16 Jan 2018 16:17:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Tue, 16 Jan 2018 16:16:38 -0800 (PST)
In-Reply-To: <20180116214239.GA3622@google.com>
References: <20171217225122.28941-1-t.gummerer@gmail.com> <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180107223015.17720-2-t.gummerer@gmail.com> <20180116214239.GA3622@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 17 Jan 2018 07:16:38 +0700
Message-ID: <CACsJy8A9AheuBK-mKy9d9m5yfSFFZ9N8=wg8FZD_C6mHHTdqXg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for other repos
To:     Brandon Williams <bmwill@google.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 4:42 AM, Brandon Williams <bmwill@google.com> wrote:
> On 01/07, Thomas Gummerer wrote:
>> read_index_from() takes a path argument for the location of the index
>> file.  For reading the shared index in split index mode however it just
>> ignores that path argument, and reads it from the gitdir of the current
>> repository.
>>
>> This works as long as an index in the_repository is read.  Once that
>> changes, such as when we read the index of a submodule, or of a
>> different working tree than the current one, the gitdir of
>> the_repository will no longer contain the appropriate shared index,
>> and git will fail to read it.
>>
>> For example t3007-ls-files-recurse-submodules.sh was broken with
>> GIT_TEST_SPLIT_INDEX set in 188dce131f ("ls-files: use repository
>> object", 2017-06-22), and t7814-grep-recurse-submodules.sh was also
>> broken in a similar manner, probably by introducing struct repository
>> there, although I didn't track down the exact commit for that.
>>
>> be489d02d2 ("revision.c: --indexed-objects add objects from all
>> worktrees", 2017-08-23) breaks with split index mode in a similar
>> manner, not erroring out when it can't read the index, but instead
>> carrying on with pruning, without taking the index of the worktree into
>> account.
>>
>> Fix this by passing an additional gitdir parameter to read_index_from,
>> to indicate where it should look for and read the shared index from.
>>
>> read_cache_from() defaults to using the gitdir of the_repository.  As it
>> is mostly a convenience macro, having to pass get_git_dir() for every
>> call seems overkill, and if necessary users can have more control by
>> using read_index_from().
>
> I'm not saying we need to change this again but I got to thinking about
> what the root cause for this bug is and I think it's a design flaw in
> how split index is implemented.  IIUC Split index is an index extension
> that can be enabled to limit the size of the index file that is written
> when making changes to the index.  It breaks the index into two pieces,
> index (which contains only changes) and sharedindex.XXXXX (which
> contains unchanged information) where 'XXXXX' is a value found in the
> index file.  If we don't do anything fancy then these two files live
> next to one another in a repository's git directory at $GIT_DIR/index
> and $GIT_DIR/sharedindex.XXXXX.  This seems to work all well and fine
> except that this isn't always the case and the read_index_from function
> takes this into account by enabling a caller to specify a path to where
> the index file is located.  We can do this by specifying the index file
> we want to use by setting GIT_INDEX_FILE.
>
> Being able to specify an index file via the environment is a feature
> that has existed for a very long time (one that I personally think makes
> things difficult because of things like additions like the sharedindex)
> and I don't think was taken into account when introducing the split
> index extension.

It was (partly because I did use GIT_INDEX_FILE on occasions).

> In this case if i were to specify a location of an
> index file in my home directory '~/index' and be using the split index
> feature then the corresponding sharedindex file would live in my
> repository's git directory '~/project/.git/sharedindex.XXXXX'.  So the
> sharedindex file is always located relative to the project's git
> directory and not the index file itself, which is kind of confusing.
> Maybe a better design would be to have the sharedindex file located
> relative to the index file.

That adds more problems. Now when you move the index file around you
have to move the shared index file too (think about atomic rename
which we use in plenty of places, we can't achieve that by moving two
files). A new dependency to $GIT_DIR is not that confusing to me, the
index file is useless anyway if you don't have access to
$GIT_DIR/objects. There was always the option to _not_ split the index
when $GIT_INDEX_FILE is specified, I think I did consider that but I
dropped it because we'd lose the performance gain by splitting.

> Anyway, some food for thought.
>
> --
> Brandon Williams



-- 
Duy
