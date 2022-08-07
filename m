Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D25C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 15:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiHGPoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHGPon (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 11:44:43 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437832DCD
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 08:44:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y13so12493292ejp.13
        for <git@vger.kernel.org>; Sun, 07 Aug 2022 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vK2iLm+Vn6DgHVv0yvhMOlDeBArLrz6QkkOAxZfHDKw=;
        b=FM313AWyUnTf0KSeYpsPwu4UeKyMInq6FnrxnXz54CBKwNwEdc5ci/86sl7Tvt/bTc
         5V7RuygS+Ak+z61f+gZqRfEZyPrS5FpAjJfaupZ4Y6oeOLW+5VtW6c+IutBCCch/0sdz
         CZCCD32UpIXaaGKmxePh0POA/+Lsm8iMMt1pz4fOB1dzVMVu+5UGl4bbSy5COHNIHcS4
         ++3rniH7EXjG7lL+AIptgslP1mRPIp6PrvxS/lG0TlAngmY/YM4Tuk+jm7eEYM9+FElF
         DKdj6vGSaHIrLbwL/lUDeI/cMidZFgwyl0uKG4HLKz44tkC2vXSBPbqVlR6NckmhmxX0
         P/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vK2iLm+Vn6DgHVv0yvhMOlDeBArLrz6QkkOAxZfHDKw=;
        b=oQ7hoG3R+NB3Q56zqTU4KvOAJ+fF8GU96DUb9p+ivESljriNMgcsuIpW3WadyUQ6kL
         amM7eEwC7XgedQVptE6+5IykWEeL5Dk9YjidQTcCINmtD2UWAT5MvX88sVJFR0syt+5F
         s7Fth0UVPANqtJa9xJhyiBkAFEuLl9SHCcPy7XGdokcIE5AX5ahSu5NkW2y84Q4WZTRp
         wKswZmWAVUTnRiksoQ2/aEfjFUMkV1CON9BR9Z4SNFreQxdBEavu2/fPnQi87NRFsKdj
         DxyPHkC34PlR9ftKypEUAhiCIQWl9HLHdIGQD5wEzYsVnhYFGZ4rgqxQz+9GynxK2LIq
         eG1A==
X-Gm-Message-State: ACgBeo0PNf2tZmzsANyPDCAJDZ7xGmoanXjy/PB30I6TrkeaU7ld7ByM
        EB39w4wzFkjBxN6MSXO11/lstQdVVn7pypH7j5dr1+jT
X-Google-Smtp-Source: AA6agR7bHY0Y1BxBcJOIysN0xZrGVHF86Dmtvp1ryhnORECzhIkZeIQEBt78B/FPfQO4BYKRNMjpnqP+ZZKxIBqeXj8=
X-Received: by 2002:a17:906:7304:b0:730:c3a8:cd7a with SMTP id
 di4-20020a170906730400b00730c3a8cd7amr10616312ejc.575.1659887080785; Sun, 07
 Aug 2022 08:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <20220807024941.222018-3-felipe.contreras@gmail.com> <Yu/QQe4lz2MhiCQp@zacax395.localdomain>
In-Reply-To: <Yu/QQe4lz2MhiCQp@zacax395.localdomain>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 7 Aug 2022 10:44:29 -0500
Message-ID: <CAMP44s388FBn7pynSQQNbo+ru-+7pm4gpUuhgu-jHqJP7tJQAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] mergetools: vimdiff: shuffle single window case
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 7, 2022 at 9:46 AM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> On 22/08/06 09:49PM, Felipe Contreras wrote:
> >
> > +     # A single window is handled specially
> > +
> > +     if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
> > +     then
> > +             CMD=$(gen_cmd_aux "$LAYOUT")
> > +             FINAL_CMD="-c \"$CMD | bufdo diffthis\" -c \"tabfirst\""
> > +             return
> > +     fi
>
> If you make this change, it fixes the first issue I was referring to in [1]
>
> -       if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
> +       if ! echo "$LAYOUT" | grep ",\|/\|\+" >/dev/null

Yeah, but 1) that's a problem in master, not with this patch, and 2)
as you already mentioned the colors are not shown so it's debatable if
it's really "fixed".

BTW, much easier to do "[,/|]" instead.

-- 
Felipe Contreras
