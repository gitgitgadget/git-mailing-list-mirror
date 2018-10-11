Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91261F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 23:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeJLGjh (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:39:37 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:46375 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeJLGjh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:39:37 -0400
Received: by mail-ed1-f46.google.com with SMTP id g32-v6so9781100edg.13
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xd2oOu2YzqOaAPGQWa7Xbr4oN/5dRdQSGHfxcNGOoAc=;
        b=srqVxL3qqJFafSnkqDBYmt1CHVdjHsKS8Sf6oMhScEgBOX5zMA5Z9FKhFQan7lrRtF
         McLVR5RjdF0ZPhrCXrolS4wdEYwm+xH4nhytgyaUl3DkH30yN5iRJhuW5q0pTbnUeFZp
         sHHcFlHDv/KCnaSo78KHYnJc3hSersRMiNwHsaackKbywvuhHL61m7Bw7zMulZ/uSV8m
         85IH1pbvEQ18wI8ekMt5q6YXkmzCxitcifiZeYvxKM3LuQcAOufgccQc+qp06cggO4JE
         cRD+boIHAxmPQHMBEQHvReorlEYhlYa1GPIQYFonfqH+SIgs9nHlxC2RNeTCTl98QqtB
         ihUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xd2oOu2YzqOaAPGQWa7Xbr4oN/5dRdQSGHfxcNGOoAc=;
        b=AIIf6NhBs6RD18te/xlNn0it+AHrn0e2/T72IXsYXRfus1mNSe9I7t1YUtegFoTG59
         qZkU6j4//f223TlMJK2HZjNSw/nu0CL9jq78ihXjcV83tNhdXCIqx7wsFyezuXYr0hhs
         RhUp0woP4la/1t/gR0+5+0GnWEM+GViMjMWDzk72vXSB0MWYnKGn36mlVtgoXCE/W81t
         ZfhAXrfgEY6/n7JAX1OUoncOZFkNKhmyVW523XQOwgI6+xPzfk8iUw2nXidiE5rsYqi9
         qzmYa9eG8p44E1d8sAq+pdjJ79yTbj8vztQ9Ydb288ETgZmuGtJcwHkz3MuSM3ynGLDn
         2lhw==
X-Gm-Message-State: ABuFfoim9nl98aouP1oG2zoxNjB5hA0ZXhPp2Zwxrk8YIfMfCCsEw94q
        VRgFixy5FQGP/XVupTa5bm1oZr0sf4h7ymiSssMeMA==
X-Google-Smtp-Source: ACcGV62XFBBZwzKmucLRkn56v6fhGufWbNCF3dGy4ztWnDSJc7OBhbEd6ThNR0SOai3GgLSDDIQaJjB9NBLQThbyr1A=
X-Received: by 2002:a50:bc12:: with SMTP id j18-v6mr5621550edh.154.1539299407324;
 Thu, 11 Oct 2018 16:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181011211754.31369-19-sbeller@google.com> <20181011230028.200488-1-jonathantanmy@google.com>
In-Reply-To: <20181011230028.200488-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 11 Oct 2018 16:09:56 -0700
Message-ID: <CAGZ79kZx+3Qwx8-is4Bbrrf_FdwUqQGkS+BuVu9QeNK6OLFBFQ@mail.gmail.com>
Subject: Re: [PATCH 18/19] submodule: don't add submodule as odb for push
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Do you know if pushing of submodules is exercised by any test?

t5531-deep-submodule-push.sh (all of them)
t5545-push-options.sh (ok 4 - push options and submodules)
