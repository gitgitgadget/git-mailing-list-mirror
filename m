Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FD7C433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 16:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbiBWQdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 11:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbiBWQda (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 11:33:30 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C016A4F47B
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 08:33:02 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id d3so15748919ilr.10
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 08:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JXgYFoEAmGCbxg3qvA6KAm1lnPF+AczZLPmMzlzVHLE=;
        b=ZC+csl09UVPOfad5p2c4vr8ZpdduPlW1w+imjNlmHp0JKg+EbK/KXCpRzSspEWMfyl
         Ckv6qYgRRNEJ2W4gH7wDpHlAbbsZdMWRbeoYft9+Y0MhTTrFhsVlLSFNj72rEIkchc/9
         AD5ZVduBXJlJy7q+4ZuKkhOoElfsKJl69zjoTUloqnhZRBsge5Fzcbex+r6T/8WN6Pq2
         3ZY5sDZGUHuhlzKQi5cax3DfiQiW0XwKWA044dklPyK3QDBR99+Ab2OS8VbZZJCDZbxM
         GuJcZhGeJv5HT3WCD0p2Lc49DvXdd0o0JPGF6VBvU7TDeeMklaRAOoXVapLM+wjbP3Lw
         7emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JXgYFoEAmGCbxg3qvA6KAm1lnPF+AczZLPmMzlzVHLE=;
        b=KTaxnb6O1PleDX+w8zMYuLkaAq9UVv1tXl6245iyxppZufOg/nOSm1t/WeA018nXa8
         GmbHSBNtDhnFZEh73AOLoim6DCfPinzilr5/oJZDi6wU5z+LtnMP8EEDfr3TZ34h3lfG
         CAun33sC9GXhuBILEb3uLuedW0iZjJpzYF9c5+9OZj7/ieofvXkKDLr1G4tnsuoaIuA9
         IutFuJKNhymeXtoIXAuuMAlvCFzrN95x7C6h/y+nDtWZJr172vHGyVgt7OYCC6wv8471
         AfXobFZFNWB0R+4KiW1seGg05hilLqeFI+UQfK/JgRLmAMQWQAiCZj6hJGCJklYQnGTn
         ajCA==
X-Gm-Message-State: AOAM532NgzXF47or8HpWPyBFglCuIKgaEMYEVIirR6ue/UrrnqZBGgl3
        p5chbhbMBX7hm8UHN5Jr0ELU2Q==
X-Google-Smtp-Source: ABdhPJzq/Bn8WnnTfdfnVyYbC68oLzI5/x/O3DEQDImd2YDPmnCLQTQEtuS9r1GQtJX81AFA+KPhiQ==
X-Received: by 2002:a05:6e02:190c:b0:2c2:6851:bce3 with SMTP id w12-20020a056e02190c00b002c26851bce3mr441254ilu.28.1645633982148;
        Wed, 23 Feb 2022 08:33:02 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c21sm69091ioh.35.2022.02.23.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:33:01 -0800 (PST)
Date:   Wed, 23 Feb 2022 11:33:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        derrickstolee@github.com, Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH 0/2] Specify the actual pack size limit which is breached
Message-ID: <YhZhvPcdD/C/LSMP@nand.local>
References: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 04:03:11PM +0000, Matt Cooper via GitGitGadget wrote:
> Matt Cooper (2):
>   index-pack: clarify the breached limit
>   t5302: confirm that large packs mention limit
>
>  builtin/index-pack.c  | 8 ++++++--
>  t/t5302-pack-index.sh | 8 ++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)

I took a look and reviewed this series internally. The patches here
match what I looked at within GitHub, so these look good to me also.

For what it's worth, I wouldn't mind to see these two patches squashed
together, since it may be easier for future readers to see the new code
and test together in the same patch.

But I don't feel strongly about it, so (with or without that suggestion)
I'd be happy to see this get picked up. Thanks, Matt!

Thanks,
Taylor
