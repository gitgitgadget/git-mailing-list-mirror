Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EFF2203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 07:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbcGZHOo (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 03:14:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59640 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbcGZHOo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 03:14:44 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EDC3203E1;
	Tue, 26 Jul 2016 07:14:43 +0000 (UTC)
Date:	Tue, 26 Jul 2016 07:14:43 +0000
From:	Eric Wong <e@80x24.org>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2016, #07; Mon, 25)
Message-ID: <20160726071443.GA24783@dcvr>
References: <xmqqh9bd2uy4.fsf@gitster.mtv.corp.google.com>
 <6E620FEE-7149-4A01-9146-A480FD985499@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6E620FEE-7149-4A01-9146-A480FD985499@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> wrote:
> On 26 Jul 2016, at 00:50, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > * ew/git-svn-http-tests (2016-07-25) 2 commits
> > - git svn: migrate tests to use lib-httpd
> > - t/t91*: do not say how to avoid the tests
> > 
> > Reuse the lib-httpd test infrastructure when testing the subversion
> > integration that interacts with subversion repositories served over
> > the http:// protocol.
> > 
> > Will merge to 'next'.
> 
> Do I understand correctly that this patch fixes $gmane/295291 ?
> Nice! Should we add "GIT_SVN_TEST_HTTPD=true" to the .travis.yml, then?

Maybe :)

Unfortunately, that currently causes the svn file:// tests (using the
same test numbers+files) to be skipped.  We should probably define new
test numbers and figure out a way to be able to always run file:// and
http:// (and svn://) tests.

On a side note, svn:// ought to be easy since svnserve supports --inetd
and we can let the kernel bind a random port.  We could be doing the
same with git-daemon --inetd, even...
