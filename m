Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A30BECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 12:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbiIBM1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 08:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbiIBM0V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 08:26:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114EADDA8F
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662121362;
        bh=/4lurAoR8S7G9MWWs4IuJCG+02JLIICx4nzLZDfVw9c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B3IUPvRoIzcu3dgBDijx35bpy34jqGWrPUhwd0AlGbOaq17zhyQAV3ye4OwxsQkWg
         bWSN7puiD4jE1xeD1bAHMtMPFV1qI8Z6NXXcHdPp5ZTJ2vr58dyIXxthYloqhWGDWK
         GmQnOVwMm8NpFekjUOyQsGjdD+2cNHOpnhDsxZ04=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1p0Nhn4A2I-00fP7F; Fri, 02
 Sep 2022 14:22:42 +0200
Date:   Fri, 2 Sep 2022 14:22:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Adam Dinwoodie <adam@dinwoodie.org>
cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] t1800: correct test to handle Cygwin
In-Reply-To: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org>
Message-ID: <4s7o04s9-3052-rqq6-584n-978p9758p580@tzk.qr>
References: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZH74soZfJtrhde4I7BOEnGdhMFk3LDQNz+lYyNQVHRMPGDHEJd5
 RVZLmF+3eyZThJypZNiKS2pSezUSKMcMsY/GzVrG6gAidD+7TaEXhObiEP+5qp3N/NRNS0s
 yQCwChWi6TfyTMoEf8And6iVROy5e0W6pAOft0/x+bcOSq0ccY8GdQAxdryTMB33G4cHF2V
 NIko53ft+d3XGxoaBrFUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2tiRWaTAmlU=:i32HBmLVVbgjl+JyX3OL/Z
 v266yGXP252ekzhK2DhJKXnW+4a/n26/k2RHjblzjIor/ivLMycupzCLA1bFjorcbwQpXrfeu
 l3BotX9ObDRQk0VJqLh3x4QrNcR6hadss7US3rITmqJX+npt+12bWkyPNstmSc2IHwKA+44DF
 JhiZfx9XSRJjrMkwkSmky3DSHinhLCeC9W2p+/RVq461FIz1LcWXormvnOZefJqbI9HkcUc8b
 LbfTAe18HUu/l9MPqYCqfdNUDQPqe4Bskd7kCIk263L4whRMyOTTSB030VJdIifj6WosCTulH
 mb/uODeSkeEDXfOtMzNwRzaeGg2SLx2J5+yukF667biOZ3thGXsqyFI7IdJT0P3HCsZ5nv41I
 RBvSuqUME9qTRghe1SBeVBks0oxwJJu2TBpNg/+mKotZ4mrtq5V9PFKWlaxr9zLq4nRjJFzfP
 tCOtv+S6De0ezrCkNPRjKxYKjkYIkTWc8mz12k8H5xIQCb+66JRA2FoMAIFMg2WODDmeuLTme
 QyqJBGhvGHH0BKrXGmWLMHNOVZZa7v1uChpEGbwAcG6WdHA9G/j+3i8hPvmcVZJeyJYYLlBWh
 QrTQAeHKOnkK1kGQUWg/FPOKFBpM3AVPN7qv7rEwlWp+WKEtbi77rtWFvyzthET2ayaYEQn/O
 htV1fwT5zZxZm7z6Kct8nfrinA3ARGqCAlZa1qnxj96GvIx9njfK821bx3s/bfzMqwYy8Ug8A
 pUVjqthyCYHrU2pP/cqRmVqkOJ8WLPFBKMVrZzziIy3ka4qjYAi8a0RK0pzZDYpsVLGO2RZWf
 RqVY19ifd4hNumCS3GPchMBHWC60eSj+BH+eIR0+o+LfKC/uopgX+MhusmXRhODneCKumBtI9
 Ke35kFCWqNRsmx3uvdkIojsWSea8DOAboKDQ2Jpx4nLxj/ddWjOQ742n0wAemWXw9efvkygCK
 ME1LRbKRPgMlqNAqmT9KC+s689przzfBgGRFoU2Ttojy0NZBfNYvnIQUH1pB/emN3AxPFAgOM
 CtmsrQMhXnD9xqajZrGLUGR9HSIk2cBjkmT9gzrorIs8lkcbw1xY0yVWtDNEL9mmXmcygV4Oa
 ogIFQynGEIqwpTxSrPxaXI59Hc9HEfwtR1OOiCuxn033hmbzYI7hZZWc8zDaDRb7TMCiKc1Ms
 or2qfNNaeUt5RQi/G992PBCw0a
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

On Thu, 1 Sep 2022, Adam Dinwoodie wrote:

> On Cygwin, when failing to spawn a process using start_command, Git
> outputs the same error as on Linux systems, rather than using the
> GIT_WINDOWS_NATIVE-specific error output.

Given this explanation, I would have expected...

> The WINDOWS test prerequisite is set in both Cygwin and native Windows
> environments, which means it's not appropriate to use to anticipate the
> error output from start_command.  Instead, use the MINGW test
> prerequisite, which is only set for Git in native Windows environments,
> and not for Cygwin.
>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>
> The job of setting Cygwin up to get Git CI builds, either as part of the
> main CI builds or as something using separate automation, is rapidly
> rising up my when-I-have-the-time to-do list...
>
>  t/t1800-hook.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 64096adac7..fae8b2faf9 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -159,7 +159,7 @@ test_expect_success 'git hook run a hook with a bad =
shebang' '
>  	# TODO: We should emit the same (or at least a more similar)
>  	# error on Windows and !Windows. See the OS-specific code in
>  	# start_command()
> -	if test_have_prereq !WINDOWS
> +	if test_have_prereq !MINGW

... this to be `test_have_prereq !WINDOWS || test_have_prereq CYGWIN`
instead.

At least it is my understanding that Cygwin is the special case of the
special case that is Windows.

That is, if most scenarios on Windows were behaving like Cygwin and the
mingw-w64 build was the odd duck, I would understand to restrict this only
to MINGW. But I think it is the other way around: with Cygwin, _despite_
being on Windows, we see this Linux-like behavior.

Ciao,
Dscho

>  	then
>  		cat >expect <<-\EOF
>  		fatal: cannot run bad-hooks/test-hook: ...
> --
> 2.37.2
>
