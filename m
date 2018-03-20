Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EFBD1FAE2
	for <e@80x24.org>; Tue, 20 Mar 2018 22:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCTWHo (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 18:07:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53372 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751484AbeCTWHo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 18:07:44 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BAFCF1F404;
        Tue, 20 Mar 2018 22:07:43 +0000 (UTC)
Date:   Tue, 20 Mar 2018 22:07:43 +0000
From:   Eric Wong <e@80x24.org>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] git-svn: allow empty email-address in
 authors-prog and authors-file
Message-ID: <20180320220743.GA17234@whir>
References: <20180304112237.19254-1-asheiduk@gmail.co>
 <20180311135835.9775-3-asheiduk@gmail.com>
 <20180318230425.GB25017@80x24.org>
 <b3fce9b7-9fc7-c5a6-eaa5-a5c12ef7d492@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3fce9b7-9fc7-c5a6-eaa5-a5c12ef7d492@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> wrote:
> Am 19.03.2018 um 00:04 schrieb Eric Wong:
> > Andreas Heiduk <asheiduk@gmail.com> wrote:
> >> The email address in --authors-file and --authors-prog can be empty but
> >> git-svn translated it into a syntethic email address in the form
> >> $USERNAME@$REPO_UUID. Now git-svn behaves like git-commit: If the email
> >> is explicitly set to the empty string, the commit does not contain
> >> an email address.
> > 
> > What is missing is WHY "<>" is preferable to "<$USERNAME@$REPO_UUID>".
> >
> > $USERNAME is good anyways since projects/organizations tie their
> > SVN usernames to email usernames via LDAP, making it easy to
> > infer their email address from $USERNAME.  The latter can also
> > be used to disambiguate authors if they happen to have the same
> > real name.
> 
> That's still available and it's even still the default.

OK.

> But: If the user of git-svn takes the burden of writing an authors
> script or maintaining an authors file then he should have full control
> over the result as long as git can handle the output reasonably.
> Currently that's the case for git but not for git-svn.

Fair enough.

>     jondoe <>
> 
> just means: "There is intentionally no email address." For an
> internal, ephemeral repository that can be OK. It has the advantage,
> that no automatic system (Jira, Jenkins, ...) will try to send emails to 
> 
>     jondoe <jondoe@6aafaa21e0fb4338a68ab372a049893d>

OK, that's a good reason to allow "<>" and should be in the
commit message.

> Further steps: Eric Sunshine mentioned [1] that you might have concerns about
> the change of behavior per se. For me the patch is not so much a new feature but
> a bugfix bringing git-svn in sync with git itself. Adding an option parameter 
> to enable the new behavior seems strange to me. But there might be other ways
> to achieve the same effect:

New options are not desirable, either, as they increase
testing/maintenance overhead.  So I'm inclined to take your
patch with only an updated commit message...

No rush, though; will wait another bit for others to comment and
I expect to be preoccupied this week with other projects and
weather problems on the forecast :<
