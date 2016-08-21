Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46CF11FD99
	for <e@80x24.org>; Sun, 21 Aug 2016 01:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbcHUBat (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 21:30:49 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52370 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbcHUBat (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 21:30:49 -0400
Received: from mfilter45-d.gandi.net (mfilter45-d.gandi.net [217.70.178.176])
        by relay4-d.mail.gandi.net (Postfix) with ESMTP id A6371172098
        for <git@vger.kernel.org>; Sun, 21 Aug 2016 03:30:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter45-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
        by mfilter45-d.gandi.net (mfilter45-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id IoQwFapDvIGd for <git@vger.kernel.org>;
        Sun, 21 Aug 2016 03:30:45 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9ACC8172095
        for <git@vger.kernel.org>; Sun, 21 Aug 2016 03:30:44 +0200 (CEST)
Date:   Sat, 20 Aug 2016 18:30:42 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     git@vger.kernel.org
Subject: Re: Most recent revision that contains a string
Message-ID: <20160821013040.4sfmg2v7rcovxxmb@x>
References: <87d1l3ce40.fsf@thinkpad.rath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d1l3ce40.fsf@thinkpad.rath.org>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 20, 2016 at 02:41:35PM -0700, Nikolaus Rath wrote:
> Hello,
> 
> What's the easiest way to find the most recent revision (of any file in
> the repository, including those that have been deleted in the current
> HEAD) that contains a given string?
> 
> I was hoping that "git grep" would do this (like in Mercurial), but as
> far as I can tell it only greps through the working copy. Or is there a
> trick that I'm missing?

git grep can search through any arbitrary blob, tree, commit, or tag.
So you can search through HEAD~10, or HEAD~10:path/to/directory, or
HEAD~10:path/to/file.  (You can also search the index with --cached, and
various other options exist as well.)

If you want to find a change that introduces or removes a particular
string, you could use "git log -S".  That doesn't allow regexes, but it
might do what you want.  "git grep" will find occurrences of the string
in the current version, and if it has been removed, "git log -S" will
find the removal.

I don't know of any way to do that in one file-oriented step, searching
backward through the first occurrence of every path, including deleted
paths.
