Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A801CC77B72
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 15:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjDTP0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDTP0r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 11:26:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657D6359B
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 08:26:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so1057690b3a.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682004403; x=1684596403;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etifrTKmGSOZl1Uf73Tz/mHdxGxtXbXOWuniMXqTsYQ=;
        b=K07vWD02yN4R9j2d99MQDZ3DFNYbyCbcreUCRzGxYO7xFtGb3sRAWqfnVB9zGKIlpZ
         ephDWa/6zgYHSTp2MRW4/0EPY2kYoD8sOkVUaKZ2IqS6uLZ0w8K/l/WlQacM92YDWfmS
         TSc9UwduHaRRHX1L2v5uKzSjgOex81H5T9Jof1pX97i93GAN6Ks0p98umN9+xy+n/0KO
         oGVash6FekL4uigqpIdgNAURALOnzPR2nLqViYbkeA7qtrvmfkIX36B/lpkWgvBYpeor
         N22ELuE2Eouu6hXmIbQ+DdEKNcpz30PB+tbeZkeil+Ovzs5TGZpN6rkSX0b/9rvLSrvm
         Afrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004403; x=1684596403;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etifrTKmGSOZl1Uf73Tz/mHdxGxtXbXOWuniMXqTsYQ=;
        b=GZM6R8jGpMErubGQ1dICVmd5cn3lbpl6WOncUuTocRcpYyL+TYRG/JL+5M6DGAP06D
         OCLrLZpBR0JPtNZFVRQtujBl6wQI16fz1NqXsJoiUjffkWH8xU/NqZFoBbNsh+Rngi7k
         hQEYSZYMHnP18qUtqES3NgKD1g+//f6v8HyDfOoFTOeW7hBzEKo1xrA5l1kzGB7rVwgh
         2YJSAX8POxc4J+qoGeX84eyRcdNRJ0VgdIqP+30AyZ8qVAsrfpyE3tot1gMo+Qo601qW
         VURHE1l/42BFQu/RvE70S6pNwC2nK1cum8Zn49BlgNyDuxkjT7EGYpxmlgd5mJiOXcJT
         csMg==
X-Gm-Message-State: AAQBX9dDsq6Jf9cLaSs/MV4S5vvdSVRixhi/grUfhSauC5RJxHvVxUGI
        bN1QxHHNPpcwu/OGQCNGmwGF
X-Google-Smtp-Source: AKy350aGRaxhMU6jIyrkVe8/ruC878qt3qfX+Xy5RrvaDDCZSn/1ypLfjonV5cSxlc6ZukuIrU+PpA==
X-Received: by 2002:a05:6a00:21d4:b0:63b:5609:3bb5 with SMTP id t20-20020a056a0021d400b0063b56093bb5mr2098744pfj.18.1682004402855;
        Thu, 20 Apr 2023 08:26:42 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id c192-20020a621cc9000000b0063d44634d8csm1393873pfc.71.2023.04.20.08.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 08:26:42 -0700 (PDT)
Message-ID: <069a53ef-63b8-c1e3-7502-6728bda50665@github.com>
Date:   Thu, 20 Apr 2023 08:26:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v7 2/2] diff-files: integrate with sparse index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <20230320205241.105476-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-3-cheskaqiqi@gmail.com>
 <c382017a-8c65-24ba-5092-6b46428d8b9b@github.com>
 <CAMO4yUF1P1Sv1aVJ1aw9US-QeNYD-GfaS7ndr=bwp-dgvOyexA@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAMO4yUF1P1Sv1aVJ1aw9US-QeNYD-GfaS7ndr=bwp-dgvOyexA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Hi Victoria,
> 
> Sorry for the late reply. I'm still in the middle of my final exams period.

No problem at all, thanks for following up!

> It's true that in the case of 'diff-files', expanding the sparse directory to
> match a pathspec to its contents might not be necessary. If we don't use
> pathspec expansion in this case. It could optimize for performance better.
> 
> However, there could be some edge cases. if a user manually modifies the
> contents of a SKIP_WORKTREE file in the working tree, the diff between
> the working tree and the index would no longer be empty. So I think, In this
> case, expanding the sparse directory might still be necessary to ensure the
> correct behavior of the 'diff-files' command.

If a user manually modifies a SKIP_WORKTREE file, SKIP_WORKTREE will be
removed from the file and the index expanded automatically [1]. If that
mechanism is working properly, there would be no need to manually check the
pathspec and expand the index.

Have you tried removing the 'pathspec_needs_expanded_index()' and running
the tests? If so, is 'diff-files' producing incorrect results? 

[1] https://lore.kernel.org/git/11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com/

