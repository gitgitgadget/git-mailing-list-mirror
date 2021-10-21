Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBBAC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBCE60C4D
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhJULe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhJULeY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:34:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75857C06161C
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 04:32:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g10so155455edj.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 04:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/ndP+fALsdkrBvFWyXH6tHFNEaB94bsTUaeBqVayB7M=;
        b=CxY7Edi/HzkC/BbMdoYlY2D8Brbtad+rlymAHkg3Dk0JVpfot3WcetpbkAjtV3RUh4
         TvJdopOsb4+sEGjimilZkFVeV2+h6/3g8aXrOGZKNyAW7UPXtX+T3de/o2RWrk4e4V8c
         PgFUdBxWNSBH7lPsv7lbz+3Wdz1EGv8cigB9m4xil0D+wOLjlMFU7HbKLdVOXeiz1kkz
         dWpUjcnsK6JN3wcBMQ7QDWLSyuIjJ1dGDYvQVkr2pYItBw5q5bxWVpTdrE07mVkx4VMV
         oAD8Syp2gIOY9Yqd0ljUceDsRb4jbp4opYKjrM+Ubv3MLvBRJwEzQB8ZS8M1lBV0Y1KM
         SEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/ndP+fALsdkrBvFWyXH6tHFNEaB94bsTUaeBqVayB7M=;
        b=tn3/nWpnc9HpHo6QsFen0K8JrC65x/xRkGYiY5IdLnQosX81sRs4f1EEtHIjjb9DmM
         ylXwnJdn1EukfBqoJD726sCZmEvqe3A5yGL0SWPT0uFFnJm2lEHAS63EPonjlkmbcLsi
         M0jDpuQNMFqUz/wbZNJEVKB2g30DfP31+o9AWbikwpKf+qGycYXrFUYOFLajIgutqQSz
         GUqLUlXTiDccKNDx6w+HlR71jplCsYB9mEtTN3n1fllrNlYZ4PNyBd45aZk0NPVRyTMB
         E+aSz1glr2fQJlSTMC2aPF2MKpKMSU5WB6am3g0y4fc9HSvT2s9rwvKKTEgdn9nyRg58
         jwdQ==
X-Gm-Message-State: AOAM530MZWF2ZhBgRjDaRF5dgQyxidXW0ewy4rnWX4y0RDBcsbpaLXEt
        5N0cm4kZ288iHcx+W/pJ53M=
X-Google-Smtp-Source: ABdhPJyxQx8Z0KrN/58kRTWS5Qp9MAtNAlFXyMz8gP1WS5AFJNMvO7aQU+FAYqmKFg6HIKqb4E6mfg==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr6780288edd.276.1634815926879;
        Thu, 21 Oct 2021 04:32:06 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e30sm2371129ejl.117.2021.10.21.04.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:32:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdWIm-000yrB-Vz;
        Thu, 21 Oct 2021 13:32:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 10/11] pack-bitmap-write.c: don't return without
 stop_progress()
Date:   Thu, 21 Oct 2021 13:31:13 +0200
References: <cover.1634787555.git.me@ttaylorr.com>
 <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
Message-ID: <211021.86ee8emx57.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 20 2021, Taylor Blau wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
> bitmap writing, 2013-12-21), we did not call stop_progress() if we
> reached the early exit in this function.
>
> We could call stop_progress() before we return, but better yet is to
> defer calling start_progress() until we need it.
>
> This will matter in a subsequent commit where we BUG(...) out if this
> happens, and matters now e.g. because we don't have a corresponding
> "region_end" for the progress trace2 event.
>
> Suggested-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap-write.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 9c55c1531e..cab3eaa2ac 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -575,15 +575,15 @@ void bitmap_writer_select_commits(struct commit **i=
ndexed_commits,
>=20=20
>  	QSORT(indexed_commits, indexed_commits_nr, date_compare);
>=20=20
> -	if (writer.show_progress)
> -		writer.progress =3D start_progress("Selecting bitmap commits", 0);
> -
>  	if (indexed_commits_nr < 100) {
>  		for (i =3D 0; i < indexed_commits_nr; ++i)
>  			push_bitmapped_commit(indexed_commits[i]);
>  		return;
>  	}
>=20=20
> +	if (writer.show_progress)
> +		writer.progress =3D start_progress("Selecting bitmap commits", 0);
> +
>  	for (;;) {
>  		struct commit *chosen =3D NULL;

Looks good :) Just a note that this is in
"ab/only-single-progress-at-once" already in case you didn't spot it.

That series is marked for "next?" (with a question mark) by Junio in the
latest what's cooking, so *hint* *hint* for any last minute review :)
