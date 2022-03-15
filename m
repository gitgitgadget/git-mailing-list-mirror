Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6485C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 08:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346199AbiCOIvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 04:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiCOIvu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 04:51:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9444D273
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 01:50:38 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a14so15275156qtx.12
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 01:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JVl8d/ScihJIGsu8jjvM5SgyjpONkZkd5h40lHJjRPQ=;
        b=CeSUPBaj2bbhEykk7WVFJcRUNKzvI4retQqFyNb9Ppa52hTGrhEYcCsDxSPD2qOJT0
         +euhBPmugziSB9uoc6dZ2AFEfIPMvbFprjJKDRO071BbrsSNSVdBRg9CzyXgxlaVQT+B
         FUdXhzOA18JehcLmWYTcJ2tQajxtolCj+hBeKtzk93HCovzlFo/q+Vo20WEfUSNwzoX9
         ygqBDj4pGkCCrwleYsviHW1LCw94jGPArrDW9CxnQcvcO1ictwATNNxzouH5PSFtLjjM
         tDtRt4wEqE1ceXLfuiErEOVnUl7/vnOFVv88k/QyHksnnVLZUaPip0FVSMF0VP7g09Xp
         l2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JVl8d/ScihJIGsu8jjvM5SgyjpONkZkd5h40lHJjRPQ=;
        b=mdJpjyMqW0jbe+SDcYR0+/GNKjSN/sWudsRXd1Ud4fnGTbqzzCRUNZfjIryz7d7nZZ
         hgtRBBMaxPks+tlixvu6j8RoD8/gUlrF1V5JoSzAQDbkHD4NOlhRw+ExwGj7zcnMcgV3
         4fIzT35yNZprkXZiZKl41WZQy9R02sQQ2PFU+PHlHyW8HgiCNiDfOfrldO+9WHQ6at8p
         eR/VrGQvVbRfygsZdEcSYe+IGBy/CAnVXK1yJyRF7zY5qD/8Z9DlyBFWYxw6lNzpAkzQ
         H5IMyqjEA+4mf6INqs1/XHCNI97vh2e1qpjkT0+6xjg3vDii3gIl6V7f5rUioR7W04ea
         3I8w==
X-Gm-Message-State: AOAM533VNODAfd/y19iThVKWU4YcrU6WEI7RuZtPrAiFSD9o1Oa9PI9l
        5Bfxr/fUT4sKyLbisRvxFZgq61S6U3QMky1Ff7D8DflHkV4=
X-Google-Smtp-Source: ABdhPJziNRFoq+ECiJR8WUZKJI95QD8AovUqAD9OzRXrgH3PI+SYXlbPAEu1AFhy92LCpCij84uWvyjNqsf1B1W/8Co=
X-Received: by 2002:a05:622a:5d0:b0:2e1:d430:a5c9 with SMTP id
 d16-20020a05622a05d000b002e1d430a5c9mr6785096qtb.639.1647334238011; Tue, 15
 Mar 2022 01:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220313105031.1081110-1-gaurijove@gmail.com>
In-Reply-To: <20220313105031.1081110-1-gaurijove@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 15 Mar 2022 09:50:26 +0100
Message-ID: <CAP8UFD0GeGr3ARkYycHNYU0r5vTC-PDdbLYrkYSohbtWBt9HSQ@mail.gmail.com>
Subject: Re: [GSOC] [PATCH 1/1] t7403: Use helper function 'test_path_is_dir'
 to check if the path is a directory
To:     JAYATI SHRIVASTAVA <gaurijove@gmail.com>
Cc:     Hariom verma <hariom18599@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 13, 2022 at 11:50 AM JAYATI SHRIVASTAVA <gaurijove@gmail.com> w=
rote:
>
> From: JAYATI SHRIVASTAVA <gaurijove@gmail.com>

Thanks for this patch! I am curious what tool you used to prepare and
send it. This is not a big deal but when there is only one patch I
think [PATCH] is preferred over [PATCH 1/1]. Also I think the 'From:
JAYATI...' line is not n=C3=A9cessary if you are sending the patch using
the same email address as what's in the 'From: JAYATI...' line.

> To check whether the given path is a directory, use
> the helper function 'test_path_is_dir' defined in the
> test harness library instead of passing the -d flag to the test command

It's nice to say why it's better to use functions like
test_path_is_dir() rather than `test -d`. Also it looks like the last
line could be formatted to be around the same length as previous
lines, instead of being significantly longer.
The sentence should end with a full stop.

> Signed-off-by: JAYATI SHRIVASTAVA <gaurijove@gmail.com>

It's also not a big deal, but, unless it's really a personal
preference, you might not want to use only uppercase letters for your
name, as it's not usual here.

> ---
>  t/t7403-submodule-sync.sh | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

The code change looks good to me.
