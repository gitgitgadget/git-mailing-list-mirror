Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453CB1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 22:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404871AbfHVWvt (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 18:51:49 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49227 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732657AbfHVWvt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 18:51:49 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2EEAEC0002;
        Thu, 22 Aug 2019 22:51:45 +0000 (UTC)
Date:   Fri, 23 Aug 2019 04:21:43 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v2 0/4] git-gui: Add ability to revert selected hunks and
 lines
Message-ID: <20190822225143.3blolae3f65z6zqq@localhost.localdomain>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190822220107.4153-1-me@yadavpratyush.com>
 <xmqq4l28ommg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4l28ommg.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/19 03:34PM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
> > This series adds the ability to revert selected lines and hunks in
> > git-gui. Partially based on the patch by Bert Wesarg [0].
> >
> > The commits can be found in the topic branch 'py/revert-hunks-lines'
> > at https://github.com/prati0100/git-gui/tree/py/revert-hunks-lines
> >
> > Once reviewed, pull the commits from
> > 415ce3f8582769d1d454b3796dc6c9c847cefa87 till
> > 0a1f4ea92b97e673fda40918dae68deead43bb27, or just munge the patches and
> > apply them locally, whichever you prefer.
> 
> Let's see how we can work together by you playing the role of
> git-gui maintainer and the others on the list (including me) playing
> the role of reviewer and contributor.  So I may keep an eye on the
> discussion on this thread, I may even comment on them myself, but
> you'll be the one waiting for the discussion to settle, adjusting
> the patches in response to reviews, etc. and making the final
> decision when/if the topic is done, at which time you'd be telling
> me to pull from you.
> 
> > Pratyush Yadav (4):
> >   git-gui: Move revert confirmation dialog creation to separate function
> >   git-gui: Add option to disable the revert confirmation prompt
> >   git-gui: Add the ability to revert selected lines
> >   git-gui: Add the ability to revert selected hunk
> 
> "Move" and "Add" after "git-gui:" would better be downcased to be
> more in line with the others in "git shortlog --no-merges"; I also
> think "allow doing X" is shorter and better way to say "add the
> ability to do X".

Will fix. Thanks.

> If I am reading the first patch correctly, we already ask for
> confirmation before reverting local changes, and the steps 3 and 4
> are about allowing partial reversion in addition to the wholesale
> reversion, right?

Yes. The ability to revert whole files already exists. This revert 
always asks for confirmation. Steps 3 and 4 allow for partial reverts.  
Step 2 allows the user to disable the confirmation dialog for both 
whole-file reverts and for partial reverts.

> An earlier objection from j6t sounded like we
> require users to respond to an extra dialog after this series, but
> that does not look like the case.  Instead, step 2 adds a new
> feature to allow those to opt-out of the existing dialog (which may
> be reused to squelch the dialog to protect features added in steps 3
> and 4).  Am I reading the series correctly?

Yes. The users always responded to an extra dialog for whole file 
reverts even before these changes. j6t was running a fork of git-gui 
which had the ability for partial reverts, and his fork did not ask for 
confirmation for partial reverts. Always asking for confirmation 
disrupts his workflow, so I added an option to disable it. It disables 
the dialog for partial reverts (which j6t cares about), and also for 
whole file reverts, which I added to maintain consistency.

> 
> Thanks.
> 
> >
> >  git-gui.sh     | 40 +++++++++++++++++++++++++++++--
> >  lib/diff.tcl   | 65 ++++++++++++++++++++++++++++++++++++++++++--------
> >  lib/index.tcl  | 31 ++++++++++++++++--------
> >  lib/option.tcl |  1 +
> >  4 files changed, 115 insertions(+), 22 deletions(-)
> >
> > --
> > 2.21.0

-- 
Regards,
Pratyush Yadav
