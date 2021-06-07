Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70047C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509F461139
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhFGTNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhFGTNy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 15:13:54 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06092C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 12:12:03 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id r17so8900157oic.7
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Zijm/gixJhdhGtEf41UZmtXOGy/C5IKno0I5zSIIvjU=;
        b=boarrqnmZqBkKlWa/AHlRlyfBFPrZBhvyOat9WBXwpPtqwMJnQlx/INigQ5FmSMFTu
         AEWcMF5ai6H77u00G3fA1H39/0pHRYLo69klDhty9JiZYj0rPuiu+ohONidUu55eWbop
         vlgpDU/Cd4eTgHuoU4n/IyGENa7U+dH7oxnqe1fojCe7ptNNGUZTezk0LSFC3eq17sfm
         f42rQTEFNTgkn4Ci1Z4u79Hw9owqvDu4sgC/XAFl4yJPGtoKFkvLAj3pUM0fRzGx5Tdk
         dOeRfTXRweJVWigrkmg6AHzd1dmFCkGg8JvI/vGPIz6/AD5RtOHLrtR08plhv8EBtILJ
         bJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Zijm/gixJhdhGtEf41UZmtXOGy/C5IKno0I5zSIIvjU=;
        b=J8YOX16tRhF1D0wrP6EwR4vPmFIPz6x934dlI322B4igoVrsCAzsiBOVXHrsHcnmiA
         WObuu9pXFycMrSzF8O+4f5HCNqgRfGtG/1lHXreBcApn+qIGUUjFsrZJgLT9yvPTLcya
         nJJiRG+j/FgdSvqBkkcXCwx/xlAFbBifGk4ljL3WT3KGgTqP8KdpTUwclUMFJXtBy/Dw
         7eUSnHjtkpseNqx/AmyEz+UWc92Y/DeC+odxOg0GmpWj9Fob44IVEIJOTD99crS0QK+M
         5ed8dsFulDWSII4h173cUWXlGMLR4m2Ug3HiB1Wgd/zDZ9inLyC6Pc24nM+Kdaac2Jgm
         Q9Cg==
X-Gm-Message-State: AOAM531TfVgx5lckopIxx12BQ3ijOtd/Yt9TtwoMHI3aykrMaKjvlMtM
        b8fCGKNICH0Z2kw+ujDglYg=
X-Google-Smtp-Source: ABdhPJxkb9pKQPvXEcDSV7ofI/CG9OlLOWBlEw9Wt8duolE/8XgCirgDpXQq5frcDC4frxp6mlOPjg==
X-Received: by 2002:a54:438e:: with SMTP id u14mr414727oiv.126.1623093122342;
        Mon, 07 Jun 2021 12:12:02 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u124sm2421259oie.38.2021.06.07.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 12:12:01 -0700 (PDT)
Date:   Mon, 07 Jun 2021 14:11:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <60be6f7fa4435_db80d208f2@natae.notmuch>
In-Reply-To: <20210607190046.GB6312@szeder.dev>
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
 <20210606184726.1018460-4-felipe.contreras@gmail.com>
 <20210607190046.GB6312@szeder.dev>
Subject: Re: [PATCH v2 try2 3/4] completion: bash: fix for multiple dash
 commands
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor wrote:
> On Sun, Jun 06, 2021 at 01:47:25PM -0500, Felipe Contreras wrote:
> > Otherwise commands like 'for-each-ref' are not completed.
> =

> I think you meant that options of commands like 'for-each-ref' are not
> completed.  The command itself can be completed just fine:
> =

>   $ git for<TAB>
>   for-each-ref      format-patch      =


Yes, I meant commands like 'for-each-ref' are not completed correctly...
by __gitcomp_builtin. Which in practical tearms means what you just
described above.

-- =

Felipe Contreras=
