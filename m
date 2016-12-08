Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034CA1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 19:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbcLHTc1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 14:32:27 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33816 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbcLHTc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 14:32:27 -0500
Received: by mail-qk0-f173.google.com with SMTP id q130so272196995qke.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 11:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZyA1VUY+fS5Pel+cyf/Vff8mHSInwysSeue73PYoj5s=;
        b=TzHhMiQ9wr+hT+KeGT9dQMAmH7cRWacTsb9GiiuGCiO0sSJjG4EdIw6ky+aI3MC2wS
         Xd13LZoBK5jKQq1w6IEm0n5lXMn0wa5BwfqmJH6fYbFxmbGnmyfl4aboyX2cd2nGEYgk
         URhipAg3cnGFLT6Bu9vwLEGkntaO+rwerubRLcXe7bSb1APJd1Tm1XaPonqxoCsy12ms
         PhzyJ+USC7fcW8P0QgvPlUbZIUPlj2i9SjMRVa2aPBRzp9UmSHZkANan9A6vjiEOAzsP
         xNGZYGaB2+WlCb/HfjqMOKzHfHtmRaDLyz8PNlRp93QMJU1gyT4GIhzv6dz2Oc/uOchY
         /uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZyA1VUY+fS5Pel+cyf/Vff8mHSInwysSeue73PYoj5s=;
        b=i5RMWQz2ZOI/t5dUdkeqGlIaPZFrh+cnCfLQxhaz/VIldjTrQssrAJGjUAjd6dHv3m
         nsKvV1HUuAMILLBpOBuzo+oN2CavuoO2GkYonb0C0mjYWeMILYYJsF03Zyu0Y9Nw8Dxk
         agx3+zjEiPaJBnbwRX9itjCd8RhFoK6HkduzEq/k34UlzvaGficmHrGgCGRuWwA9TNjI
         wMsuasoENUC9ZRWOA0D9dqXCY0tCt2mpVZnffvFJCThTPZjJ9C0XqAai4McQvbd9vOJw
         uJC3w4Rys6LxrC9N6flObdciHB+leiKs51HnTGnnD2WqAI3kbdhrMmSKPBObdrLkACHl
         Oa4A==
X-Gm-Message-State: AKaTC01mAig/CHJXKBSZbRUjricY6o7ESWcXj/jEiNyaA5TMb0D+PZ145UkORJWQ0Op17/1I7pqbeP+pmMrL7fQu
X-Received: by 10.55.105.129 with SMTP id e123mr71031727qkc.173.1481225545764;
 Thu, 08 Dec 2016 11:32:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Thu, 8 Dec 2016 11:32:25 -0800 (PST)
In-Reply-To: <CACsJy8DMhC7Umnqf+-ViOBKn46Emtan4647=MDdLoYXVNB0=6A@mail.gmail.com>
References: <20161208014623.7588-1-sbeller@google.com> <20161208014623.7588-6-sbeller@google.com>
 <CACsJy8ANNz6FsJ4_5MOhj2Qqd+wHHu5UpVOAobqEiHU2KM26eg@mail.gmail.com> <CACsJy8DMhC7Umnqf+-ViOBKn46Emtan4647=MDdLoYXVNB0=6A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Dec 2016 11:32:25 -0800
Message-ID: <CAGZ79kbNAZ81JqO+UEmKJC06oDRKWjxaF3Cb6jpZ3Xxo=des8g@mail.gmail.com>
Subject: Re: [PATCHv6 5/7] worktree: add function to check if worktrees are in use
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 2:51 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Dec 8, 2016 at 5:40 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> Alternatively, we could add a new flag to get_worktrees() to tell it
>> to return all worktrees if there is a least one linked worktree, or
>> return NULL if there's only main worktree. I'm not sure if this is
>> clever or very stupid.
>
> No, this may be better. Add a flag to say "returns linked worktrees
> _only_". Which means when you're in a "normal" repo, get_worktrees()
> with this flag returns NULL. When you're in a multiple-worktree repo,
> it returns all linked worktrees (no main worktree). I think I might
> have a use for this flag in addition to this uses_worktrees() here.
> uses_worktrees() look quite simple with that flag
>
> int uses_worktrees(void)
> {
>     struct worktree **worktrees = get_worktrees(WT_LINKED_ONLY);
>     int retval = worktrees != NULL;

I am interested in the submodule case however, where we already return NULL
e.g. when the submodule git dir cannot be found. Actually that would
work out fine
as well:

    /* NOTE on accuracy of result, hence not exposed. */
    static worktree **submodule_get_worktrees(const char *path, unsigned flags)
    ..

    int submodule_uses_worktrees(const char *path)
    {
        struct worktree **worktrees = submodule_get_worktrees(path,
WT_LINKED_ONLY);
        int retval = worktrees != NULL;
        free_worktrees(worktrees);
        return retval;
    }

Thanks for that inspiration!
