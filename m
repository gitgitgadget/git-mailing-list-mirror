Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E58D1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 17:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754868AbeBGR3H (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 12:29:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50143 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754789AbeBGR3G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 12:29:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46FFDC142B;
        Wed,  7 Feb 2018 12:29:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=1stJ1AndDL9W9hKGyTcEJ+zBau8=; b=xkGcBnG
        nX5W6ExX/oaj+UMhmArr4BfGfrhJvFM6eb3XDvmiKBLzAtdOWOLPHj8LMqGlGO3Y
        toGQU7UOVE7AqIwwGOYL0UPv/1cgQobn4CPw+poWCOdnOO/CWL0ksDiiKdvL22yf
        Ab0i7RGm/tis2yX7pteYQyt/jL0MUiW9rQq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=PqWydUVKlHREHjW8VbzVBwsj2id4FWrlo
        61KP5Hus/7H1fqEcVLije+sBA9hBEBPAoUDCCF90EMe4v9xgI9EDz0BvK5K1pu9B
        LUzMzC4yQp5PWTkTc3HWt2yBJ7jkY1pzIPbiwl/MQSVlDweUHrPmvTAylfnAFylh
        6tEjN7tLK8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F5D9C142A;
        Wed,  7 Feb 2018 12:29:05 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE107C1427;
        Wed,  7 Feb 2018 12:29:04 -0500 (EST)
Date:   Wed, 7 Feb 2018 12:29:02 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: categorization, documentation and packaging of "git core"
 commands
Message-ID: <20180207172902.GL1427@zaya.teonanacatl.net>
References: <alpine.LFD.2.21.1802070801470.19185@android-a172fe96dd584b41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1802070801470.19185@android-a172fe96dd584b41>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Pobox-Relay-ID: 650BBED6-0C2C-11E8-9B9D-D3940C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert P. J. Day wrote:
> first, here are the executables under /usr/libexec/git-core/ that
> are unreferenced by that web page, but that should be fine as almost
> all of them would be considered underlying helpers or utilities
> (except for things like git-subtree, but we're still unclear on its
> status, right?):

I don't think there's anything unclear about git subtree's
status.  It's in contrib/ within the source, so it's not
part of the core git suite.  Some distributions (Fedora
being one of them) ship a git-subtree package to provide it
for users who want it.

> on the other hand (and this is not so much a git issue as a fedora
> packaging issue), there are a number of command links at that web page
> that are supplied by distinct RPM packages rather than by the basic
> fedora git package, so one would need to install the following
> packages to get some of those commands on fedora:
> 
>   * gitk
>   * git-cvs
>   * git-svn
>   * git-p4
>   * git-email (provides git-send-email)

These packages are in separate sub-packages in Fedora (and
some other distributions) because they are no required by
all users and they pull in dependencies which are not wanted
on minimal installs.  In Fedora, you can install git-all to
get all the available git sub-packages.

> finally, from fedora, i am utterly unable to find a package that
> provides git-archimport. pretty sure fedora used to have a "git-arch"
> package but it's not there now.

It hasn't been in Fedora since 2011.  The tla command which
is required for git-archimport  was retired, thus we removed
the git-arch package.  The rpm changelog shows this:

* Tue Jul 26 2011 Todd Zullinger <tmz@pobox.com> - 1.7.6-4
- Drop git-arch on fedora >= 16, the tla package has been retired

As does the git history for the package:

    https://src.fedoraproject.org/rpms/git/c/3f0dc974fa

The tla package was retired because it failed to build for
several releases:

    https://src.fedoraproject.org/rpms/tla/blob/master/f/dead.package

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Going to trial with a lawyer who considers your whole life-style a
Crime in Progress is not a happy prospect.
    -- Hunter S. Thompson

