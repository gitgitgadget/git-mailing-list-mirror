Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F490C6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 13:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjCYNEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 09:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYNEg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 09:04:36 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A5155BB
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 06:04:35 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id jl13so3415253qvb.10
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679749474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tmn+s6I6KnqpT2tYXATyLz8WEWPj+KAVMuuynTGTPPg=;
        b=ZJwkq3/ejAxH9uDN5ynJSgC8d7s/jvtpP4e9jtTuZUp5Dv9IV8MEQGSb3Mg04KsdKj
         Nz2usheX7KZVC4xFBUwmhY3srB/Ji8etlXK7w8eqS35AjhRiZLAyC2V7bJE2JH0k02d5
         gtqQ9CXFJz/la37Dd3qNzQg2jkcDqid14qxKT7nHK4a6ASTR5TV27e1SlG/45gQ8bEiC
         qOgyGcrtFfiJkRPqKSB9jiJCCwk7xKAGLa8VMHnbsG/vfX6Tn8n8hIp2Kn4Ts+2jsVR0
         xXMH/nkLyJ7EmOJ8sNsWuGudLeN0qvqpigU7CLJTgzaQGfggnPJqxEp0q8HmypUJL6G/
         r2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679749474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tmn+s6I6KnqpT2tYXATyLz8WEWPj+KAVMuuynTGTPPg=;
        b=uTLAoiX6FVF3AN3Sl6305x38qg+5aRYjA5p29lP7B7+6jQtIPjvEQTbUKQ5FGd1jAT
         XZz/L/45ocOt+mffJkFgAd7U5FGgK13MaaXk8zTnvsymhm9zvEtzo4cFaBrUhMguz4dG
         pWha+Q87ah8TIltodddoQMMkANm6Su0Ra8tNXSrHckKZAdsLZSbQaLGNpRoa7y+u7ydn
         19+UmwNVPr6/fBT/jZRa2K+6m6CXmZbCuFvizxBbpUnXPcyxmOuYmybITRSoLVjiwLEO
         GtWNum5mqDcaPsWSktfupV77Cs8Jo5XmtpixVfJuqlMiTm2uZKIpsUs0oIej3TnKtWjg
         xqRw==
X-Gm-Message-State: AAQBX9cFgtOG7KpBCPrZyKJXcpgzQUf3s/t2aUUla7clYjlx06id+OTj
        o3KvdNxu4Qy8Uw765Cc4yk/yuDzQ1oEcBTwZ6fw=
X-Google-Smtp-Source: AKy350bv5YoLONl95EZ4SmdbX6wv11GaObAHo0zyUwJnBwIN8S1LhUtpXRLhbj2jj2V0k8w+2Xke0tkUnpDZh+5Ui2s=
X-Received: by 2002:ad4:58e6:0:b0:56f:6e1b:fac1 with SMTP id
 di6-20020ad458e6000000b0056f6e1bfac1mr1056520qvb.2.1679749474502; Sat, 25 Mar
 2023 06:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
In-Reply-To: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
From:   demerphq <demerphq@gmail.com>
Date:   Sat, 25 Mar 2023 14:04:23 +0100
Message-ID: <CANgJU+Vn8ZLGcAYbuDeNkv6T5YdX6t20BqGQDPB0VL_TzoGSWg@mail.gmail.com>
Subject: Re: git bug: Perl compatible regular expressions do not work as expected
To:     Mario Grgic <mario_grgic@hotmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 25 Mar 2023 at 14:00, Mario Grgic <mario_grgic@hotmail.com> wrote:
> git log --all -p -G '\bmain\b'

I think you want -P not -p.

cheers,
Yves
