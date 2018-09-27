Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60EDB1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 21:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeI1D7N (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 23:59:13 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:40029 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1D7N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 23:59:13 -0400
Received: by mail-yb1-f170.google.com with SMTP id w7-v6so1773366ybm.7
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 14:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4llvJGoAAhwXNJ2PZhRGs5Y6L2xRxDlWjK9z3HNc7QA=;
        b=lSIQsmM/y0AEfB5i3208bzqRTGBuHCXLeuvRafGQ8MnoYga0oJJHy7LDXwHpoL9fAK
         FTEZwAO3wUjxBOOloWeQYNyfAPmTD3kwzN1O7rxH8/UgedgFpoIaOfJDZ+DVxPl9+Ev+
         ToiUySAI2sKkNGqnqdZB13T6heavDXgIzMMrPCznp5wmYXh1QFtHfM3tatj5MF/HEY7+
         IshnxEflrvyHXCV8gRDsxmvzKS7LFHMG3ge9N/7vzaHzUjVlDw317d8rI+LyirGXjgWI
         Qy+SpywqI/o8Z5GoYU4TV6CiGH9J9LOb/yELBl3HUByq6E0LkdtHsuDDMJdnEkO3d5rR
         6Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4llvJGoAAhwXNJ2PZhRGs5Y6L2xRxDlWjK9z3HNc7QA=;
        b=d3ntBxiX8oy7wIGZzy8FQYTfOWbtuMvU0XY8BUDFICxLTfNMf1/kTkwV+E0pOZV18K
         qe5TUwPdka5tukhqFD9d19H3Oc4tdQJHP4GUbgM3UhVwAlImCaTms4LdVJCDjJkgzN4P
         i1c7mao9g4QRMC/4b2MvlXuYL9hV0+HH9YI6yRlf+uc0HihepBOeMNB/nvonVXbOzRNv
         E8XpvyBAWnzMPjJcR/3ONIQZQ/wBIxhHHTvzP3Wq9huxs2hZPjr0PC63M/epXP102CBI
         mI9LJKVUoI2jkPDNh6ywbbIWVE+E6OJ6jKuoBAN0RoefaVjywJN3Y4p64KGOkZHxEB9N
         dEqQ==
X-Gm-Message-State: ABuFfoiPlRsQjoxSgNM+PCi6jGcw3c4k6mpkiKTofu02uiYXw6x4bAw0
        hbU6p0ifvBZtUsBYdj16ZoPfujbsCVmY6QLcEVpt0g==
X-Google-Smtp-Source: ACcGV60T5YS22eoZIQWmjSSlvF9Mtf/Yx7zFnLHiyrp9NN+DjtIU+Ca5m1XGdvRvK0D+Y5Fzt1/tFAM107ko82vdGa0=
X-Received: by 2002:a25:e481:: with SMTP id b123-v6mr6795580ybh.416.1538084333881;
 Thu, 27 Sep 2018 14:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180925225355.74237-1-jonathantanmy@google.com>
 <cover.1538075680.git.jonathantanmy@google.com> <61ad64245470e51cb97988e0f2f5ea76c9e2276c.1538075680.git.jonathantanmy@google.com>
In-Reply-To: <61ad64245470e51cb97988e0f2f5ea76c9e2276c.1538075680.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Sep 2018 14:38:42 -0700
Message-ID: <CAGZ79kbN9Yu3sSrE+jxKFQyqRVM1eEvqoHCn3Y283biu-R6smw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] transport: do not list refs if possible
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 12:24 PM Jonathan Tan <jonathantanmy@google.com> wrote:

>
> +test_expect_success 'when dynamically fetching missing object, do not list refs' '
> +       cat trace &&

leftover debug cat?
