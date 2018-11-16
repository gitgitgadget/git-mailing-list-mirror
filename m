Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD941F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 18:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeKQEQr (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 23:16:47 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52758 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeKQEQr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 23:16:47 -0500
Received: by mail-it1-f194.google.com with SMTP id t190-v6so36058046itb.2
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 10:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eF8GoYOzQ3R/My53rVEhzdmoeGtrc4nyO9Paw3WKCDQ=;
        b=V5igpy8hT7LzvAZCHTHdIsx2H5ZSwfcyydZPTI2fsrHSpEwpm9043AFwshHbmQhsAD
         toZ3pOO/StZkvl6BkRZoeK750snINewDp0qCiLumbSldRlYCyyjvDnFmI2Uq5BnZUiqq
         xU5KxS1Jb810r1DaF3t+WF6UU+qkrWkeoX+Y5oVmF26Mk2AGNJ679d9raNj9f8O2aQxO
         tYgfGtyjo0nNkK/5fR6hhaRTSSSig3g6FGfM7NKUjsufzi1euhiL0Ln34BakzOzCmq+a
         44Ud3rcX0S3kyCNrV05Oc6JfFnt60DB+yJ2Iw/ucnELknseP7Q0u0osCP1lxhsrQ+cQz
         wStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eF8GoYOzQ3R/My53rVEhzdmoeGtrc4nyO9Paw3WKCDQ=;
        b=bhlFNawifOyzqbp8ZiA/IepXLlYXblYfvwX/LwJg2EZgp6GrpaaI/TzO461d9KQJ58
         ZegcnUJbs+BSqyrxn2GMVoKgCm4VjnuGPmgI4sCmfx69TODHsSyOMzTt3xeNoVBl2D4r
         fGZiCza3HOC/g0J+WR7kNeUeRYwRqRQ4q+ez8z8oRm29yjAPJCJbn9pxkBGCpHNUQJeE
         d69vBnySDo2+WQGL1PAlE4246tSrePao+S7MlcKFNOX088nubEPtAL75yWTyc675ewO8
         VRr8TO8m/a55Uf1aFdsQgOcYmJd4nZG2V31cbu9Aeu23cVfsBrHC+/EbWjkmJeYjjhtC
         O9gg==
X-Gm-Message-State: AGRZ1gItZaRbgaQ5mXk7D4vT20CRswvD84D5lcGF1kjKW/PLRdYuA3Pc
        TxAT4G+d2qq7ss8MmMOALB1vxMkkQ199asE4bqA=
X-Google-Smtp-Source: AJdET5fn7VKy03PcItQbOJd03BdKQSnEpGCJ2kV9QML/lP+rUNrq6q+sHLIIGd2kjyPvfQt4yg6afgCSkVVw/TGoAxs=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr10269855jak.30.1542391402919;
 Fri, 16 Nov 2018 10:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20181116173105.21784-1-chriscool@tuxfamily.org>
In-Reply-To: <20181116173105.21784-1-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 16 Nov 2018 19:02:56 +0100
Message-ID: <CACsJy8Cdk8YQWJM1HAFYWB6qJpepNQoj86yrTqF9Rg3oN0TeUA@mail.gmail.com>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same permissions
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 6:31 PM Christian Couder
<christian.couder@gmail.com> wrote:
> diff --git a/read-cache.c b/read-cache.c
> index 8c924506dd..ea80600bff 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3165,7 +3165,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
>                 struct tempfile *temp;
>                 int saved_errno;
>
> -               temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
> +               /* Same permissions as the main .git/index file */

If the permission is already correct from the beginning (of this temp
file), should df801f3f9f be reverted since we don't need to adjust
permission anymore?

Or does $GIT_DIR/index go through the same adjust_shared_perm() anyway
in the end, which means df801f3f9f must stay? If so, perhaps clarify
that in the commit message.

> +               temp = mks_tempfile_sm(git_path("sharedindex_XXXXXX"), 0, 0666);
>                 if (!temp) {
>                         oidclr(&si->base_oid);
>                         ret = do_write_locked_index(istate, lock, flags);
-- 
Duy
