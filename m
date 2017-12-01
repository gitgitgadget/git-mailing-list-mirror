Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B8E620C11
	for <e@80x24.org>; Fri,  1 Dec 2017 02:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbdLAC4C (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 21:56:02 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39510 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752135AbdLAC4B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 21:56:01 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E90F320C11;
        Fri,  1 Dec 2017 02:56:00 +0000 (UTC)
Date:   Fri, 1 Dec 2017 02:56:00 +0000
From:   Eric Wong <e@80x24.org>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] t/lib-git-svn.sh: improve svnserve tests with
 parallel make test
Message-ID: <20171201025600.GA29213@starla>
References: <20171201023239.26153-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171201023239.26153-1-tmz@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> wrote:
> These tests are not run by default nor are they enabled in travis-ci.  I
> don't know how much testing they get in user or other packager builds.
> 
> I've been slowly increasing the test suite usage in fedora builds.  I
> ran into this while testing locally with parallel make test.  The
> official fedora builds don't run in parallel (yet), as even before I ran
> into this issue, builds on the fedora builders randomly failed too
> often.  I'm hoping to eventually enable parallel tests by default
> though, since it's so much faster.

Cool.

> I'm not sure if there's any objection to changing the variable needed to
> enable the tests from SVNSERVE_PORT to GIT_TEST_SVNSERVE.  The way
> SVNSERVE_PORT is set in this patch should allow the port to be set
> explicitly, in case someone requires that -- and they understand that it
> can fail if running parallel tests, of course.  Whether that's a
> feature or a bug, I'm not sure. :)

I'm fine with this for now.  Since svnserve (and git-daemon)
both support inetd behavior, I think we can eventually have a
test helper which binds random ports and pretends to be an
inetd, letting the test run without any special setup.

It would let multiple test instances run in parallel, even.

> The indentation of lib-git-svn.sh didn't use tabs consistently, in only
> a few places, so I cleaned that up first.  I can drop that change if
> it's unwanted.

Fine by me.
