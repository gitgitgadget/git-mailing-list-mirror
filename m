Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCCAE1FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 08:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbcF2IMB (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 04:12:01 -0400
Received: from plane.gmane.org ([80.91.229.3]:55739 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbcF2IL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 04:11:59 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bIAbD-0007gM-QP
	for git@vger.kernel.org; Wed, 29 Jun 2016 10:11:56 +0200
Received: from 147.114.44.200 ([147.114.44.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 10:11:55 +0200
Received: from ioannis.kappas by 147.114.44.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 10:11:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Ioannis Kappas <ioannis.kappas@rbs.com>
Subject: Re: git svn clone segmentation faul issue
Date:	Wed, 29 Jun 2016 08:11:38 +0000 (UTC)
Message-ID: <loom.20160629T095219-589@post.gmane.org>
References: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net> <20160628194804.GA3653@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 147.114.44.200 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; Trident/7.0; rv:11.0) like Gecko)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Eric,

Eric Wong <e <at> 80x24.org> writes:

> 
> Ioannis.Kappas <at> rbs.com wrote:
> > Fortunately, a patch has already been submitted to subversion
> > with (github) revision
> > a074af86c8764404b28ce99d0bedcb668a321408 (at
> > 
https://github.com/apache/subversion/commit/a074af86c8764404b28ce99d0bedcb66
8a321408
> > ) on the trunk to handle this and a couple of other similar
> > cases. But by the looks of it has not been picked up yet in
> > the latest subversion 1.9.4 release or the 1.9.x branch,
> > perhaps because this patch was identified in sanity checks
> > rather than coming out from a perceivable production issue?
> 
> Thank you for documenting this.  Curious, does this affect older
> SVN versions or only 1.9.x?

It does not appear so, at least not in the degree of failures that I am 
seeing it now, i.e. failing consistently. It only came to my attention 
after I upgraded to the latest git/perl/subversion release from a version 
that was more than a year's old.

Given that the issue is with corruption in the perl interpreter stack, I 
suspect is due to one, or combination, of the following:

- git in latest releases makes additional perl subversion calls, thus 
affecting the perl stack usage.
- perl in latest releases affected the stack allocation profile.
- subversion perl module in latest releases refactored/added new calls that 
has changed the perl stack usage.

> 
> I don't know Perl internals well or SWIG at all; so reports
> like these are very much appreciated.
> 

Thanks



