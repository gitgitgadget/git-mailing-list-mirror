Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC84C43215
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 11:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E94820679
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 11:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCUeVZIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfKVLYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:24:37 -0500
Received: from mail-vs1-f46.google.com ([209.85.217.46]:40778 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfKVKij (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 05:38:39 -0500
Received: by mail-vs1-f46.google.com with SMTP id m9so4487080vsq.7
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 02:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/ke/OsXcnob4dz4cprtZdUhLTQqXAkx8uYaDkITNso=;
        b=lCUeVZIRJsSN4NXQ5NeI4nCxRdt4jfDfmbf3RxC8VSrzCm9opphTk/sBeO6m0dcPhC
         yxIrL9X3SLtV9eFeA8WW1VM47+UIbR3xOY59gbTZODb481+nnPFMzsVT3B2qp/F8OIti
         P3NCKpjXyWRM8p/QMxzmTed5uf4M08TNApLakyd7DOXC7XURGhHQclm8Neh/DIFNZ2W5
         BwNeAuje9mqT4cyi6aj+7RV8bLJOLpt7QIcUnD5AVvT6k8K58+0GZdhR78ZfTQNBxleN
         2g2n9T6PGK61QSud4MuuwvV9EkWE+TN+emJFY5v3Fp65xZu99o0aWlOrgGHlLUF0Vliz
         DFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/ke/OsXcnob4dz4cprtZdUhLTQqXAkx8uYaDkITNso=;
        b=p0gosPPC6kH5dHrlCqvGqWdSP/1r18T+gsshpdLEsu4GngJ+4HH8uKZj+3t4RP4FDy
         Gz/zBwU00wwCYvZXB3BjGMsnJYPAVQi7LmMzBo9z4o4vDRTvRcKe6+ByK2Dub9N8Tyb1
         JLelVx3yMVj3EmpT3/RUImkjkfWLcoxFU6TCvkblBP6adcPkWNid1NEggOSG5gxsv44A
         a0PW6N0V/0HFJVAXxB/kYojOGpKW0hrc8lTnAouI5oCr6LUeya0k9V00xamFqIezSnR5
         FrSsnPITmMT3AIiavtVu3ht2MkcQ/cwk0qggSc/ZueQY1AFR0b8zuzZEtt1Qxqey30Fd
         qGoQ==
X-Gm-Message-State: APjAAAW/mA1YRA1dCelulQk3THXS6LNsWnJOoPnSZAyjVUOV3TybW5sb
        G8y9yxDcU8h5DuZMWE+JhcjIFbw+Ti6RF2+Gcep9ug==
X-Google-Smtp-Source: APXvYqyEK3n34jomK57ABPvVK3u82LD/djzit2w3uBOwzDpZn4apwch1xBl3cyaQxhcA0Ng9xeyPofygoteUJDg9bUw=
X-Received: by 2002:a67:f98a:: with SMTP id b10mr9977262vsq.203.1574419117958;
 Fri, 22 Nov 2019 02:38:37 -0800 (PST)
MIME-Version: 1.0
References: <CAFQ2z_OMr4J-gF1HXXkSQFheiDkf+7WBbn-oLYeDydmuLSfN1w@mail.gmail.com>
 <xmqqsgmjb13r.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgmjb13r.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Fri, 22 Nov 2019 02:38:25 -0800
Message-ID: <CAFQ2z_PbPEH3=9uJHqXdjV+pxF_-NSS2PGY1ZU-JtxRAuxN66g@mail.gmail.com>
Subject: reftable (was: Re: none)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 19, 2019 at 8:53 PM Junio C Hamano <gitster@pobox.com> wrote:
> > I spent the last few weeks cobbling together an implementation of the
> > reftable format in C and in Go. I thought this would be cool to add to
> > git-core, but I doubt whether I will have enough time to see such an
> > effort through. Maybe some of you would want to try integrating it
> > into the Git-core code base?  Example code is here:
> >
> >   https://github.com/google/reftable/blob/master/c/api.h#L153
> >
> > cheers!
>
> My initial impression was that the API overuses typedef.

I changed the code to use struct throughout.

> But the set of operations defined in the header file seemed at the
> right granularity in order to interface with the refs.h & refs/* API
> we have.  It however was unclear to me how transactional ref updates
> would work with it.

I implemented the reftable stack in Go, see

  https://godoc.org/github.com/google/reftable#Stack

which I could implement in C too. Would that work?

-- 
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
