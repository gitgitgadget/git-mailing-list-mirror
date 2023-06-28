Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9A4EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 16:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjF1Qhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjF1Qhx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 12:37:53 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0050510D7
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 09:37:50 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55b10f171e0so1264873a12.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687970270; x=1690562270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5KYC/HVt1lS1CKHHh5DhJz55My+/t7O1aDe7pHOo74=;
        b=PTeEzFON1Sg/eft88fKXnU6QMGYnA5jFwGNPN8KsaDknsNXQlSwOTd1rt856x6qSxO
         uqCSMYecitrfmBc7iFXw4bHAmpPU0c7xEOUTHzEY1ERNlV+6nYDoSMjSb4tOXo4Cf1yV
         RjKH2jvCH9+Y1BVw1SJknTAessGIMS6t6ZxfQ28GHxpgrW7fuJi+ektZU1YCVyoplhrg
         8878HyIs34Rw84O09AKM13GhiKu143QQi/YuYRrsCt4gQLUYMb3yqMEiIe27jFvzaOlz
         HgcBNR4DM3wf2YS6FoKmbrXViZ3dnqLXWQPp8gfZ4tt561nE/Kzj3Yk8pObNWEdbn6kz
         awlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687970270; x=1690562270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5KYC/HVt1lS1CKHHh5DhJz55My+/t7O1aDe7pHOo74=;
        b=kHONud2ZXJI0PUY001y3NIQsEw+M6LBWD75kWq+SKkokFI4Dulf5bEaFZGr8NwEbsg
         D+CAWXSU7G3Fn+kTHTs3vx1uiXjPa7ZrNcdW7k91GfmI3KS1Fmi765KzwYJ5wnCLcJIO
         3mBG8wI6yKmKujgWT7sqbkdHOHo+RXa+dbACUursHeIhgWRC0Wq+NliyRjkse8i/x14O
         q/TvICMmWjCoW99i+ZJdWsxgxhG08vkXg45wUJybT1fv1ZrQywjnX8fzyBxMuTodNMW7
         Oj8DvAJEDUzNPbTwo9l2mXz7QhUWMQXsViAUtw55djbdInziRHFZf+YUBn8QBEUH59JI
         vAVw==
X-Gm-Message-State: AC+VfDxsUq2BhvphPYbpGYk6m85cLKOMPh48RUB3Pr9YHtu5XNIpHMQl
        ta54xoxlZForO6ywOF60uD4T476x+B6gOA==
X-Google-Smtp-Source: ACHHUZ7/3DdlEJdFI20jaMXgBCgmR4yjVfLRD8Oqw0t1QyEfUQDheeJ0tT85/MMO01Lg/yBlq18K72OQV7mwWg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a65:644d:0:b0:557:9c72:7138 with SMTP id
 s13-20020a65644d000000b005579c727138mr1061347pgv.12.1687970270430; Wed, 28
 Jun 2023 09:37:50 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:37:48 -0700
In-Reply-To: <kl6lv8f8qvhd.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-7-calvinwan@google.com> <xmqq1qhwfr46.fsf@gitster.g> <kl6lv8f8qvhd.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <kl6lpm5fr19f.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 6/8] pager: remove pager_in_use()
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com,
        johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>                      Could we add a is_pager/pager_in_use to that
> function and push the pager.h dependency upwards?

Bleh, I meant "Could we add a new is_pager/pager_in_use parameter to
that function?"
