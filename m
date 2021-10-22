Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF60C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E18461526
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhJVDIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhJVDIv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 23:08:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BFFC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:06:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso2020791pjw.2
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=xf4aTTNSAFUE9EP5UR5fRlY5owUeQIecLSiXZL3iA7o=;
        b=UveZA4g+DKHujHf0W4lLJ5kscOLuoyuzokxRb3iRdYk7kT5DOh+ykZKXCNbS6Y8dPA
         rrIGuke2r4BfFqpAPO8+MT8Jw2n5Ic4YCFc4gkCOK0mK5407hBGOftSWa9yoAkPFfRmE
         X68OO3hB6pEoCV99MYZTVf+ye4wqMvRfVuaYR8Ak4GmNV8DhAjtkOKLgQCeEB3nQlz7l
         PIN/b+VnwvfV4TVwPtGjXg7i7PWHoxfgbrroL6uyWj6pXiZBOz/9ObtyXbXWhUR0016z
         Ro8BRxXVODGQw4XAclJszyjakCx4bzKZa5H3vh1RK7kqNs/mO+vFhqC/VySparfmx7gc
         3UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xf4aTTNSAFUE9EP5UR5fRlY5owUeQIecLSiXZL3iA7o=;
        b=5LcP/MWLc9M3lht+tUFmERn0hpzBDGD+9NHDY9V6L0TYYgIjhW/zTO6ZimblKjUwsP
         lEaD5wRm2Y9vGpYzvQf8YS9lQ477jRBL40tpopjaIXv6mIMivirZfZZ9ha4PVHgLyqGn
         49IMnu7b5pDeOHuWSNHRA3MXB9uz4947KaX2FBNGawbL/PUQrgy7GVJnXXLGt4XSoTkM
         ccQrMp6lLNt5iUn/IxJB6lsAE5CotjuuMxk1Jd4GfzUJ24oLPOmgOJ1JSReoMaM1OnlU
         jJzVBOAynYiZSG4zxnl5ASCXdVDIyeQHQ1zc9+DuwL3j3JfsshHlIIsw6Jn+1U2pFooq
         iR4A==
X-Gm-Message-State: AOAM533JQSkXwlLcaZ6wXZcJoQoAjCH6BR386MvCn0xzXE0CofK9md39
        VGJ/v/AAIIGqrax9NXayn70=
X-Google-Smtp-Source: ABdhPJzX2fXOHtTHgD8Hn2WZ8+5/orC9pXDDazA+Hru/NxsPnFJE2WpYf/OX84tw2ouBIh74UWX9mw==
X-Received: by 2002:a17:90a:c85:: with SMTP id v5mr1277725pja.47.1634871994245;
        Thu, 21 Oct 2021 20:06:34 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-84.three.co.id. [180.214.232.84])
        by smtp.gmail.com with ESMTPSA id 31sm5577273pgs.29.2021.10.21.20.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 20:06:33 -0700 (PDT)
Message-ID: <bdf47d51-9cf6-046d-fd97-aa35299daadd@gmail.com>
Date:   Fri, 22 Oct 2021 10:06:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [Summit topic] Server-side merge/rebase: needs and wants?
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/10/21 18.56, Johannes Schindelin wrote:
>   5.  The challenge is not necessarily the technical challenges, but the UX for
>       server tools that live “above” the git executable.
> 
>       1. What kind of output is needed? Machine-readable error messages?
> 
>       2. What Git objects must be created: a tree? A commit?
> 
>       3. How to handle, report, and store conflicts? Index is not typically
>          available on the server.

1) I prefer human-readable (i.e. l10n-able) output, because the output 
messages for server-side merge/rebase are user-facing.

2) Same as when doing merge/rebase on local machine (merge commit if 
non-ff).

3) I think because on the server-side we have bare repo (instead of 
normal repo), we need to create temporary index just for merge/rebase. 
For conflicts, the users need to resolve them locally, then notify the 
server that they have been resolved, and continue merging process.

-- 
An old man doll... just what I always wanted! - Clara
