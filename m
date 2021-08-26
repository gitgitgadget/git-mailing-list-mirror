Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD9BC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 05:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11693610A1
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 05:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbhHZF6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 01:58:09 -0400
Received: from verein.lst.de ([213.95.11.211]:58115 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhHZF6J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 01:58:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D8056736F; Thu, 26 Aug 2021 07:57:20 +0200 (CEST)
Date:   Thu, 26 Aug 2021 07:57:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
Message-ID: <20210826055719.GB17560@lst.de>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com> <87mtp5cwpn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtp5cwpn.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 06:11:13PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 3) Re some of the musings about fsync() recently in
> https://lore.kernel.org/git/877dhs20x3.fsf@evledraar.gmail.com/; is this
> method of doing not-quite-an-fsync guaranteed by some OS's / POSIX etc,
> or is it more like the initial approach before core.fsyncObjectFiles,
> i.e. the happy-go-lucky approach described in the "[...]that orders data
> writes properly[...]" documentation you're removing.

Except for the now removed ext3 filesystem in Linux that basically turned
every fsync into syncfs, that is a file system-wide sync I've never
heard about such behavior for data writeback.  Many file systems will
sometimes or always behave like that for metadata writeback, but there
is no guarantees you could rely on for that.
