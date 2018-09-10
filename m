Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBDF01F404
	for <e@80x24.org>; Mon, 10 Sep 2018 17:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeIJWCz (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 18:02:55 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42929 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeIJWCz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 18:02:55 -0400
Received: by mail-yb1-f193.google.com with SMTP id j8-v6so8210819ybg.9
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5vCmQvw6/5EuFSePp5H3V1LgSuDT5udb+FzZSwKP8jU=;
        b=qpaR6dDh3o28vjfUTZcXZj8B8C6kHtYXKuCy8np8f6t51+A1DQEKUKvT79/G/9gr42
         0qhXpVLNxbMNhX6AcjTznqBXb4XF0yAAa4tmP2TEyOpV59GuGzMuNJ+SSjZ3XhLiUeU/
         yNzCfpXBSOKMGrtoto4I5cU6XEtftNQnGOSoH7vhYL+RZMag3zixTSwRxmvkcyg0qE1t
         qC9idZfvB5QOOP6ceVNNpq3D9yMWA+SOjzbTl/cEvEgL65R4UIPUe961kl67llQN3jLd
         eQLW6MQgJZyMvevAeRpTTExhFs8Z4pm3zIHdKpkschM3xG22ZQSdsV+YgHfXg4cZh7Tv
         75XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5vCmQvw6/5EuFSePp5H3V1LgSuDT5udb+FzZSwKP8jU=;
        b=FZZuTKo+cfC6R4Sverza7LcMftffWYCRXmjgne7p1+BdVEu6dyaLYlwwaMK9EQPVWI
         Mp0VfiK7RbVR3iwbkG/j+Stb425NnGsOnMbMJi77GqdRjtdjTvUxVYVaxC/2O4XBTe5T
         GbMH7HNNqfmLnb8MuKZBvZbWd5sfg8Ffy90rs7oK+jHdq0cUMfIyccczPWeRQI4euP+t
         aR9COc1+iZXo7pTffKgtKRkmdmJhHrKFqKSVhKtta0EvPyajiUkuV/ocVcDzifj9NHV0
         M4gUaJxLITZvwnKtCFXMEa/X+LvFeLqgxGC4gt5njlyvO2Fpgi2BgzewQ9W05VE8kXKf
         d7kw==
X-Gm-Message-State: APzg51CzIQD++VWnlXlaqikXlehr8UyuOzwcHMeAkaPVwl/CmwZhfMWF
        caKAe96rEv4SmDI5wiW/8F5gDZ0gX/3mRhwTpLxmww==
X-Google-Smtp-Source: ANB0VdZ7o27ip+VHSJWKJq32jc1VXOHGY7s4RhlXSRGhXswkG0CwZXx0mQ0spPQb3W2+FK8iV+XrlGo9fYEPBEGpmk4=
X-Received: by 2002:a25:8205:: with SMTP id q5-v6mr3615770ybk.191.1536599271740;
 Mon, 10 Sep 2018 10:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <85d96d65-2e74-7877-80ab-f74fdb81d500@gmail.com> <20180910162911.31920-1-benpeart@microsoft.com>
In-Reply-To: <20180910162911.31920-1-benpeart@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Sep 2018 10:07:40 -0700
Message-ID: <CAGZ79kZmmULJHrPJS1=areXAP-nSK0_9UOUOry2Hd6aHSBrAiQ@mail.gmail.com>
Subject: Re: [PATCH v1] git-mv: allow submodules and fsmonitor to work together
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 9:29 AM Ben Peart <benpeart@microsoft.com> wrote:
>
> It was reported that
>
>    GIT_FSMONITOR_TEST=3D$PWD/t7519/fsmonitor-all ./t7411-submodule-config=
.sh
>
> breaks as the fsmonitor data is out of sync with the state of the .gitmod=
ules
> file. Update is_staging_gitmodules_ok() so that it no longer tells
> ie_match_stat() to ignore refreshing the fsmonitor data.

Wondering how this came to be,
7da9aba4178 (submodule: used correct index in is_staging_gitmodules_ok,
2017-12-12) last touched this line, but is unrelated as the fsmonitor
behavior was
there before.

Before that, we have 883e248b8a0 (fsmonitor: teach git to optionally utiliz=
e a
file system monitor to speed up detecting new or changed files., 2017-09-22=
)
that was written by you, who knows the fsmonitor better than I do (or Brand=
on
who wrote the commit referenced above).

Looking through the archive, it seems that we might have more such hidden
gems?

https://public-inbox.org/git/f50825a4-fa15-9f28-a079-853e78ee8e2e@gmail.com=
/

Anyway, I think this is a better fix than what I proposed for sure.

Thanks for looking into this!

Stefan

>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Helped-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>
> Notes:
>     Base Ref: v2.19.0-rc2
>     Web-Diff: https://github.com/benpeart/git/commit/ed30e1a885
>     Checkout: git fetch https://github.com/benpeart/git fsmonitor-t7411-v=
1 && git checkout ed30e1a885
>
>  submodule.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 50cbf5f13e..1e7194af28 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -65,8 +65,7 @@ int is_staging_gitmodules_ok(struct index_state *istate=
)
>         if ((pos >=3D 0) && (pos < istate->cache_nr)) {
>                 struct stat st;
>                 if (lstat(GITMODULES_FILE, &st) =3D=3D 0 &&
> -                   ie_match_stat(istate, istate->cache[pos], &st,
> -                                 CE_MATCH_IGNORE_FSMONITOR) & DATA_CHANG=
ED)
> +                   ie_match_stat(istate, istate->cache[pos], &st, 0) & D=
ATA_CHANGED)
>                         return 0;
>         }
>
>
> base-commit: c05048d43925ab8edcb36663752c2b4541911231
> --
> 2.18.0.windows.1
>
