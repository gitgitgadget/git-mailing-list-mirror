Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A04FC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 21:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346889AbiFCV2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346661AbiFCV2G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 17:28:06 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A06E37A2E
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 14:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654291658;
        bh=DQBufQf1TSI4rS7eeh6jc/Q/fyNxO8duKJHa/YldRh8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=nqsWmmOjkIIEsO7WMq38A9PFoh5aT0i9Nj2h548H7zdZC/ydYAqAwfx+uAGxjJ2Dv
         WI0rcvmrNrt5QJ1r/dgHqAIdEtmXnS/4QlrE1v2EOMsfp4ojUym8M9MqibVNfBALNz
         UNdoW9X949tjaViyoZ439ex7swUG3ZN/Cx3XINZU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAtwh-1o44Sh278j-00BDlW; Fri, 03
 Jun 2022 23:27:38 +0200
Message-ID: <20bc49fd-4142-ac63-0fcc-30a5c68fa82b@web.de>
Date:   Fri, 3 Jun 2022 23:27:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 02/15] pull.c: don't feed NULL to strcmp() on
 get_rebase_fork_point() path
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-02.15-4a055969ea5-20220603T183608Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-02.15-4a055969ea5-20220603T183608Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ykz97UdbPjmhPeP6IWqDRDJ9zzhLDB80zRseIZ6w5ikj1HBP8nq
 ShRgAorDmAD1VhK1PiDpE3jva+0GV3NyNpEevGnRgNaZrYrmyln2BXidHNZONPs1zR2GyFG
 1plLfn1WvoPGDw11CsHq5dgbvBO8yff07MDaUy+ByiDuVI+qgKqTNKcLEUE352X8E3JSc8Q
 975ImL0Ufl5CEN1+i/tCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G13rCbPNcAA=:vXHjcra5Ky/g8eCsWerv4g
 U+jPaS6vE4kcKUHhAd+Q8RGMvCuZqs3iKsfb0+4Z1n91fhqW/Elo2q1tRoXtN8N+stjLO9aaH
 f6KvtCgt/ElJepyNMQPhKFYc3imMazeIP54FAOlPQaIo8E2KTDfqd1hAn8lDt7+xXA/2W/PvF
 /9vpF3nJ2wlhFOGaBc4hkUs/N7Yp7njtWVbxj6j8QRMVcfcCMpFR1NFQZxRuFD4rp+P/isko7
 sgSRseNWLbaqXE4B1Tqch3UMqdMoQUb0WCAHdodDE2hyt0MahfeuhSC5n/RcA/9gavwTMcyuE
 aFggjEfrxNbKV9Td5VdRNhneMe/wpjcz3LM1BGG/bld7GO+Ly2uNjuJsBQ4z2XeEItoXQrPBU
 SWb/TJxlyAZcbqfYaDvvidRD9sT6W6nQ+6tqjrkwNfQb0ai/Wr/hlc3/RYDZ/3iS2Fzp6Sia+
 Ggf/FskhNaLomDExNAG/s8NFjYYm8Uj6EONsDuM/URpFUlN+Tcjq/4sKyrjoHPo+2D+kRjlG6
 lnScV5oMEj5uTpblSiKNb9gYcGhS/3wJRwG7QuMaEkbMhSieFiYZks58viFjA624kca7yHYlA
 RMXn87QrkAYo9Q5i8VpLXhwtLDhMCSbqW34kRg9Vso9PVgWZwTh+61XieqE9dTvrkyz3WXQyj
 ftl/cYpVxTTxwyHls4TL00PEuZmjhVaUIb7YZ4l/JXC204EDMDN5MN//2Z+TnyBAFVUbh/RJG
 S099FiIALf1GakGxut6NviOYPfTmd6H40boRKXCcFmKxWqyqR0pQaxqFDP7QO6sfnUcdNcGge
 kAxLUuCaYe8gAnLLdTGJXzV4djCKHb2setF5vWt1N2mLINif7gfQCgwqJJmK1pIN7fZxuPdqV
 7icSwp+wVzKJVkRfVDSRgC6UavbUIyaI1bLWTvpbqocCBSn1K6AZKdDmwR3SrO4r8tHOezBX5
 9sTSED4KVZlDHNxdDA2rqHWKuZ290RHYxaAocDNtHSRqu7AbSmsXeCmRPT/xjZDG3aDmLfjar
 LgB0TRjs3v15UmcBVV9JBTW8IuwELQwX2BXbQyjKmmatrT19cC+fpjpFooYu+eYX4C/M4gVdY
 1U6x7uQO3rFi4ITLOPbJ/omRuC5hbId3aH3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.22 um 20:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Fix an issue with feeding NULL to strcmp() noted by GCC's -fanalyzer,
> this fixes a bug in 1678b81ecce (pull: teach git pull about --rebase,
> 2015-06-18).
>
> In cmd_pull() we could go through the function without initializing
> the "repo" argument (the -fanalyzer output shows how exactly), we'd
> then call get_rebase_fork_point (), which would in turn call
> get_tracking_branch() with that "NULL" repo argument.
>
> Let's avoid this potential issue by returning NULL in this case, which
> will have get_rebase_fork_point() return -1 in turn.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/pull.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 01155ba67b2..ed8df004028 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -756,14 +756,16 @@ static const char *get_tracking_branch(const char =
*remote, const char *refspec)
>  		starts_with(spec_src, "remotes/"))
>  		spec_src =3D "";
>
> -	if (*spec_src) {
> -		if (!strcmp(remote, "."))
> -			merge_branch =3D mkpath("refs/heads/%s", spec_src);
> -		else
> -			merge_branch =3D mkpath("refs/remotes/%s/%s", remote, spec_src);
> -	} else
> +	if ((*spec_src && !remote) || !*spec_src) {

This is equivalent to:

+	if (!*spec_src || !remote) {

It's easier to read without the redundant term.

The patch would be even easier to understand as a one-liner that just adds
the missing check, i.e.:

-	if (*spec_src) {
+	if (*spec_src && remote) {

>  		merge_branch =3D NULL;
> +		goto cleanup;
> +	}
>
> +	if (!strcmp(remote, "."))
> +		merge_branch =3D mkpath("refs/heads/%s", spec_src);
> +	else
> +		merge_branch =3D mkpath("refs/remotes/%s/%s", remote, spec_src);
> +cleanup:
>  	refspec_item_clear(&spec);
>  	return merge_branch;
>  }
