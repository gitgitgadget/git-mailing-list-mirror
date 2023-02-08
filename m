Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1DEC678D5
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 15:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjBHPyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 10:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjBHPyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 10:54:01 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD852413E
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 07:53:56 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id m2so19773519plg.4
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 07:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4gnfRDCy9PljzatagcQmJhC/I1jP4qMSVYNEbHAiJM=;
        b=Wz/O0RIFNCFCyHgTDQHvbaYoxZHxTEhUzl4tTyUqLTFxnm5QC6jy7D8noVBuennhJ3
         A7DASjvO/K4an2zJ7xrKGry1BKGn44qM4FbdjR8p4CjTywCg07Wt2SxuAQykd2e9+FFp
         Q9NJzdnjIiaLJxBknYYGe4nd4+kNYzk6frlaFFLs7SlMKqhB+lVgb46jQ3ocuozo+dCl
         u2lZo/iOKoLe1w1DGZjiSzVvjRbUX1RoszbfzvZ7wuK8YMQRId6T3oEJ/y45xmvW92+q
         61X83OvWY3ULKzXiH7OWJlxOq0RzYb8uGtAjCTCwyGunMiFTqDQkeCVukhVTrsyiyhWo
         791w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4gnfRDCy9PljzatagcQmJhC/I1jP4qMSVYNEbHAiJM=;
        b=ZsE6HAto9yrTwPg5807hlHgLF1RVe46K+cDD904ixvqwD79/wulhEo1IiDzGBCxs9i
         o6BLslaxXzL2yhveSeAMuQ2T2J+YAHi1BUu44H8igYwKmx2xoktoSRsc8tQhmco8WBji
         Q6DboW5OoenfKDh0HUZYLvzir8geuZ3X5P7FAdDVUOVaYQ1X9PiqYtf1v2l7zvuvl0JH
         S3Lh2gAa2c7792fDTSzTxCsq156B4aTbcHy4e6/Gakact8E1FPL2nNbDbQIm7lW+gJHz
         pSatPOSEObBSVHOC1J2d01RFD4AGiedtJhOcIrD2AWyeWOZ+MK9ucgRL6Ssep0kqMNkZ
         +RYQ==
X-Gm-Message-State: AO0yUKVVE+bMDoq6wdodgu+KcQMnPdZMC856/tVsNE/93yCYYShHhCC7
        LTIjmMESv4oo8RZFRI5b+F0TI1cLi0e+CKKW
X-Google-Smtp-Source: AK7set+ud25L8wA+Xx1JIhnBG3DoOsCO9QSemrQF/ulPDaGA/LDYNg04TylmbyJipKFHHkq9evA+HQ==
X-Received: by 2002:a05:6a20:12cc:b0:bc:f665:8655 with SMTP id v12-20020a056a2012cc00b000bcf6658655mr9856695pzg.53.1675871635575;
        Wed, 08 Feb 2023 07:53:55 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.149.188])
        by smtp.gmail.com with ESMTPSA id v2-20020a622f02000000b0059261bd5bacsm11237749pfv.202.2023.02.08.07.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:53:55 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     avarab@gmail.com
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [GSoC][PATCH] commit: warn the usage of reverse_commit_list() helper
Date:   Wed,  8 Feb 2023 21:23:50 +0530
Message-Id: <20230208155350.186187-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <230207.86o7q52vxu.gmgdl@evledraar.gmail.com>
References: <230207.86o7q52vxu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 7 Feb 2023 at 23:35, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>
>[...]
>
> Having said that, I think the existing version is fine, and we could
> just ascribe the issue that prompted this to a one-off mistake :)

I understand it now. Thanks.

> I think if you want to pursue this, a much better improvement here would
> be to show what the user *should* do.
>
> E.g. show one code example of using the API in-place, and then the
> preferred pattern if one wants to produce a new reversed commit list,
> while retaining the original (presumably just copy_commit_list()
> followed by reverse_commit_list()).

Following the response by Junio, I think it's better off that I leave
it this way?

Thanks,
Kousik
