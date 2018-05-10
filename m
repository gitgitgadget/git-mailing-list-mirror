Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B561F406
	for <e@80x24.org>; Thu, 10 May 2018 20:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeEJU4T (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 16:56:19 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33231 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbeEJU4S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 16:56:18 -0400
Received: by mail-pf0-f170.google.com with SMTP id f20-v6so1641741pfn.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uv4wuLBdEDctbzrZopReUgJqgDA64/pyesfboLcQPPw=;
        b=DzzwFX92Kg+SAAqHYeVrg5VvNhE98ms0j24/BR1pxeEn79k3UhTK7/pkTPSuaB44JS
         t5rDRmLHrgnt2udh7v6hGmNaRbvdAtcYISLqU0v4jADFeZEpogNaye4qbEYwRmNut9n4
         SDB0kEmsoDsjmNNvP3CE4xIAwlnuALKTjLeiWSzwJpWMa49rqyOXmzw00n8aq+dgiAT+
         ZQbrV+GpGYaOCb2YGDP7+L7Tff4uU/PSkPPxtZkJ8YsXupJGsUjIWdlpRbuSlgWR6wSB
         MRt3qlxyzHpEwagzwQrW2etkQbUy3UZsxZPUB0Gy0yi5HpTYiUhTMqx6miE5F/wPD4dn
         oVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uv4wuLBdEDctbzrZopReUgJqgDA64/pyesfboLcQPPw=;
        b=C1dtEuzJIsyki+ygl662oGHOCMNzxCdOBB+OZPunpFtzx7aomgbeCbIyLFadWkW1An
         WjEvzBmXH3Fa1r1mUP+x1k+zwr98Fxkc/XlBajV2tK8WY5hKIQcLlBY4vwEiyYYx1r2i
         sNbMCxxSzEtSacmWUuliPC/P15WEVzDl0rJ1afWBkhxTdIeVljQ4nbMvNRL6GldDdBU7
         wBEJ432464dkZLdxLdorwr8Gxor+TYBJg8YfycvjgD3VavqNayEgpIlBoNaqX/QohbP3
         MV8n5Qx4niG9Xi+pEt09CEzdlgjI59pLNUbXurq4/JHI2NwYwlpp4QddzRtwDsq9yNqs
         zxYw==
X-Gm-Message-State: ALKqPwc+ms3IoH9W583+OMhFAuuBAZ/HkPwCxncOBmabbTgtbhdRw2s4
        3yAsoK7ODQ2BbIdu8biUTcs0Jw==
X-Google-Smtp-Source: AB8JxZqB23OC4/O3bP9fCphFucQWOlQMbm4sK+rTJAwKJ1vPbNUTwzp4Aw0uSMHIZIMq3l347Ei5+w==
X-Received: by 2002:a65:4dc7:: with SMTP id q7-v6mr2346829pgt.48.1525985777991;
        Thu, 10 May 2018 13:56:17 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id f78-v6sm3956921pfk.138.2018.05.10.13.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 13:56:16 -0700 (PDT)
Date:   Thu, 10 May 2018 13:56:15 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 00/13] object store: alloc
Message-Id: <20180510135615.aee82c0d9720fd6c1be80585@google.com>
In-Reply-To: <CAGZ79kab0RDE1D81-uxrJPRQF7LoWkTfHj=nLntd8v2cz8THHg@mail.gmail.com>
References: <20180508193736.14883-1-sbeller@google.com>
        <20180510004024.93974-1-sbeller@google.com>
        <20180510101615.931eb0d219eac4c84cf8140d@google.com>
        <CAGZ79kab0RDE1D81-uxrJPRQF7LoWkTfHj=nLntd8v2cz8THHg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 10 May 2018 10:32:09 -0700
Stefan Beller <sbeller@google.com> wrote:

> >  - I would call them release_commit() and release_tag(), to match
> >    strbuf_release().
> 
> Why not commit_release and tag_release to also have the same order
> of words as in strbuf_release ?

At this point in the discussion, either is fine.

> >  - It might be better to just inline the handling of releasing commit
> >    and tag memory. This code already knows that, for a tree, it needs to
> >    free its buffer and only its buffer, so it is not much of a stretch
> >    to think that it similarly knows the details of commit and tag
> >    objects too.
> 
> We still call out to free_tree_buffer? Not sure I understand.

I meant that since we call out to free_tree_buffer (as you said), this
shows that the code knows the internal details of a tree object (in that
it has a buffer, and that needs to be freed, and that is the only thing
that needs to be freed), so maybe the code should operate on the
internal details of commits and tags as well. But again, this is a minor
point.
