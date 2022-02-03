Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61156C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 23:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354766AbiBCX3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 18:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbiBCX3A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 18:29:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE65AC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 15:29:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o16-20020a17090aac1000b001b62f629953so11448621pjq.3
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 15:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6GRN6ZIf1FonHYJ20PMxQiNeWp2Xlc35lKEM2rxrJA4=;
        b=UwjXH1SooiTNgSLG1OAo7EkbXHiiQLzmoR13Ztqipgph/x/IfQ0WH0f5D8aGtDxf2w
         frGlvD4jJVdzA8Q3qde1kI5Ad/KcT+0q23lg5asKye/09jdEtJcZV+pQ14YI9o4hmbx5
         Ur+cEP8nsSIhkgwUBwwD2ueu2i4H0e8KRlWJp3PJTDrjUrQ3iCAm2lLFdKpVT8x22tNi
         5Kd7gKjgRoU5dNSYYjhSDndUUnig3SHcYg6H0+Ebf8j5PanEpVjonNbFzg2oN9WYl/f5
         0biibzxx0fErg7Mh8wDoADOJveFDcP0niwSBvlFry91yNzWOQnbpxu26d75wCxTygCEV
         cEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6GRN6ZIf1FonHYJ20PMxQiNeWp2Xlc35lKEM2rxrJA4=;
        b=IFJi1yG0STVStnhgTEGHVHk1RzurXkoU+3+jgsDc4ydopeOuL7cxZ5ptGDhMPgzl7L
         Dvng2kD3Q/bsP8KlRjyH+sBhmYJYnEqCogtjC9GT0/CAoQyG9Vx+9SnfH8ItvRokCQLY
         +NmmEU27Z0RBtK8HgWHo9g2JqFxVdOBuh42Y80OpfvlUUusbevsgmeuQViYB+STUHpNc
         Xa1ulUNXOWEzL3mL0c/m0/YM2SF9LZUYNd5ly5fKIhM/bMsEEegTz4dh1ODSnGjSmANd
         rxGRhYI/kQx/gsG6lRLV9I+4pgm35psfnKBJyR5H0c4LqX/357W8Rgs43l7ccDanZZtL
         Np0A==
X-Gm-Message-State: AOAM530IY6f9zohBXshkMnwmQTPSi53oOwVak1D5XASjwl+ugd/WR/mc
        ItkXqk9aQMUYx7XKT6UkkQKG0uiSZXE=
X-Google-Smtp-Source: ABdhPJzkQCxvFmxK4dZwnfF9Iku4LKngOs4JSNNbYDu1QGcGwd6beM+KalUx0BwjDBwFZcZ5nx7+6Q==
X-Received: by 2002:a17:903:3049:: with SMTP id u9mr215003pla.2.1643930940228;
        Thu, 03 Feb 2022 15:29:00 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id f3sm109365pfe.43.2022.02.03.15.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 15:28:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com,
        johannes.schindelin@gmail.com, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 0/3] completion: sparse-checkout updates
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
        <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
        <xmqqo83nr59i.fsf@gitster.g>
        <7033ab1b-7d90-d83c-fc65-33801c6348cc@gmail.com>
Date:   Thu, 03 Feb 2022 15:28:59 -0800
In-Reply-To: <7033ab1b-7d90-d83c-fc65-33801c6348cc@gmail.com> (Lessley
        Dennington's message of "Thu, 3 Feb 2022 14:17:12 -0800")
Message-ID: <xmqqy22rpm10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lessley Dennington <lessleydennington@gmail.com> writes:

> On 2/3/22 1:48 PM, Junio C Hamano wrote:
>> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>> 
>>> This series is based on en/sparse-checkout-set.
>> This has been a very helpful note, but after the topic was merged to
>> 'master' on Jan 3rd, it has become a tad stale.  Let me apply the
>> topic directly on v2.35.0 instead.
>> Thanks.
>
> Thank you for the heads up! I will remove from future versions.

No problem.

FWIW, the tip of 'seen' seems to be failing the CI; I haven't looked
into the cause of the breakage.

  https://github.com/git/git/actions/runs/1792151138

There is another CI job running on 'seen', whose only difference from
the above version is that this topic has been temporarily ejected:

  https://github.com/git/git/actions/runs/1792296432

We'll see if that fails the same way (in which this topic may not
have anything to do with the breakage) or if it passes.

Thanks.
