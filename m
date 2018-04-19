Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA151F404
	for <e@80x24.org>; Thu, 19 Apr 2018 22:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753590AbeDSW0s (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 18:26:48 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:42531 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbeDSW0r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 18:26:47 -0400
Received: by mail-vk0-f52.google.com with SMTP id g6so4157562vkb.9
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 15:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cCtSp9zjF1kiWKgwOTJeMfpbbla/mjIXtUCXuDxRXAM=;
        b=mLbq73A2ROCHWdd2QTGzfqwEpFnO19kq4Kz3Xx5KtSKt3/Z4LMYCnnZioTPKRd/BXh
         3KEjMn5Wg+Dezu5lWiUK0QFueBfjR9zJumJX3Ls7pQ5zeug7zbirnRph0uylNkihRTs1
         jsahfw0HAKvI1SrLgSFBxv37XE+prb0bdP5UwM1Jm+jBdltEtut2fSsEtfRO5n/X8M4o
         xBysC3MqoZ0YBv3WE4vOocZ5EZw8aKzy70Ya/MfqeNKS46oK0RxT1jvjdbeKUg6aPR7e
         hdU2r5AoAXvA7Y2iSfypUMm5JHe/dpxyI4d/hWUeOIpfuziM/+bIAKr+/9I07waLUjbK
         hjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cCtSp9zjF1kiWKgwOTJeMfpbbla/mjIXtUCXuDxRXAM=;
        b=XDfh7hBVw87tBPDCRvLx8GPJfNfHCFfFNYe81dvVMr0Dn6qna6oa9dWbNMjwvTGrH0
         e5+G8mJ0nxJixFPdQDzxu1B6SIC3BUEp+SQul8yXM2qMADC1WO8ED2QDNWWOqBI95KgS
         OlY0v5mMggY1kaZlAClEVA1fw/5xjfOCVWc40BBdgOANMklIZ/o4gGi5RMCxhtKtNW69
         pmpnv5t0bBIwUGyvF1EznuxWvWjVIjkzvuTLgHmhx3gcRX8w55D9bmCSGl5PFe85nH6q
         rpp/nscvR3H3EvKR/V5zv1sBkKgJeOEAmamFCK2lAT8oi6XLIYBfSFG6BvJBxKGcxoOS
         tDBA==
X-Gm-Message-State: ALQs6tBgicynzvlDnVsKas6LUq1QCT2FM9QQ5YSzR7BBWPnmM95i8M+Z
        RfPhmoAqK6QRc3qBNp8WBSRogWP1wfdwnH0zWvk=
X-Google-Smtp-Source: AIpwx4+0b1VGBpjZsm5ai1JekZOQoBm9jSd3d0MQxraUzQeXdaNoh4oYACWiUszhIJ2jBxbONxb7sgG3H16+pyJkkyM=
X-Received: by 10.31.193.85 with SMTP id r82mr5678020vkf.76.1524176806552;
 Thu, 19 Apr 2018 15:26:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 19 Apr 2018 15:26:45 -0700 (PDT)
In-Reply-To: <MW2PR18MB2284E3091991A3DB228CEBBEE5B50@MW2PR18MB2284.namprd18.prod.outlook.com>
References: <MW2PR18MB2284E3091991A3DB228CEBBEE5B50@MW2PR18MB2284.namprd18.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Apr 2018 15:26:45 -0700
Message-ID: <CABPp-BHv=jZZfbZnfSt81oxJ0QAxJp7W2rOsfFq6ThVEYK5z7Q@mail.gmail.com>
Subject: Re: [BUG] Git fast-export with import marks file omits merge commits
To:     Isaac Chou <Isaac.Chou@microfocus.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Isaac,

On Thu, Apr 19, 2018 at 2:46 PM, Isaac Chou <Isaac.Chou@microfocus.com> wro=
te:
> I inspected the source code (builtin/fast-export.c) for the fast-export i=
ssue I encountered, and it looks like the merge commit is discarded too ear=
ly by the call to object_array_pop() after only one of the two UNSHOWN pare=
nts is processed in the method handle_tail().  The poped merge commit still=
 has one UNSHOWN parent, therefore it is not processed and is lost in the o=
utput.  Can someone advise me on how to submit a code change or bug report =
in order to get the fix into the code base?

Careful now, fast-export was also the location of my first patch.
It's easy to get addicted to contributing changes to git.  :-)

Inside the git.git repository, there are two files that explain the
basic process -- Documentation/SubmittingPatches and
Documentation/CodingGuidelines.  If they don't cover the process well,
that's probably a bug itself, but feel free to ask on the list if you
still run into questions.  Those documents can be slighly overwhelming
at first glance, but they've got good information.

Elijah
