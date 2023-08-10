Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B064FC001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 11:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjHJLYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 07:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjHJLYb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 07:24:31 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5794010D
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 04:24:29 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 04C652427E;
        Thu, 10 Aug 2023 07:24:27 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qU3mF-304-00; Thu, 10 Aug 2023 13:24:27 +0200
Date:   Thu, 10 Aug 2023 13:24:27 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] sequencer: rectify empty hint in call of
 require_clean_work_tree()
Message-ID: <ZNTI6xpXIRaoFlxx@ugly>
References: <xmqqa5v2ehba.fsf@gitster.g>
 <20230809171531.2564829-1-oswald.buddenhagen@gmx.de>
 <xmqq7cq3lwli.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq7cq3lwli.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 02:44:25PM -0700, Junio C Hamano wrote:
>"git rebase" does not seem to start (i.e. does not perform "initial
>checkout") from a dirty working tree, with
>
>	error: cannot rebase: You have unstaged changes.
>	error: Please commit or stash them.
>
>at least from my quick attempt.  I am not sure if this is actually
>triggerble?
>
hmm, unless i'm missing something, it is apparently not ... currently.

it becomes actually relevant only after my "rebase: improve resumption 
from incorrect initial todo list" patch, which still needs reworking.

so there are several possibilities how to proceed with this:
- you merge it as a merely theoretical fix (adjust the commit message 
   yourself if saving the round-trip is more convenient for you)
- we postpone the change until it becomes not theoretical
- we make sure that the code really is not triggerable and delete it.  
   this would obviously introduce some churn, as i'll need to 
   re-introduce it. but then, i remember that something was wrong with it 
   anyway (i.e., it didn't actually trigger in some cases i expected it 
   to, but i haven't figured out yet why), so the new code would be 
   slightly different anyway.

regards
