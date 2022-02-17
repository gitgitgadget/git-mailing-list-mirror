Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD27C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 16:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbiBQQuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:50:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243184AbiBQQu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 11:50:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5D5CD5C7
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 08:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645116607;
        bh=euDl46H3kooSAWWIuqDLypCseuoT+Pq2XZ1lFNrmrBQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T6cLdnd/B+3OY4rCeCvsLTIaeiS1+oRpHB3fOGEFcBx17V4rCOFZlH9ioC2X2NGsR
         SGysecKVnsbviIEbHO+2KagU6r5ok73tYmgxf63A45KlKUToiwW5OvY8/REgb6K+JN
         bYyqzVFwgnCkorLG/4e+Ro+96vlnBqh3vE8CkYVA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2aN-1o1SqO1sJz-00k9kX; Thu, 17
 Feb 2022 17:50:07 +0100
Date:   Thu, 17 Feb 2022 17:50:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 11/30] fsmonitor--daemon: implement 'start' command
In-Reply-To: <69fc0998286cbc791f199710a68a2028080e1632.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202171748010.348@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <69fc0998286cbc791f199710a68a2028080e1632.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QiEYUAIa7zsgfccLCtjDsTgmRTQLtzSHAjjIFgEpLCdC0Ab7lM2
 7C+qjsem6w5zpBnyvI7h6VQCAJAEXyQ4dWjWKFXz5e6CEnFj78GkwNMpDZYelnhwz9MazRk
 zQ/XWi8N/THElyUdta0y/kVtHOXR/QTVqj3ob1aynaenjBvNBBkZ/XQk+Yt99jR3BidfuIM
 NvxzKCx88QDM3JRxYxvnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SCc+2qerRPA=:YfsAO8QeWYwcMxMyngrNQw
 M4g4Rpem2+6qECMmJVlb+vWuasRf3BM5V3IPwF7j3a4Cp6vIK6hYVA38ZtpeqO/fkmKpoqBC/
 47ZeeSQKW0N8WLYnTxJxbuS0MO6tjcFE0/vQgnjO/yAiEIFiX7dR5KCymYpBn3+7Qi6e9kZap
 64peX5Ae/npwcQhdR9NWa6BF7IeucijKy3PNdm/V3wVhImXE/xQrLgg89UisZYwBow+7RRmGh
 4g96K5OEXiFpsb7o3iFKytbtdbuLyyhsydIAPhWn2lfZXJNk/Ryweqkf422m2tXjPAAYY5mpC
 j5n2icT5EfIGe9PemN4dlgYRWnPl/K0Kuy8949iBfv8lrszjgFwmNzVOypHcoYKkiVc0i8h52
 j6letT/ZgWfA9dALu8BtVyWqfUwHi39UZUXvtqZONsVQzqP3TsOXsPxXG78d8RPFI9Rvartf9
 WmiV0tsAm3jfQexVYNFCMHs7VvBMtESpcFeyDoHMWvV4y0Uo7J0svIrjOpeqWWWTGvw7T3q9y
 yQTpC+9TNR3RZDTQPxwP+sxsuQ380DgZBaMe7gI59V9YruuT0PMm2BIHCQG7RXRpfnF/9M8Df
 4+oFCSw0KVLinAHVorJMYcL5g0c7KGoQwRbp45VopFeFpxV2GKn2mEQOONPoJQimk9kB6vNns
 dYNGhURLhiEkr8e5AHekpe5V/QBs9p3HlX31ZwBx371MBflJOyoFE6ggAV2JG2xjYRluzVgh6
 /m0iGMwYR/5ohC0sg3Xh/pDrj/4JZMF0KtgkZlqbJC7p55xSmLpz67e1o9iXXxERdH5RSDa3p
 Pq7EogNpJG7E7NixXg1pmeszFGtI3oSa0oztwcuXdL2xCq4Rvl48ISJgxJ/UshSZT9u/a4Zic
 T2V0cggYXFGA+0APaLS3o6hPHMIHJcWfovJPAuSw6vzfee9MXYxiy1NfmQAHsexcecgXFXZOD
 EDlhzwMM6uJL6o6Xi1g3wXVgBi75C1g1seAyAaRIoy/FrF3FOZyGJAepLton0aWMIx4kaSKuK
 Bqo6V15rb+H88yd6Lac/I5+QImIfnf1o10BUpn9baYsJDBv8POAgl0JcL/PN0EXXX5id6fyY7
 GUFYq8y5fELVd0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> +static int try_to_start_background_daemon(void)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	enum start_bg_result sbgr;
> +
> +	/*
> +	 * Before we try to create a background daemon process, see
> +	 * if a daemon process is already listening.  This makes it
> +	 * easier for us to report an already-listening error to the
> +	 * console, since our spawn/daemon can only report the success
> +	 * of creating the background process (and not whether it
> +	 * immediately exited).
> +	 */
> +	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
> +		die("fsmonitor--daemon is already running '%s'",
> +		    the_repository->worktree);
> +
> +	printf(_("starting fsmonitor-daemon in '%s'\n"),
> +	       the_repository->worktree);
> +	fflush(stdout);

Just like for the patch before, my question whether `stdout` or `stderr`
is preferable here?

> +	cp.git_cmd = 1;
> +
> +	strvec_push(&cp.args, "fsmonitor--daemon");
> +	strvec_push(&cp.args, "run");
> +	strvec_push(&cp.args, "--free-console");

We could call this function `--detached` or `--detach`, too, to indicate
the intention.

I am fine with the code as-is, just wanted to make sure that these
questions are on record ;-)

Ciao,
Dscho
