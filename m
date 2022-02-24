Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF09C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiBXPav (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiBXPav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:30:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234891BA16A
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645716614;
        bh=AdJOH8Zs9jWiHSA/wzf0NpFgpe8PHv0c+3NPZVPW0Lc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NsO7qaYgIhj2+4gWDHwvXzduyxKA3aYZdgcQGCW4sOZb6iZ7zNULDxAYmcrOz3EOH
         TkvCBp+NXkz3SWZxIzK4I7Lqslw6GSdS3bKi9bl0oYz5D6U2CowFVD0JHUGnIYO/Uh
         nff4VBP+ZszyqqJTLrOLHWtkAKiIfNcccrA0xuBw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1nXgTP3xQA-00Be0k; Thu, 24
 Feb 2022 16:30:14 +0100
Date:   Thu, 24 Feb 2022 16:30:12 +0100 (CET)
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
Message-ID: <nycvar.QRO.7.76.6.2202241627150.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <69fc0998286cbc791f199710a68a2028080e1632.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:137UbzROoF4W9JK8cX0KyxNwP0YL/yix59vJkK630RkqA3aQoFd
 JMWGf2PyDiCI0s32EBVWdPkFQP1WLQZ/xwNUoJ7bZAp38DrEBqYF/niQ+eHvORfGu6bjM9R
 H6iO82wpER3qYo4X4WEqrBh14BEz6vcNmMP78JY2OfSK84hEbttzBYYHa5QGEcXWHetiA2j
 2SFp4xU/fAMcvj6O6BIOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BnwmmBAv9gI=:LQuKe0nZh9E0JOAidVxA0t
 W7h4Qdbx6UoQqGHyp6fAwASEvwlpYYujbCGJjylNfPB6qETdFmTD2fDQxYlKHGnNe7SpdIwRN
 cD+rUg6Gj3PGFevM/nKI2OUhIrJTe9Q1OrGmLDsnSlGEeTo/XiN0jy7LTTatd436gcZ3Ga/fw
 bxA23PFyWLb17urAyzi24xBp94RX+nijXRjaE42bzWgMVJLPmCNShg3GHsGdJ4ab0kffuoKhi
 4mk2BP8yUCghogi1EeDOjUdyJHdQh78RiCOSmHD0Xd0gUs2PtLsaIJPxFpXrkZD5F6yg2Iurw
 xiotIa3EKt0SxFPj7oribjaGBJbMiBJc/1m/VypNTkzwysk2CR4pNBBzHpJBLtGRhsZemZgwQ
 OosSGwo7KSqDwoQhZJhPKdVNVk2JERuHO0Oz+0VkO9TNb/K29IClvoIaH3huMjTOTNw5CIqit
 Gf8saPjnQRnSSwV02+CG3NGi1K3gwh4/vpL3j2QJ0aqxlLG5kSqOxvYcDDOqhAS8Pmk7MDmjk
 sPB5MS5uH+yNr0oAIH2lpf7ID33S7Dp9jgaiypv15BDpCxjptDKpFTaj88E38OqouucTVnKeX
 84TWvSNbG1LoBKByRlsxN9qb3Z9LUhWzsdDf4r0xSXpqPq4z+FclkpShzfhNbxTYiNUiU6R8u
 YlacjRRvUN/SkGu4Jj+NdAnK9uo9/HHMctKTVVkUy0AbKCRPatX5k+vuJs4qtD67BH8FXIbhp
 O7ZDijz0cpDmiDneWt/pD5XNUU32PdezIACRnNhNrbKwZvc6hijElHruNtfU3+ZlYrLzQvLjc
 Rus9H4aj4Y1/WB7/d9zdtq+9jppj11wSKpb1opSswUue6IP7UsRS8BS+s4ZZTR7p1HtJOlINV
 W9yFw/uydJZbAzODUTn8jmqISFsJLD1vlcNUZ1jZx6gZNAmqhnrsTpEo9W8/ZvaClIel0MBVo
 F67tXdKftOZltpiQXKpme/LtRHPwi3fTZz3eyldKhqNKkl9GsHvY9FODU/uTZh0tLVjnQlr20
 qvOkVYhBhbZKq2+rreEoPhf1SRvG5OtkgHNuSrjK/dCKPdzWSTtxBKbANi/B2D8P/eaN7CQCY
 8Xug0V9yiTXuyY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

something I missed in my review, but which causes failures in `seen`
because of the interplay with `ac/usage-string-fixups`:

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

>  int cmd_fsmonitor__daemon(int argc, const char **argv, const char *pref=
ix)
>  {
>  	const char *subcmd;
> +	int free_console =3D 0;
>
>  	struct option options[] =3D {
> +		OPT_BOOL(0, "free-console", &free_console, N_("free console")),
>  		OPT_INTEGER(0, "ipc-threads",
>  			    &fsmonitor__ipc_threads,
>  			    N_("use <n> ipc worker threads")),
> +		OPT_INTEGER(0, "start-timeout",
> +			    &fsmonitor__start_timeout_sec,
> +			    N_("Max seconds to wait for background daemon startup")),

Git is about to be stricter about these option usage strings: they are no
longer allowed to start with an upper-case letter. This diff fixes it for =
me:

=2D- snip --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 24 Feb 2022 15:48:01 +0100
Subject: [PATCH] fixup??? fsmonitor--daemon: implement 'start' command

There is a patch series in `seen` that errors out on option usage
strings starting with a capital letter. Let's avoid that preemptively.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 builtin/fsmonitor--daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 591433e897df..775e4de5584d 100644
=2D-- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1504,7 +1504,7 @@ int cmd_fsmonitor__daemon(int argc, const char **arg=
v, const char *prefix)
 			    N_("use <n> ipc worker threads")),
 		OPT_INTEGER(0, "start-timeout",
 			    &fsmonitor__start_timeout_sec,
-			    N_("Max seconds to wait for background daemon startup")),
+			    N_("max seconds to wait for background daemon startup")),

 		OPT_END()
 	};
=2D-
2.35.1.windows.2
=2D- snap --

Could I ask you to squash this in before you send a new iteration?

Thank you,
Dscho


> +
>  		OPT_END()
>  	};
>
