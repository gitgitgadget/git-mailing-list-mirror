Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75F0C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 14:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD016054E
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 14:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhFXPBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFXPBq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 11:01:46 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FAAC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 07:59:27 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id i189so8564336ioa.8
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/oHpGHupO0BjmvUZrrqk0Qtk5Z4sNOyYlSMOwdCt8Wk=;
        b=dOqAFtRLJ0yTBHoGmzsp7I+7iWP2pUa6nRAycCjik9BxUJznEdf5NUBBslyeV1Scyi
         Z95XeGCwIlg5nFccTasoK11i67YdcX8T78nrxjH8U0WQQ8MdzqYUDRloAeykG2k4A199
         wcPBDIF1BZJDiWJ66gP3fjcCZxwjrSAGYuodwjvQ+Qhv/4XTzgm2i/SVGfylLVlYZbn/
         tywrdmq9tk2vZJ61EDcOezzTSBDZrEPB+0wNWSMdsIj71hkunFMLM8sDLcsAHg04LwR5
         nBVeKYAl+CZaRRfACGCHBCGl3gFWIChsRcaNyESe9mRbwHHKUme8AX+0kEXDmIf12Ytz
         Mo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/oHpGHupO0BjmvUZrrqk0Qtk5Z4sNOyYlSMOwdCt8Wk=;
        b=RcPuAI0QCNUXKD3/U6CqiKawszo0SgWvarB8Flywl32iPvYC6P+qnKku0A/Glhv+y9
         A9+X/F8ZC6H28MxNgEN4CMhEpRMPvH3CBbJm25DFoRPruSOuwrpC4772j2lkexgdi+uS
         8vHGzEaB3DWIF8lbyXKjzjsEhe6W1bNw9U7R2RImnGQ2W+NIImXSLA/P2UQRIayymaci
         aHVhLIsD9MpQBrXEFJFpJOUrZFeefKf4RjbTpRuxBgvqvzIR+8mFu5Kg4ShdVBUY4NHz
         2ALKP37YGjTWeEe5sc6Y7RjPJrRtUQgb+NDzuHoGQ4YVwevEsD6i73goL6yDmYyviR3d
         Hyhw==
X-Gm-Message-State: AOAM530o3s6sHSS89XMur744ulMT3aHhMWjIxHUOKZia2V6OGGyox8rN
        BW7tk6BNhWESW+A6jgz3Mcza2hGuzYnINXaP
X-Google-Smtp-Source: ABdhPJxYTpSNLxHEmx7VUHNgkkIkwdQL8HfI1lcZfIV2VRz7nT2KqCy4uTPDZFQv5tUW6Cskg/E1UA==
X-Received: by 2002:a6b:f704:: with SMTP id k4mr4463492iog.191.1624546766670;
        Thu, 24 Jun 2021 07:59:26 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:1d42:698c:d39a:1915])
        by smtp.gmail.com with ESMTPSA id h26sm1424196ioh.34.2021.06.24.07.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 07:59:26 -0700 (PDT)
Date:   Thu, 24 Jun 2021 10:59:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 11/24] pack-bitmap.c: introduce
 'nth_bitmap_object_oid()'
Message-ID: <YNSdzWSb8pZv1xWg@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <ac1f46aa1f0dbc7fba45229555b11b390fe104a0.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac1f46aa1f0dbc7fba45229555b11b390fe104a0.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 06:25:26PM -0400, Taylor Blau wrote:
>  static int load_bitmap_entries_v1(struct bitmap_index *index)
>  {
>  	uint32_t i;
> @@ -242,9 +249,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
>  		xor_offset = read_u8(index->map, &index->map_pos);
>  		flags = read_u8(index->map, &index->map_pos);
>
> -		if (nth_packed_object_id(&oid, index->pack, commit_idx_pos) < 0)
> -			return error("corrupt ewah bitmap: commit index %u out of range",
> -				     (unsigned)commit_idx_pos);
> +		nth_bitmap_object_oid(index, &oid, commit_idx_pos);

Oops. I was reading code in this area and noticed that this patch drops
the check introduced by c6b0c3910c (pack-bitmap.c: check reads more
aggressively when loading, 2020-12-08).

I fixed it up locally by restoring the check (but on the new function
nth_bitmap_object_oid() instead), and will send it in a reroll.

Thanks,
Taylor
