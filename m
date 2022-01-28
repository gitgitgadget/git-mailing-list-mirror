Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF7BC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 06:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbiA1GHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 01:07:15 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:35108 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242330AbiA1GHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 01:07:15 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id DD7081F852;
        Fri, 28 Jan 2022 06:07:14 +0000 (UTC)
Date:   Fri, 28 Jan 2022 06:07:14 +0000
From:   Eric Wong <e@80x24.org>
To:     John Cai <johncai86@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, me@ttaylorr.com,
        phillip.wood123@gmail.com
Subject: Re: [RFC v2] cat-file: add a --stdin-cmd mode
Message-ID: <20220128060714.M764085@dcvr>
References: <20220125225008.45944-1-johncai86@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125225008.45944-1-johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> wrote:
> This RFC patch proposes a new flag --stdin-cmd that works with
> git-cat-file --batch. Similar to git-update-ref --stdin, it will accept
> commands and arguments from stdin.
> 
> The start of this idea was discussed in [1], where the original
> motivation was to be able to control when the buffer was flushed to
> stdout in --buffer mode.
> 
> However, this can actually be much more useful in situations when
> git-cat-file --batch is being used as a long lived backend query
> process. At GitLab, we use a pair of cat-file processes. One for
> iterating over object metadata with --batch-check, and the other to grab
> object contents with --batch. However, if we had --stdin-cmd, we could
> get rid of the second --batch-check process, and just have one progress
> where we can flip between getting object info, and getting object contents.
> This can lead to huge savings.

Cool.  I wish I had this back when I worked on a project which uses git.
In case I ever continue, having 2-3 features in git itself would be useful:

1) ability to add new alternates / object directories on-the-fly
2) ability to deal with unlinked packs

And maybe:

3) ability to remove alternates

I've implemented 1 and 2 via libgit2; but not yet 3 (not really
important, atm).

Thanks.
