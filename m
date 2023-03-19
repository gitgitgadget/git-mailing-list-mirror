Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52223C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 19:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCST0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 15:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCST0R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 15:26:17 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22446DBFB
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 12:25:57 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id t4so10673785ybg.11
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679253956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPWTV6kkff6+4Wz4ellvyrhefBMaXc78a/zQ1fIS7rg=;
        b=nfhSYF3JxUCta9NgnOy3dAB1+MHaIS2CrwsZMM5da7tN/1bA1/HZYmKANHjWq+SqmI
         Dwywq7xReSDgYewxPLR5QpX7AE4vFTogcQTvr/dFbOeYzclVqBjAlEKHncWzqtcvz/xe
         XCDtT8xjtL5YRve6uhLgreCkyj0ghhmoVvYd5qMgeC8O54Tws9ee1RTpmwPdtUsQBHbT
         TDpO2662U1oss4vCv3CR7E6/ORz7Yc4H06LAflF8Co9ROFpDc6IemI9G2nKri/32O7Mz
         mX37JzXxSgpdn2Dl9nHlgjng9lHoyu96QNjM9YATL7v127qv3gUfi4ojcLFvYAmEf188
         cDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679253956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPWTV6kkff6+4Wz4ellvyrhefBMaXc78a/zQ1fIS7rg=;
        b=2zcOmMxXn3+oMIwHjUsNnwzFVfAOGCc7CdwfzSu7tZzYeX1d6PWyr8lIJ7J9yneX6e
         m1Y3XkQgrFzZBeg8GH41ObfbMUicaBSQmQJE5rdpSE220CN5TtkhfxAVINz7zwUazzMl
         Ax2thT65dbdeZqKSfbaWF/aFLZlxCJhd4bofczE91qvobF6EyzbJKzEocDRDQhFeX+0H
         173gaFArbo/8yKzZRfPKTN6H0GxDYb96jAnZ4JPz842YGzHz/Xd0lsddm/ozv8SuyMdV
         xk2RJqs+tZ+TN8UjLnnOyMF/pfFLuNcGaA2FovPUXG/77PSfTNilE9GKelZwr0+u0WSX
         GRcw==
X-Gm-Message-State: AO0yUKX02OLJlgRo5AxcRIXCQ3mOIhzOS5O6sA/r2CDIcvI1zVvciEnE
        h9mkt7dybQzhUnHXIntj1qTp3gYzzkHN8WPFsGKpfaLIDkw=
X-Google-Smtp-Source: AK7set9I3zXENyYOG5AT8ojJynUZVg0Ra73G320asjVek0j6Ut7g9H9Kq9t67R8PXLmep9ugji9f8DsrZXYlFpCxtiQ=
X-Received: by 2002:a25:acdb:0:b0:b69:83b2:5124 with SMTP id
 x27-20020a25acdb000000b00b6983b25124mr1801519ybd.0.1679253956345; Sun, 19 Mar
 2023 12:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1471.git.git.1679153586903.gitgitgadget@gmail.com> <CAPig+cQ+__c0CVspBgVxcGrzj8AnJJKKaQr-ofT4oLS-C-bQtw@mail.gmail.com>
In-Reply-To: <CAPig+cQ+__c0CVspBgVxcGrzj8AnJJKKaQr-ofT4oLS-C-bQtw@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 19 Mar 2023 13:25:45 -0600
Message-ID: <CAMP44s2nkQN4Dnzq47_zU+MjPeTAoicpau3rHbsxifrhotRoRw@mail.gmail.com>
Subject: Re: [PATCH] Document the output format of ls-remote
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Sean Allred via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2023 at 11:52=E2=80=AFAM Eric Sunshine <sunshine@sunshineco=
.com> wrote:

> > +----
> > +$ git ls-remote
> > +950264636c68591989456e3ba0a5442f93152c1a       refs/heads/main
> > +73876f4861cd3d187a4682290ab75c9dccadbc56       refs/heads/maint
> > +d9ab777d41f92a8c1684c91cfb02053d7dd1046b       refs/heads/next
> > +74a0ffe000da036ce4ca843d991a7c6b8c246a08       refs/heads/seen
> > +860bc4360c4fcba0fe2df942984d87f8467af3df       refs/heads/todo
> > +d4ca2e3147b409459955613c152220f4db848ee1       refs/tags/v2.40.0
> > +8810a79228a149a9773bf9c75f381fca27a6a80e       refs/tags/v2.40.0-rc0
> > +f899c182d0bffb6e915da7c8db9be202b144c098       refs/tags/v2.40.0-rc1
> > +6bed3304b2b2f1cf440ca3050b57a7cf3a3fe687       refs/tags/v2.40.0-rc2
> > +----
>
> I'm not an Asciidoc expert, but despite the fact that the real
> git-ls-remote output emits TABs, I'm not sure we really want TABs in
> the documentation since various Asciidoc implementations may render it
> differently. Also, we don't seem to have any embedded TABs like this
> in other documentation. It probably would be better to use spaces in
> the documentation.

AsciiDoc implementations follow the AsciiDoc specification, and
everything between ---- is considered a source code block, so tabs
should be interpreted as such.

--=20
Felipe Contreras
