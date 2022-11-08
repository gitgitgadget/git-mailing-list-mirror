Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DB4C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 21:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiKHVxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 16:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiKHVxe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 16:53:34 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4077D132
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 13:53:32 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id s10so10728111ioa.5
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 13:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DdXzVbGAqu275v8NYyx+dchC3bTnnz2Igx3AXYYy/TU=;
        b=Q7qSovsEUYR9Ht3jCVIlWP6SOyG8DyAhHszW+6W+1QPXxUcIacS9ov8xOdCtWs4t2t
         8krbY7HumiihuqWhMsCKFlnx3TT4v/0XtPmeT4f1z5PXynu0LjO6FHbhYIqCfpLhH++H
         xAMJj3c92zTDjzzbA+x1aOkA92DHKdH9YJYiDWGa7kYHOuh5TShzRwwHJM9tS8Hs6g4u
         CwI88p6FFVveC0t6f37ou89jAK30UhiABzEMJZmxTJFvcwSaloUe5VaU97Dd0IQwzHGZ
         IDKTkuaNVS9Oj2Pp91JVM6rlsYxkCfB6c20kQu/3ViX9WmSnpfcLMJuwq1zTr1KZyObk
         mOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdXzVbGAqu275v8NYyx+dchC3bTnnz2Igx3AXYYy/TU=;
        b=hY/7Myai/NierowupqF/xv/8BDMgHArEeRl3EtNzJ1eod40jECFzSUMf29NQ/jH40K
         OP+XSIXwwRdpWiN7O6dSfA3uN+mlYE7PrbcsW+O75TK6pg6zHlDwzPiYOistGZNi2Xj/
         k6ldhuS1+BZSnj5ljOt84qNVMuE5jaerG0SuPzqhCbJgBtYpvQzUC8U78yKzwXua+kil
         RuxQqwtDELaxkQvp0hrrWXKN8vtDYbf4VNqPCjlYqDXZeOQO39u0AZqye8DrDYfUppXq
         R1z1XW+lSTnCdajj7AMSmuIfV3uLv8klKFC7kQBuIdtuepmtQH/mVRCjDvcjIsJDP326
         HcHQ==
X-Gm-Message-State: ACrzQf13KoBM+fJsKttEE1Tsql4SD5Vu3pYC9Cv7NWGptbWOnqyOBGBA
        XXAO8FHkV57fNQc8bNNX7QLqjd9Ze8MNAJgj
X-Google-Smtp-Source: AMsMyM44Od/et7uYBjs1ZALP1bs30RNhCFUo24yS+BSqtKoK/HgnXLaYq6OIyPSVGjrxy82NL0Q5tA==
X-Received: by 2002:a6b:c9c5:0:b0:6d2:76f4:e041 with SMTP id z188-20020a6bc9c5000000b006d276f4e041mr1118377iof.11.1667944412321;
        Tue, 08 Nov 2022 13:53:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q6-20020a92c006000000b002f9f7d24d78sm4204319ild.76.2022.11.08.13.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:53:31 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:53:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: ab/coccicheck-incremental (was: What's cooking in git.git (Nov
 2022, #01; Thu, 3))
Message-ID: <Y2rP2xN2CJbeDdsl@nand.local>
References: <Y2RldUHTwNzmez73@nand.local>
 <221107.861qqev53o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221107.861qqev53o.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 10:14:28PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Thu, Nov 03 2022, Taylor Blau wrote:
>
> > * ab/coccicheck-incremental (2022-11-02) 13 commits
> >  - spatchcache: add a ccache-alike for "spatch"
> >  - cocci: run against a generated ALL.cocci
> >  - cocci rules: remove <id>'s from rules that don't need them
> >  - Makefile: copy contrib/coccinelle/*.cocci to build/
> >  - cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
> >  - cocci: make "coccicheck" rule incremental
> >  - cocci: split off "--all-includes" from SPATCH_FLAGS
> >  - cocci: split off include-less "tests" from SPATCH_FLAGS
> >  - Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
> >  - Makefile: have "coccicheck" re-run if flags change
> >  - Makefile: add ability to TAB-complete cocci *.patch rules
> >  - cocci rules: remove unused "F" metavariable from pending rule
> >  - Makefile + shared.mak: rename and indent $(QUIET_SPATCH_T)
> >
> >  "make coccicheck" is time consuming. It has been made to run more
> >  incrementally.
> >
> >  Will merge to 'next'?
> >  source: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
>
> I think it's ready for that, the v5 having hopefully solved any last
> remaining nits / issues.

Yep, let's start merging this one down.

Thanks,
Taylor
