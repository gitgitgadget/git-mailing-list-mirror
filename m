Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970361F461
	for <e@80x24.org>; Tue, 20 Aug 2019 19:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfHTT3t (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 15:29:49 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37391 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbfHTT3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 15:29:49 -0400
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 74625240004;
        Tue, 20 Aug 2019 19:29:47 +0000 (UTC)
Date:   Wed, 21 Aug 2019 00:59:45 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-gui: Add the ability to revert selected lines
Message-ID: <20190820192944.gzfwnm52fvb5refq@localhost.localdomain>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190819214110.26461-3-me@yadavpratyush.com>
 <73e63382-4f79-cfd0-47f4-812f9cd4f88b@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73e63382-4f79-cfd0-47f4-812f9cd4f88b@kdbg.org>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/19 09:21PM, Johannes Sixt wrote:
> Am 19.08.19 um 23:41 schrieb Pratyush Yadav:
> > Just like the user can select lines to stage or unstage, add the
> > ability to revert selected lines.
> > 
> > Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> 
> > +	if {$revert} {
> > +		set query "[mc "Revert changes in file %s?" \
> > +			[short_path $current_diff_path]]
> > +
> > +[mc "The selected lines will be permanently lost by the revert."]"
> > +
> > +		set reply [revert_dialog $query]
> 
> Please don't do this. This confirmation dialog is unacceptable in my
> workflow. I use reversals of hunks and lines frequently, almost like a
> secondary code editor. My safety net is the undo function of the IDE,
> which works across reloads that are triggered by these external edits.
> These confirmations get in the way.
 
But not everyone uses an IDE. I use vim and it does not have any such 
undo feature that works across reloads. Not one I'm aware of anyway. It 
is absolutely necessary IMO to ask the user for confirmation before 
deleting their work, unless we have a built in safety net.

So how about adding a config option that allows you to disable the 
confirmation dialog? Sounds like a reasonable compromise to me.

> > +		if {$reply ne 1} {
> > +			unlock_index
> > +			return
> > +		}
> > +	}
> > +
> >  	set wholepatch {}
> >  
> >  	while {$first_l < $last_l} {
> > 
> 
> -- Hannes

-- 
Regards,
Pratyush Yadav
