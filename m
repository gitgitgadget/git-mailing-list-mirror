Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04B1F20964
	for <e@80x24.org>; Thu, 23 Mar 2017 17:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964990AbdCWRb6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:31:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35356 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933005AbdCWRb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:31:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 454DA20958;
        Thu, 23 Mar 2017 17:31:56 +0000 (UTC)
Date:   Thu, 23 Mar 2017 17:31:56 +0000
From:   Eric Wong <e@80x24.org>
To:     Craig McQueen <craig.mcqueen@innerrange.com>
Cc:     git@vger.kernel.org
Subject: Re: git svn and SVN property svn:original-date
Message-ID: <20170323173156.GA29732@starla>
References: <5500469A22567C4BAF673A6E86AFA3A40295E65B42D1@IR-CENTRAL.corp.innerrange.com>
 <20170323025623.GA14619@starla>
 <5500469A22567C4BAF673A6E86AFA3A40295E65B4365@IR-CENTRAL.corp.innerrange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5500469A22567C4BAF673A6E86AFA3A40295E65B4365@IR-CENTRAL.corp.innerrange.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Craig McQueen <craig.mcqueen@innerrange.com> wrote:
> Eric Wong wrote:
> > Craig McQueen <craig.mcqueen@innerrange.com> wrote:
> > > Apparently SVN revisions can have an "svn:original-date" property, which
> > would be good to set on dcommit, to preserve the timestamp from the git
> > repository.
> > >
> > >
> > https://subversion.apache.org/docs/api/1.7/group__svn__props__revision
> > > __props.html#ga8f17351dd056149da9cb490f1daf4018
> > 
> > Any idea if which versions of SVN it's supported in and how recent the
> > feature is?
> 
> I see discussion about it in 2003, so I guess it's been there right from 1.0.0.
> 
> > Perhaps we can enable it everywhere, and maybe only old clients won't
> > understand it, but won't fail; and we could start using it as the author date
> > with "git svn fetch".
> 
> Using it for author date sounds sensible.

OK, I'd be inclined to accept a patch + tests for that;
my plate might be full with non-git stuff until April.

> > OTOH, that would break the (perhaps unofficial) independently-created-git-
> > svn-mirrors-should-have-same-oids-by-default
> > rule when people run different versions of git, so maybe it could be an
> > option...
> 
> Hmm, good question. Maybe it should be an option, though I
> hope it would be enabled by default (since the feature would
> be more metadata-preserving, which is a good thing), with an
> option to disable it to allow backwards compatibility with
> people running an older version of git. That's my opinion
> anyway, and I realise my opinion is not necessarily
> well-informed regarding all considerations.

Given git-svn behavior hasn't changed much in over a decade, I'd
rather be conservative with regards to changing any existing
behavior.  We could offer one warning about it to inform users
about it if original-date is seen, however.

> Note, I'm unclear as to whether Subversion is willing to store
> timezone information in svn:original-date. But I guess having
> git author date correspond to svn:original-date is an
> improvement for preserving more metadata, even if the timezone
> is lost in the process.

Can you find any examples of it in the wild?  I prefer having
real-world examples to look at.  Thanks.
