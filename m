Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89BC31F453
	for <e@80x24.org>; Mon, 18 Feb 2019 08:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfBRIy0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 03:54:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:52532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727570AbfBRIy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 03:54:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3D9DAD7D;
        Mon, 18 Feb 2019 08:54:24 +0000 (UTC)
Date:   Mon, 18 Feb 2019 09:54:23 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] setup: don't fail if commondir is deleted.
Message-ID: <20190218095423.0705aa7a@naga>
In-Reply-To: <CAPig+cTS0MNvwx67ZVbYUvi9bA63KWnNnSmWdFjLuqc_SNAy8A@mail.gmail.com>
References: <429046b2c9f02c5e4f0af88db51f6c0c099f08a9.1550254374.git.msuchanek@suse.de>
        <dd42ab7054077c7d29ad62e7481c00ab5c1bf864.1550254374.git.msuchanek@suse.de>
        <CAPig+cTS0MNvwx67ZVbYUvi9bA63KWnNnSmWdFjLuqc_SNAy8A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Feb 2019 02:14:14 -0500
Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Fri, Feb 15, 2019 at 1:16 PM Michal Suchanek <msuchanek@suse.de> wrote:
> > When adding wotktrees git can die in get_common_dir_noenv while
> > examining existing worktrees because the commondir file does not exist.
> > Handle ENOENT so adding a worktree does not fail because of incompletely
> > set-up other worktree.
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > diff --git a/setup.c b/setup.c
> > @@ -274,22 +274,25 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
> > +               if (strbuf_read_file(&data, path.buf, 0) <= 0) {
> > +                       if (errno != ENOENT)
> > +                               die_errno(_("failed to read %s"), path.buf);  
> 
> Documentation for strbuf_read_file() in strbuf.h does not state that
> 'errno' has any meaningful value when this function fails, however,

It is stated in the documentation of strbuf_read().

Thanks

Michal
