Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E60CC4167B
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 23:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLHXFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 18:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHXFW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 18:05:22 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6266427
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 15:05:21 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id k18-20020a170902c41200b001896d523dc8so2572128plk.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 15:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3td/6uAnx//D54qYP0sqF6HrdUzpGLVwAapY8bX5wQ=;
        b=Nzre/udlsyR1k2/uL3pS0Z/kCSFa0KFC38bZRz2qdi6OCLfpe1N4MqElm5GC0eaZbZ
         ykjY5J/6m0zjWevAwkclY+NDMle+ELyu3d/wKoZhiUpKPyqbCtLcQwWOS9N/K8vazSIw
         khc9LtWJyp8zvZU+lrtgCTXiKbvu2ETOrj58aq8TBv5TzPoTxpSEuUMUBfAQtC8FXJn+
         8aoTqQr+eKupPJ8U0bvY8+O3KPWQuC60KVBcG308ksMKjTf6b/XJ1MppY6T+GksmFmXB
         LLw52Mp2TfwdczowwaFymJW7hnrdSiqpqOniBAZtpAOjJfgVJjxKane8u5wTKEkQqEWc
         bZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3td/6uAnx//D54qYP0sqF6HrdUzpGLVwAapY8bX5wQ=;
        b=6y/t3IXfzlsncRUkwSnBEjmO4bzCnzGCBzSj6rFQSfjHFKhYHtFsxDOpi2yeQgsSi5
         UR3QyKGZmQD3OXvWVWzmh0SotWkwhWq0/jDB3/LlAOaxLBwetAfCYKqjSgisxCeExd6I
         Z2Fo2eTqJbmQAcvYKeURA1j5xl9/Q2yI9tPDfKJ8eBHDIi9PQBt6ZpRoIMEFKXH44NB0
         ugJhhVCi1OHEN0cMuduQNUsFq0lQLz8tnt2iSK5kFnyEe0gpJKn/o7rloaXqfQSdXhyL
         S3BSMg0QbLCh5jl07v0UzY6934XQmy+cZz6+Kh1wN1m6PKAEKmdH9w1NbSFib+VXhPeS
         tGyQ==
X-Gm-Message-State: ANoB5pmYJuczmyMzSTgfMvTVqFOJvvu3t2E9QNrFyP7HUtUmdVAQKkxN
        TY9K99bDFpkmHLUsRGl4DvaMZEGWBkJODg==
X-Google-Smtp-Source: AA0mqf5HWT5Syh4HqEpX+X6l3HPlkLAYfkAtp5+kCo6yx9n0G54ldtup5CcwulWwGABXLlUVliYbmabx7GVXVQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:31d5:b0:187:1461:9b27 with SMTP
 id v21-20020a17090331d500b0018714619b27mr81676827ple.165.1670540720809; Thu,
 08 Dec 2022 15:05:20 -0800 (PST)
Date:   Thu, 08 Dec 2022 15:05:11 -0800
In-Reply-To: <87tu26arzy.fsf@osv.gnss.ru>
Mime-Version: 1.0
References: <20221127093721.31012-1-sorganov@gmail.com> <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
 <87tu26arzy.fsf@osv.gnss.ru>
Message-ID: <kl6lcz8tebtk.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/5] diff-merges: more features
From:   Glen Choo <chooglen@google.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> The last time '-m' issue appeared on the list, it all started here:
>
> https://lore.kernel.org/git/CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com/
>
> In particular, the final patch and its revert is deeper down this tread:
>
> https://lore.kernel.org/git/20210520214703.27323-11-sorganov@gmail.com/#t
>
> and
>
> https://lore.kernel.org/git/YQyUM2uZdFBX8G0r@google.com/

Thanks, these provide extremely helpful context :) In particular:

- Junio describes this "do nothing unless -p" is given behavior as an
  accident [1].
- Jonathan Nieder notes that this change accidentally broke scripts
  where "-m" probably wasn't doing anything useful, but we wanted to
  avoid breaking the scripts for backwards compatibility anyway [2].

I got the sense that the closest thing to an intentional use case of
"-m" is for users who thought that "-m" would affect path limiting [3],
although it doesn't actually do that. So what I've reads so far suggests
that "do nothing unless -p" (aka --diff-merges=hide) is not actually
useful, and we should just drop it.

We could keep the warning for "-m" without "-p" (Patch 5), and recommend
"--diff-merges=(on|m)".

[1] https://lore.kernel.org/git/xmqqwnsl93m3.fsf@gitster.g/
[2] https://lore.kernel.org/git/YQtYEftByY8cNMml@google.com/
[3] https://lore.kernel.org/git/YQyUM2uZdFBX8G0r@google.com/
>
> Where do you prefer these references to be put, in the cover letter, in
> the commit message, or in both places?
>
> -- Sergey Organov
