Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD710C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 04:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866AB64D73
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 04:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhBHEcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 23:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhBHEcH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 23:32:07 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C08C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 20:31:26 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id l23so1351051otn.10
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 20:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jyyf/NeyE9ESW12//Egy9BzvJbvMemHA2R5Lb6C0kqs=;
        b=dydTSAk+7562NscwOn7CacCjj6oDuOab0gyFwUHImh1hVcB8Ae2LF0hcFlpuCoEq2P
         t/uqvBv5r0jwVqPGuBtl+MpTL+gotj0lDlOqPfZuEodf80/aqJTxhxTkESq5bFV3gj8B
         HxAqe7/RrSP58pdU8INt2UEipPJ7SefRmCcw6N86u0kp9vLTd3BEwPMjAwiTuPaIRkSs
         q0SMm4fdDq6iCV2gWhwrN+D+FNDn4gXqfawphXx9Ih+g1wkJ5DMM153RJGfKWdf8c02j
         R+nmga8ZIOQjH2MX66oGpl/7w6zr9JNzoAeWpqVan0uE/UXIf1VD2PnPGG4B/UK3Qpdb
         PomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jyyf/NeyE9ESW12//Egy9BzvJbvMemHA2R5Lb6C0kqs=;
        b=rj9NruMfkYPO2c6rNNsRyzcnSIflhDfccBqwn09WGl9gJTVLUYvaVx4NBSS4ZDdpEP
         uS6Q6/TMt7hRhv3OaTHpH/ZrYyqX1wdZt93fipL44LYAsslHNyCBk5uYW/XIwDTW/DSy
         8wbmV1/7XiC4ohBFlv9Bq/MAoMoinfmBRR0TlPVo26GPYlJNvzgbLf15wHdhPwBU9NPm
         +cRH9NBQTvbQaSyCIe6fUEt0BxK1d2R2U1xm/Z010R7xNYXfzbQP7MQP5NYcGOQEubpF
         bTRS9Foy+KeejHrXwG4vMu9WlOXHUHAYjYh1IilNcPtb5IcKERu57Un5Ovxi9xwMlv63
         ZYlA==
X-Gm-Message-State: AOAM5304W2VI7UXuae46/oaTCz+pvYi8YWoQCc/dp7Zm94brZ9TWID6L
        kk52ehkG51vb3IiNNdo9S9XJm2G91Ri6sk3XwLo=
X-Google-Smtp-Source: ABdhPJxg+DoEHJKflB79TmLFoAuOZFPbW5W3BAivUnYUMq4A8l70etbgfq5Dsg60s8IY6dGvb6NxBBaP0vMSIiq9i5k=
X-Received: by 2002:a9d:7550:: with SMTP id b16mr4916876otl.184.1612758686343;
 Sun, 07 Feb 2021 20:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <CAPig+cTQaP_FvixPiwosPybxy-C91pvV_FvQfwf7cO0QGpH7UQ@mail.gmail.com>
In-Reply-To: <CAPig+cTQaP_FvixPiwosPybxy-C91pvV_FvQfwf7cO0QGpH7UQ@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Mon, 8 Feb 2021 10:01:15 +0530
Message-ID: <CAPSFM5fG1jSUM1tuw8UCzkLigpM9SqVqDO=wA1CQ_fs5Xy+04w@mail.gmail.com>
Subject: Re: [PATCH 0/7][Outreachy] Improve the 'fixup [-C | -c]' in
 interactive rebase
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 8 Feb 2021 at 00:28, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Feb 7, 2021 at 1:18 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > This patch series is build on the top of "cm/rebase-i" in the 'next' branch and
> > improves it. It fixup the source code of 'fixup [-C | -c]' command in the
> > sequencer, do some fixes in rebase -i, improves the 'fixup_-C' like commands
> > in lib-rebase.sh, update the test-script 't3437' and fixes a typo in the
> > documentation.
>
> Thanks for working on this. I looked over the entire series and left a
> few minor comments. As mentioned in my [6/7] review, you might also
> want to consider splitting that patch into several patches (though
> it's not clear if the extra work of doing so is warranted). Anyhow,
> aside from some botched indentation in [6/7], it all looked clean.

Thanks for the corrections. I admit there are few silly mistakes, will
fixup all and
also split [6/7] in the next version.

Thanks and Regards,
Charvi
