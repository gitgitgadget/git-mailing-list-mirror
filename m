Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20CF51F453
	for <e@80x24.org>; Mon, 22 Oct 2018 04:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeJVMpe (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 08:45:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39321 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJVMpe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 08:45:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18-v6so1510634wrw.6
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 21:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=n63sqVIKdWF29aI1Z12GQnGaz495JNzN9dkKC69u570=;
        b=YpmmYUqeVaRBK6tTbsMzSBcwq//Hz2tVmiICI5KJwhs2DORUhM8khWzXcYHVV+8qum
         7LjbBOrxZLp+6Mf6ApietrUc3I4rkA3u290Yf3m4Q94kIuLrhopOVywvTIsg5uPGnXIJ
         boeAVmmPfVcL/Y/drUAGkLsr4oPt1D+UXYBHDMR60FuWqUloxVigEwqA9iGn8JZBtEMM
         iVs7rBu+zg15CvzeyD+79vdZ+zVUuGb9paaBLmNSY9OMZCKm1mCyhO6yTGXAl9MGAaNr
         Aij77KpiWKO7jcj4zuYsowVLXTuQBbFIkz7tV+sbnCBO8xohGqnmeu6Cfzhq5+2P+IMu
         04Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=n63sqVIKdWF29aI1Z12GQnGaz495JNzN9dkKC69u570=;
        b=ssergPEYaCqfiJqFdgltmzqv1DMd69zRXifX6TjQ0aYtuMWASzWKVxPfK1B9LL1AQs
         t4gKEvGmFF5o/X2qu0NPQqXdXvT85BI28z6L8ofkDVeuoURVLPKMIsdR4zXavBOhDQ6W
         aylbd5+zilRIWhdD3v9LxZu/X59L68NkNB1BsceDVIMiLiNQ6/5P9iV1yLZzSbrCimiu
         AujQrb9U1+lIQVFAOwSJycict9tZ2jpRhUyx7evuoBE63VKIj1+m2NHLCDn+je2YLUDv
         rG1x9/f5hQVoQMdYOo2zqb1Ad67YXheP/GYnlUym1Y7y1KOPGsYnNcLdPGD0kAB41UPu
         WWeA==
X-Gm-Message-State: AGRZ1gJUO42hnpYNOSa6AR8hnid1DZ7DoUh3JAhHoSiiTgtjtO0WH2RJ
        jqJ99v5IhSOAWWXPeFLOouY=
X-Google-Smtp-Source: AJdET5fZkklaFLzS9q+ZY8zP8am5aAfwWBYIxgQSMf3cUtUzwZBK/G/KgrS1YeKaHJJGdRQhXG0Plw==
X-Received: by 2002:a5d:410a:: with SMTP id l10-v6mr3428652wrp.61.1540182523782;
        Sun, 21 Oct 2018 21:28:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e6-v6sm24620202wrc.70.2018.10.21.21.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 21:28:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 2/8] Add a place for (not) sharing stuff between worktrees
References: <20180929191029.13994-1-pclouds@gmail.com>
        <20181021080859.3203-1-pclouds@gmail.com>
        <20181021080859.3203-3-pclouds@gmail.com>
Date:   Mon, 22 Oct 2018 13:28:41 +0900
In-Reply-To: <20181021080859.3203-3-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sun, 21 Oct 2018 10:08:53 +0200")
Message-ID: <xmqqin1uwqo6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Subject: Re: [PATCH v3 2/8] Add a place for (not) sharing stuff between worktrees

"a place"?  Missing "in $GIR_DIR" in the descrition made me read the
above three times before getting what it wanted to say.

My attempt to improve it, which admittedly is not great, came up with:

worktree: convention to make per-worktree things identifiable in $GIT_DIR

> When multiple worktrees are used, we need rules to determine if
> something belongs to one worktree or all of them. Instead of keeping
> adding rules when new stuff comes (*), have a generic rule:
>
> - Inside $GIT_DIR, which is per-worktree by default, add
>   $GIT_DIR/common which is always shared. New features that want to
>   share stuff should put stuff under this directory.
>
> - Inside refs/, which is shared by default except refs/bisect, add
>   refs/worktree/ which is per-worktree. We may eventually move
>   refs/bisect to this new location and remove the exception in refs
>   code.
>
> (*) And it may also include stuff from external commands which will
>     have no way to modify common/per-worktree rules.

OK.  Establishing such a convention is a good role for the core-git
should play to help third-party tools.

Should this play well with the per-worktree configuration as well?
Is it better to carve out a configuration variable namespace so that
certain keys are never read from common ones (or per-worktree ones),
so that people can tell which ones are what?  I know your current
design says "this is just another new layer, and the users can hang
themselves with this new rope".  I am wondering if there is a need
to do something a bit more structured.


