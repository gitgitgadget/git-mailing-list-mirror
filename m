Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C23C1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 19:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfJUTEz (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 15:04:55 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:53113 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfJUTEz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 15:04:55 -0400
X-Originating-IP: 1.186.12.46
Received: from localhost (unknown [1.186.12.46])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9A395FF802;
        Mon, 21 Oct 2019 19:04:50 +0000 (UTC)
Date:   Tue, 22 Oct 2019 00:34:48 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 4/4] git-gui: allow undoing last revert
Message-ID: <20191021190448.34vs3zsqvqc5hryl@yadavpratyush.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190828215725.13376-1-me@yadavpratyush.com>
 <20190828215725.13376-5-me@yadavpratyush.com>
 <CAKPyHN0Kh8eKjzXink3YtE6wRrOgpzTYyPmLnbpbxPt3LFsvig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN0Kh8eKjzXink3YtE6wRrOgpzTYyPmLnbpbxPt3LFsvig@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/10/19 11:16AM, Bert Wesarg wrote:
> Dear Pratyush,
> 
> I just noticed that the 'Revert Last Hunk' menu entry is enabled in
> the stage-list. But I think it should be disabled, like the 'Revert
> Hunk' and 'Revert Line' menu entry.

I'm not sure what you mean. There is no "Revert Last Hunk" menu entry (I 
assume you are talking about the context menu in the diff view that we 
open by right clicking).

My guess is that you mean the "Undo Last Revert" option. And you want it 
disabled if the diff shown is of a staged file, correct?

I'm not sure if disabling it would be a good idea.

Say I revert a hunk or line while the file is not staged, and stage the 
rest of the file. This would mean that file is no longer in the 
"Unstaged Changes" widget. Now if I choose the file from the "Staged 
Changes" widget, I get the option to undo the last revert. If I hit 
that, it will put whatever I reverted in the "Unstaged Changes" widget. 
So, now part of the file that was reverted is in "Unstaged Changes", and 
the rest in "Unstaged Changes".

IIUC, this is what you think should not happen, correct? What's wrong 
with allowing the user to undo reverts from anywhere?

The way I see it, it doesn't really matter what file is selected or 
whether it is staged or not, the action of the undo remains the same, so 
it makes sense to me to allow it from anywhere.
 
> Can you confirm this?
> 
> On Wed, Aug 28, 2019 at 11:57 PM Pratyush Yadav <me@yadavpratyush.com> 
> wrote:
> >
> > Accidental clicks on the revert hunk/lines buttons can cause loss of
> > work, and can be frustrating. So, allow undoing the last revert.
> >
> > Right now, a stack or deque are not being used for the sake of
> > simplicity, so only one undo is possible. Any reverts before the
> > previous one are lost.
> >
> > Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>

-- 
Regards,
Pratyush Yadav
