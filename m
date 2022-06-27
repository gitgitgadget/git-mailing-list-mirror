Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE7CCCA473
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 16:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbiF0Qvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbiF0Qvr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 12:51:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBA215A08
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 09:51:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id n12so9624160pfq.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YD/C58sueHefYrJBK9pmfW7KXgKXShmxFwG33cgKlls=;
        b=jO6ZFyy+RtKBZW32uhIA+QK4G9wJs3iGmywpnPdZNPSkx7adxTQFo+Y2n1ZrINxjfp
         nsDxfpmx3UVzoHXpE51c69dTCBNmB39nWz+aOyDlCHm8IiAvi3PaqhtZkqJPmSkZjvmL
         0CuTKHSALs1PX408E6Uv34qXnZg55g3SugJII7UrF5DJz0KIHOxv284/nmPsQubFFo5z
         DBjDRBi/cD2cFUPs2jHOqN5wjZI8AMXwBAgV4RNI2EI9TvqVFOjxPXcSQzJtlilqqlb9
         Acp1H1AsXMVzjPOeo0JY+qNgj66PN197KJ9/Cx4CUxt5hc5JpAQdWYj0zqF/4J21nDwc
         3NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YD/C58sueHefYrJBK9pmfW7KXgKXShmxFwG33cgKlls=;
        b=JaDuFnL7utUHSe9L32oHcVh+BTBKlhNupIbI31KiWy6WymrKG+4kXQPocFs9toywFN
         2QRUIq51SReW6NQOA70MFuV0iS3TPYUHnOg1P+CQ42TjCg9kV79BjXfLvoGi9mTp3QoK
         mlad8hD8O3TLlPvf/kuhWUV8nogaPGIKAvkY9cWmeQ7To7y56JMvk6D20TCDtB6aVnLD
         Hf5011g2EBxejDp8vo4566URe4mNZIZBqYjXtiSM6NdtXXd0TD6gvgBvVKbPTpezs9iW
         rplAHAtty9gUiKR29oYNPHCwyXGVz/rVTBAonjKTi8jKu9SrNMWFnp+QJcoHY1EVnKWV
         GP5A==
X-Gm-Message-State: AJIora8Vl7o0uxQw6C2tHCMjX8A8BbxfhQkknpY9TxRsGZEec+Ey7hlk
        E3Mmnj68UnLQbLJGd3218H4itECGK2Y=
X-Google-Smtp-Source: AGRyM1v3A1191aSaIUactoEmUOUygG0ucHaq9KWK5g4F7RGyElNyI6zXoSvPARTpjiq7+qp/qATK3Q==
X-Received: by 2002:a63:6bc4:0:b0:40d:fd98:bb21 with SMTP id g187-20020a636bc4000000b0040dfd98bb21mr5057153pgc.249.1656348705769;
        Mon, 27 Jun 2022 09:51:45 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.81])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d68300b0015e8d4eb246sm7456201ply.144.2022.06.27.09.51.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jun 2022 09:51:45 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/6] Documentation/technical: describe bitmap lookup table extension
Date:   Mon, 27 Jun 2022 22:21:00 +0530
Message-Id: <20220627165100.16178-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <b2c947c6-b33b-066e-a578-65f769ef4f75@github.com>
References: <b2c947c6-b33b-066e-a578-65f769ef4f75@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> wrote:

> I found this difficult to parse. Here is an attempt at a rewording. Please
> let me know if I misunderstood something when reading your version:
>
>   NOTE: The xor_offset stored in the BITMAP_OPT_LOOKUP_TABLE is different
>   from the xor_offset used in the bitmap data table. The xor_offset in this
>   table indicates the row number within this table of the commit whose
>   bitmap is used for the XOR computation with the current commit's stored
>   bitmap to create the proper logical reachability bitmap.
>
> This does make me think that "xor_offset" should really be "xor_row" or
> something like that.

Thanks. `xor_row` seems nice to me.

> > +	* {empty}
> > +	commit pos (4 byte integer, network byte order): ::
> > +	It stores the object position of the commit (in the midx or pack index)
> > +	to which the i'th bitmap in the bitmap entries belongs.
>
> Ok, we are saving some space here, but relying on looking into the pack-index
> or multi-pack-index to get the actual commit OID.

Seems like I didn't update this particular part. At the time of writing this
patch, I was clear that I would store these triplets in the bitmap's order.
But when I started to implement the "read" part, I realised that these triplets
need to be ordered in ascending order. So I did update the "write extension"
patch but somehow missed this particular part.

Just to be clear, bitmaps are sorted by their commit's date (as far as I know).
Bitmaps for recent commits comes before bitmaps for older commits. So these
two orders are not same. Thus hashmap would not work here.

Will update this portion.

Thanks :)
