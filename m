Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376F81F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbeGRRqf (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:46:35 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:37424 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbeGRRqe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:46:34 -0400
Received: by mail-yw0-f176.google.com with SMTP id w76-v6so1987138ywg.4
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jc2XTl35+XW2I4VWYmHnkDB+P2FUi8pPBhkDJEY9q0w=;
        b=v8uTPfLA9vaVVK022HjoqlTOLjOO7nNl/KnS5cXQUnUM1eJ9ft25ygZQC4OeX5opJC
         FIJb8nbrxlt+v8txp4vAkBcTU5gaAXVbG+rCNGx9yokUETyTLazxWQucbvLIF55820Yb
         MoiUJd2eeL9gHibuMrWtjI9C0RkT1we2ZcFeRx5kdwJtiCJIMAVsYBdQ9/QMV+Y7AubZ
         sn9ndZIo1y9HRG6GfZ4RSTzoP37EsEwz1MunGlNttUoBO03peYnmdiOKc/9/Cleddd0L
         OYCcAEdZ5H+GdVmvef1Pzikz0j/XhNxglKM/M0wY3HghpxqKsnv8u2z3rDvMX8oF/VMO
         ItAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jc2XTl35+XW2I4VWYmHnkDB+P2FUi8pPBhkDJEY9q0w=;
        b=XT4yoFYYbUwof3MfJERIc33PUdvBmx1Gu4tnYPKgHV+OWlTE4oIj20Q45E9uGDKZkl
         WrhrsQri8HdjmikHT9lnd5mHU55MSEFz0Uy42lyX1IpYfYrt//FiO0X2ikCrPV2vrqCB
         HWfis0Ebr9nXYKPX7fayviQMl6E29B9oURVXJ0Gw6UEKCwtOVNvL62kJGBLPBrKDJNKC
         34/CAvtju5nEsnh/reRHl4pVmWCXYu+j2Uk0RN+MYka16p4vlIsLa/qSfygGO+LoKWRA
         eQR++Kr5+WbyyXSk1Wbp+9Px5MO2Gqni4pMlDI1K0lSm8x5EwXSXnjqCsRRsRhcNA0RP
         IbwQ==
X-Gm-Message-State: AOUpUlGQlW7EGqiL3khFv70SA76InnqbRRaRlwHl3kfMsj5RY/4w+pXh
        JxC8JoVYkkFQrTHe6ZYzLC39wc/xnWBtKFnOqHnhQw==
X-Google-Smtp-Source: AAOMgpeHk3cylINHine1g+dCXNWJtLOZjnqxrQ/5MmbPlVf7GRTM9APqfa+qXIGxp7xrHyXGRBPD7K8zyODrVU+M/s0=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr3462808ywh.238.1531933664307;
 Wed, 18 Jul 2018 10:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180717224935.96397-1-sbeller@google.com> <20180717224935.96397-3-sbeller@google.com>
 <6c74aee8-2e18-99de-f775-dced1310809f@gmail.com>
In-Reply-To: <6c74aee8-2e18-99de-f775-dced1310809f@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 10:07:33 -0700
Message-ID: <CAGZ79kZyWWivaVgdCt-Zf-_3p9L5fis7ZC73pwDEGNQUfc8f+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs.c: upgrade for_each_replace_ref to be a
 each_repo_ref_fn callback
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

> Overall, I think this is the right approach. The only problem is that
> you're missing a few 'the_repository' to 'r' replacements in the bodies
> of show_reference and register_replace_ref.

Thanks.

Originally I had another approach, which was to convert all
callbacks to take a repository argument, and only if the refs
backend learned to propagate the correct repository the repo
argument would be the specific repo, NULL otherwise.

With that approach it was not possible to replace all occurrences
of the_repository with 'r', and it would also be confusing.

But as I pursued that approach at the time of writing this patch...
I missed the conversions needed.

Thanks for catching them (and fixing them in the reroll that
you just sent out via gitgitgadget)!

Thanks,
Stefan
