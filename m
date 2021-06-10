Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EC6C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D67613E3
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhFJOto (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:49:44 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:36476 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhFJOtn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 10:49:43 -0400
Received: by mail-oi1-f174.google.com with SMTP id r16so2025513oiw.3
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=QNdbqpZouFMJmfkIKCpE41oA4hhzxSqNynxetj9cJqU=;
        b=dNmSqD639moQAlaXO3pQaxDpRWIlZbTysJ4K/77s2wRx1drB0sIVmH5Ck39UUHKl26
         EvfTYE3jMsA0yO+9n4KuHmVYHj3gBARsvcGj485Z8IDJeRH36FTkR/6aQJK699A4pBfJ
         9yNPxnklhzbqqOk79NZE3qIY5BmMRb8vF+NcG9Xm1rELudigP93KIg5uZ/sRAe56o5iI
         PdtJaz1MJyXYy2lSlsdK9vCyUpRpZ8wuS4UH8PkhAty5fUW7Xj5s9N6lgPGq5iiEgp+q
         Zx2XZrRwlWJl5C4Q1muCRVP9o1AYQwsFmCZQr6Ey1RJFOdYerWw5wa1/XxI6yZ1R2LjX
         9obA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=QNdbqpZouFMJmfkIKCpE41oA4hhzxSqNynxetj9cJqU=;
        b=h8FBXJ8pGSSdnwvzf4NZJsg8Ftyw3YuX5OJnE/vIrd6XoA7L/mHNJlMbmQlXSABHKS
         nq1826Mct28WB7/KpL0y+WViQc+5NGSL3Wvfmy/zeDxglUA/bp+nOUzP33O30EzM4PFI
         WoKNknkOydmUz5KCfTviCylnZ30We6OwGIHk7QMnlivYvevZ8IqnAzw9jY3ePGAsmaEq
         HQOKHPOeRo462VndjBRwwMuSddeTYvuwcdFdBksfVVRJml4ZbF+zvKdMpgbJm8OuQ2/I
         djwBIo3dA9n+fqVxpWDrgsLAWPrq4zFj+qM30ftauL8NJLMyhNM4oJV0V7Bv9/QVnNMV
         nhqQ==
X-Gm-Message-State: AOAM532wui3Qtoi7sKnz68jjJGxgbXzuWijSdfcfbhlB6uIw6XfFLqj2
        iWd1SyBfgDf1V2dSrFFr5qA=
X-Google-Smtp-Source: ABdhPJzBHIA5SRH4bLZx4BKeZIBW7wXew2nxQlDmu/d5OpeA3OQ/eYp7HFZhcdkq1D1TUj5VO1QGVw==
X-Received: by 2002:aca:b145:: with SMTP id a66mr3549430oif.177.1623336406954;
        Thu, 10 Jun 2021 07:46:46 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id v22sm585095oic.37.2021.06.10.07.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:46:46 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:46:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Message-ID: <60c225d540231_b25b1208cd@natae.notmuch>
In-Reply-To: <20210610072406.10203-1-rybak.a.v@gmail.com>
References: <20210609102641.3531183-1-rybak.a.v@gmail.com>
 <20210610072406.10203-1-rybak.a.v@gmail.com>
Subject: RE: [PATCH v2] *: fix typos which duplicate a word
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: *: fix typos which duplicate a word

This is still awkward to me. "Fix typos..." is much better.

-- 
Felipe Contreras
