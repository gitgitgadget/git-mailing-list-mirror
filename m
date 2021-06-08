Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFE0C4743E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 18:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B1D61376
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 18:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhFHSFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 14:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhFHSFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 14:05:41 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C719C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 11:03:48 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t40so9395284oiw.8
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ZCGCOH/2BNiF/PYbwWAiGVnNd2GDnWIM83DC/NuHSGQ=;
        b=h6bWnqcHdKQDeQu6f6xdxaW58qnv/3Gq7L6GFXrUd+iabENHT5E8Pi5WodLo/9TOTQ
         bcbrGEnTB1ZYTmJ257XHxmVu/pejL+R47Fm/sz/3WQ0BHM0IpZ0bvSNKZxjkZqQJE+wf
         LXwWlvAxaqKY2rTXv7I9rj63zN0p/EaeRUq5LwvpF42mnzejnN6cVg8sOzLmttq4R8QV
         tsUS6PUT2oJnKSBEwSfS6CYifFR1AgMxMqdgEzgRgBKO9Z1kEKjJG61IbMwFhLY10EKK
         TBbwGdPmiT+FRkp2/TAcWvz64BqoIjpL9yp23Vi3jVK5prIWZHcjYCXl/9rHwJalY27f
         QygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ZCGCOH/2BNiF/PYbwWAiGVnNd2GDnWIM83DC/NuHSGQ=;
        b=orjtGtM0n/nrejRyNNGKTjQGe0Rzby+HkurgULWwWa4inJm0GJTyNM06UYEyUnoJDe
         J7mO0LSzsxpoQEI7pRbonCsH1khsSgWRooZH42ZamW7WskuOLi2SmF8VsSg7TImgWG8s
         0o6EOVKZQhv/qIMli4Zv/UCoCpsiTskNZGjybhkvNgHX1rQGmtVkFwyXIfg2a96aI6Nj
         1hUsiRQVkFGAITRmQDCKu1RHKxIwMThiZ+eERi60rvlNzZNPNw30Bd23n2nyNr2j5WC4
         fo+pZNq66SzGXxQ9Hd+Jv5DdzNbg3ncBGtQxScqfjhb7CDjQr4tLJg5WifPudKCSYAlj
         6wsQ==
X-Gm-Message-State: AOAM533ioAamKZ0EuPh8LAj4bZLwfkHEzHeE52lXlpbgD8YtoGIPCMP1
        Ak/ru+HfPBKqVhI4kizk12M=
X-Google-Smtp-Source: ABdhPJzQG7zQER1FbxYA7FWD/wc0CkocBspMmOoiHzJgxD7gYuKIcOE9ZftGI8NyITIo+F9jueg5TA==
X-Received: by 2002:aca:efc1:: with SMTP id n184mr3644829oih.23.1623175425779;
        Tue, 08 Jun 2021 11:03:45 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 7sm1561274oip.56.2021.06.08.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:03:45 -0700 (PDT)
Date:   Tue, 08 Jun 2021 13:03:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60bfb1003c46b_1ac15c20894@natae.notmuch>
In-Reply-To: <YL+p+MlgJ754YoqB@google.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <YL+p+MlgJ754YoqB@google.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:
> On Mon, Jun 07, 2021 at 04:57:45PM +0000, Derrick Stolee via GitGitGadget wrote:
> > Replace these uses with "they/them" to ensure that these documentation
> > examples apply to all potential users without exception.
> 
> However, in this case, I think "they/them" is appropriate as a default.
> As you say, this documentation is intended as a guide to potential users
> and contributors, and should apply to them. Thanks for writing the
> change.

What do you prefer?

  A. We thank the reviewer for their helpful comments
  B. We thank the reviewer for her helpful comments

-- 
Felipe Contreras
