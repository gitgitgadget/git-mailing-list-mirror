Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF9E202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 06:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbdJYGqV (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 02:46:21 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:45470 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdJYGqU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 02:46:20 -0400
Received: by mail-it0-f50.google.com with SMTP id n195so12898455itg.0
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 23:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zr1+0w4Fjr0s/3u+770hl4avq1j7nzb75oHTT8uwUwQ=;
        b=thI0llKF2q4oZshyrHb8/GCDz6+WOWhLyT90YsQBNrrv+UdV/AvO8jcjZC1uK+rNzl
         c0Th+7bPmErGt2oHpvmDhF6KjKrDuIrBzaNFFIsCa6nw77d6UEivzinM9JP6Gp6rSCKX
         /KwVbVla2S7CnCatsxZjCcgoxGbCCca7YPSuhxUl5YyHIexfBmKflP2W4J3z6z8Dwyg9
         q4RonqSz9rhGxd6rWSFGXY+ZDPQy0lqeOTRdIAThk0hDYlIL/Agr70ViFtRpwWSnLAvy
         V2Hr/7jv3sDX+8J9feYr7CxfpvA2fdGL/22G+5wwRpikShZ1Jx9Pl4mWSboQToUwGKWj
         sQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zr1+0w4Fjr0s/3u+770hl4avq1j7nzb75oHTT8uwUwQ=;
        b=kn6ZLzZxT4TDw+/GGbT6QmupS5QUJiRYl3lULa99TADg41v+3U2+27zl67l99KxIx0
         RgSHDFyfUQXuuwBU4n649LPse9dfb8NR7WLaL0yNP6l4BI5paONTc0ElcM5GRWNBywhk
         nddaurvI2OsCDOSr5nFCtUq+WKoBhcM5HHwmIxd1z0YsrHvCtU8tfKFuLZyE9fdxCP/O
         neDSBcgV09+BZWGfVjsIFwhdCGIAZxWrLyHBukhW6jL9mCE5o4C/d39d/5i39rvS0MPD
         l7UIrdVNsvrBpUaitFcay545wOOl9U587TbekwBqZRJ7JNlv6v7M+U+tqpSc81GAYgc2
         388Q==
X-Gm-Message-State: AMCzsaU1TgxuGGZsa2vaLOqdLkfXuYHYqww7/0bhMb8e3qogeYsTiEpi
        oOggmVxGneNT83d1QvmQHQawquTmZAHn4xWTGE4NDw==
X-Google-Smtp-Source: ABhQp+QQdNfOKaWdnH9NS8bQzVZA8yFeoKMoKDLWdTl4oV3c+BXjC0J0Gdj7y6GBcL5Flybsx58J3bimp50DOeZ3RnY=
X-Received: by 10.36.61.133 with SMTP id n127mr814031itn.106.1508913979143;
 Tue, 24 Oct 2017 23:46:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.174.66 with HTTP; Tue, 24 Oct 2017 23:46:18 -0700 (PDT)
In-Reply-To: <xmqqmv4fizyn.fsf@gitster.mtv.corp.google.com>
References: <20171024185332.57261-1-git@jeffhostetler.com> <xmqqmv4fizyn.fsf@gitster.mtv.corp.google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 24 Oct 2017 23:46:18 -0700
Message-ID: <CAGf8dg+cK3WpEqosgkbdcrDzrMXJxVYHiBZda6UM7k8Ggq=eBw@mail.gmail.com>
Subject: Re: [PATCH 00/13] WIP Partial clone part 1: object filtering
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 10:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> OK, thanks for working well together.  So does this (1) build on
> Jonathan's fsck-squelching series, or (2) ignores that and builds
> filtering first, potentially leaving the codebase to a broken state
> where it can create fsck-unclean repository until Jonathan's series
> is rebased on top of this, or (3) something else?  [*1*]

Excluding the partialclone patch (patch 9), I think that the answer is
(2), but I don't think that it leaves the codebase in a broken state.
In particular, none of the code modifies the repo, so it can't create
a fsck-unclean one.

Maybe one could say that this leaves the codebase with features that
no one will ever use in the absence of partial clone, but I don't
think that's true - rev-list with blob-size/sparse-specification
filter seems independently useful, at least (for example, when
desiring to operate on a repo in a sparse way without going through a
workdir), and if we're planning to allow listing of objects, we
probably should allow packing as well (especially since this doesn't
add much code).

The above is relevant only if we can exclude the partialclone patch,
but I think that we can and we should, as I wrote in my reply to Jeff
Hostetler [1].

As for how this patch set (excluding the partialclone patch) interacts
with my fsck series, they are relatively independent, as far as I can
tell. I'll rebase my fsck, gc, and lazy object fetch patches (but not
the fetch and clone parts, which we plan to instead adapt from Jeff
Hostetler's patches, as far as I know) on top of these and resend
those out once discussion on this has settled.

[1] https://public-inbox.org/git/CAGf8dg+8AR=XfSV92ODAtKTNjBnD1+oVZp9rs4Y4Otz_eZyTfg@mail.gmail.com/

> I also saw a patch marked as "this is from Jonathan's earlier work",
> taking the authorship (which to me implies that the changes were
> extensive enough), so I am a bit at loss envisioning how this piece
> fits in the bigger picture together with the other piece.

The patch you mentioned is the partialclone patch, which I think can
be considered separately from the rest (as I said above).
