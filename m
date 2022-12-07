Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F51C4708D
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 22:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiLGWWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiLGWWh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 17:22:37 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42E7D49
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 14:22:35 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id v1so8087875ioe.4
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 14:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKS3lE9HeaYRwOhYwB2EuryiA7ZomLA9ntRmteP/33s=;
        b=z1CUqHm9Oo5o3KlXghcopiec2xTMFKv8eyIKLTkabMMHXRLlPTMtJnlGwL9YBibKwV
         764H7v3Ec341DZiHUpNq349WhijiBJ0wE+4afSRy+aoatAKpRImRoodij99P9nCP+Sc1
         saWGakmouHThcsIbQqfFqCBtSZw84vGGRH1PPT+tsu28n/gA1EBmx+n6QCPK61X+YIet
         3mjxU6wKkREoAgspKMn+cbuNCEFKQ/GWXZ5GRW7vJiQco8QZ5o7ogrGTdSeNn+6uxoFh
         ztU8UDF5IZ2/IMsnzs/rxUtxKL2QrM452vgUE+ZnOpKWjl7mHKddqis9JRKNgMZgS5oo
         jIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKS3lE9HeaYRwOhYwB2EuryiA7ZomLA9ntRmteP/33s=;
        b=ISE90hQCUG5Zh2XQ7LHXowO0OXYKkfWrdGWzvjNyTGF1amqgcxE1sFcSHBtcYGQ9Ms
         jv/IoTD67DrKqypSRXRU4YYKWCb2OzhYIFpT2Prw34h2Pn4ba7wFoguIBqZiEDEdLTB5
         lH7CiFPKyzwPzHo5fU/TNY/TnduDMY9AOgSEcEgDe2s/yw3i0er9T/vEGCIWngMJRgKi
         zDu46NynMcnJ88lGbS2q9ESSIudjra5TRnGfC1nIfn3lfkY8ggB23qso/MH/xa9BZ4Qh
         t0VbhVbwq6Fxnq8+QIeAYxA6afXfr3qDd2wJWZjsRMEmFdav6vzlKya/9hIsbGDCwbB2
         JQRg==
X-Gm-Message-State: ANoB5plRXCEgn1tCbJgDeVcyQksmdSOlGXDjs8uHiU11WF+O2wwHrCIv
        NPhjREqjOEz7dqKorHhwwA2aUw==
X-Google-Smtp-Source: AA0mqf7geRYlQA0/oDrXQUkAv85kMZ6NAODwEG1HmrPPUjz50cqHvmcULCOw1KJjkL7E883eJT+PZw==
X-Received: by 2002:a5d:9904:0:b0:6bd:1f62:6c97 with SMTP id x4-20020a5d9904000000b006bd1f626c97mr607935iol.3.1670451755254;
        Wed, 07 Dec 2022 14:22:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g66-20020a028548000000b0038a183cb719sm6641208jai.141.2022.12.07.14.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:22:34 -0800 (PST)
Date:   Wed, 7 Dec 2022 17:22:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] ci: use a newer `github-script` version
Message-ID: <Y5ESKYvOyrnbCV+B@nand.local>
References: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
 <472481561f03900fb519065d88ae8af910bea794.1670423680.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <472481561f03900fb519065d88ae8af910bea794.1670423680.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 02:34:37PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The old version we currently use runs in node.js v12.x, which is being
> deprecated in GitHub Actions. The new version uses node.js v16.x.
>
> Incidentally, this also avoids the warning about the deprecated
> `::set-output::` workflow command because the newer version of the
> `github-script` Action uses the recommended new way to specify outputs.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

It took me a second to remember why my S-o-b was here, but it looks like
this is from when I queued this patch in [1], which is on 'master' as of
63357b79c9 (ci: use a newer `github-script` version, 2022-11-08).

So having my S-o-b here is definitely OK (since I was the one who put it
there in the first place!), but I don't think we need to re-queue this
patch, unless it was reverted out in the meantime (which it doesn't
appear to be).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/Y2q9723uEtfkJrah@nand.local/
