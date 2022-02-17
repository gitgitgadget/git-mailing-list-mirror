Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D96BC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 16:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242977AbiBQQNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:13:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbiBQQNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 11:13:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAAC16A5B5
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 08:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645114407;
        bh=hlUxnWjLdA2XS9ZfqyJpxFaflITYT4gWFtIHjRHHWe8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FYrbTTw/B0c+XSQ5D84O1gBomlVvyb3RuzmTvExQsc94dW0FQVc6sVwuLJVBxF+tI
         EdOMh8eHXNAwGoEJAXDcOaoOSsvrCb3Cu6sjwMLtArov1SIwLIgZzt3WBIbMVn8FRp
         rpQBFkt/VOFcJf1CLX1MQcSzf4ELMqHbhXpdLd6o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1niprS3XjM-00SjWM; Thu, 17
 Feb 2022 17:13:26 +0100
Date:   Thu, 17 Feb 2022 17:13:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 02/30] fsmonitor-ipc: create client routines for
 git-fsmonitor--daemon
In-Reply-To: <365964b766400654a9978092f8fe5cfaa525fd3b.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202171710270.348@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <365964b766400654a9978092f8fe5cfaa525fd3b.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Gyt4kZoHEE93pvBwhf17Cx/w3yUWMM8acvUMf2AzW2U27jL8b2P
 4tPvejERFNOh1KU/ZU3G2lCooSc/1GtqYl9satoR6lKnnvS7df9K9TO5iPSPqYCK25gEK3y
 s4Y3NRD05t5oASJ5knztUA98jf2Ync1NZa+x7DFZ3bzvt9aulr9pt2ErOo301LeblEhjZFy
 pzjd1XxDeN1X0Tu3yNfnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z1iSuYOPouk=:C/jdidURQs/SDjMqEyjiyV
 F6vTZ1uU8RlI2ewnYA4chZ8ZvmDjuTvD0ztNUqnOXLAPnI2rwLDwjyl/8e7CQSAnxdrJYJZZr
 UpaVGnaYsj2Z/X9Xdc16lwKPmjoL8toJSordzyp/2Fx4EUhBKdu6m8RHYYcLQf7UMeP2wRJu5
 XiAwvJJ8kq1ipIRW5tmiIbmy10iei7psBGGdECafF79G85U82h67ROEAbfUexnMZZZ9xb7wa9
 bBJZf5KKDuFXdc8IzB4xQlBX0bCzpOlksNTSO3qADFwjvouRv0DFcYYNBGNqhOYnEe37DPZoo
 J6gNGKtEhZZJCQtxSYXiryqZVhU8Y7bXOF5vWuTfJPOlyd3ziJAMcWz1NeOS1mz4YhkNt5/V6
 Y4keK6+qUFyFZHfe2FaZ+WBnzvaTXCn3LrdFQt5Ki4RWB3Yv89fzMDc2vsDhtJwVcgKMbKIFU
 JDIEc02SfSK3Z8ylmgoZg4GBGw+Klq/AZj6FvFHa/U48cK8gkvrL7x/AfRwmLXypUqTE1kRcI
 IO8WGDGzY0XgOM8JVFmH4iHYwmnmSSSXtuwMwjkKlrkZa2WK9C77hBE2tAyhY3jGJr+4BNRcf
 9Ime+2eoRGz5aHp9j/kLGkjHewjAEAD6Q3fSfRvqBE77fYjrQzCdyz3QhFnHshfqx2VWtC7qe
 /t6uI3V2a1BzF6X/brV85x9omwwpMeUFLZfN5lrWQ848PctOXulnQzwzlKN5xjAjO2RpDzevO
 Lf+zi/ItHxje5rauBt8J4RLYPNHTn7AlWxTSJCFFjl9s0QiWD36wazqPX6R7thZxBRcyy44jP
 QbHkK6CwQzcS5MRqdy32vNrBfBwoAlsOEKKi4LH93f0Sz4wrs+RXQdSqMeAQXqkTnyC1b9Byb
 gMsCuxcfcWs/O/NDHZ2DWWM72ZHTCJVymU8bFJh8y1AEBJ2hPeaLF2Sv9u+NgqZIQuLTeZudp
 H3LskDrm8y/uRD1kyJf8auPhZQZXcxILRp0fOXBDxoy5NctPaI3WN6ZEhVMAfk65jm8ylupkW
 j7ZvlAhUBPMf6mvcPieJcw02Lke81fKEfghpI3W+zbLXcxBN06O738z6XYCTq/dxs+3wHWE6P
 p1d7SgxTzXYcco=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Create fsmonitor_ipc__*() client routines to spawn the built-in file
> system monitor daemon and send it an IPC request using the `Simple
> IPC` API.
>
> Stub in empty fsmonitor_ipc__*() functions for unsupported platforms.

This looks very straight-forward, thanks to your design of the Simple IPC.

Just one thing:

> diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
> new file mode 100644
> index 00000000000..01c8c25bf50
> --- /dev/null
> +++ b/fsmonitor-ipc.c
> @@ -0,0 +1,171 @@
> +#include "cache.h"
> +#include "fsmonitor.h"
> +#include "simple-ipc.h"
> +#include "fsmonitor-ipc.h"
> +#include "run-command.h"
> +#include "strbuf.h"
> +#include "trace2.h"
> +
> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> +
> [...]
> +
> +#else
> +
> +/*
> + * A trivial implementation of the fsmonitor_ipc__ API for unsupported
> + * platforms.
> + */
> +
> +int fsmonitor_ipc__is_supported(void)
> +{
> +	return 0;
> +}
> +
> +const char *fsmonitor_ipc__get_path(void)
> +{
> +	return NULL;
> +}
> +
> +enum ipc_active_state fsmonitor_ipc__get_state(void)
> +{
> +	return IPC_STATE__OTHER_ERROR;
> +}
> +
> +int fsmonitor_ipc__send_query(const char *since_token,
> +			      struct strbuf *answer)
> +{
> +	return -1;
> +}
> +
> +int fsmonitor_ipc__send_command(const char *command,
> +				struct strbuf *answer)
> +{
> +	return -1;
> +}
> +
> +#endif

Not a big deal (read: I won't mind if you leave the code as-is), but I
usually find it easier to read the shorter, more trivial arm of
conditional if/else arms first. In this instance, the dummy implementation
for platforms that are not (yet) supported looks more trivial to me.

Thanks,
Dscho
