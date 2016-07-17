Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B9D2018F
	for <e@80x24.org>; Sun, 17 Jul 2016 19:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbcGQTZh (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 15:25:37 -0400
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:44257 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbcGQTZg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 15:25:36 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id B444F486496
	for <git@vger.kernel.org>; Sun, 17 Jul 2016 21:20:26 +0200 (CEST)
Received: from mfilter27-d.gandi.net (mfilter27-d.gandi.net [217.70.178.155])
	by relay2-d.mail.gandi.net (Postfix) with ESMTP id CA663C5A5C;
	Sun, 17 Jul 2016 21:20:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter27-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter27-d.gandi.net (mfilter27-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id hvNe4HExtpfc; Sun, 17 Jul 2016 21:20:23 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 86EA2C5A4F;
	Sun, 17 Jul 2016 21:20:21 +0200 (CEST)
Date:	Sun, 17 Jul 2016 12:20:19 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: format-patch with pager.format-patch=true gets very confused
Message-ID: <20160717192019.GA29262@x>
References: <20160717025642.GA30640@x>
 <alpine.DEB.2.20.1607171438030.28832@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607171438030.28832@virtualbox>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 17, 2016 at 02:41:48PM +0200, Johannes Schindelin wrote:
> Hi Josh,
> 
> On Sat, 16 Jul 2016, Josh Triplett wrote:
> 
> > git-config(1) documents the ability to enable or disable the pager (or
> > set a command-specific pager) for any command by setting
> > pager.<cmd>=true.  For most commands, this seems to work as expected.
> > However, setting pager.format-patch=true (or setting it to any specific
> > pager) breaks badly: the pager spawns, with no output in it, and the
> > pager doesn't respond to keystrokes (which makes it difficult to quit).
> > 
> > I think this may occur because format-patch's "reopen_stdout" interacts
> > badly with the pager.
> > 
> > I think it makes sense for "format-patch --stdout" to respect
> > pager.format-patch, but for format-patch *without* stdout to ignore
> > pager.* and *never* spawn a pager, given that its only output (the list
> > of patch files) goes to "realstdout".
> 
> As per http://article.gmane.org/gmane.comp.version-control.git/299451,
> the `js/log-to-diffopt-file` patch series will be merged to `master` soon.
> This patch series avoids the reopen() altogether and should fix the
> problem you experience.
> 
> Since it is already in `next`, it should be relatively easy for you to
> build and confirm. Would you kindly do that?

I can confirm that that fixes the problem.  Thanks!

- Josh Triplett
