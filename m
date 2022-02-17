Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E87C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 16:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243412AbiBQQq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:46:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239915AbiBQQqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 11:46:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D82F67
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645116364;
        bh=HTwL2Qsq80goQhVTQ3kGcvI1ea84vUm98Yyq4o0jTyU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AHExGxSdnpDO9cEEGR1sf6+E8ggEFfMgrGvMTtezrHuVBlCn9WzKPfCRmuBE868Zp
         /i4XI4UXgnVgGGQYMc/OA0yQYNqoSzKiKkX9HeqddZtCxb9ama7b4MMC8+RsZAoBUt
         R6zuNjLAhvcSbNJFozopO7mdGgOBMODXWQwEFeyk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiacR-1nx5D92Mop-00flx2; Thu, 17
 Feb 2022 17:46:04 +0100
Date:   Thu, 17 Feb 2022 17:46:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 10/30] fsmonitor--daemon: implement 'run' command
In-Reply-To: <6fe5a2bc79eec132b6455d53196906036d0f4a80.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202171744410.348@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <6fe5a2bc79eec132b6455d53196906036d0f4a80.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F0RXyrs91gawacn21BwboUswE4Kx8J8kWb+gGOXpNqJetXDehIH
 LBjIH1bFOnsBCwYO0A5wNIXF24F/PsuFrAojYs3/MWFqOjUwEZhmpT4KBOT50zX7OqX/Cui
 OCYfKVQ1i67Ey6ZBBAXWpP6xwDfSEeLZ+z8gUmpxY5gk7zYyKGud41OknjLFAQUjUoMCS45
 IytdFXxOoKMEmRjfO7lLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NMeFxo1nG+0=:BIEgNPY4PhPdp99+oIDFU5
 v85JYHjCDF5QduvjL8Ya7isNib8daxSq2tV3Iph0I+CKXMTaPi4WGpX4BfuknkZeVVXC7ufdB
 DCdqoAM3I2nSHdGbKgLUz5njeJuVrvljTJBiBAvbA6L1ztuG0/Oa5Tii7oDJCrrXnXUZlW2vM
 nTtxeuCJK2ay2vNKEZ8DDGrBhZYS6s3ri4ZgmklbT/R8lq/Coke2x9fVATxyblvWTwKSVnBtf
 xwysiu3WrOT5rT5qqlrIZfsthVv28VCmXuAgpWivzsztv2PcgxLHI5LOYjzVudJSnmdZzgHFq
 KkQNgbXnjUP7BobydhTQ7o/57FlK6gck9jQhyTgwCk5img7T4MOjoEaXUX1crQHZ5Jx1j4oYS
 Ik95SNyujsJphsmkMcDRS6ljAOnroWwGkPBdep9fe/sU91vhpCw7fZSSTWD7ai1/gerFgfGWu
 vEERW+IlLlXGOtPO8/+GtpkmNr6uiylUJmYC88vqAZtI/hrsp69M0rPg6Zser8uVXhXpUucNE
 Kxt3TwoSpf5nLiu46/B2/N0+I6ftYc4XXbYZaY6qGGoWQZsdpa8+D9YtfgV0x+PXVbDPgKp+Y
 kw3Vbf24cYf5g5PpO0UW54SURnY32PmNwAgchovah/CLqVdehVigBnc66tw0mjuxPsdD+ZZbZ
 vR8ul8IJKny94Qj/K30/+T9jNska5f1Ic/Zt6mSp7dhws6Cnbk1Z3CayKFz9Mcw82pJxSE03W
 t0BknvGB7taN4+A08HIwbHaAoExeMzHTP8VlhscvOAKdDkLcEUItGcNKhQWSLG8yiXCjV6yEY
 3/iByrfYhvt7i4p3Mn6x1UWtynI92I/Am3mr7aehAl/6XP9VJmsdQTXVsgq3htCzgtO2MiPKy
 KUHAayc5eNV1xfpAqb35FOfSundRQz0E2TcQ3qUX3JqLq4SQi5QsZyk+1QYh9QEv/rneGgPb3
 OBer/JZ3rZRzKHr+UnjeCXdS6THO8gjFttM6BhpYrhEJhMAwaqedpBSdeaZNHJmh2uvjqnVN0
 t55RYE17Nh/4o4NkQitzB2S2xp66K9jUyn+crIsnUfqadiJwxhyXeWNKiL4dQBPAR1zDK1W56
 kdMbzMwAoh02wU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> +static int try_to_run_foreground_daemon(void)
> +{
> +	/*
> +	 * Technically, we don't need to probe for an existing daemon
> +	 * process, since we could just call `fsmonitor_run_daemon()`
> +	 * and let it fail if the pipe/socket is busy.
> +	 *
> +	 * However, this method gives us a nicer error message for a
> +	 * common error case.
> +	 */
> +	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
> +		die("fsmonitor--daemon is already running '%s'",
> +		    the_repository->worktree);
> +
> +	printf(_("running fsmonitor-daemon in '%s'\n"),
> +	       the_repository->worktree);
> +	fflush(stdout);

Do we want to print this to `stderr` instead?

Ciao,
Dscho
