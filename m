Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B647C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiBXPXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbiBXPXM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:23:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEB41B8FCB
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645716119;
        bh=aUqXfyU7IEXb+NoQif3pbEh83/dNyx2BjzA8Zxrltz4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GiDTTmt/fN87ZFQ39bQb3vjTb7IRo0OKBdM9S0QB+gjycZlDHPFC6MdvHtXylHFL/
         S7BaApe+08xvpCx4CXzrj2rY1Ybtwxw+Z3Ngw0PGgLsO09P9J7QWebRFAZIkCCUFqN
         q3nAqiWwf9K2AFxyJgAnXfuJZjKtMB8Cy3Uwl7uk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1nfD8C2K8V-00LqAl; Thu, 24
 Feb 2022 16:21:59 +0100
Date:   Thu, 24 Feb 2022 16:21:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 17/30] compat/fsmonitor/fsm-listen-darwin: implement
 FSEvent listener on MacOS
In-Reply-To: <162e357db7211e72c8a39e722e8432baf710c70d.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202241614040.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <162e357db7211e72c8a39e722e8432baf710c70d.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RQ5zThou00ShAWDBRPvpWcJM6GDQUBLpQsrnBbjFNYZbKq4vSuJ
 0fl0Te8W+25wSWJytgnXoW9wJ8Hu6S+42SRXgw6AaFlcEp8HDU3VXdbRSfhxGgBV98G1eN3
 D1cd/16gdmpv+wuQ0qEod7Pxr4mgXMBAI2LHaUmcURBcvAr9+JhEW7usf44Cbl9JTDswxmy
 KGNqUNSCRler0VB8zFZOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eo3mchJWwLE=:0qRUWvUs7eYygjEwYUqmYo
 tXpClildurYGcjIVjoPNQ1RH42rRCu4TPlx7YY/KeLG2LQ9ENVm/MHwdzmUlqc0K86kYBTvKT
 Y04Zo/zEsXsl5VCRAzmucaaTKWbv/HlXHns2KLdXT+0xbTs4A+TGpdzHXUgWQwXrOoQbaU0aH
 EHZORWbPpvTSdXB6hy2pUKTJxdOvy85Td5p4zbkcBkN3Pq+ol7aJjKJKSrpkeKx0KKgNIZOxr
 tDYF+7fydJ2whksNhEpVL+lqrWI/cPIrsWVDYouQxKLHUp8cBWWCMXxZBVkf25AKZuwLyDMN7
 YSeqwLluzBICVSFGHotP6O5vrGpR8rv7QGHK9eZf0YDEqT95HMPTrwJApfG9jEI4oaIPs92SJ
 PjfU5GeTfGOaR9yGHwnhOG9PXrXLFKzt1eLGq3ZQYh3nTY1mUSxHhK4Uf7zvDVPd04LDZkAjp
 9kuAF6j7E+7JGRgL7J/EtrjFpu+3EgQOi9q+TsLbUztUC2cAo9qsXhf5MRZWcDuOnqyeNEWa1
 4rS/cuuATtad/DGw9XczTlq2wiWnpIzDX/3lpwiV5dCn0QnQYerQa2PGU5nErZKd9yJDcWJPj
 iWP85MzSR6mWuyrFkJOHIhH+T6V2IaaME/Vcad/VYD6bHPPA7LrY4BqM7CNjt3MPU4GoKzNsF
 yCmIbz7qpt63a7clVOhX7uD6VfVdhNin3IyH3S8KTtys+nJw2Q+tyxD/nse+1l7IcrPm7V2EN
 YVId6eHBgAMyWMzI4rGvHa1H8BARO7b7QAYeMUjL49zRcIS96Vb9EPewLaYzpUXOGvX0OvQpL
 NEpR7B4y5x3hvnMqrtxKIn77E8UDWuEYLUpPdMxEbRbpOY+ec6tz26zozdmYgv7Z3n9EyZPbm
 KUlATE8SA6Y51PgnV9pA/nO8iNmRdi12DR/2VkLzUXmO3iYo1CRd415dt49JpnBRYB8pMh4gq
 EopuHBCuztp/V8GIIVHLtOCiRypfIeMo2sHFMItHxCm8Ed+E5oZElGAdhvqYnwv9p/TehnQPT
 bP4nr0LrLvBTdftD+6FLXwbQPk73ER/NLCnI2UJLDA1Y7GBk5DOKA2LMR6CbPsKDUtar1hBEl
 YrU6gy196+BJg0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
> index f424253d3eb..2aefdc14d89 100644
> --- a/compat/fsmonitor/fsm-listen-darwin.c
> +++ b/compat/fsmonitor/fsm-listen-darwin.c
> @@ -1,4 +1,4 @@
> -#if defined(__GNUC__)
> +#ifndef __clang__

