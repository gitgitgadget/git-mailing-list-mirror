Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6532EB64DD
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 09:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349518AbjHQJYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 05:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349514AbjHQJYb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 05:24:31 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C82271B
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 02:24:29 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 1AFD724309;
        Thu, 17 Aug 2023 05:24:26 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qWZEw-LEP-00; Thu, 17 Aug 2023 11:24:26 +0200
Date:   Thu, 17 Aug 2023 11:24:26 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [Leftoverbits] exit code clean-up?
Message-ID: <ZN3nSsGOHMDQZ438@ugly>
References: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
 <fe028981d353158e9840eb035194ca15e6a2c15e.1692165840.git.ps@pks.im>
 <xmqqjztvezen.fsf@gitster.g>
 <xmqqsf8iex5v.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqsf8iex5v.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2023 at 10:04:28AM -0700, Junio C Hamano wrote:
>"git help git" does not have "EXIT CODES" section, and it is assumed 
>that the "common sense" of older generation [...] that exiting with 0 
>is success and non-zero is failure is shared among its users, which 
>might not be warranted these days.
>
well, that's actually a standard (exit(3) has things to say about it), 
and given how shell scripts treat exit codes, there is no wiggle room 
here. just about every shell intro tutorial explains it.

>We could either
>
> * Be more prescriptive and add "EXIT CODES" section to each and
>   every document to describe how we fail in the current code.
>
>or
>
> * Describe "In general, 0 is success, non-zero is failure, but some
>   commands may signal more than that with its non-zero exit codes"
>   in "git help git", and add "EXIT CODES" section to the manual
>   page of the commands whose exit codes matter (there are a
>   handful, like "git diff --exit-code" that explicitly says "1" is
>   the signal that it found difference as opposed to it failing).
>
i'd go with the second, with some minor modifications:
- 1 is the by far most common non-zero error code (and it matches 
   EXIT_FAILURE on all relevant systems), so it's ok to state that. it 
   may be wise to actually check that commands don't deviate from it 
   needlessly.
- the canonical name of the section appears to be "EXIT STATUS"

regards
