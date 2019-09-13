Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81ACA1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 22:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403952AbfIMWLY (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 18:11:24 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58887 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403902AbfIMWLY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 18:11:24 -0400
X-Originating-IP: 1.186.12.20
Received: from localhost (unknown [1.186.12.20])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id EB85840002;
        Fri, 13 Sep 2019 22:11:21 +0000 (UTC)
Date:   Sat, 14 Sep 2019 03:41:19 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-gui: add hotkey to toggle "Amend Last Commit"
Message-ID: <20190913221119.552477ff3cl2q5pc@yadavpratyush.com>
References: <20190913143740.5zkrclivsvyj6k2o@yadavpratyush.com>
 <20190913211152.8860-1-birger.sp@gmail.com>
 <CAGr--=JhBYmYCJNNm8DyL+MKU0V0V-cwzH4WABX-dvE+uXNwDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=JhBYmYCJNNm8DyL+MKU0V0V-cwzH4WABX-dvE+uXNwDw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


+Cc Junio so you know what development model I'm using, and comment with 
your thoughts (if you want to).

On 13/09/19 11:32PM, Birger Skogeng Pedersen wrote:
> On Fri, Sep 13, 2019 at 4:37 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > Hi Birger,
> >
> > I'm afraid you are working on an older version of this patch. You should
> > be re-rolling [0], which works well with Bert's "amend check button"
> > change.
> >
> > [0] https://public-inbox.org/git/b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com/
> 
> Forgive me, I get a little bit confused. Should my patch be based on
> "next" or "master" branch?

For git-gui, ignore "next" for now. I considered using a model similar 
to Git where patches first get queued to "next" (or "pu" depending on 
how finished they are). And then after some time letting people use 
them, they are merged to "master" which eventually goes in the release. 
But this seems to be too complicated to me without any clear benefit.

I think for now using just "master" for git-gui should be fine, since I 
won't directly release git-gui. Instead I'll periodically ask Junio to 
pull changes from my master. This will be our "release". So essentially 
my "master" for now acts as a place for people involved in development 
to test out all the changes, and then the rest of the world gets the new 
version along with Git's release.

(Junio, you have done this for much longer than I have, so is there a 
major problem with my workflow?)

If all this seems too complicated, just work on top of my "master". The 
rest of it is mostly my problem.

> Also, is it an issue that this patch won't work unless you merge
> Bert's 1/2 patch[0]?

Your patch is dependent on Bert's patch. This means I will have to merge 
his patch first, and then yours. And that makes complete sense. That's 
how dependent changes should work. So no, it is not an issue that this 
patch won't work unless I merge Bert's patch first.

So while my advice above was to work on top of "master", that does not 
apply in this case since your patch is dependent on someone's patch 
which isn't in master yet. So in this specific case, you should base 
your patch on top of Bert's. Otherwise there are two problems:

- Your patch in and of itself makes little sense, it probably would 
  crash or do some unexpected stuff. This hurts people doing a bisect, 
  where if they land on your patch stuff is broken, and they have to 
  manually move a commit up or down to continue.

- Your patch will textually conflict with Bert's. That means I'd first 
  merge Bert's patch since yours doesn't work without his. But then when 
  I merge yours, I'd get a nasty merge conflict that is not easy to 
  resolve and leaves chances for a subtle bug.

> Your feedback cannot be too specific, I want to learn how to do this
> properly :-)

I'm not sure how well I explained this, so feel free to ask more 
questions if I didn't explain something properly :).
 
> [0] https://public-inbox.org/git/ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com/

-- 
Regards,
Pratyush Yadav
