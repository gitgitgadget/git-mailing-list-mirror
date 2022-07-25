Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5632BC433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 21:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbiGYV4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 17:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGYV4D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 17:56:03 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F4E64C2
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:56:02 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id mh14so9433290qvb.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b4/qAi4uvvxTU8mcA/pBN1+2GT4U6CJp+qSgV6DP4gw=;
        b=AcRG9HDGT1lRisZUW1cDGAsqh4uFevOrHg6TrCLEhfWxpbtLuG7m64tX5rTWrex/KL
         H8iV2ZMVYl0oU1GEXBA507dQ+cWyDJChae9wvEWWUhK7WTr5oOnQQ3uAVMPqiobHqwBH
         2XSeZJvLntSGzQ4rILnUz87bTBQMPB6oSclmzzjassbrF60I7pPqLr436g/QJ9BMvW/X
         b6g1SfJ2ISvP6G8guNdZEa50BbLger8ey56xm9GsXOc3INhH4Toi/y72rfYUtbQ2WVj8
         p/p1iyrRLZELRnKMMFqCoYQ28CN3Bb3QhABcxc5IpBWg8hfYV0Z+mh77yQe8SgofW7p6
         kVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b4/qAi4uvvxTU8mcA/pBN1+2GT4U6CJp+qSgV6DP4gw=;
        b=myoMnU/qfLy/bTLraRGCwP15zwk9wuhP1ZZItpFjSvUT5Hxfo750FPyelPj65o7T5r
         ejRT0Ms/4cizljsNb7cxJ0hoIjUUEsYvdPe4t4f0qV2Cxgy37oqPK2WLw+tlhLyl9Xy5
         Cam118ewAKFJD7uu23yRgLtJjrRIV3KKh/+BVlVjsZMKwnUwBR+bWVK6iO3n+B24F+4/
         Ee1/L5BbCrPqgejQwCrRrqs8VjDbSrWlqu9hTIBp2hyF0MhjEbPeCtAklwcJVbnIB/Vk
         a4nunsSg86r6KgghaRTqDYk0+A7NXKlVNJ7BhKHYTLsge3DhhSd3N4TlpSUQlFVIG8iz
         7AhQ==
X-Gm-Message-State: AJIora+41En0pMRjbtRtCrizUaFRbpW6G0K5WX3EGIlRaVrnr561sxnF
        HG6Roy8Onl8xa3IFE/3yKGaOPg==
X-Google-Smtp-Source: AGRyM1sQzZ0GtGygiA/rxdHugi1ILFljiTRxEi1FXk0AGucAK82QnMsB6uXKZVCpLr4NOSK9W0qR1Q==
X-Received: by 2002:ad4:5ba7:0:b0:473:6eb1:70d2 with SMTP id 7-20020ad45ba7000000b004736eb170d2mr12587134qvq.100.1658786161731;
        Mon, 25 Jul 2022 14:56:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k7-20020a05620a414700b006b5e5ebfff8sm10834751qko.62.2022.07.25.14.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:56:01 -0700 (PDT)
Date:   Mon, 25 Jul 2022 17:56:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <junio@pobox.com>
Cc:     git@vger.kernel.org
Subject: tb/commit-graph-genv2-upgrade-fix
Message-ID: <Yt8RcDeSht56gU5v@nand.local>
References: <xmqqh738bq21.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh738bq21.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 06:01:10PM -0700, Junio C Hamano wrote:
> * tb/commit-graph-genv2-upgrade-fix (2022-07-15) 3 commits
>  - commit-graph: fix corrupt upgrade from generation v1 to v2
>  - commit-graph: introduce `repo_find_commit_pos_in_graph()`
>  - t5318: demonstrate commit-graph generation v2 corruption
>
>  There was a bug in the codepath to upgrade generation information
>  in commit-graph from v1 to v2 format, which has been corrected.
>
>  Will merge to 'next'?
>  source: <cover.1657667404.git.me@ttaylorr.com>

Yeah, I think that this one is ready to go. It's the minimal fix I would
consider acceptable for squashing this bug, but it should do what we
need.

Stolee gave it a positive review, and I doubt he has any objections.

Thanks,
Taylor
