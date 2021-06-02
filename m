Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95835C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2FC613D2
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhFBL0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:26:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:33061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhFBL0a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622633080;
        bh=uzSj88cdpr1sEoktnTPuCscYij/Ffmqrib+0iWNfH7s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M0Q0DHo7yrwwhOiXR/B1u1Obo1AyvlnKVq7lX6JYXxvXYilzBfehOriRIvZncx8+4
         pQO1biP0Q96Cwa16qQI46sGVikhwpawx7GlQu8A79n0HlXxSHQBf5TWcVmhu8cDXCd
         HoVWMO63GVeBKFhQC7/pDih8oYPNYJKSSj5PrxFc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.8.58] ([89.1.215.222]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6DWi-1lmD7g0W6a-006jHZ; Wed, 02
 Jun 2021 13:24:40 +0200
Date:   Wed, 2 Jun 2021 13:24:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 04/28] fsmonitor-ipc: create client routines for
 git-fsmonitor--daemon
In-Reply-To: <e4a263728773381a64b8662c0577a3f12eff4ca0.1621691828.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106021320490.55@tvgsbejvaqbjf.bet>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com> <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <e4a263728773381a64b8662c0577a3f12eff4ca0.1621691828.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DCNfAgebapPLd7HISdMuGaFq2Ud1L4X5zKy6xwIT1HnBIvTKPIb
 zcHpB+j3W8BC8/IO9/dTlMGEYhKVGHrcBTEOhgDkWlqKigHI+Ro15FnxuVrEhUN/2rNFh+4
 Wut12VwvG81F2KHebJ9EmqvryRoXtiB2WbzexZ/RcNkkrI+dm+qhJn0J3ZzbC6KrfQpYype
 /SMxI4ZaDfSbGqAZMPf2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IbsXWLnnYY4=:maxA1wcH2zIHSJDnOZCChm
 eUo0/RVh+jO0ZlMdO8rg4ozISLOwTGqYKsz8afPO09hR9+ZqeGIpeK8DjDiALtzD9H2tTIDY1
 olX2sCq6+9LPN1EE5FrHjVfyOO+Mj3v/CbF6jh72brCaiMRJWD0fd6y0D4ET5sXy2r8jROeDa
 UXFyggZmE4ZWjDxuPJWrz/Qszv4Uw5Obw7kWs459ban9+fxFQsJmG52QmawgelXzhdXOzaOmL
 aaAgW9TQUIqvDsG1QMlInqPkyfRoEPS7MPwNbDjQP07NA48k1e/5D4S6T753ZvVsUsu6KkMEa
 +CE9ht9hDWwoEk1Zk8vqF3wzEgjWZRebapyb8fo/unElCFhoaDHLZdYC0/QmPFM5ErMlsrhW0
 TncXxDyOK0epZoc5mzD0XpkqK+EG5n291I/3pfmRKrV9Tk4YY1Za+OzCPYH18oK+Wiqk+hwyG
 1LyrVLCFfdTi9gxYehIVvhbEa5rbeOO/JlFfAD0zp30+Sb7gHBFDDaeNjDPHPQe57woUD3zub
 diiCziFrTWx22+pHuCYq8Do2WDjuySjxJ4cB2GPt6bCsJjI4uHpacJJt5FoEXzCG39E2fHBs1
 BW2Of7bCU+UdgYer4ZB8WiXmVkS2+CNPS0I9B4Lid1fn7eup/mdbKEXSt0DMPbA1hFUplZ7ds
 WDttK/T4/6eLBz4F0mtkRlqMi1UctpKRLl8AvZ+icm3Wa2tRlj3Owv3Z9Q4q7ZE+nBD4ewl4s
 f2P3hU6E9ltaKK2YR5WkTk5kXLSyyRoxAWsJ9b0ULv8HlaPZWUq2lhCWRXMxZ2z6xAnc0ock+
 IdOOK6jq7bBgu4mD71NYNiKOwNHhM7L7p8E8jr3H9rtqUtj6kctjId3Wlwhs+lxd1yOxpANp5
 nTXdorvf3k710ohq/rTQA7dzPYAzXluSKuIVbGO17tee/ukYFjOrmQ85HbP/0eAbMyNbUYMvu
 RjBx8hynKErBTR2s6Ywt3x4E+xRos0LS1G+9OkYAj7BsFs5ojheNrsgugSwQrfg3gsAiVXe0y
 IbSpNloI/JaIAOss/3c3ynA0p8Nk7CusKnToy5mD8Nnv4AgnKsL5gAygnHxmN68sLumi0Yey4
 kRfFoUPfNWltO64Uk0dd5QuR4mJMzi7hCvHSXw5Molz7R0D24BelmebPQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

I know you're on vacation, therefore I would like to apologize for adding
to your post-vacation notification overload, but...

On Sat, 22 May 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
> new file mode 100644
> index 000000000000..e62901a85b5d
> --- /dev/null
> +++ b/fsmonitor-ipc.c
> @@ -0,0 +1,179 @@
> [...]
> +
> +int fsmonitor_ipc__send_query(const char *since_token,
> +			      struct strbuf *answer)
> +{
> +	int ret =3D -1;
> +	int tried_to_spawn =3D 0;
> +	enum ipc_active_state state =3D IPC_STATE__OTHER_ERROR;
> +	struct ipc_client_connection *connection =3D NULL;
> +	struct ipc_client_connect_options options
> +		=3D IPC_CLIENT_CONNECT_OPTIONS_INIT;
> +
> +	options.wait_if_busy =3D 1;
> +	options.wait_if_not_found =3D 0;
> +
> +	trace2_region_enter("fsm_client", "query", NULL);
> +
> +	trace2_data_string("fsm_client", NULL, "query/command",
> +			   since_token);
> +
> +try_again:
> +	state =3D ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
> +				       &connection);
> +
> +	switch (state) {
> +	case IPC_STATE__LISTENING:
> +		ret =3D ipc_client_send_command_to_connection(
> +			connection, since_token, strlen(since_token), answer);

Here, `since_token` can be `NULL` (and hence the `strlen(since_token)` can
lead to a segmentation fault). I ran into this situation while `git rebase
-i --autostash` wanted to apply the stashed changes.

Since I picked up your v2 and included it in Git for Windows v2.32.0-rc2,
I needed this hotfix: https://github.com/git-for-windows/git/pull/3241

Thanks,
Dscho
