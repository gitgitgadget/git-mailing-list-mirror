Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4019C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF9964E1F
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhAaDsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 22:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhAaDsg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 22:48:36 -0500
Received: from joooj.vinc17.net (joooj.vinc17.net [IPv6:2001:4b99:1:3:216:3eff:fe20:ac98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA68C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:47:56 -0800 (PST)
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id D6A49983;
        Sun, 31 Jan 2021 04:47:54 +0100 (CET)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id 7B7E6C20315; Sun, 31 Jan 2021 04:47:54 +0100 (CET)
Date:   Sun, 31 Jan 2021 04:47:54 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git fails with a broken pipe when one quits the pager
Message-ID: <20210131034754.GL623063@zira.vinc17.org>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210131033652.GK623063@zira.vinc17.org>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.0.5+101 (ab6d0dc5) vl-132933 (2021-01-27)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-01-31 04:36:52 +0100, Vincent Lefevre wrote:
> On 2021-01-31 02:47:59 +0100, Ævar Arnfjörð Bjarmason wrote:
> > On Fri, Jan 15 2021, Vincent Lefevre wrote:
> > > The broken pipe is internally expected, thus should not be reported
> > > by git.
> > >
> > > Just to be clear: this broken pipe should be discarded only when git
> > > uses its builtin pager feature, not with a general pipe, where the
> > > error may be important.
> > >
> > > For instance,
> > >
> > > $ { git log ; echo "Exit status: $?" >&2 ; } | true
> > >
> > > should still output
> > >
> > > Exit status: 141
> > 
> > I don't get it, how is it less meaningful when git itself invokes the
> > pager?
> 
> I don't understand your question. If I invoke the pager myself,
> I don't get a SIGPIPE:
> 
> cventin:~/software/gcc-trunk> git log
> cventin:~/software/gcc-trunk[PIPE]> git log|m
> cventin:~/software/gcc-trunk>

Well, more precisely, I mean that it is not reported. But
the SIGPIPE itself still occurs as expected, e.g. for scripts,
and one may choose to ignore it or not, as usual.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
