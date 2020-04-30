Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A208C4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 16:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061FA2070B
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 16:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT5/pp1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgD3Qsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbgD3Qsg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 12:48:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC1BC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 09:48:36 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id k8so5235724ejv.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fLr2dU6PMsR0r6SYbZZhMYz348aCt/JEsdq5w4G/P4U=;
        b=mT5/pp1dqIoTFA62KkIaVCqwy/D0/nddvHdtyrJ4+EfLhsTZxn4+80Txd2W/nbiAe6
         5VpWZCRZ7rWau0mhBqXjOFCNDFEnvR8w7xvx9ZjhQ/GHyqKs2bDoOBNisDJ8PqSNlHI6
         5lltTUaGSXyootsU3WCWzh4u5njjEoQAKPRrBJQZVcqUNrFhoQBuy0Y68bRsjyMjLVGC
         +rPs1KR7pRoZb4aGeGpcgYtlMqkke7dVOw8j/Z7g7nKaGt8Uz1EibJLCHfG1Rt9dss/N
         jRBZtor310vEnmfaQqtTTYqjnNkXdRIJSmcTmgcNgrEFQ4bY48NiI/+Ultty5mibO35d
         iBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fLr2dU6PMsR0r6SYbZZhMYz348aCt/JEsdq5w4G/P4U=;
        b=kqZ1/zp3Yz9Q6hAKjNWUhPPH8pY+ZxPpVj5zLNBHvZJKCoWIAg8Lvbjf1hIrCSrs28
         VPp3nHQKS3q0L2JJ05yg4pDAVTVKHCMqo0IaNQjLdVVflHVTzh/VeA5y5eLXC/BoRvw0
         8M8TEcMbvI6DU/dRa/I0ORwaxihhJM63EKTf+rMl3uP8ts2mSHFVjydZmBWL0+3K6HLe
         RH5bbGKRozDNBIn0wTtQ7/rKCw/pTGRJ7Tf3c2r5XmBTLGhR30/2yKBPh9Kpr6v1+hKT
         wQ0/XJZV+tFF5WjO3obWhd3HuBR+Uz4ZPcobU8MU3iaSfgVgQKlKmCWV/xWIHi3dbnXD
         cUCw==
X-Gm-Message-State: AGi0PuYilYfHYxm9kVS1pYpv+Y/uU/uAwIi67abvwj6P7FwE9pbM9grJ
        Tot+25ACalIu7H+lUQtj4haxgEDzTIwHqFr7FJU=
X-Google-Smtp-Source: APiQypLwoFFU7HxArILljRaGXnnzY7MLswIcmKO6WmeEp6rxlt4iIV+b9QmwcSLk/CNvT6qxKKiOnaWHU24OrcSFnT0=
X-Received: by 2002:a17:906:85d3:: with SMTP id i19mr3437493ejy.153.1588265315193;
 Thu, 30 Apr 2020 09:48:35 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Thu, 30 Apr 2020 18:48:24 +0200
Message-ID: <CAL3xRKcsa_P6X5Y+c2LWoftfjqEw9eheikrxfwXU=y6KuFHjtQ@mail.gmail.com>
Subject: Re: [PATCH 06/15] run-job: auto-size or use custom pack-files batch
To:     gitgitgadget@gmail.com
Cc:     dstolee@microsoft.com, git@vger.kernel.org, jrnieder@google.com,
        peff@peff.net, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

I have been reviewing these jobs' mechanics closely and have some questions:

> The dynamic default size is computed with this idea in mind for
> a client repository that was cloned from a very large remote: there
> is likely one "big" pack-file that was created at clone time. Thus,
> do not try repacking it as it is likely packed efficiently by the
> server. Instead, try packing the other pack-files into a single
> pack-file.
>
> The size is then computed as follows:
>
> batch size = total size - max pack size

Could you please elaborate why is this the best value?
In practice I have been testing this out with the following

> % cat debug.sh
> #!/bin/bash
>
> temp=$(du -cb .git/objects/pack/*.pack)
>
> total_size=$(echo "$temp" | grep total | awk '{print $1}')
> echo total_size
> echo $total_size
>
> biggest_pack=$(echo "$temp" | sort -n | tail -2 | head -1 | awk '{print $1}')
> echo biggest pack
> echo $biggest_pack
>
> batch_size=$(expr $total_size - $biggest_pack)
> echo batch size
> echo $batch_size

If you were to run

> git multi-pack-index repack --batch-size=$(./debug.sh | tail -1)

then nothing would be repack.

Instead, I have had a lot more success with the following

> # Get the 2nd biggest pack size (in bytes) + 1
> $(du -b .git/objects/pack/*pack | sort -n | tail -2 | head -1 | awk '{print $1}') + 1

I think you also used this approach in t5319 when you used the 3rd
biggest pack size

> test_expect_success 'repack creates a new pack' '
> (
> cd dup &&
> ls .git/objects/pack/*idx >idx-list &&
> test_line_count = 5 idx-list &&
> THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
> BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
> git multi-pack-index repack --batch-size=$BATCH_SIZE &&
> ls .git/objects/pack/*idx >idx-list &&
> test_line_count = 6 idx-list &&
> test-tool read-midx .git/objects | grep idx >midx-list &&
> test_line_count = 6 midx-list
> )
> '

Looking forward to a re-roll of this RFC.

Cheers,
Son Luong.
