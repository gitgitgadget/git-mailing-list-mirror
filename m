Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65BDC433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 12:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388394AbiEFM7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 08:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392201AbiEFM7c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 08:59:32 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8157563516
        for <git@vger.kernel.org>; Fri,  6 May 2022 05:55:49 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d25so6178022pfo.10
        for <git@vger.kernel.org>; Fri, 06 May 2022 05:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uDHuo4GceaVZYsc779yxn7+Jbst1CbCIsljJZ1Wu/xA=;
        b=Xtxh7eQj81GE1qum7BROSbTbwCEgmrCFrQN50rA1vdjNUeNddQdRmgCPMUFjCNB/yw
         i8vxgejkWwpC7tef7B101kwJm7ICOs9jTEEdfKPwUPMjHGMmfJD5SXgI2sg71zSz3w0b
         1Vuo8LUG51bVe9TG3fpQNpcQVu23a7vVkbAWPjw/dybGQZdUUCgYto6txap64iS+cZa0
         rza2PLAxOvYOKN2jh/sAi7i5YFasXZoumaNa9Ah0VTQbKHx7MAJps6DSDRJWLde6grT+
         uJE9nglkKkNFjj7PIadZsvK1IPNSyKNmjMNDwo9IdlhDpandcdcmuWXYaPrscqFiMJqo
         vhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDHuo4GceaVZYsc779yxn7+Jbst1CbCIsljJZ1Wu/xA=;
        b=vEsyR7Jsg3wF9kRmai2uzqAWJuKMhjOR/ZDiw0pLAPoy0Jj1cJi7nwCnwqe0nK/v60
         QD7sJ33NUeWar7MpDT/qAqD/DlOzBkLFdbDsgXtXfsFSRZGZFV1OKJYYmEe1zAjTM2Z1
         ebKb7LLRaS+PHV0AlwIRZg0NlotsZTb1UizBm8BMdY7uBw37J2u0o9ThbixZU8FPWmFZ
         ajy9o+FrheKRCCAPFR6jVOCprccQuo+u4+4tY13pbzWco2SRE4Ys8xRLVzE/JvXxquVN
         Yp2531b3GDf861Y/Kirq7lMMm1dZ9aSCdCklVySwopyrr4lE5AQXUiqcYNHUIgANj/uf
         zF1A==
X-Gm-Message-State: AOAM533J5VTC0uFMxrGvBfcyX3UNIWgGrxYG96MUGJFfTpErOoGGjewA
        1Z8fNW1lhIJPexvr4ZThC60=
X-Google-Smtp-Source: ABdhPJy/Z4QTVyR2ZI7Gq5bgpPMOB26dSWGuIydXD59DjInFQpFiWQHzmschXovI5zK7clf0AV1FUA==
X-Received: by 2002:a63:6205:0:b0:3c6:4449:fc69 with SMTP id w5-20020a636205000000b003c64449fc69mr2399929pgb.330.1651841748965;
        Fri, 06 May 2022 05:55:48 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.50])
        by smtp.gmail.com with ESMTPSA id cj9-20020a056a00298900b0050dc76281b3sm3301600pfb.141.2022.05.06.05.55.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 May 2022 05:55:48 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 5/5] pack-bitmap.c: using error() instead of silently returning -1
Date:   Fri,  6 May 2022 20:55:30 +0800
Message-Id: <20220506125530.70989-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g1a169d7b5e
In-Reply-To: <220421.86o80u77xj.gmgdl@evledraar.gmail.com>
References: <220421.86o80u77xj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Apr 2022 17:41:36 +0200, Ævar Arnfjörð Bjarmason wrote:

> First, I wondered if we were missing _(), but looking at other string in
> the file they're not using that already, looks like these all should,
> but we can fix this all up some other time in some i18n commit. It's
> fine to keep this for now.

Yes, I agree with you.

I also think I have a willingness to make another patchset to solve
the _() missing problems recently.

> But more importantly: I think this should be your 4/5. I.e. just make
> these an error() and you won't need to add e.g. this
> trace2_data_string() for a failed stat.

Make sense. Will adjust the order in next path.
 
> You will be inside your trace2 region, so any failure to stat etc. will
> be obvious from the structure of the data and the "error" event, no
> reason to have an additional trace2_data_string().

Yeah, I forgot about the "error()" already load the trace2 functions in.
Will remove the redundant trace2_data_string() where it's  obviously will
return error().

> Aside from that & as a general matter: Unless you have some use-case for
> trace2 data in this detail I'd think that it would be better just to
> skip logging it (except if we get it for free, such as with error()).
> 
> I.e. is this particular callsite really different from other places we
> fail to stat() or open() something?
> 
> It's all a moot point with the region + error, but just something to
> keep in mind.

Make sense.

And I think it's a good case in "open_midx_bitmap_1()" to add related
trace2_data_string() because there only a general error info in "cleanup:".


Thanks.
