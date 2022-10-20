Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C891CC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJTUu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTUuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:50:25 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AE6495F6
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:50:12 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id y14so2406648ejd.9
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBN5AD+iKrlIhj0TrPSjW7rf1QSVZnZDzvAoSLnquhc=;
        b=8I7+5IhtPDBErqBniIn6y5pHXfwE7x3EorT54C84lQjQV5DiRkKrwLUu3ZTKudXPBL
         p1yLTu6cuwu1DUEmlyYi1SQBL/RO48r+Veah4blx4Txbkb/dfgQZUK9uWgCU/YQPAxVK
         EbPncTZeHNbVHpBtwJ1XzbJEiKS6b688RWReYASOBElpoT5ndMYBq0imyE/N/cFi/MGL
         aTwOgS+pMdwYiGro0dndb62XKN6h1ujb5W8BvjSd5JV59Yidi4rcn/AIPMMagLmhHgA5
         7gt865Xxfr7e1E4aWL3XNrrBYeWkt1ndOZAtWgNy9HTQ0hYhwH3YjWb8rSLqxERHeuZy
         gihg==
X-Gm-Message-State: ACrzQf079JiapnE5SFhVxH9+XFtyABK1V6zLTgscVGByIskLw0kZbBJ7
        qHbhBALImvW/xI3E7NoGGEWYWqFrtMIbOFcXXNX/dATF
X-Google-Smtp-Source: AMsMyM5UNeo4DEG0JGrqrwtz+KSww8FmRmqUkkaUS2DxSm+AHt/Sf+WnyKcEqurxFuoDLnnyWFgtws3lZyIkESIioQk=
X-Received: by 2002:a17:906:5daa:b0:78e:2bc7:f1a3 with SMTP id
 n10-20020a1709065daa00b0078e2bc7f1a3mr12141512ejv.256.1666299005847; Thu, 20
 Oct 2022 13:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com>
In-Reply-To: <CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 20 Oct 2022 22:49:27 +0200
Message-ID: <CA+JQ7M-GbBTHZZ9xOLR=FitWFpUnkfuep9kSfNPxuSbJbKteGw@mail.gmail.com>
Subject: Re: rebase -i --update-refs can lead to deletion of branches
To:     "herr.kaste" <herr.kaste@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 7:04 PM herr.kaste <herr.kaste@gmail.com> wrote:
>
> After that all refs have been removed/deleted.
>
> ```
> $ git branch  --list
> * test
> ```

:(

> I decide late that I rather don't want to update "master" etc. and it should
> probably not delete the local refs.

Deleting refs if you remove from the rebase-todo seems undesirable in
my opinion. It's too easy to use that footgun. It may be a good
feature to be _able_ to delete branches during a rebase, in a similar
manner as updating them, but with a different explicit flag, like d
regs/heads/ or something

> Actually, I so love the new feature that I switched it *on* by default, and just
> wanted to overwrite the behavior in the todo editor.

I didn't know this feature had been added but I'm very very pleased as
I've wanted it. It doesn't seem to update tags though. That would've
been nice.
