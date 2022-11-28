Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8977C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 11:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiK1L5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 06:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiK1L5L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 06:57:11 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A3A186E2
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 03:57:08 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id v81so11266953oie.5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 03:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LCD3M298LCzn54CQ2m+fG5Rzmq05pUMORaPUKdsDH3U=;
        b=XFf6UhkJ1rhDx8gHD7Iz6dkpbAJAtse3jLBMkWXEkb0OgyyIM0toBvJfmxbiZeiVJz
         qVFJgQ4SQ8e2QZfYZCIMbcJl/JPg2dOSD0NzRS0CDz5DtArZo0qiBpWSxuEEt7ELV6nJ
         NdKazRRKxBv93M6TZTV61wlEdAlqzJ6Vc5+WvtzF8HREZ2zycx1+q4oC943JRnuUfS7x
         L6gvKAajCMU3oM+x8cvFYzkI0mDm3LWm+PtnDuMgHxnfJbjH52kN3/AHVj1I1tGQNz6k
         oJ554GlnCBhlqArntlsRMuGEAEHfXwgFutj2ps8VvlatJ8+w0UZSv7AvnQ+zIa5uNK1c
         uvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCD3M298LCzn54CQ2m+fG5Rzmq05pUMORaPUKdsDH3U=;
        b=WXUf1WyXm1rMK0ks08nqybFnXboEIPqIFu8+mnh+nq0Myj7UdjDmkHjlnlJzAYXRqF
         rPc9UrKp6W0f0lVfBriRsRGH+eUtzm8+8Y1sCRTGT1SBEzM4fr0x9uUIfteocuNYetZW
         QtNDUuiTpIe3JiS6PEZmp+OPK/A8Gw4a/AbE8kNmeBctQejiqhTY7xU6A3/G3HwjIkZt
         zkiU4owfIQHZhuT+taHz5tdXMNunhJ+4nK3U/5uQyXoFF9dzdtDQDDbtakMM96L98Dd1
         6ZBEl+RPMdpZJOTrw9Q8sEd5IH1LlR/ApEH9I2mlKhM9hVRrpJzURlXJ+2Q6iGCWuMGG
         uxag==
X-Gm-Message-State: ANoB5plnru3JX/p1XPBb2o4CD/EsR6cSpHPttBGGvVy3xOd0GwNpxTCF
        EHfotMPKsxWF0qNI7csc8n6TmjhzVzRzzrHwHgc=
X-Google-Smtp-Source: AA0mqf6Ysf37OFO81gXAi7AwSIpMBAdjLn5sHE/lX0zH+lBT1BXVEnlzv2TJE3c/FgomwqZF/llkY/PG2utCEn4m6x4=
X-Received: by 2002:a05:6808:109:b0:359:ac90:eb35 with SMTP id
 b9-20020a056808010900b00359ac90eb35mr23456379oie.80.1669636628087; Mon, 28
 Nov 2022 03:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20221127145130.16155-1-worldhello.net@gmail.com>
 <20221127145130.16155-3-worldhello.net@gmail.com> <xmqq35a390ek.fsf@gitster.g>
In-Reply-To: <xmqq35a390ek.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 28 Nov 2022 19:56:56 +0800
Message-ID: <CANYiYbEpuPk==QZLAzn0vy_FTr-_8KVnT9zB0as2WZHg2=L2Kw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] t1301: wrap the statements in the for loop
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Heikki Orsila <heikki.orsila@iki.fi>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 12:19 PM Junio C Hamano <gitster@pobox.com> wrote:
> So I am not sure how this patch can be an improvement.
>
> If you wrapped the setting of $x, $y, $u and the config into a
> helper shell function, e.g.
>
>         prepare_perm_test_variables () {
>                 u=$1
>                 x=...
>                 y=...
>                 u=...
>                 git config core.sharedrepository "$u"
>         }

I tried, but found the first test case passed, but the other test case
in the for loop failed. This is because the variable u is changed
twice after prepare_perm_test_variables has been called twice.

So, will drop this patch 3/4.

--
Jiang Xin
