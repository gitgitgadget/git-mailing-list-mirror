Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5B3C433E9
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA58221EC
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbhAZE7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 23:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbhAYMwF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 07:52:05 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEF9C061797
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 03:30:57 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id v23so4323857uam.8
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 03:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lAHr3bJJ3qlMqYSUa+dYSHXhYsgmf9yx8gi4oAbNUw=;
        b=lg3QAyi1vrJXbSnCliSOlUKA+hu6i726nHO+X1AS+WdI5GxGv/QHW8pY1YLpmgeKZU
         x5jK421vgYufo8xuP5mdoxdwQnsZ93LjXTgJ0BKkVInZ8Ga0w0T7V7D7rqkUuNZEPGiu
         NRl2TzNSb4Htm+hdJLlezNqVEGf7zIFsm5NNVge2bihwGjnkEoCzECWRuf44zqHfckS9
         YGDJjfOF/Ik0dkxgZNceARWQpwzaiSAY26HIxXNsWuSU5eMVvzyudwQgFvGawQiGrZaf
         boJwrTurbOfUuMwOxrrbreiJV63XADqoLB9oigdDdITVqnJ7RqbVjq8PpSmCBJkWYEVU
         n86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lAHr3bJJ3qlMqYSUa+dYSHXhYsgmf9yx8gi4oAbNUw=;
        b=tbuRbehIUcD//vBu5Q16z94Qr0yt0Lp5jw3QoVVs+pjNrQEiUSYoMpHfrqxv3vBAmF
         aUQjwF21mJB6bGYBQItnOqJR+gFe66l805VeIbGKGIKXgSB/dpqhkdhfPhybzV8HSbM0
         7pnsSB6cKdXMJJkEGrP5h0yHcW1ug7U7ndtlao3k+olSkobA5RFkjCJIO3X4p7NKtLZz
         8tjM7cSx3+Q+vPBl2Uk0b0O4czcGV+M3ZopH6CnxtppjmewqpAWa95D0WOQ3FulHgCns
         GS4MrkoW3K1W3Ex82R/4VKhHTRfqECAsTBe8tGPA2v9+vwXjPerDY20FqCEbrnEVO/1s
         PqDw==
X-Gm-Message-State: AOAM531MTu0ZjCFsi0zOvQFzz2nJPyP9zN4aqQap6Qfgt8IpZLaRcTQq
        10YHMQqnLxLnpVYJrVwDzREcbB101Ndo8s/f7sgnu7bKN7U=
X-Google-Smtp-Source: ABdhPJyk7CUfv1eW7tsoItG4CbUq/+RVe33N/eBzqsOMHkt1sDbYp4e9q0YBoyTZr5rqRz14kgpw1elKqwBkjS34WVI=
X-Received: by 2002:ab0:e14:: with SMTP id g20mr295721uak.112.1611574257056;
 Mon, 25 Jan 2021 03:30:57 -0800 (PST)
MIME-Version: 1.0
References: <1327609829.20210125123816@yandex.ru>
In-Reply-To: <1327609829.20210125123816@yandex.ru>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 25 Jan 2021 12:30:46 +0100
Message-ID: <CAN0heSp-bd-Dy4rT7DmEx3TQELoCr7a81WQLsT7wWdmbm5ZQ1g@mail.gmail.com>
Subject: Re: Can not rebase to first commit
To:     Eugen Konkov <kes-kes@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 25 Jan 2021 at 11:53, Eugen Konkov <kes-kes@yandex.ru> wrote:
>
> I can not rebase to first commit.
>
> This is how to reproduce:
>
> kes@work ~/work/projects/general/Auth $ git tree
> * 67857d5 (HEAD -> dev) asdf
> * 1e99034 (local/dev) Initial commit
> kes@work ~/work/projects/general/Auth $ git rebase -i --autostash --rebase-merges 1e99034^
> fatal: invalid upstream '1e99034^'

The commit 1e99034 has no parent, so 1e99034^ errors out.

Try the `--root` option. That should do what you want.

Martin
