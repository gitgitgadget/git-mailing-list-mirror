Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1CC21F6C1
	for <e@80x24.org>; Sun, 21 Aug 2016 14:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753226AbcHUOHS (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 10:07:18 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48358 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752976AbcHUOHR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 10:07:17 -0400
Received: from mfilter31-d.gandi.net (mfilter31-d.gandi.net [217.70.178.162])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id 53CEBA80C2;
        Sun, 21 Aug 2016 16:07:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter31-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter31-d.gandi.net (mfilter31-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id fQRKLgkfFTtH; Sun, 21 Aug 2016 16:07:12 +0200 (CEST)
X-Originating-IP: 65.158.186.241
Received: from x (unknown [65.158.186.241])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 266ADA80D1;
        Sun, 21 Aug 2016 16:07:11 +0200 (CEST)
Date:   Sun, 21 Aug 2016 07:07:10 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Richard <richard.maw@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Adding more namespace support to git
Message-ID: <20160821140710.qpbm37nhhvbkmxgz@x>
References: <CAB2VqoZh6zZV3Lk2B7dBPVE5h6H1LCwyxWrUo4yJFhqB=hAjig@mail.gmail.com>
 <20160821020537.eiyh4vnhmnuctgtz@x>
 <CAB2VqoZdj1rhdt-4gUhXTAMQjJTOqCuwXiO6yfB2Fzyy_qSWHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB2VqoZdj1rhdt-4gUhXTAMQjJTOqCuwXiO6yfB2Fzyy_qSWHg@mail.gmail.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 21, 2016 at 12:30:16PM +0100, Richard wrote:
> On 21 August 2016 at 03:05, Josh Triplett <josh@joshtriplett.org> wrote:
> > Unfortunately, I think at this point, GIT_NAMESPACE has to exclusively
> > refer to the namespace for the remote end, to avoid breakage.  Which
> > means any automatic pervasive support for namespaces on the local side
> > would need to use a different mechanism.  (In addition to applying to
> > ref enumeration, this would also need to apply to the local end of
> > refspecs.)  And this new mechanism would need to not affect the remote
> > end, to allow remapping the local end while accessing an un-namespaced
> > (or differently namespaced) remote.
> 
> The problem for hooks is that it is implicitly inherited,
> so it could work if upload-pack receive-pack and http-backend work
> with GIT_NAMESPACE set,
> but everything else that wants to use a namespace has to set
> --namespace on the command-line.

I'd like to see it work more automatically than that.  Perhaps a
separate environment variable to set the client-side namespace?
