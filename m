Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91465C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EFB2083E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckuE1QlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgA3WVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:21:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40787 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgA3WVv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 17:21:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so1879433plp.7
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abVKuzCALkU7St/UXJDs20LHTIcswGF1UhLwWVuHLDQ=;
        b=ckuE1QlT4g9vvWAYII3se67jZ+4742zQW6aSS3KSakcZlXVdPsol46BlZGMnPLdUp8
         mxu7oHWHKO9cX9xYZlj4eQslDdv3Q1LpvNVvd8gMTVhP9OPS8Br1d9TXMOE8zeS/h0aB
         yBpz3+WveqfJLB2SJNoFtdKxbF743ol8yUKHigu0kuK5Bqqz6y3BU72+5Ta/iDYQF84u
         2fhYBPvjY7jhh59vQmCejydkcv1BF3x4PRckPl/93J3uQndPE+QPjNP3u7f1XiV7Yh1z
         VJegjqGlSHtQHdMyStx9JwnMS1ySGdo8wzzK0B467Uu7gxA2H+XqBED2BCNgZcS09zWi
         VlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abVKuzCALkU7St/UXJDs20LHTIcswGF1UhLwWVuHLDQ=;
        b=kcJHJcs/VSr8TT4B2FYiUwNCuchFiYpKvsyIVmhRk4bvVOeVWjn78PUXzhSQsTxQQN
         xISs8o27t+6f+MANEwjPNaeTZgedr0HbVz3peMXRj00Uw+lpUFf/Sx3+jkECteK6yZHV
         5zi0nX5bOx/wkV/rigOubb1TPaRLt40BXsh+LLlAMXeB3MV8d6qHRqksM0ZvjVc1DTkI
         HbuELR+jENkrhm6Y7Rigm7/LAI82pPrUKAkD7Cz/rHXnXECDvPajFoJQ6XJpGYhJC9H6
         vbKOycQ/0KS+70Gt9hTm8Mdw9YnFtyn8GChCzhUuEMsPmS9AiNNwfsQFCKLQGfpfWU5k
         0kkw==
X-Gm-Message-State: APjAAAV2SyLEK/ktjNHLZgdVDTptQ9CFwCk160rrEy1e6I+5/DSnSXc+
        Miw6Lc2qPQ+xdyxhrVULDaYVQUVqw11MOicEBNJEYQ==
X-Google-Smtp-Source: APXvYqyswroC4RW6ual+fd3y66anNBpvysnkgGUvVtWYwYhcofKgWRWlop3JFw8tN3xDNVW164wUEW5VL0Uwq52tC5Y=
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr6933861plq.79.1580422910773;
 Thu, 30 Jan 2020 14:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com> <20200124033436.81097-7-emilyshaffer@google.com>
In-Reply-To: <20200124033436.81097-7-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 30 Jan 2020 23:21:39 +0100
Message-ID: <CAN0heSoh87_16y+B5=UXAhbaVnejmRj3XXjy5viABheBz+D3fA@mail.gmail.com>
Subject: Re: [PATCH v5 06/15] bugreport: add compiler info
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> +#else
> +
> +static inline void get_compiler_info(struct strbuf *info)
> +{
> +       strbuf_addstr(info, "get_compiler_info() not implemented");

Maybe "no compiler info available" (or s/ available//, or
s/available/reported/), or something else more human-readable?


> +}
> +
> +#endif
> +
> +#endif /* COMPILER_H */

Martin
