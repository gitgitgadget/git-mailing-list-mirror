Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC2C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 02:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbiBUCoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 21:44:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244809AbiBUCoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 21:44:09 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5128E08
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 18:43:47 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id e79so14377529iof.13
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 18:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+ziZm80xUbYuydZ4ldC+d2EPzyyMrxwcFJ9sEu6Sdus=;
        b=M8CJQaHXIUWbxbMG4Suf6CK1o0jtjWay1mQq3KIYiLIxigJit2mbAc157LQtIPCIkP
         9AKedQFVyDpydBytofin97DuopuWkqAGeG+lqTfjORrp9sW/eZQeNZTy7TOwmI4zBtmg
         r6oEjdjgzfmte6zaULxLdRipu9FVzrkN8ldAqqDsd3vIQaql/LEV3CXWhltD2RKp9OPT
         OZ0BAzGjfvIad6DPT/RQdc1KLt1kJYq6O7e63VUvRFY/oncS1jj0kIRQRW/uHweF3AXK
         MptDFbprU5cAL8GVNdsc84FQVWd4qfJ9Clfru3wcGSHRz7jJiccSn2lv5b7uk9C5oMRV
         qX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+ziZm80xUbYuydZ4ldC+d2EPzyyMrxwcFJ9sEu6Sdus=;
        b=3y+tIYPLUDesoLC1NqAIulcEi3sw2knhURsHzhrMIFUro9TW7LmmEJxXH/jlx5Cup4
         Uej2gm2tiLR6W5OxtTsnWoYZytAYujinxoRhjiqeIdDpIRZr2aJ9HqR8b5Cb0wHYv6Ii
         6p2XSITIpSOfUYkqoxidPWMi0X4Cue0h7c1oId9/sO5PnPDy+RgazZZQj2lZsDBVfb6I
         BpRzFuGqk8pnuVawfraLjaAIzwKG0wTVFTlAj84ew6KLiP9/UfcazSMY5wH9WafRzxZd
         1j66mBrQlOz2X359bGP58wPP2Pg96+PERjH+svPFfFtF+XImxJNa2HAcxSPznWHyDoSu
         rDkw==
X-Gm-Message-State: AOAM532/2BEoOAhow1694gb5g0q2OuWLNcM4BbuQil1Vf3IvEF/+Bk0T
        IpLnWgv1lDgavo/Z/mNCKaemYtRdL3ixUi0q
X-Google-Smtp-Source: ABdhPJzHFb55y3KANI50yyNbs5pukIKm3fqy6Fd4t1Dj0m23EPNnrB1+0aFaBuZUfuAMDT2t93iLDQ==
X-Received: by 2002:a02:cceb:0:b0:314:91c9:89be with SMTP id l11-20020a02cceb000000b0031491c989bemr13096615jaq.65.1645411426577;
        Sun, 20 Feb 2022 18:43:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u12sm7156023ilg.51.2022.02.20.18.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:43:46 -0800 (PST)
Date:   Sun, 20 Feb 2022 21:43:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/2] Fix a couple small leaks in merge-ort
Message-ID: <YhL8YXgRdCJV/ReP@nand.local>
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
 <pull.1152.v2.git.1645320591.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1152.v2.git.1645320591.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 01:29:49AM +0000, Elijah Newren via GitGitGadget wrote:
> Off-list, Ævar reported a few small leaks in merge-ort to me that I missed
> previously. Here's a couple fixes.
>
> Changes since v1:
>
>  * Simplified patch 1 a bit as per Ævar's suggestion

Thanks; both look good. I left a comment about an issue unrelated to
this series on the first patch. But this looks ready to go to my eyes.

Thanks,
Taylor
