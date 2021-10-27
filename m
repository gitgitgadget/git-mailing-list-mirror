Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76E2C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFD2610F8
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbhJ0IKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:10:40 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:23405 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240761AbhJ0IKj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:10:39 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4HfLsm0t0Dz5tlG;
        Wed, 27 Oct 2021 10:08:11 +0200 (CEST)
Subject: Re: Unexpected cat-file --batch-check output
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CAGyf7-HFGgkXsA-MXBOdiogDid+=F8jmqw0zxwQoUzha-jc1Hw@mail.gmail.com>
 <YXcC8jQbFsaqYN2M@coredump.intra.peff.net>
 <CAGyf7-Gaphb9q=4cyT0BQa7oYGKXQQsU-XfqvoxfDyijehJO3Q@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ad21b3f5-d352-64f4-0dd2-5ad1e839193a@kdbg.org>
Date:   Wed, 27 Oct 2021 10:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGyf7-Gaphb9q=4cyT0BQa7oYGKXQQsU-XfqvoxfDyijehJO3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.10.21 um 01:58 schrieb Bryan Turner:
> $ /usr/bin/git rev-parse refs/heads/develop
> 28a05ce2e3079afcb32e4f1777b42971d7933a91
> $ /usr/bin/git rev-parse refs/heads/develop:path/to/parent/file
> cc10f4b278086325aab2f95df97c807c7c6cd75e
> 
> So it looks like rev-parse and cat-file --batch-check both exhibit the
> same behavior.
> 
> I also had them expand their cat-file --batch-check to include another
> file in the same "path/to/parent" directory:
> $ echo 'refs/heads/develop
> refs/heads/develop:path/to/parent/sibling
> refs/heads/develop:path/to/parent/file' | /usr/bin/git cat-file --batch-check
> 28a05ce2e3079afcb32e4f1777b42971d7933a91 commit 259
> 2bfe7b4b7c7cdeb9653801d99b65dfefe5780dda blob 897
> cc10f4b278086325aab2f95df97c807c7c6cd75e commit 330
> 
> So the "sibling" file in the same directory comes out as a "blob", as expected.
> 
> They also ran an ls-tree for the directory without any globs:
> # /usr/bin/git ls-tree refs/heads/develop:path/to/parent
> 100644 blob 2bfe7b4b7c7cdeb9653801d99b65dfefe5780dda    sibling
> 100644 blob 4c8d566ed80a1554a059b97f7cd533a55bbd2ea8    file

Just a shot in the dark: what happens when you use /usr/bin/git
--no-replace-objects?

-- Hannes
