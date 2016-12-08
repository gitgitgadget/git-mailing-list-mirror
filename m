Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594D31FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 20:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbcLHUTD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 15:19:03 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33823 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbcLHUTC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 15:19:02 -0500
Received: by mail-qk0-f175.google.com with SMTP id q130so273466834qke.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 12:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HMLe6pOK5GUkKpI28K/nNuJFl/GfYOMb/fHhO9taUyE=;
        b=HNhs0aeZ1LCxI4zYFehMljy+F6OeUefMaGTPSqdMfZuTsFOlj/GNn8Kf/4lVhKsPWn
         X0dkqSly/uSJN1AwfKf5Ux8jpd2zQUTBGf6v5Arrxm0HV71QQabbUB5GMkcNggYNqqzs
         q1dl5+lcd3INnPCchvZMS9zCOqLGJxumiE/u8ZbZihGpS2miLK9EwXie374Q5EpJW5OM
         bWgmWdolKlQ3BPV0pTGNN2RTkPzJ1HWcV5bw3seBc/X7Zy1UFQsxyoxkIxCKKyoQEAC0
         9YULElcAXeEwu2ogcnAPzL0hAQdn1T6rytexhxYAgk0ptNwUT2aMjROVIgulWn2LzqLI
         /vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HMLe6pOK5GUkKpI28K/nNuJFl/GfYOMb/fHhO9taUyE=;
        b=mDifcqPrpZcL9Pl5+UVDTAmJgftabaaq8lWqZEHbk3/w2YgOd0YygNdw54fpp430is
         BO9TKGifOth10gQh1Zr1/Yd3hU4fsEtDYTosTjIBnCY8yLVLG5Ip2seZrxOZRkZfbVBH
         +CN8HRLVt2G4RAvAUvTV7ceWV7xFMFDx86bSbRrhLwVlvFDvbNhylHPhDoyMXhChpJ5T
         r80t9rGXoO05fPqcgboGXGyIo5T4DjzbsrSWgaryS+2+weYI04UxTyGQGx2rTqkchBza
         UEa1uR/UpOP5QCPGfovNeBLU8Hjsye6X2LMmLF8vcWJfCP73o+72eSw07N2KrHGye1gt
         gcvg==
X-Gm-Message-State: AKaTC03nklNbkrBTi3ViI0fTvVcsAkX1zLPgp66d9ugbDsFKyJv2ix3R2c0fB5uwKeSwTDX11N4PLVqkeQk/qjaG
X-Received: by 10.55.186.3 with SMTP id k3mr73077583qkf.47.1481228341352; Thu,
 08 Dec 2016 12:19:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Thu, 8 Dec 2016 12:19:00 -0800 (PST)
In-Reply-To: <CACsJy8AohKMTm0inUyxu=kTwxNFcCbbBRO=O126SCzi5e=0tSQ@mail.gmail.com>
References: <20161208014623.7588-1-sbeller@google.com> <20161208014623.7588-3-sbeller@google.com>
 <CACsJy8AohKMTm0inUyxu=kTwxNFcCbbBRO=O126SCzi5e=0tSQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Dec 2016 12:19:00 -0800
Message-ID: <CAGZ79kagKKE7fiwdPGgLsaQuQV-Y2ePgPdTLkwZJ0T9UN9uH_Q@mail.gmail.com>
Subject: Re: [PATCHv6 2/7] submodule helper: support super prefix
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> unsigned int is probably safer for variables that are used as bit-flags.

done

> If it's meant for users to see, please _() the string.

done

>> +       { "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
>
> The same macro defined twice in two separate .c files? Hmm.. it
> confused me a bit because i thought there was a connection.. I guess
> it's ok.

Its effect is exactly the same. just plain code duplication. I assume that
is okay here as it really is only one constant for now. Maybe we can
refactor that to
be defined in a header file (but which? There is no such thing as a git.h, where
I'd expect to put it.)

Thanks,
Stefan
