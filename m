Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635C5C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 21:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIGVWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 17:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIGVWR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 17:22:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05D713D74
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 14:22:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e18so21502088edj.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=KNdLU1BLh9gW8sPm1To7ESch3LXXu2/g1hDYtoMWUe4=;
        b=lo8reRg0OoeRulBtPpeETMifsksXCDuVxvdchXEWbzHbiXXZ8TvAfSJWuJNtcc+QhZ
         GX2K6wKNfSu1WytymzzI92nfarPiTHdUAzx2NL9mxa4g/VcHhMzqqwvglBC6sMyH887M
         nnIGALCMsZGBuIKnFIkhpHSHrcdshH+oYiusoslyxq9d+DtIXGTRDkOrFmUUNFBXlYs2
         Fw9bbjkRRPbbm2FEkpDfWqzdETJMuSYXkruPQqtE+01qPtVxCRuDrIgddLZ6u00fAaZJ
         vXJtA0cXdWSG0oH+rhC0gsicSx8xm9tfeBMevYEAiHfzBTmy24smob5/CACaeUAK2uNx
         nEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KNdLU1BLh9gW8sPm1To7ESch3LXXu2/g1hDYtoMWUe4=;
        b=OpdULcTY+jmK0Q8XP/2x2aeNfichlOB756RxEtbJksvYZhWdsHGEO+PcFo42Ra/ZbC
         YtYgFBn9I7HAt8TeZoF3g6KqVAy9/BBWbqX0FaIfMhZk6iB8JuhZMQsP8Xh358M6Q4yE
         1d2h9zmYJPtRIOCP1bK2+I1R3dGDN3Q+PxN8KfbD6t8hy34pFQLhwr7ee4AyjYPKIqsq
         4bi6TBjXy7AH8KPnPTGwvHPK/fQYKppdK5d0ZLJeASkoyWIb6vhFmlyPMzDbaF38X2hz
         28ZrWg0BrD8vOEuRfM/UD6yXPvd2tja6/DFL4lloNecDzkuK/jmJeymKgie+GScWh1Bh
         XdSw==
X-Gm-Message-State: ACgBeo2KvHzT8hAxXhSZLt78Q/N43A2i2O8NSwHRJmL2mTYAUr1ZKGry
        3CXeSNG2o9hCYIlwQS1EoJs=
X-Google-Smtp-Source: AA6agR6gucxlxiMxZ//iX5Ml8oo+uA2yC1GrAZSS4NwulPe29/xbt2JXQdmbNYZ5GXO2iAClfSVLNw==
X-Received: by 2002:a05:6402:4311:b0:448:7bba:146a with SMTP id m17-20020a056402431100b004487bba146amr4552015edc.317.1662585735383;
        Wed, 07 Sep 2022 14:22:15 -0700 (PDT)
Received: from localhost (78-131-14-38.pool.digikabel.hu. [78.131.14.38])
        by smtp.gmail.com with ESMTPSA id gu20-20020a170906f29400b0072af890f52dsm287612ejb.88.2022.09.07.14.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:22:14 -0700 (PDT)
Date:   Wed, 7 Sep 2022 23:22:13 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/5] parse-options: minor cleanups for handling
 subcommands
Message-ID: <20220907212213.GA1795@szeder.dev>
References: <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220905185007.9042-1-szeder.dev@gmail.com>
 <xmqq5yhzuhgq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5yhzuhgq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2022 at 12:12:21PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > The changes really are minor: the first four patches shouldn't alter
> > behavior in any way, and even the last one touches only two error
> > messages.
> 
> All of them make sense.  I especially liked the simplification of
> "defaults to list" one.  "git notes list list foo" might change
> behaviour but probably in a better direction.

v2.37, current master (or 'sg/parse-options-subcommand'), and this
series behave the same when running that command: control is
dispatched to the function implementing the 'list' subcommand, which
then complains about "too many arguments", as it accepts only a one
argument.

