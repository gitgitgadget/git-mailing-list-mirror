Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816D7C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 12:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242305AbiHHMzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243019AbiHHMzq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 08:55:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02232708
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659963327;
        bh=DkbrqDwPk/0Mdrr3fPMFMUm/J4a8F6g2himPCrOioUE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MZCbrVbUthhZQsamqRo50zcag5TEciEoNFPGZxGVUruuCesBubGing2jO8dEgm+o3
         2CT1C7ETAtOMybdUUr1SnRq7up/gNkFEfUj6dX5iPmoYPfTmp34ECY7oOfwHoDfX4j
         8MuRadovU9kRManpCNivu+rs1Y0bLUbbd7TTN/m0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.182.192] ([89.1.214.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5UN-1o9Fu40PFn-00FBB9; Mon, 08
 Aug 2022 14:55:27 +0200
Date:   Mon, 8 Aug 2022 14:55:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as
 non-blocking
In-Reply-To: <362560ca-1e37-bab3-e508-4d5bf5429e66@web.de>
Message-ID: <099911o8-43q1-o29s-5s36-34r5qn37nq8n@tzk.qr>
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net> <YulFTSTbVaTwuQtt@coredump.intra.peff.net> <xmqq5yjahb8u.fsf@gitster.g> <YunxHOa2sJeEpJxd@coredump.intra.peff.net> <a9953278-b15f-fd76-17b0-e949c7937992@web.de> <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
 <41477326-5493-4d3c-246d-8a28969fa73e@web.de> <Yu05GjncDaGRTgce@coredump.intra.peff.net> <362560ca-1e37-bab3-e508-4d5bf5429e66@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-304667906-1659963341=:226"
X-Provags-ID: V03:K1:25A9P3ax7gDivs0TYK2XvZIQTk1t/IEHd6TRZDj7xJ2Afd+Rzsi
 4RAwRthtE4PlOhzE5izh/tKGMUw8KwXky2dbxwAXEfNtrnl8vDnmuPhEnnh2CvmfFYYehDK
 vOdjHpUFfqK+bAK2KSiGXiDbatQG3ef6pJETudGRdbw6X0n7qcvzagwZUZIF9KcyvGz/ZQd
 laWe3TCKteBHVf1bPkt2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mesw3zO4PcY=:u3fWtFkcghWR6EwrN7IBJO
 sX1jarpVH8HKJKfgLZj7vZdo5tCov1FrE7q5Vc2oZ/POZ7ARiFy6Of9azt1HQeNMbtahSHJvP
 U++OBqLlyo9imnMhz1rfhWQXtF6zoOrcm2P3FAnLvPqpBIzuPli/CN05bQ5duNF23GaK9ekQq
 I/Y3F6fAzCQ5SQkpXSE4Rep9SmYpNlCPQdXZQwbiaoLwjymiup5I8C4ZeHX+bNJdd6fdC+ahR
 MrEV1gCf6RZzvyGxgiAvS2W9dqz+XhFZv/xUzMLjILwYQ8j5SCC8fVlnAqYBya0wytw4lb13G
 2MpLBjEo6zDZA+L8RinObHuf4iGk2DeZNOkMPZ2W3VeiNYKGFWyvap3dO9eXu9/deFz5g4NIP
 pHkT1zugrYZMALSHQdFMdPG/ODiKvfvFbhATZfnl6t54lYfel0cu8Yfk9Lw/55hXjrzCcE7De
 F2ZIFlcCnJA+czlqb+OUBvDf+VPZbpAVxQ/p7O1WaID0MbkIeBm1YIao8YJKgBnnB1iEuLl+N
 z/3GoMGH9cpVCd/7Zxad9SgH02CrcUw/AJNjdAk08nqKUFTq7gxxLg2AX2E8LljGyvvzd7ifO
 yND+hniDhUeSc3pXjdnKi1GQEdbB96rje6B2F+M9GlNkOKQjmw/ZUeGWle5xEGjRLRCbSUSmi
 tB9a/YTOdfKzk1sWDFNbr9wXbj7H9x/Zf5PdhMzVq97DymRy+dU6nq5DRjWGjE03zoIcdC4W2
 LSQ7f/eJq0HE0YlXfynFRHIsM3B8YkvN1jSPpmCb2zpuuPs2leEBN0zlrar+TiB1t1c9pjaV5
 RCxLjw6UpcJKxMzPAYPRkkVJcd7+Qb0090q8i2GLO4/v42GAyCcwN/miKZNvgLgzZU+MoMV3I
 KT1hsN1LboPZqvTBdF/IcjwyIPJ9SRncv6dVtEutxdnTf/vzq9FBlp19S1jzDfzZBT3yb+CFe
 BLRksGHe4r9TYjDL5yooKpRX3kLs7YHHh7DLs/En8im8UgbaIc4zrXUp6BxijkOtEaX4cn4aZ
 EqPEh4dPFvQpzJARbJdcHA4lugGn4T+2V1nwqX2U1oqRKtwWc+Hz04mP1ocHfVIAmsBFkR6eS
 Rwegt81dL9sgsnfxwoX9ogCcRQMwk6ngE/QTp3Zh4PzWiZshF7s88Qocw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-304667906-1659963341=:226
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Sun, 7 Aug 2022, Ren=C3=A9 Scharfe wrote:

> Am 05.08.2022 um 17:36 schrieb Jeff King:
> > On Wed, Aug 03, 2022 at 11:56:13PM +0200, Ren=C3=A9 Scharfe wrote:
> > >>  int enable_nonblock(int fd)
> >>  {
> >> +	DWORD mode;
> >> +	HANDLE handle =3D winansi_get_osfhandle(fd);
> >> +	if (!handle)
> >> +		return -1;
> >> +	if (!GetNamedPipeHandleState(handle, &mode, NULL, NULL, NULL, NULL,=
 0))
> >> +		return -1;
> >> +	if (mode & PIPE_NOWAIT)
> >> +		return 0;
> >> +	mode |=3D PIPE_NOWAIT;
> >> +	if (!SetNamedPipeHandleState(handle, &mode, NULL, NULL))
> >> +		return -1;
> >>  	return 0;
> >>  }
> >
> > This looks plausibly correct to me. ;) We might want to change the nam=
e
> > of the compat layer to enable_pipe_nonblock(), since one assumes from
> > the function names this only works for pipes.
>
> Or how about this?  Squashable.  Needs testing.
>
> --- >8 ---
> Subject: [PATCH] nonblock: support Windows
>
> Implement enable_nonblock() using the Windows API.  Supports only named
> and anonymous pipes for now, which suffices for the current caller.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  compat/nonblock.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/compat/nonblock.c b/compat/nonblock.c
> index 897c099010..78923cd2c3 100644
> --- a/compat/nonblock.c
> +++ b/compat/nonblock.c
> @@ -14,9 +14,40 @@ int enable_nonblock(int fd)
>
>  #else
>
> +#ifdef GIT_WINDOWS_NATIVE

Maybe use an `#elif defined(GIT_WINDOWS_NATIVE)` here? That would make the
code structures clearer, methinks.

> +
> +#include "win32.h"
> +
> +int enable_nonblock(int fd)
> +{
> +	HANDLE h =3D (HANDLE)_get_osfhandle(fd);
> +	DWORD mode;
> +	DWORD type =3D GetFileType(h);
> +	if (type =3D=3D FILE_TYPE_UNKNOWN && GetLastError() !=3D NO_ERROR) {
> +		errno =3D EBADF;
> +		return -1;
> +	}
> +	if (type !=3D FILE_TYPE_PIPE)
> +		BUG("unsupported file type: %lu", type);
> +	if (!GetNamedPipeHandleState(h, &mode, NULL, NULL, NULL, NULL, 0)) {
> +		errno =3D err_win_to_posix(GetLastError());
> +		return -1;
> +	}
> +	mode |=3D PIPE_NOWAIT;
> +	if (!SetNamedPipeHandleState(h, &mode, NULL, NULL)) {

Nice.

FWIW the documentation of `PIPE_NOWAIT` says:

	Note that nonblocking mode is supported for compatibility with
	Microsoft LAN Manager version 2.0 and should not be used to
	achieve asynchronous input and output (I/O) with named pipes.

(see
https://docs.microsoft.com/en-us/windows/win32/api/namedpipeapi/nf-namedpi=
peapi-setnamedpipehandlestate
for full details)

There is little more information to be found on the interwebs, the closest
to an in-depth explanation is here:
https://devblogs.microsoft.com/oldnewthing/20110114-00/?p=3D11753

Even if that comment suggests that this mode is deprecated, I think it is
safe to rely on it in Git's source code.

Thanks,
Dscho

> +		errno =3D err_win_to_posix(GetLastError());
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +#else
> +
>  int enable_nonblock(int fd)
>  {
>  	return 0;
>  }
>
>  #endif
> +
> +#endif
> --
> 2.37.1.windows.1
>

--8323328-304667906-1659963341=:226--
