Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D566CC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 17:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B647261C88
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 17:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhGGRHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhGGRHg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 13:07:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F18DC061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 10:04:55 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y17so2894727pgf.12
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KQ0yiZDkEcl+WDjJBMid3uOlPsQu9a2calmsm0dTJuM=;
        b=IjvH/lCCWnwPtQfDMrmkAvXCfJ41Dh1yacH9ZY/niJflcJzsaVWwlDlACMkuo1Mci/
         meEHIKovH08mmx1lINV+NX5XnlVAxgt4nVKiLziw9zMxZfPyTYe7b00RF21A8gmYYCZX
         cXDpXCZcmeLyfL543rD1Uop3r99L+LTwBrcY6EESbsiHo4qyWSAhMT/dzasheF3tPs2O
         d/CClCjFwa/Fy8W8TG2t43BbRUEbTsyJKspRxEDVlZmOJcuI96Nw6VqpjFlNHgubcneV
         P91IJXsQ3mg/QReqtKkt+Iye9gSJSLXjBmBrwZMsA9oGobC0cERmZVV58G21dcoT56rO
         ijYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KQ0yiZDkEcl+WDjJBMid3uOlPsQu9a2calmsm0dTJuM=;
        b=a73ilpXOH3fmHuYGRiqdGhXQ4D5nXTjgPyoJ7fbs8lozdmZ7EsmfqGFedpQcW7Mli4
         eFh0asVCUz/7QHKLgU2QVAh9Cg1sx+vFM8L3NopCM/oibDW3zpvppnCDWeVhgCMhtlUL
         yRa0sBUNPS3kPTnlFNgJk7wOdKTU3bb/IrMo9z1Db/Zk1Kr/on5DojCdObrdMNfK17nm
         lZ3v2CXKaIM97pe5TYedTX8qFUFijCWMlQWh4MpyBcDsqN3oEQLV4Zo/GyVwjh665x7f
         JKG/UwErLian9EQwkOviolV1K8aXGcLDU9aUwFELCA2k5UwNiSuXMo817zt9KH/8CWjv
         Fy7w==
X-Gm-Message-State: AOAM53044IayhGEpS05PDPhiWV/qvou0BFlXu6yvfOUoIc0V9hiYjgSk
        5BSnK4dL7gL8SXJHDt9vXsg=
X-Google-Smtp-Source: ABdhPJw5IsWzDugWUWYLfZi1btmS5uKMAzkfCw+zA0lN0Mz3GzAz+iqr5uTu5xVYnrO4CMYEdxnrVw==
X-Received: by 2002:a63:4c3:: with SMTP id 186mr16848517pge.240.1625677494958;
        Wed, 07 Jul 2021 10:04:54 -0700 (PDT)
Received: from localhost ([2402:800:63b8:9039:443b:57cf:40b5:f8d1])
        by smtp.gmail.com with ESMTPSA id l2sm9713110pfc.157.2021.07.07.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 10:04:53 -0700 (PDT)
Date:   Thu, 8 Jul 2021 00:04:51 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Professor Bloodstone <prof.bloodstone@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-am changes author if its short
Message-ID: <YOXesxUQW9zRX4uV@danh.dev>
References: <CABHhMZHEL=0sU8JqwMb5Va7mjA4ZxM_WMaLMabbKS085RVbDzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABHhMZHEL=0sU8JqwMb5Va7mjA4ZxM_WMaLMabbKS085RVbDzQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-07-07 18:46:53+0200, Professor Bloodstone <prof.bloodstone@gmail.com> wrote:
> When applying a patch using git am test.patch, if author consists of 1
> or 2 letters, then it is being replaced with author email instead.
> 
> For example take patch with such line:
> 
> From: AA <git@bloodstone.dev>
> 
> Upon applying such patch, the author is replaced with email:
> 
> Author: git@bloodstone.dev <git@bloodstone.dev>
> 
> I did try multiple different 1 or 2 letter names, they all seem to
> have the same issue. 3 letter names work fine. This was tested by 3
> people in our project, and happens in very different setups.
> 
> I'm having a hard time finding the exact cause of it. Tried searching
> for issues, but didn't find anything. Maybe someone has an idea what
> could it be caused by?

A patch for this problem has been merged [1]. Git 2.32.0 should have
this problem fixed.

1: https://lore.kernel.org/git/xmqq4kf25lso.fsf@gitster.g/

-- 
Danh
