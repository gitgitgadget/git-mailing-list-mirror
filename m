Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94353C433EF
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 00:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiGZAea (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 20:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGZAe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 20:34:29 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C26920BCC
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 17:34:29 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z18so9655114qki.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 17:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RjNfLgVylh5nJP4AOaxvO2ZUseis9w+0BWynpBa2CcQ=;
        b=kPADGIz2b6rameQHg0EEYx+/WLDivJmO4iOs2GovDVLqhl+VIvoZ5VltEl9t0/rZEn
         20m1fpKj/RrY58RjSKJncRMXWFRKLbYuxkswrJRVwNCh9qv1O2S2L9z/as77TjbtgnER
         1ohGy/cF7B5rCiALrZcosdAFLwZOzwmae82I/kZsi3n9UIK9hioaj2q208s1Glr5uAB7
         UclkDgCUGzWaOX3/sfUoJqyCEsK2582HrNzgQoXWr61ctynjlF3s9uUZLEoSdSuCcfik
         mOlHPqM5m3fVrl88e7Gw7Od4C82L+IjW0nUEU0QO97iRlChyRvYzYzwgczgt/M6xJQhz
         se4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RjNfLgVylh5nJP4AOaxvO2ZUseis9w+0BWynpBa2CcQ=;
        b=kKeJKlfpx6XFIp5LnrVCCxHtk4CknGjLCVq8jgzg+F4PbDf/c41t//Xs4N4ydIqCVX
         xL/aTfYQ3zvUc4zHxD4pi7tcRjeNWWhBXVcmXrj2R0RL2EUsN+cYMYdWIwNLNkx/Jd+C
         HYEo6OZG/L4L0UoJtoCrP2+SrH8/n3CLQq6eQf6zX6U45vrSxuHkcKhWKxHmMifdkndT
         tT5rJGE3OPlAKQc8WugdA0TokGDY9B9m63nTKS14xYdQO+ZwLTtpOMNDFCsQyDEZj4Vq
         2NyfYTMoGljaiR8+6SO+6M+yV3LH4wFFbDAo0vEm1GVNmNbZYAPeZvDu0XAg6oS9T8hz
         Ze0Q==
X-Gm-Message-State: AJIora/d4M8y6aqfWvaLJmtc9XMRWl6d1qnew6hfvckYJA748lMhTQhF
        BYf3zBRNas1AHYCuhQIMJFRxxw==
X-Google-Smtp-Source: AGRyM1sX1f1lmn7MRwkq3a0gkkxZHTD+xuvDp5tltRNJEwrDKLz1GTgkYX/zQF4tMD4orx5XAmoiQQ==
X-Received: by 2002:a05:620a:31a1:b0:6b6:202f:d071 with SMTP id bi33-20020a05620a31a100b006b6202fd071mr11257910qkb.629.1658795668290;
        Mon, 25 Jul 2022 17:34:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d21-20020ac85ad5000000b0031ea1ad6c5asm8784693qtd.75.2022.07.25.17.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 17:34:27 -0700 (PDT)
Date:   Mon, 25 Jul 2022 20:34:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 2/6] pack-bitmap-write.c: write lookup table extension
Message-ID: <Yt82kskifigs9kAf@nand.local>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
 <5e9b985e39b0b9edee7af55dd8b0698a20062cf7.1656924376.git.gitgitgadget@gmail.com>
 <YtDPePTo52A+Uo0p@nand.local>
 <CAPOJW5x8Vf2qJ-109UH=gvy2i7HdfbFH84hb6fD+YUBN4-GkRg@mail.gmail.com>
 <YtHm+Dv0lN3Ktibx@nand.local>
 <CAPOJW5yH=Xywqos2tPS4Cn7dAdDqymPVbb6tn_XoAz0ofsACAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPOJW5yH=Xywqos2tPS4Cn7dAdDqymPVbb6tn_XoAz0ofsACAA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 16, 2022 at 05:20:57PM +0530, Abhradeep Chakraborty wrote:
> I think the comment I added is not that good. The following might be better -
>
>     At the end of this sort table[j] = i means that the i'th
>     bitmap corresponds to j'th bitmapped commit (among the selected commits)
>     in lex order of OIDs.

Makes sense, I think that version of the comment is more helpful. I
appreciate your attention to detail on getting these things right!

Thanks,
Taylor
