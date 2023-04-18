Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CFC77B72
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 02:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjDRCQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 22:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDRCQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 22:16:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479AF40F3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 19:16:15 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-247122e9845so895396a91.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 19:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681784175; x=1684376175;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ARvU1oeIirwAg5buS1oPV61+YCiBuLvWghGkVhzOMO4=;
        b=e9HOHSlUUjSRZNQyH3MNvnXVlXKEcCBodFNnJ6igK4W6WJh/zmtUcxxDNhS3CgHNyL
         uPQZtm6gNfHz19bD64n5+yh0/5EUPFea5KJ+7+vknLrf8FKjPKeamb5UyQje1KmQG+SR
         mCDDFDOFXeh2K3v3ySyXNp5mvKrinyErZQy4o4Elsgn6PDP/55YQrOMfw9Os2EJrlpsM
         F7cPf+vpg8XnVTZbl0WlFV99fjmFYp1d4Z+ZJ3yY5wI3PXOvrYUX5iAowHgm1UNwqNSg
         OesKJbaQ0WVYGy4A7csHyiKgFSLPnl8qvwi3E3e7S01gpwuAEkMQH2jfYg3TCMIlUfxX
         5nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681784175; x=1684376175;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARvU1oeIirwAg5buS1oPV61+YCiBuLvWghGkVhzOMO4=;
        b=UZQJBcKOal/lkflyGruc05hXtTYNHiad29tc1NgL41SyOKQee47agQuoQxLy3fqdDj
         p8m+K07KnD5MjbKm4ji0YTwH102XmZyoiJSAjEUwxIronXRk2ZWLM3Nym09UWUhGhju0
         ABeKn1MHGecv3ktJD00r7CWF4jt8DZY4NILHamG8Q0NAflvRUkue+AAjaogatNJ4aQBs
         Bh7jFBqDBHnmtVCRk4jCuCWMXGVz06RY28yz8VeB0uqhfBb78HmLSVBnRYvlsVEsX0JN
         3/0/JOOGf96+BesBVcEqNwytoBgvS7V8NyBCrT61ijomkSigzcajP8zFcSXmhwh4qb+J
         WJ6g==
X-Gm-Message-State: AAQBX9f/leWdgK5okwC/z5VjVSE6HvsmwSMl6gDFY7Wnkm7PpT7C0WuY
        9E5T9nUdnpqGpljZzl311NPyfLiXMHdCng==
X-Google-Smtp-Source: AKy350YwbudU8s9+YLzqvhOL5bifA2augCirNgQIwjFNG6m8usXV/kiALPWWHS7uky7Y/6RRk/vRcw==
X-Received: by 2002:a17:90b:2251:b0:246:8f9b:d28e with SMTP id hk17-20020a17090b225100b002468f9bd28emr555085pjb.18.1681784174625;
        Mon, 17 Apr 2023 19:16:14 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-15.three.co.id. [180.214.233.15])
        by smtp.gmail.com with ESMTPSA id ge5-20020a17090b0e0500b002474ea30ce2sm4998211pjb.16.2023.04.17.19.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 19:16:14 -0700 (PDT)
Message-ID: <8e630625-8121-1c95-2c45-5e3f162eec75@gmail.com>
Date:   Tue, 18 Apr 2023 09:16:11 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Planned maintenance for crbug.com/git tomorrow
Content-Language: en-US
To:     Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>
References: <CAJoAoZ=FHmY=-xvdscFOXiuJmkZidZWDvFia-VH3Zoac+zhNwQ@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAJoAoZ=FHmY=-xvdscFOXiuJmkZidZWDvFia-VH3Zoac+zhNwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/23 03:07, Emily Shaffer wrote:
> Hi folks,
> 
> Heads up that tomorrow the crbug.com/git (Monorail) bug tracker will
> be placed into read-only mode so that we can move it to a new stack
> with equivalent functionality and ongoing maintenance and support. We
> expect this maintenance to take a few hours. I'll send another mail
> when it's completed.
> 

To bugzilla?

Nevertheless, reporting via git@v.k.o is preferred since the response
from fellow developers here is faster and mostly helpful. 

-- 
An old man doll... just what I always wanted! - Clara

