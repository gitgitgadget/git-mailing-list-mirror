Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617E120281
	for <e@80x24.org>; Thu, 21 Sep 2017 03:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdIUD4X (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 23:56:23 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:46649 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdIUD4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 23:56:22 -0400
Received: by mail-pg0-f44.google.com with SMTP id i130so2854975pgc.3
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 20:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cvntDzVBmvx617+8a5CK9nM4gmtnhlVLrd+m8KoODmU=;
        b=KX1KDB8bjRtKJVqt3PMXewjuyqHtp9S60eho3WRIh1RI8MVjhtvNPh5TGd0Q9WBuRu
         LbxIQb9dviZ2mhawPSR+aSipouA4VIfA1wLQoeyzWbASxdA/U5FmZmg2ZsWEiNxG2/oh
         hWDj/UAseeNH77/NJXqoXoV0Zfz/mPA7/NMHhFQp+ZHw3/2uWBFqJJrv/MoG1djKFH6N
         lKRs8FwMY/dEFmU/qvvBiqtdwzwzU6gOewTBlFkVcV/hba8eAQE/P0aN7ksznUOjetiv
         MNX2u9a3ilepPa+HbmtUrQnc3SCsNrMHFtZGKIGCaepR0FxRv45TkH6o3unUb4tGfLFL
         gOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cvntDzVBmvx617+8a5CK9nM4gmtnhlVLrd+m8KoODmU=;
        b=C+SstyAm89d+8RbABGmYmVHU0beb3JA21eeqx58T3tD4ZvLn2Hq9CdLtUJ0FJGgmjr
         Vf7SqLMvPldRxd2fXrAL2rJ7xdXWkJwKIJQ5mLgNF8RvBGYrIBNjgW5lM4KFsR9LES1/
         PKwVwgdUzRiJ7a6TAZNLysbHYTK5b7J/4g9gOuxpV6FOcxfERyuiw1wlPefiYrs5/yCk
         ZNZZYyjOP4MsrbNp4u0epY32SdF4BBqmkS+rfLOJrlpyZFWyle08HgftEa0ha5HT2hr6
         yGHb1Ii86CtpOx8/k0i96f9Hq0vW7F+FXc9inLZKnVBDjMM7hUe0gyJ9jD0jeHioScSm
         3mrw==
X-Gm-Message-State: AHPjjUgcwwnYiq2B6PosFiRDbDqDDXMwgVWi1p04zodnKhWQiqnjHLpk
        gRuHOl68NyBIK7Wezh4aKEyqCpKGxzghWOb/yl92Uw==
X-Google-Smtp-Source: AOwi7QAN6WDjKFUPKYJHgFrZzaUws4sBtYhzWCAhmR6yVFK9he+FC+Zr37nXkqiwkZUYnqLJjblgEF3U3LxWtWWKmKA=
X-Received: by 10.99.98.70 with SMTP id w67mr4401905pgb.362.1505966181765;
 Wed, 20 Sep 2017 20:56:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Wed, 20 Sep 2017 20:56:21 -0700 (PDT)
In-Reply-To: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
References: <1505936846-2195-2-git-send-email-martin.agren@gmail.com> <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 21 Sep 2017 05:56:21 +0200
Message-ID: <CAN0heSqVxBreaZN9x1XtX2OpeAoVZNzixr+vzyCWwe8UKtdtgQ@mail.gmail.com>
Subject: Re: [PATCH] diff-lib: clear `pending` object-array in `index_differs_from()`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stephan Beyer <s-beyer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 September 2017 at 22:02, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 20, 2017 at 09:47:24PM +0200, Martin =C3=85gren wrote:
>
>> Instead of conditionally freeing `rev.pending.objects`, just call
>> `object_array_clear()` on `rev.pending`. This means we don't poke as
>> much into the implementation, which is already a good thing, but also
>> that we free the individual entries as well, thereby fixing a
>> memory-leak.

> Looks good. A similar bug was the exact reason for adding the function
> in 46be82312. I did a grep for 'free.*\.objects' to see if there were
> other cases.

Ah. I grepped for "pending.objects", but didn't go more general than that.

> There are some hits. E.g., the one in orphaned_commit_warning(). It does
> something funny with setting revs.leak_pending. But I _think_ after the
> whole thing is done and we call free(refs.objects), that probably ought
> to be an object_array_clear().

I'll look into that one in the evening.

> As I suspect you're working your way through leak-checker results, I'm
> OK if you want to punt on digging into more cases for now and just fix
> ones that the tool has identified as real leaks.

I am indeed going through ASan results. Your UNLEAK helps immensely!
(I'm collecting UNLEAKs on the side. I see now that UNLEAK is in master,
so I should probably submit those where I believe things are
"UNLEAK-complete".)

Thanks for looking at this.

Martin
