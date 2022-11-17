Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CDEC433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 21:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiKQVuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiKQVud (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 16:50:33 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88444720B9
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 13:50:32 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e189so2489897iof.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 13:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P+/c3ouOUfQHis1HB6twu/ez18Xm5pxalAJCfDEyWvE=;
        b=HN/ZkWsfMwAgrwN+5sHKQ6paXxGcGicNLg7clKN0MDvogKs1uo98QTzZr9zxsmV4o2
         31SC97a3mAeBUUpbCGgAjDRphg6AAzX3ZVXWo1gDGVNZMmCdpfY1qvfverJIdeFZflQ8
         ldD8nbQqO2UeYRX2b01Bgd57cIoEcLSsgjIB/ABmRwdDZurJH7a9RmavTzmVh2pi4ptZ
         bsCxt0CjeyY8arxIp2SLtdIvfDY1qtHfsxioGCE0vLSvVaS5aLggzEYEhtrX7f2B+/T8
         JXE+VjvlYrrGq5wrz2H0xEvvS9tOXLWfeXbC3n/SKE13yJBXQacBP6vQZ7oja3UzzSSI
         9/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+/c3ouOUfQHis1HB6twu/ez18Xm5pxalAJCfDEyWvE=;
        b=Ro6ftPoZDuprRbyoOByPdrUt7FXiOxESbbh81uliwgHW0Z05kv/QHTRK6Ub4DSBbqM
         RB8I7/mUQsYBvsrDu1qgHC8Ab9lZKrriCrC984Kp+zQMyJOYTCvBZpqtB6umTIJ+enxf
         bYq5pYxq0Y+oPC6R0W/X2S6bRHi0WoKsxT/+pRGKrZ/I5hhGVt4TyBmaqYf9mDYUvSwy
         0zt5Q3y0A0CSgiuNj4KJGCMv1pXVMOsV2V7Gzc1UXG9xyAAh2AYTnn9opI68DTaV5bPs
         /BmBrqi6j3bUXn2k9B25X6gqbyDTU7dC6B0d1CvozQnluL9pECMXyP2xbdtJ7qLlFa/w
         9NnQ==
X-Gm-Message-State: ANoB5pk1qA7gdkZbFE0dzCmbpzvYkqzKJp0iRT1OPJuPUlMeInfrsCkz
        BOqcE34JtUeZls1k4soZ1wtL8Q==
X-Google-Smtp-Source: AA0mqf5v7GTgwZepAW06qZC30CRK+mlK5U13wmMhv9JZrlFiuk4pX/3T2CLEfDc8Y0cv9Ti7p7CHoQ==
X-Received: by 2002:a6b:bc87:0:b0:6d5:1edb:2b9d with SMTP id m129-20020a6bbc87000000b006d51edb2b9dmr2252140iof.185.1668721831875;
        Thu, 17 Nov 2022 13:50:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w6-20020a022a06000000b00375966aa90esm308656jaw.161.2022.11.17.13.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:50:31 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:50:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] t7610: use "file:///dev/null", not "/dev/null", fixes
 MinGW
Message-ID: <Y3asprytS9MY+TMH@nand.local>
References: <Y3PrjMLcEGfoHifZ@nand.local>
 <patch-1.1-21a9cb49299-20221115T233516Z-avarab@gmail.com>
 <Y3Q3xQeaXGPemcWv@nand.local>
 <221117.86o7t5j3jd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221117.86o7t5j3jd.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 11:08:08AM +0100, Ævar Arnfjörð Bjarmason wrote:
> And thank for picking it up! Looks like "next" is passing CI now:
> https://github.com/git/git/actions/runs/3475751137/jobs/5810308794

No problem. I dislike pushing out 'next' without a corresponding WC
report, but I dislike 'next' failing CI even more. So I felt like here
it was OK.

Thanks,
Taylor
