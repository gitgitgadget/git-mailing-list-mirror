Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8283AC433E9
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542F065020
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhCFLm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:42:29 -0500
Received: from mout.web.de ([212.227.15.4]:37527 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhCFLmY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615030941;
        bh=QYxrGjSMVe1mvVyLcz+ZNAj6Bh2GbzYaYKyrq6LbkUM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WEZ5B6/Agk6HRdmCvpzUpH5apLGvi01OGCwgdRtQ363HuQ+MzPkL/MlppPZ0n0/uI
         y1qO3pfq7aMr8zbVgd0HXl/qN7MR62iDoH8xOTP6lUxGDAraYyCnRYkDd7PtUgqQFf
         nze8DdiHs0GyMlktFmTh4Oaq9O6dlkw9ALWtahf0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MODiX-1l7AfN455l-00OkGm; Sat, 06 Mar 2021 12:42:21 +0100
Subject: Re: [PATCH 5/8] unix-stream-server: add st_dev and st_mode to socket
 stolen checks
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
 <89100959528c6a3c16622cf86e6920273f5ed2d3.1614889047.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <05f4cb97-5d78-4698-795d-311197052e22@web.de>
Date:   Sat, 6 Mar 2021 12:42:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <89100959528c6a3c16622cf86e6920273f5ed2d3.1614889047.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:18ks/NxuR4P8zgUBMfs5so+D/PMlQAjwVnvztAY63f2Y2aafFdx
 shJJHw1cYpJoo2gMDzl2ZW8Q1vQGAcaBfLOl4tmyu6HAaRiezM9s3iz7XrNdLDngGw9brXP
 9NHWsyxBS1bVKB8VuPToWvfUiPhq6gGSl04FnjeRJpBTiHqY9jCN+EmfF+YkLOOkDn2lG1R
 AAlqdh42oLdOpmKu+ZHUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RLgNBNmItOQ=:gUAL7YP7hBXkor+zysh2TQ
 sKvTvrRwpZEUgDt+DjytLpPZ99LlNl+saOEKn6arY0cUw83lO9YUAaIYknXHvbzZ5xyFxI3kb
 fA0mn5MsxMPS7PF9/9z7s2N3EYhr8BdwOXFu0sIPA7fqHMsweW5PzB/6gHIIdV8wb2vZRVhu7
 2jBJiiGf02I0gYseKPdJB+tkHp0zvGIdDucz+yScw6E3hlMV1GPh/E3P1jRjDH9MWqFaqIpTC
 LH/1TQZSd0ECGvD2Oo4KGWiKlJ7AaE5Ex13a4L1H4gXDGIYt6JsV2WizkvW2v0DNKYgNqIpQr
 jGdiP9ya3+C53825rY3qysxpbQ3QuSg9p4kd1I/ECtlj3mbfvWBUBpxeR0WttcBLx3QPHuKoy
 qQhRJpO9vaDkW2P7wT2UUldjq65WuqJYh1n8tQRX+IprERcpjL3OYOFGgiVFQAx11aIxOgjeK
 uh5d7322lcwlmgYRSLepJGlMSUvCgn0Hl9JesxaCrh63nHKtrCUvQnNySF8MeXepQZhy+f/h1
 sePogeIe/Rt9jCniqL5YifuW+bl7/4ArFY7jSP53qwY4pDs8mpmQ+zgzCnoQs+cx6GD3zAwOn
 EU1OV1m1w19VF0Kq1B8oiyjnZLnytj2Lhx62ZuV+3SpXWMy12bzM0nQ7oekwQeFXWNIbR4fMX
 kXoqNzGYZ9X82ppIYNGK1SYO2vuCOpWkmwBfCMl1zLMkG6b0TS+S21gE8OZQ12++gtXNSn2yD
 LukVixfI8UPpISnWVAUU11Xr62PkmTIF5jlaqNL7a1MQdtk9D9zAEEmcwazWmu4Bqqrzme1de
 u0+eYJ2C0SEtBWyAi2xHrU8dr6WCiZiheiyKcEnm/ZPk/E5XB1R9NejsgVaO+Pp9gnVy0SHVq
 uCZ/fuJsRi2LHPiIz1Pw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.03.21 um 21:17 schrieb Jeff Hostetler via GitGitGadget:
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> When checking to see if our unix domain socket was stolen, also check
> whether the st.st_dev and st.st_mode fields changed (in addition to
> the st.st_ino field).
>
> The inode by itself is not unique; it is only unique on a given
> device.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  unix-stream-server.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/unix-stream-server.c b/unix-stream-server.c
> index f00298ca7ec3..366ece69306b 100644
> --- a/unix-stream-server.c
> +++ b/unix-stream-server.c
> @@ -120,8 +120,11 @@ int unix_stream_server__was_stolen(
>
>  	if (st_now.st_ino !=3D server_socket->st_socket.st_ino)
>  		return 1;
> +	if (st_now.st_dev !=3D server_socket->st_socket.st_dev)
> +		return 1;
>
> -	/* We might also consider the ctime on some platforms. */

Why remove that comment?  (This change is not mentioned in the commit
message.)

> +	if (!S_ISSOCK(st_now.st_mode))
> +		return 1;
>
>  	return 0;
>  }
>

