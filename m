Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419BEC433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 13:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347413AbiFTNuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 09:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350610AbiFTNtm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 09:49:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A49E2FFFF
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 06:18:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d13so9697569plh.13
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TxcexxqFL+8Qwbe2wkK407XWKnYOtLLH9Zc1TfOPKqc=;
        b=ZV0cbFvlQHZikHbxAD8NcC9dg+RBPY3gvzZGxWoYsTfZ30dVQah4dlX7IK5UE0TDbI
         AHoawOIrKByHS6Z0OyLGFPFdSJtgoPKyajGCbIYR8uO9EzbjX7ikUA492o00+CV2xplG
         gEMni9Ik2Oaoc/UtodJzNFJ5+jATg/Dzs8vV6Km/ecsy0likMtNLwHZuakM65Bs7yN8l
         6rD38Y1/kRWdc9RLsoY0bYKYT2sZqidtpMM3ARrjaNpzwWaTXBcGpwQfdje9xuLWUu+Z
         KhewfreI7YizFkWC14naMQ84hO3piJ/eTzFFabcu+2AXfyO5JhxOoTkIRSKjXA8J2fVn
         S8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxcexxqFL+8Qwbe2wkK407XWKnYOtLLH9Zc1TfOPKqc=;
        b=0nw+F9jpzeCBHZSE3UJzKHUmWsfkbgDRiQLL1X10OwiFENsFcCZoflILhEsHE7FTGm
         S8y2nwRTqt8R6f8+udaIKXzgsGcppIV/zv/Ac/n1rty1JgxPOTS5jDwXNNPCgtF01woI
         wgURUJHVShbBNjPZeAZjBHLU94CpAjHztNPScw+XBlDoBxnuNTSe/R81YvAJhTRKdQ8X
         nlMenegdC/b6vqYAH3ZHqk7x6b/8DE/1wRrJeu9EC7LfLqegC7GPSmo/dSJS/kaTn9Xk
         gP9weZSPr2B0z4cHLZypETeQ4xbyNRAw04hSgpAQ3UYfmAXJA9WMBWyc1bpThW1KZzRl
         1GDA==
X-Gm-Message-State: AJIora8EO1PTaM1abMQvQH4jAXGTiq7K/UglnMc3uP7RV8Pb6Zk1vPb5
        /t4Bqxk6zp/h0RYWGpbAYNA=
X-Google-Smtp-Source: AGRyM1uXtjem/VR7aEAKLJW6pFV5093VSh2zhhoq7ioftaKDDifrnI7n1i8s4K2kHsrnuF5Udev9uA==
X-Received: by 2002:a17:90a:d148:b0:1ea:4e16:545b with SMTP id t8-20020a17090ad14800b001ea4e16545bmr38279621pjw.132.1655731056967;
        Mon, 20 Jun 2022 06:17:36 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090a931200b001e8875e3326sm10369428pjo.47.2022.06.20.06.17.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2022 06:17:36 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 4/5] pack-bitmap.c: using error() instead of silently returning -1
Date:   Mon, 20 Jun 2022 21:17:30 +0800
Message-Id: <20220620131730.23409-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g270d558070.dirty
In-Reply-To: <YqfhR/PV6HhGyhT5@nand.local>
References: <YqfhR/PV6HhGyhT5@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 13 Jun 2022 21:15:51 -0400, Taylor Blau wrote:

> Since we are handling an error from fstat here, the errno variable
> contains useful information that we should include in the error via
> error_errno().

Appreciate for reminding this.
Will fix.

> The other error strings are marked for translation, but this one is not.
> Was that intentional, or just a typo / oversight?

It's an oversight.
Will fix.

> Same note here about using error_errno() instead of just error().

As same as the first one, will fix.

Thanks.
