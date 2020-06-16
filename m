Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E225C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 07:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F2C2082F
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 07:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgFPHId (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:08:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36058 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgFPHIc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 03:08:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 863521F5AE;
        Tue, 16 Jun 2020 07:08:32 +0000 (UTC)
Date:   Tue, 16 Jun 2020 07:08:32 +0000
From:   Eric Wong <e@80x24.org>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, meta@public-inbox.org
Subject: Re: CFT: imaps://public-inbox.org/INBOX.comp.version-control.git.7
Message-ID: <20200616070832.GA13965@dcvr>
References: <20200610184147.GA1887@dcvr>
 <20200610233127.GA51956@generichostname>
 <20200611003036.GA5446@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611003036.GA5446@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Denton Liu <liu.denton@gmail.com> wrote:
> > Exciting news! Since I'm not actually subscribed to the mailing list,
> > public-inbox has been integral in my workflow by letting me reply to
> > messages that I'm not CC'd on. The IMAP gateway is a great development.
> > 
> > I fetched your message via IMAP just now ;)
> 
> Hi Denton, great to know you appreciate it :)
> 
> It's still in the early stages and there still seems to be a
> problem where it still interacts badly with mutt's header cache.
> Maybe checking over the old HTTPS/NNTPS endpoints once in a
> while if things appear too quiet is a good idea while I shake
> out some bugs.
> 
> I'm dreading the cost of ~100K RAM/storage overhead per-client
> connection to support sequence numbers properly...

OK, that ought to be fixed and I found what seems to be an
acceptable solution w.r.t. server-side overhead:
https://public-inbox.org/meta/20200612234924.GA31809@dcvr/

I've also just deployed a recursive descent parser for which is
hopefully compliant with the way IMAP search queries are parsed:
https://public-inbox.org/meta/20200616050540.13357-3-e@yhbt.net/

One of the annoyances of read-only IMAP is MUAs (unlike
newsreaders) lack the ability to store status flags for
new/unread messages.  I've got some ideas to deal with that on
the client-side...
