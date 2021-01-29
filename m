Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3A1C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 07:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21FB564DDB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 07:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhA2HvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 02:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhA2HvW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 02:51:22 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AD9C061756
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 23:51:25 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id rv9so11567484ejb.13
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 23:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQ1ptPBGsc5wNATVHC7BF6DYzxB3GwfXhlb23+tsE0o=;
        b=reViw300L9OiSI+/wScMbGr0dSkv6ZNdgFRpr5ynW+rlD/kc2PAPw0lW58BlyYprPM
         k+F50EHVkrXBKXrFh2eU0ICC4HWC5WW3BpgRuW6yI1zWqyN7JqwLCYwLL1SR9qZMtFSV
         as9tvH4j5ZrXCyGKp9YpRJMZG7hSDsqHXJCpSxr8N+7tCnWoa+HbuEtnRMt+n6zhQS/z
         EWz4pwWb/dDPN16A2BkiBwXNSJBWw455vywlFSmtNqPezSPnTEQ/J5/fzlGFkjg4uepc
         ygsbsFJzFMPdtIOqM4EvjRYyB+pTi+G62oETgLGX7B/2GR0//NyAl9kl7G3EifZYX588
         A0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQ1ptPBGsc5wNATVHC7BF6DYzxB3GwfXhlb23+tsE0o=;
        b=isdZMnAaM8RYUlv/n2nm9ma7+3sniYjUu4ojo6gBd6lyyyfLrN3C1IGlvNiDwne4A3
         pjnILJQJwQ6ZERg6u9P11cvC70S/rLkw5MeJ7uQuR0Y4sEpP7f4dpSYbjdYGiwBBqTq5
         AK61OXKxDcl0UenscFyAlBP9oV+Uw8TgR+vAIT/LVwdbycB+aTTabMBqGc2PRPdKoufq
         uDcliNwkneYzfXHdBfQxuyvd1s4c1SyK/i+5LF6NKFq2a/mTQfuHxYGnmuI050rbTw1L
         oKQvFnGso2udT95Uf6oMoNOQ3J0n3eTqEhlNxVdG4p0yw38l5g8s97vdh/5bOY0h8go4
         /dcQ==
X-Gm-Message-State: AOAM530UeGylIrsQ3iDVd+YqbddPAq6yXvfLKEv5KeEmVaK0wIfx8qLl
        vL7myNjflsuCTr7+u53ksaGZsJ3y+i8Ou3wcYmg=
X-Google-Smtp-Source: ABdhPJxZZAqGfPKeDcBItDUPLgct7EBbBM1FzpqlopZTdd9JdS8eJSuIRsJ71DLg0tLU6zgXbfHW4Z9W1NJYNwXGDB0=
X-Received: by 2002:a17:906:3883:: with SMTP id q3mr3275421ejd.160.1611906683924;
 Thu, 28 Jan 2021 23:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20210125191710.45161-1-mirucam@gmail.com> <20210125191710.45161-3-mirucam@gmail.com>
In-Reply-To: <20210125191710.45161-3-mirucam@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 29 Jan 2021 08:51:12 +0100
Message-ID: <CAP8UFD2qK2BmdjLnaMzvdyMnr7Xi8phe2GhiCMsj5qNx9pTM-w@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] bisect--helper: reimplement `bisect_replay` shell
 function in C
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 8:17 PM Miriam Rubio <mirucam@gmail.com> wrote:

> +       while ((strbuf_getline(&line, fp) != EOF) && !res){

It looks like a space char is missing between ")" and "{"...

> +               res = process_replay_line(terms, &line);
> +       }

...but as there is only one line in the {...}, we could just get rid
of the block like this:

       while ((strbuf_getline(&line, fp) != EOF) && !res)
               res = process_replay_line(terms, &line);

Best,
Christian.
