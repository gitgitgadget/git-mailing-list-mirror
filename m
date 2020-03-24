Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54BFC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 07:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE6120735
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 07:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiPPH/bh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCXH3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:29:21 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:38683 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXH3V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 03:29:21 -0400
Received: by mail-ed1-f53.google.com with SMTP id e5so9622650edq.5
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4QgZ6AuxigxLsyT9j0Nw32/D/p0hJBI76K25qB/Prw=;
        b=TiPPH/bhn9TpPXOt6KA8BWFNUt7l18TobjmassUXPCZ8PJ1O5gZKJYWZhhZk3k31D/
         9M8rFkQLS3/Zgzzz0R9Uq1mDd0Tp3Q7nsehtBZF/utkn4yr3kcjG11TeimwuQtBOb8Bs
         7mL60aPBdrmyrYMn0TTU531yqrUeb6CSgnsJC+8/QVkyOo8FN11T0D4e4rrXl1QdLfo5
         yhZM6leU3ICYv1HSWeQEprDq9JMdAGj48fZSIbXNjM3Por+GFIha2o48gf6Rl+FFrZaz
         co6Z5/WvH0VjrdVlI2yoLYo/fPkBJ9utIwWgBCkmmY3+5k27AlO++JGRauIGBA1zikbh
         SVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4QgZ6AuxigxLsyT9j0Nw32/D/p0hJBI76K25qB/Prw=;
        b=MHiipUc0NHZO2gNE7C9or2E3SjaXRdSlskDdEkTo2ju/KeSOEmUma+6rPwA8wYYOnM
         AXmqtConCVl7mp89kcKNC5IQTSbMMOzXQSYajeKTd+tif1YXZZPX0DYiPnf35S9XtbCF
         DMJyOG6DDbYl843KR+nqFHqqzuSwWi4xxiS809pFeq4tYN6qUhLBjoxX+Jk21M7YhoH6
         qcVRj0/buavf5JsMv3x4ar1JUWCfWanJXeW4t+QDLlTmCgNyLzMQp+Y68DfeMnfvK/yk
         q07zvG08Vcl8QxlhiFyO/5QUvAuEHaKxs4b95Ch//Tl9r5DTett93Xo1+4EFCua9YYyK
         deVQ==
X-Gm-Message-State: ANhLgQ2MfTJfzHzvVTT0rh2+KZ1JcBrZJ8ipmC2Vnfy2O4B1qdh0RCIh
        mxrX/bbITrlFi4PDGDTNsb60l26A9Vs7/vIKRLA=
X-Google-Smtp-Source: ADFU+vuqTKXWuvmm4oMIwgt65Y9BB2mQ+oG5WQ60e0dlEI2OBuhag4PawwQ3gXgFFnQBadMlO6wj7Iz+MyaS75rETB0=
X-Received: by 2002:a17:906:af57:: with SMTP id ly23mr8753372ejb.6.1585034957708;
 Tue, 24 Mar 2020 00:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh7ykdo7e.fsf@gitster.c.googlers.com> <20200320160813.9242-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200320160813.9242-1-shouryashukla.oo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 24 Mar 2020 08:29:06 +0100
Message-ID: <CAP8UFD2nfqRX6+xjRk=F1g+t9T=FgxQVsaNt+b+jW8XoYzuTDQ@mail.gmail.com>
Subject: Re: Re: [RFC][Feature]
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 5:08 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> >    "We want submodule A and B's sub(sub)*modules all the way down
> >    to the leaf submodule, but directory C houses many submodules,
> >    among which only one can be active, and we want C/X and its
> >    sub(sub)*modules all the way down to the leaf but not C/Y nor
> >    C/Z or any other C/<anything>."
>
> That's a tough one. Would you advise developing the feature which may
> work atleast for the "normal" cases? In case it does not work for the
> aforementioned case and the like, we classify it as a BUG for further
> correction?

How are the other git-submodule sub-commands working with --recursive?
Shouldn't --recursive work in the same way for all the sub-commands?
