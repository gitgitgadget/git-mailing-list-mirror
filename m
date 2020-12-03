Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0927C64E8A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 09:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB9F22245
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 09:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbgLCJjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbgLCJjo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 04:39:44 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE38C061A4D
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 01:39:04 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id z13so356693ooa.5
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 01:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UFm8aIxyP3f3lVOAHNfYt6z0f/pSRUCuvxyLjxoBqLk=;
        b=lfpwRQArZJRM+rKOTiSH3xeZocxpoBMTqgR/XRZ22g37al4L5M/8+zWmUCiwbOFwjE
         MsOa4bZECKYRtXiaERjudUWIBnJer2oVke/a5NjTyUJ2+GU3ZbKVpCper2hXnE8xWUkD
         /Pr2UsT5/9IpdWXqEU2lH1Na4r/i9k3J8mlZ2NUhGVFpjP8bsBt3q3xNZz+7ZI9raMLV
         Z1hXNj/3DztSMKKEH1QBbsUT7P26qHSlYNuI2OjSetBwV41+p1H/Z/jPXhvWzrK9gVm3
         D7fMQe9YQhFFHA50pJjs+ayMKHmtPd3r1sa4fDiFrKkEGw312oNmsM7FXpdYaZ4oqJlq
         Dqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UFm8aIxyP3f3lVOAHNfYt6z0f/pSRUCuvxyLjxoBqLk=;
        b=AD5x7Mtwac+1NZU/gxhLXLo4Iz5YeuLrZH9ENwe53Vpx5x8fzKCqIdaiK/rSicd8V6
         SuXOS9C2W+S6+SJWg8iy8GohWUCEFopdufrMlVh4CkLSONe3JMXJrwoWBwjnsCpyiw+U
         nunoYTGGsn+xl7cfY4raKdQmJZ4LMU7DEDffckFRKEXcNmXKXvxHmR+1QEMYJzL3O3VW
         HSNsf30PbJBLkBFKSWFt2FFlZT5q8SGb66pxgT03iS5vJ0ZkV0wNG0N5Aw34puiItq2+
         F4dx93xMqmPx5zEQSKelORl7R3ZSLv+APdkYW6xBt6/ZWUP/BalBi7P4pYAY2Lm5/ER0
         Nwhg==
X-Gm-Message-State: AOAM530y7RNz8crN2KfffScKVfH6rSAcG7rIFejma8NBFFdKkVuEgzUo
        tb3zxDVvZdoTMdMtVa7NlYYENTfIhTQZ7xqzkf8=
X-Google-Smtp-Source: ABdhPJw9LxlUQlsfUcQ4cfHwojRRBgYBc1ArCu/JVOTSUXK9um1dikAMOyoCTPgQcpWTXqk7u4ya+ACZMoiTz87HLMw=
X-Received: by 2002:a4a:6b4d:: with SMTP id h13mr1470923oof.67.1606988344048;
 Thu, 03 Dec 2020 01:39:04 -0800 (PST)
MIME-Version: 1.0
References: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
 <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com> <CAN0XMOKEG9HLuzf9ZRXyUs_uHTXagyCdghtP98rLVoPj_75UYQ@mail.gmail.com>
 <034d340f-ae62-2c22-3c6c-c9b14e0de662@nokia.com>
In-Reply-To: <034d340f-ae62-2c22-3c6c-c9b14e0de662@nokia.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Thu, 3 Dec 2020 10:38:28 +0100
Message-ID: <CAN0XMOLHM0mFvXcdiXJS_yD59rSTuyJpp9N9MLvcZ5LCC1-yZA@mail.gmail.com>
Subject: Re: BUG in fetching non-checked out submodule
To:     =?UTF-8?Q?Peter_K=C3=A4stle?= <peter.kaestle@nokia.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,

Am Do., 3. Dez. 2020 um 09:20 Uhr schrieb Peter K=C3=A4stle
<peter.kaestle@nokia.com>:
> > I can see the same misbehaviour when I run
> > $ git -c submodule.recurse=3Dfalse fetch --recurse-submodules
> > too, so I think it doesn't have necessarily something to do with
> > the 'submodule.recursive' config, but with 'recurse submodules'
> > in general.
> This is interesting.  There are several testcases using
> "--recurse-submodules".  Have you tried, whether any of these trigger?
>

The test suite passes.

Ralf
