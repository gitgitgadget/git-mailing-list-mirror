Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04A6202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 16:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753427AbdGLQBq (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 12:01:46 -0400
Received: from ms-fb53.so-net.ne.jp ([202.238.84.157]:19798 "EHLO
        ms-fb53.so-net.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753177AbdGLQBq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 12:01:46 -0400
X-Greylist: delayed 4552 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jul 2017 12:01:45 EDT
Received: from ms-omx53.so-net.ne.jp (ms-omx53.plus.so-net.ne.jp [10.240.84.98])
        by ms-fb53.so-net.ne.jp  with ESMTP id v6CEjrCR020173
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 23:45:54 +0900
Received: from ms-omx61.so-net.ne.jp (ms-omx61.plus.so-net.ne.jp [10.240.84.163])
        by ms-omx53.plus.so-net.ne.jp  with ESMTP id v6CEjkUf019706;
        Wed, 12 Jul 2017 23:45:46 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tc4.so-net.ne.jp;
        s=sn2017; t=1499870746;
        bh=GN2BYJrONemGicfOzfxX6xVqktx6w9Q7S6Zf+V5bbWA=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=EbhLaMghN0LLbjc4XiExgpeFAoH2DfWn2zunejNq6jioieZ0pZa4bx3i0IOYOuzCK
         ncoTwmrEr72XO3EvxoQOYiKQB2aZI740QnUnDAzb0AISSRQkiHozngPhO9TE6tUFfd
         popCf6ZlsXbjOIiOFbGhiGUDxw1/+ywlg2bftE39RrAHXIivqtPF2Rd9Jl1k+8Eyy9
         tsjFAcP32aWZiijchUIN12J6fODrb2qEcclj0kxXDeg8rXis45ffvOiglEELtnIrz5
         Fd0MZh1TF6XThQfbH6PKYOtXOaGkq+vlvmM9ucH6ZNikyqU2FptlSPQLqX6rA88zzm
         ZZQsqFOm7R6MQ==
Received: from goofy.localdomain ([IPv6:240f:f:1023:1:71ac:83be:141b:873b])
        (authenticated)
        by ms-omx61.plus.so-net.ne.jp  with ESMTP id v6CEjk63018006
        (using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
        Wed, 12 Jul 2017 23:45:46 +0900
Received: from osamu by goofy.localdomain with local (Exim 4.89)
        (envelope-from <osamu.aoki@tc4.so-net.ne.jp>)
        id 1dVIte-0002mI-Hd; Wed, 12 Jul 2017 23:45:46 +0900
Date:   Wed, 12 Jul 2017 23:45:46 +0900
From:   Osamu Aoki <osamu.aoki@tc4.so-net.ne.jp>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: git <-> cvs synch script with git cvsexportcommit -W
Message-ID: <20170712144546.ac3pvwe3jwxqf675@tc4.so-net.ne.jp>
References: <20150713123855.GA3773@goofy.local>
 <alpine.DEB.2.21.1.1707121540460.4193@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1707121540460.4193@virtualbox>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is my old mail with updated pointer.  This may be useful for people
to migrate git to cvs while keeping cvs up-to-date.

On Wed, Jul 12, 2017 at 03:41:58PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 13 Jul 2015, Osamu Aoki wrote:
> 
> > Thanks for "git cvsexportcommit -W" feature.
> >   http://git.kernel.org/cgit/git/git.git/commit/?id=d775734c40afed216160437c59a45c93bdf28689
> > 
> > It took me a while to get this working right.  I may have made a bit of
> > error in the way, but it looks like I need to have 
> > 
> >  $ cat .git/info/exclude
> > CVS
> > 
> > to avaid error when commiting more than 2 commts.  Is this what you
> > expect?
> > 
> > I am trying to emulate git-svn for CVS using this and others.  I am
> > making a first trial script as seen at:
> >   https://wiki.debian.org/CvsusingGit
> >   https://people.debian.org/~osamu/git-cvs.sh (my current trial script.)

Since then I updated wiki page and then moved script to github.

https://github.com/osamuaoki/git-cvs

> Sorry, this completely slipped through and bit-rotted in my inbox for two
> years (there are still 2,000+ friends in my inbox that paid your mail
> company).

Oh, well happens.

> Would you mind sending a mail about git-cvs.sh to git@vger.kernel.org for
> much wider visibility?

OK.  Here we go.

Osamu
