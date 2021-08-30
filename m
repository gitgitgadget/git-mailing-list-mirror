Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758E3C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CDBD60E98
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbhH3Sbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:31:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:16751 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238785AbhH3Sbi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 14:31:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218048747"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218048747"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 11:30:44 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="427923183"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 11:30:42 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mKm3L-00FmMz-Sp;
        Mon, 30 Aug 2021 21:30:39 +0300
Date:   Mon, 30 Aug 2021 21:30:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Greg Pflaum <greg.pflaum@pnp-hcl.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem accessing git.kernel.org with git v2.33 plus gitproxy
Message-ID: <YS0jzwsaRFaJnfo6@smile.fi.intel.com>
References: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
 <20210830180433.5rqqh7zsakbrfmrp@box>
 <YS0jopxToBW0g1Rm@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS0jopxToBW0g1Rm@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 09:29:54PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 30, 2021 at 09:04:33PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Aug 30, 2021 at 07:11:50PM +0300, Kirill A. Shutemov wrote:
> > > Hi folks,
> > > 
> > > I've stepped on a problem after upgrading git to v2.33.0. git fetch-pack
> > > fails with an error:
> > > 
> > >         fetch-pack: unexpected disconnect while reading sideband packet
> > > 
> > > It only happens when I access git.kernel.org over git:// (github over
> > > git:// works fine) and if there's a gitproxy configured.
> > > 
> > > For test I used a dummy gitproxy:
> > > 
> > >         #!/bin/sh -efu
> > >         socat - "TCP:$1:$2"
> > > 
> > > It is enough to trigger the issue.
> > > 
> > > I'm not sure if it's kernel.org problem or git problem.
> > > 
> > > Has anybody else stepped on the issue? Any clues?
> > 
> > I've bisected the issue to commit
> > 
> > 	ae1a7eefffe6 ("fetch-pack: signal v2 server that we are done making requests")
> 
> Thanks, Kirill!
> 
> Are you going to report it to the Git community?

Just realized that this discussion is in the Git community :-)

-- 
With Best Regards,
Andy Shevchenko


