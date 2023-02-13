Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CF2C636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 21:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBMV7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 16:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMV7J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 16:59:09 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD801166C6
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 13:59:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i18so6598703pli.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 13:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3fcDglVS/eZF78iYYqhiL7gXX6TsUuluu87L77I7+M=;
        b=QIu5xIkG9l4y7mClolJQ/aTe83SrlNVwj1PXqIn11p+XlGAwqcT2kER6tziq1NsNNc
         L0hGZP9+6ZYV1lLe+5JK8/8Bj9a43BssF70Ra3EXDZ2H5lDIi1+hZF6PgUfsXsjS7bgj
         JId8DZlq1nrmtizcbO2WUxld2YuW55TRTrYsW0t6FCiAxv8LQ8BFL/bhjizRFSmht4Bg
         FuY8xGgxKBKEiOkiV4nDlC2Oz5E9AZk5cvAXPWjhsYYDY+F0oYPexn9ByNEo0k6fxR3w
         I+i45/0v3438eUykhk4AIUvNznplN7v84jkyo10QJ7lIj5bLojVQGewQMwYaW2/q6n1Q
         gjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3fcDglVS/eZF78iYYqhiL7gXX6TsUuluu87L77I7+M=;
        b=DIzl0DO+E6wfqUolEBmvVYl8P3ZiOCotGZhN5jF/nZhHxIjJIMndxRb/aL9m6FNGBw
         pqVI1cCc7aL69h74YowmUWcSc5+At0SKgoDTvo52S7vAR8BCKLR5o5osa7G1XAs1coGm
         mIPcy1hbebHj6uOA5blxTwWA063eZvgJj+z7FeR7kH7x2TLADJKXHpF64uJRyZO5Frlb
         3dV4x832YqV4nfs/mojbBlYRlgs3YEKtz/0DfhEm8kQeKG86ahe8tHWcOqg5T8pEQazt
         Fdxz6o4qPfSgLKVDcFiFqH39EinwWsC7cLdXCq1W4k/fKhDY8YidYcpdLthUs/0uD7W9
         HjDQ==
X-Gm-Message-State: AO0yUKVn2JMgWsH7CBNRaHIdcxn3VlZdVbYl3vPlm3J6l7aV8nmwDWnn
        JEG85XbOyzsKdFxW+GjpFsPxk6HpB/w=
X-Google-Smtp-Source: AK7set9L9U5s2ZivatKz/jnLITd+MprO65wZNh29/ZXjDW/C4n5AS3ki8aY/V7tgERTwviKjtHPj9Q==
X-Received: by 2002:a17:902:ce89:b0:19a:a9d8:e48a with SMTP id f9-20020a170902ce8900b0019aa9d8e48amr479901plg.22.1676325547176;
        Mon, 13 Feb 2023 13:59:07 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id z11-20020a170902ee0b00b00198b0fd363bsm2824433plb.45.2023.02.13.13.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 13:59:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 0/3] test-ctype: test all classifiers
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
        <81eee04b-598e-dfe1-f954-3105bcbcb2f2@web.de>
Date:   Mon, 13 Feb 2023 13:59:06 -0800
In-Reply-To: <81eee04b-598e-dfe1-f954-3105bcbcb2f2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 13 Feb 2023 22:08:12 +0100")
Message-ID: <xmqqa61h9qhh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Add tests to cover the remaining character class test functions.
>
> Changes since v1:
> - More compact and readable isprint() test string specification by
>   reusing the one for ispunct().

Very nice.  Thanks.

