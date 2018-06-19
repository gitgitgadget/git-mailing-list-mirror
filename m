Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031E81F403
	for <e@80x24.org>; Tue, 19 Jun 2018 18:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030319AbeFSSfq (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 14:35:46 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45856 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030279AbeFSSfp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 14:35:45 -0400
Received: by mail-yw0-f195.google.com with SMTP id v190-v6so237957ywa.12
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8X/9JaNB7bZtgqkST4A+W8Z4F9iDO1EJPDaTr9lG7OY=;
        b=p5irTGUbHrlNxhHeQthzLzNA8Hgdjz22hGPbgVKjCyrXCmmsrbQasmagtplxon6ckP
         Qyg0l8byDd9PeCDc9zB01Pp1XfpFokb/hTcgsSHNll45tA6kzj1U/QjPaVZRi/lpWCo9
         WHMvE42uwRqZnC2jkQdDI77OBnF9/NbH86tdErRiZzHb1TcRab1H6rhngWeJaFV3G1ul
         2LfhCxJKeWlIU+ZMDmvCXeyt3Z5XKMtNiYv3PuMNOV1OrWhlxqyEXf3Li1LOj8s9+Zcl
         GWRXlsXfLBC4fYF7vLW101dA8KX434K8y62QnpzGnPyPzquC0Ve5dXHXxT/g8zON95Ur
         6NCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8X/9JaNB7bZtgqkST4A+W8Z4F9iDO1EJPDaTr9lG7OY=;
        b=EhuYY4jvLtkYLPIRgbjG3dOAOMVT8WF7tVgexXE6nz7CP4TibJFRdNDbAyzbynXuIM
         qa9qK2AXzz8zXovFr1BRyAv5Fodb4cHmHCBlFj8iO4qCsZOKcM6gwWFrPGyiY1RlAa3G
         xn1BqGnCCI7mFGJdEpzogpSn4mdL7cqGgjSsYKkZa1o7/mODzUVYHi/4eUdCLAWiVUbP
         yyKolJabWst7/37O6aYPF2hWED1SAaGqCFOgmsaFNgElp+A+2yl2wv7qRGonudTEMCJd
         PJdora4AzrU27aG9v3DTCQSAiIblv1z4nU1SrU6d1Nz5rpjggyrPX2DJPRZfLZlyLhjE
         DXJQ==
X-Gm-Message-State: APt69E2vKdkobB92lZ2ewlJVBzrnXXRX3cYGNqso4OEdzGOst65wpIvK
        fPK4YucUiWczebLiVGL32OajklaScWtQDa1Cq2DA9shG
X-Google-Smtp-Source: ADUXVKJh31/WpRVtLNfFmFRrsTR+GdqSlzmjE3cu3Wr7Y5X4LYvY2xhkgxKeQMRl0kLuzzprjwPno/hzKxZn9BAEIls=
X-Received: by 2002:a81:b283:: with SMTP id q125-v6mr8693833ywh.414.1529433344397;
 Tue, 19 Jun 2018 11:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180618131844.13408-1-alban.gruin@gmail.com> <20180619154421.14999-1-alban.gruin@gmail.com>
In-Reply-To: <20180619154421.14999-1-alban.gruin@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 19 Jun 2018 11:35:33 -0700
Message-ID: <CAGZ79kb=T42ePDjpkXtTeiwBknR7p5eGXuOXfujoCtU9eEJm+g@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 0/3] rebase -i: rewrite reflog operations in C
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 8:45 AM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> This patch series rewrites the reflog operations from shell to C.  This
> is part of the effort to rewrite interactive rebase in C.

This series looks good to me.

Thanks,
Stefan
