Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2655E1F4C1
	for <e@80x24.org>; Tue, 29 Oct 2019 21:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfJ2VcI (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 17:32:08 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:37485 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfJ2VcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 17:32:08 -0400
Received: from localhost (unknown [1.186.12.13])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 11469100005;
        Tue, 29 Oct 2019 21:32:04 +0000 (UTC)
Date:   Wed, 30 Oct 2019 03:02:03 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-gui: remove unused global declarations
Message-ID: <20191029213202.67mmtd3lo324bhmx@yadavpratyush.com>
References: <20191025013255.7367-1-me@yadavpratyush.com>
 <20191025013255.7367-2-me@yadavpratyush.com>
 <xmqq1rv1eaz1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rv1eaz1.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/10/19 12:54PM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
> >  proc next_diff {{after {}}} {
> > -	global next_diff_p next_diff_w next_diff_i
> > +	global next_diff_p next_diff_w
> >  	show_diff $next_diff_p $next_diff_w {} {} $after
> >  }
> 
> Not in particular about next_diff_i, but seeing a hunk like this
> makes me wonder if you want to go the other way around.  If a future
> fix needs to (re)introduce the use of next_diff_i global variable in
> this proc (it seems that there are two procs that declare the
> variable as global, one of which is this one, and the other one
> assigns to it), the code change must resurrect this declaration;
> otherwise the code would only confuse itself by potentially having
> two variables (one global, one local) with the same name, no?

I'm not sure what you mean by this. Do you mean we should keep 
next_diff_i global, or do you mean we should instead convert it to a 
local variable?

Or is it related to similar sounding variable names (next_diff_i, 
next_diff_w, next_diff_p), which appear in multiple functions together?
 
> For next_diff_i in particular, I think the right solution would be
> to remove both global decl and the assignment, as the assignment is
> made to otherwise unused variable.  But the primary point in such a
> change is not "remove unused global decl"; it is "remove unused
> variable".

Thanks for spotting it! Will fix.

-- 
Regards,
Pratyush Yadav
