Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46016C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 02:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbiFOC1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 22:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiFOC1h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 22:27:37 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD29C24953
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 19:27:35 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g15so6416791qke.4
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 19:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bQHXAZyOoHz7exsBKFymUpc59Y4dXNFhuA4tv/pYRuM=;
        b=y2VhiyJYmvBll7nHVk9E0sFo+Jqc9I9UsdYmJkD8+BeHAnIPEjLqtxSNbVv116jooj
         HxwIgIPkVlbE6YNa7UkJE0Pngv7SYlkMWxR9xFBBdJY5WDqH1Fg2TUh2R0YwkHu1YJ0b
         XYzqVMIdvwM6wWgX8t6BLLlJtVG/qY7ZqYHm3m+riP2Fb0sQTgZHcav8ugd9wKQ9F7G1
         I8zRRG1uTuNZgOpTYhQpuNuVTqQpaJiprqTSioPNAMZErTIm4VpHhwImyPjgS9fmAUAJ
         oUq1zFfz+gbaUilIGCBtUjWPDdfH3s2vVJ7ZfZymv7no7cSg7xjMMkdOfk/SCSW4jlWI
         M1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bQHXAZyOoHz7exsBKFymUpc59Y4dXNFhuA4tv/pYRuM=;
        b=KnWtduDGXXqzT2kvJOfAr97OPIgWpl03Vnxg662IkzixJHud0oNAhb+bYk0CM6+Jtw
         RYWXqUcFwxXbGtKw/n8tKuDYe090r0nlWhgMZTPiv7igg/POHhHZbZUzDt1GVro85UPw
         vqtpkVmIjleSe4iwdDfqMhkhIucs4m+sqlj4/fAkp9O2tMAi+/4g4iiEU8uwcERz59ZV
         jfMQHbuhIhJwQVFkF3rRHEgzVtPN2n2c1PKu1pjw3HOSe4F/5uPXxUdBgKVntFe0WGC7
         2icSiZt3mgdXDw5wUy+Nfy0D3PkrLQh7Alv6sOBq+H/ACRC+ZB8wWiQ7SjEzvcDh9Yet
         uAzQ==
X-Gm-Message-State: AOAM533rK9a6BqIpNWIeb4djq3GaTkmETndOgH8K+IXlm4vqG/ag8b0e
        KxJoU++tiMuCnae9LRtBDsA4IA==
X-Google-Smtp-Source: ABdhPJxqoE5C4VY+PWsn3eZdZH7YKEs2ahVIZTES4dnF2LDExfiycrhQbqbV1zeFw3DHG7Mkq++hAQ==
X-Received: by 2002:a37:98b:0:b0:6a6:b2ca:194c with SMTP id 133-20020a37098b000000b006a6b2ca194cmr6684943qkj.470.1655260054959;
        Tue, 14 Jun 2022 19:27:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p6-20020a05622a048600b00304de7561a8sm9354464qtx.27.2022.06.14.19.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 19:27:34 -0700 (PDT)
Date:   Tue, 14 Jun 2022 22:27:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v3 2/3] bitmap-format.txt: fix some formatting issues
Message-ID: <YqlDlYHR1HBJRiDZ@nand.local>
References: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
 <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
 <c74b9a52c2a7b5f3ebbfaca08c8de42aac7f7eac.1654858481.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c74b9a52c2a7b5f3ebbfaca08c8de42aac7f7eac.1654858481.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Fri, Jun 10, 2022 at 10:54:40AM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> ++
> +In each bitmap, the `n`th bit is set to true if the `n`th object
> +in the packfile or multi-pack index is of that type.
> +
> +    The obvious consequence is that the OR of all 4 bitmaps will result
> +    in a full set (all bits set), and the AND of all 4 bitmaps will
> +    result in an empty bitmap (no bits set).
> +
> +	* N entries with compressed bitmaps, one for each indexed commit
> ++
> +Where `N` is the total amount of entries in this bitmap index.
> +Each entry contains the following:

The new formatting looks terrific; it's much easier to read this in my
browser after generating the HTML version of these docs. Two questions:

- Are the hard-tabs added in this file required for ASCIIDoc to treat it
  correctly? They are a slight impediment to reading the source in my
  editor, but it's not a huge deal. It would just be nice if we could
  replace "\t" characters with two or four spaces or something.

- The above hunk is the only one which rendered slightly oddly to me; it
  looks like the paragraph beginning with "The obvious consequence ..."
  is surrounded by a <pre> element, when it should be a continuation of
  the above paragraph ("In each bitmap ...").

Otherwise, this series is looking great. Let me know what you think!

Thanks,
Taylor
