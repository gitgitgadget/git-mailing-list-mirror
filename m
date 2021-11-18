Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBC8C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 05:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FAA61B39
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 05:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243118AbhKRFha (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 00:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbhKRFha (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 00:37:30 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5931DC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 21:34:30 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mna3x-009383-6X; Thu, 18 Nov 2021 05:34:25 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mna3r-00A85l-WD; Thu, 18 Nov 2021 14:34:16 +0900
Date:   Thu, 18 Nov 2021 14:34:15 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] Use mingw.h declarations for gmtime_r/localtime_r on
 msys2
Message-ID: <20211118053415.4axljmr4s6kmqmms@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20211005063936.588874-1-mh@glandium.org>
 <CAPUEspgLwLxavP3bC9OEJQTphoemQ+jxv+9Nkcvbf51uaBEpww@mail.gmail.com>
 <20211118030255.jscp2zda4p2ewact@glandium.org>
 <CAPUEspg-5+YdfTJ6zi9hdDqF=KV2LJFCtqmECSss9Kfpn6sGrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUEspg-5+YdfTJ6zi9hdDqF=KV2LJFCtqmECSss9Kfpn6sGrQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 08:51:06PM -0800, Carlo Arenas wrote:
> On Wed, Nov 17, 2021 at 7:03 PM Mike Hommey <mh@glandium.org> wrote:
> >
> > On Tue, Oct 05, 2021 at 12:12:12AM -0700, Carlo Arenas wrote:
> > > On Mon, Oct 4, 2021 at 11:57 PM Mike Hommey <mh@glandium.org> wrote:
> > > > A possible alternative fix would be to e.g. add `#define _POSIX_C_SOURCE
> > > > 200112L` to git-compat-util.h and add `ifndef __MINGW64_VERSION_MAJOR`
> > > > around the definitions of `gmtime_r` and `localtime_r` in
> > > > compat/mingw.c, since, after all, they are available there.
> > >
> > > something like that was merged to "main"[1] a few months ago, would
> > > that work for you?
> > >
> > > Carlo
> > >
> > > [1] https://github.com/git-for-windows/git/commit/9e52042d4a4ee2d91808dda71e7f2fdf74c83862
> >
> > Since this reached 2.34
> 
> It is not in 2.34; only in the git for windows fork, but agree is
> needed if you are building master with a newish mingw

Err, I did mean 2.34.0.windows.1. My working workaround is to build with
-D_POSIX_THREAD_SAFE_FUNCTIONS=200112L.

