Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BE8C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 17:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiKORff (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiKORfb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 12:35:31 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C5D2F39B
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 09:35:30 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id g7so6109861ile.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 09:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1l5geHms3a9qZBmbVuRbjYcq4rSe0Z8fI1xWoiHE3k=;
        b=4v9q681NmjxavutSSnQqYgEefE863Pp0nwyDAY4oK3uoIn033aFMBMKR1IFgDl1wwd
         GdRsT9oGp1TTatKpXG+qVrQVnsbwlQiZx2gU1+lc6Xh2kzsb0o0Pd5IHFc+/PcoxlcYC
         bzIoKEM9sHVBhpHgCFw75kcIApW4kRI/BdkEGAVmZ4fwxU7SPunn6xhik1zSwSevW5cQ
         GV0XkMTt//ME0ewlneCc2wncRJS/cVpOCqe/dkm9e8hW7ALhlsgOkbv2/7cpSXd2gU9J
         jhEQ9CZCSPxP0kRhECykwP5jSo9Ag9UQFvx/+NbbMEwNwoqw5SUn+9YgxcJrZtQGOZMF
         z0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1l5geHms3a9qZBmbVuRbjYcq4rSe0Z8fI1xWoiHE3k=;
        b=2rpnTXDQq5Cme8yJhJTfsY0e5EijjnltlrRJFOIfBAC+cjPgXVAWdVLzfzKtDxWGYi
         PhOHzvpmDDElGYOFlIXV2C0Ifm8gsMaLU/jGGFAXcSCUvWs7IhecsuD4GciMfYOpNW4G
         Dhy6Y5uS2aJHYE4gtqGWTFKVmYPkxrA+D3lum2stPQEDesd8+/nBqb757q/l4Np7CPXB
         gA8JmS8qy040f8fX/2vqbWaZtI2V6w6+u6ti6sGOuvTfdn5rdFyn8BOD4TxJ/ESZYubh
         pqycaNG41VeGoc83su4gTOAd1nyGxsu08uKHuGs2o30+yFN1RNu2ks08UIV48mIU9WeU
         MqBg==
X-Gm-Message-State: ANoB5pmPpg9uujITtFiTPTIgA9ioKxMcLR0LHxEk19ciJlJ+IOvDdeOc
        KgbihSmx8t2yp9oA/Vl627ap9A==
X-Google-Smtp-Source: AA0mqf4N7pYqu19xQmLoSorlQcHERjUPhMUAw8WO16dZDwF9jA7X1z49ADYPIPgHohP2aPRpBNii5g==
X-Received: by 2002:a92:cb08:0:b0:302:4ba1:188b with SMTP id s8-20020a92cb08000000b003024ba1188bmr6641307ilo.62.1668533730040;
        Tue, 15 Nov 2022 09:35:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h10-20020a02c72a000000b00372d05cab42sm4919649jao.23.2022.11.15.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:35:29 -0800 (PST)
Date:   Tue, 15 Nov 2022 12:35:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     ronan@rjp.ie
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] maintenance --unregister: fix uninit'd data use &
 -Wdeclaration-after-statement
Message-ID: <Y3PN4K1ULrvGCEEE@nand.local>
References: <patch-v2-1.1-f37e99c9d59-20221115T160240Z-avarab@gmail.com>
 <patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com>
 <1ab6aa0e8178c88689f26b8df9ec75cb@rjp.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ab6aa0e8178c88689f26b8df9ec75cb@rjp.ie>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 04:32:03PM +0000, ronan@rjp.ie wrote:
> I had done that in [1], but these issues were caught in review so I
> submitted a v2 of that correction in [2] which declares the configsset
> earlier and unconditionally initializes it is cleared. Are these
> further issues discovered after [2] was applied, or was there some
> issue rebasing the patches?
>
> [1] https://lore.kernel.org/git/20221110225310.7488-1-ronan@rjp.ie/
> [2] https://lore.kernel.org/git/20221111231910.26769-1-ronan@rjp.ie/

It was human error on my part. Please let me know if the result in
'next' now is OK to you.

Thanks,
Taylor
