Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1348DC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E532071E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="T8XaMW1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404285AbgAXUPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:15:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35993 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387535AbgAXUPH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 15:15:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so687589wma.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 12:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vaMzl4A19+5V1un/wTtLWglaxPPydpC+Okizohu9wM=;
        b=T8XaMW1cpk5/bu+PevSvl+6xzNPtiWeBpWBaj5Emi2TtkyuWbRFpsrnlQGrPFm46uq
         n8oBvQVGSlkUDsYp/uNA0WR4zAv5m/9Tt6+G0w8t1aZosfI5Cmdjy3tTAQt906CSmTvv
         qKVHU1C3daYSHL5i1zQktWWHKpJ0n6IVyXsC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vaMzl4A19+5V1un/wTtLWglaxPPydpC+Okizohu9wM=;
        b=YYLuIgfr+BV4R30MrSYhVX0/NCklA/j3mGZEN3LQc9VRPJy9PP/vQY4LtqU4nGVOxd
         /jG/BveubvFJ78q+Af/8bsAnJLTIcBNi6pMZc25Mw98+8y2VpRuhf7GQNrDokCjNH5KC
         9iz8rhSD5jyZZyJDhYb0WauhEKWtPijxqgzmW9sTlc1nQTBxi3I+PbGloCZAauajkka+
         jzMtkttmnZuk13ln2CLhpJJ7RLdbRoj76AhV19xNCdN4lI7tNmgYAEhkYN/H6O54pfGy
         rsbAFMfN6ZfeHsf2hF1sHqPOnnGh6ZJj9kZSJPr0ozLSANxKsuL9XJ2AbHIlVwquQlPv
         iDyw==
X-Gm-Message-State: APjAAAXYyfl5gP6YDpfMCVzpAZcTQbH4NzCAmfkMIM9YBRFWREZdM2Tl
        cQA/5KjKe3m0yhhY+31qDFdkkS6ZWHqshARDMYrHZGbJE+Q=
X-Google-Smtp-Source: APXvYqzW4svbaag98OYjFwUm2k01bLPSp0GkO+uyqI2TUvaYqmnOaAJluF1bJFX6d1q77NQMyspD2do7jN3v0ziCOtM=
X-Received: by 2002:a1c:e3c2:: with SMTP id a185mr788853wmh.27.1579896904126;
 Fri, 24 Jan 2020 12:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
 <20191213235247.23660-2-yang.zhao@skyboxlabs.com> <CABvFv3LH2tYbobn8xBykyC43FB+z16FFOSAX1XjTLFZ2BUqZ1Q@mail.gmail.com>
In-Reply-To: <CABvFv3LH2tYbobn8xBykyC43FB+z16FFOSAX1XjTLFZ2BUqZ1Q@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 24 Jan 2020 20:14:53 +0000
Message-ID: <CAE5ih7-LrK1XZgjhpx3qQqRMQ5MUf-e0q=45VY4cNhHV--nSuQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] git-p4: python3 compatibility
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 17 Jan 2020 at 22:00, Yang Zhao <yang.zhao@skyboxlabs.com> wrote:
>
> On Fri, Dec 13, 2019 at 3:53 PM Yang Zhao <yang.zhao@skyboxlabs.com> wrote:
> > This patchset adds python3 compatibility to git-p4.
>
> Ping?

Hi!

Sorry, I've been a bit busy.

I quickly tried this and it was failing for me with:

> failure accessing depot: could not connect

It works fine with the interpreter set to /usr/bin/python, but
changing it to python3 caused this problem.

I'm at 050387ce43179f1b0da364dd6eec10ce578d6583.

Thanks,
Luke
