Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285BD1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 19:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfBDTBR (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 14:01:17 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37066 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfBDTBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 14:01:16 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so2362474iti.2
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 11:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mA+h6wYhFQZRzTNR1kgcIf+OU4zRK0yhICMX7Xj7Q0k=;
        b=NFRoSVn9XEAH2MRkl7baAfXsXjNXRyJeOvwAuSxoStSFzn6dPXVzhVSRabuPqGwuHP
         EXPVzN8QR7/j2X7XXxe1QYdScQesxy85Sp2s3P5/hB0vZ2G5j9dg8n9Hcn2o8hhpUGm0
         6Pi0NL+xYr86kalwWwSFQS4OBMYybjHdNb//t6jv03CFvwk9HsWnC6RcJxFKHeFgeCBe
         QnY+Vj2f/gMFfLrlHQMDkHzU4MCu3f6x7Ea7+taOfFFcAFtR49ys7H7ew0NN6g6u+oEE
         Sg71IqacgP1nnMW3LRg+ek/+yVj7sSs58Ku3rtOzwiKTHnwKrhAN2Mxd9H8gHXAupCel
         Rq/A==
X-Gm-Message-State: AHQUAuZFuLXXZyDImb6hq6RBcF3MtJ9j+AJwijvB1Ou7PLec1ezmZovY
        a8xfADvqziVfR01cguLge7/qnxx4wVKx2egf/UgKrA==
X-Google-Smtp-Source: AHgI3IbdZiLbchVZAipXIbbMJnIJfYo9f0OItXKb2Xhwufoxhj8n2s9Ug1vbq6rT0MuSzj+xLm+pQHlhQngk3XG7TCE=
X-Received: by 2002:a6b:7903:: with SMTP id i3mr480962iop.273.1549306875985;
 Mon, 04 Feb 2019 11:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20190203210027.13272-1-svenvh@gmail.com> <CAPig+cQXuzMwZjHa3n+DwRFL3E76U8uAvhiFiC5S=B23f03Vnw@mail.gmail.com>
 <xmqqftt3v1ah.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftt3v1ah.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 Feb 2019 14:01:04 -0500
Message-ID: <CAPig+cQezC8_T=pms=XY71+9pP2WgdvdyiF9+UwarFB8sXo+Tw@mail.gmail.com>
Subject: Re: [PATCH v3] git-submodule.sh: shorten submodule SHA-1s using rev-parse
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sven van Haastregt <svenvh@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 4, 2019 at 1:47 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Sun, Feb 3, 2019 at 4:01 PM Sven van Haastregt <svenvh@gmail.com> wrote:
> >> We cannot always rely on successfully invoking `git rev-parse` in the
> >> submodule directory.  Keep the old method using `cut` as a fallback.
> >
> > Reviewers and future readers of this patch are left in the dark
> > regarding the circumstances in which git-rev-parse may fail in the
> > submodule directory. It would be helpful for the commit message to
> > explain this potential failure in enough detail for someone working in
> > this area in the future to understand any implications of changes to
> > this code.
>
> Replace that problematic sentence with something like
>
>         As a submodule may not be initialized with "submodule init"
>         or not cloned, `git rev-parse` may not work in it yet; as a
>         fallback, use the original method of cutting at 7 hexdigits.
>
> perhaps?

That's better.