This probably wants to be squashed into the previous patch, and while at
it, the corresponding commit message should probably be adjusted:

	We need GCC and clang versions because of compiler and header file
	conflicts.

This should probably say something along the lines "This is only needed
for GCC, clang is fine" instead.

> +static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
> +{
> +	struct strbuf msg = STRBUF_INIT;
> +
> +	if (flag & kFSEventStreamEventFlagMustScanSubDirs)
> +		strbuf_addstr(&msg, "MustScanSubDirs|");
> +	if (flag & kFSEventStreamEventFlagUserDropped)
> +		strbuf_addstr(&msg, "UserDropped|");
> +	if (flag & kFSEventStreamEventFlagKernelDropped)
> +		strbuf_addstr(&msg, "KernelDropped|");
> +	if (flag & kFSEventStreamEventFlagEventIdsWrapped)
> +		strbuf_addstr(&msg, "EventIdsWrapped|");
> +	if (flag & kFSEventStreamEventFlagHistoryDone)
> +		strbuf_addstr(&msg, "HistoryDone|");
> +	if (flag & kFSEventStreamEventFlagRootChanged)
> +		strbuf_addstr(&msg, "RootChanged|");
> +	if (flag & kFSEventStreamEventFlagMount)
> +		strbuf_addstr(&msg, "Mount|");
> +	if (flag & kFSEventStreamEventFlagUnmount)
> +		strbuf_addstr(&msg, "Unmount|");
> +	if (flag & kFSEventStreamEventFlagItemChangeOwner)
> +		strbuf_addstr(&msg, "ItemChangeOwner|");
> +	if (flag & kFSEventStreamEventFlagItemCreated)
> +		strbuf_addstr(&msg, "ItemCreated|");
> +	if (flag & kFSEventStreamEventFlagItemFinderInfoMod)
> +		strbuf_addstr(&msg, "ItemFinderInfoMod|");
> +	if (flag & kFSEventStreamEventFlagItemInodeMetaMod)
> +		strbuf_addstr(&msg, "ItemInodeMetaMod|");
> +	if (flag & kFSEventStreamEventFlagItemIsDir)
> +		strbuf_addstr(&msg, "ItemIsDir|");
> +	if (flag & kFSEventStreamEventFlagItemIsFile)
> +		strbuf_addstr(&msg, "ItemIsFile|");
> +	if (flag & kFSEventStreamEventFlagItemIsHardlink)
> +		strbuf_addstr(&msg, "ItemIsHardlink|");
> +	if (flag & kFSEventStreamEventFlagItemIsLastHardlink)
> +		strbuf_addstr(&msg, "ItemIsLastHardlink|");
> +	if (flag & kFSEventStreamEventFlagItemIsSymlink)
> +		strbuf_addstr(&msg, "ItemIsSymlink|");
> +	if (flag & kFSEventStreamEventFlagItemModified)
> +		strbuf_addstr(&msg, "ItemModified|");
> +	if (flag & kFSEventStreamEventFlagItemRemoved)
> +		strbuf_addstr(&msg, "ItemRemoved|");
> +	if (flag & kFSEventStreamEventFlagItemRenamed)
> +		strbuf_addstr(&msg, "ItemRenamed|");
> +	if (flag & kFSEventStreamEventFlagItemXattrMod)
> +		strbuf_addstr(&msg, "ItemXattrMod|");
> +	if (flag & kFSEventStreamEventFlagOwnEvent)
> +		strbuf_addstr(&msg, "OwnEvent|");
> +	if (flag & kFSEventStreamEventFlagItemCloned)
> +		strbuf_addstr(&msg, "ItemCloned|");

I cannot think of any more elegant way to do this, either, but I wish
there was a way...

> +/*
> + * NEEDSWORK: Investigate the proper value for the `latency` argument
> + * in the call to `FSEventStreamCreate()`.  I'm not sure that this
> + * needs to be a config setting or just something that we tune after
> + * some testing.

Since this was written, we had ample time to investigate the proper value,
and I think you actually did. Therefore this comment is probably no longer
needed.

> + *
> + * With a latency of 0.1, I was seeing lots of dropped events during
> + * the "touch 100000" files test within t/perf/p7519, but with a
> + * latency of 0.001 I did not see any dropped events.  So the
> + * "correct" value may be somewhere in between.
> + *
> + * https://developer.apple.com/documentation/coreservices/1443980-fseventstreamcreate
> + */

The rest of the patch looks good to me, and since we saw this code working
nicely in practice, I have high confidence in it.

Ciao,
Dscho
