Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938ABC636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 14:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBEOir (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 09:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBEOip (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 09:38:45 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2112F16AD6
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 06:38:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bh13-20020a05600c3d0d00b003dff6cd8b7eso1804786wmb.5
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 06:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pXC8oVlL34PTTDmJ0SSpU81itpT1rdrko0AhN7hWehI=;
        b=PzzdICo0lorx/CKLM/1YV2dRwiXrRHWfwDtvVIVfQlPpGaxKHFbc5YNftqGV3lEjQm
         RGZblJ4+tOhZrp8VsOnZwbrVOxQscu9tzDU7R4jgDrl5caQh0Z9gIWKdYyvp7jdtf66V
         86sYy9UAcXiFGj+U0zwrSFIsc9DuEgW8wm3oRDCN5wETjGCZkuFVGc0zzTZa8UAXSiI0
         oKHe8Hl+nPM/kN3xVV9iIfB+LEvkA4i+ddSR+CM3UPg9ot/9F53vqlG8v05fg9rDsHv0
         Re5JtXO4MSzj3pSECV6w78vxfLkZTmcgwddYxX478zlVRuZvzrkECYImAC8YaJuDBjn5
         50HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXC8oVlL34PTTDmJ0SSpU81itpT1rdrko0AhN7hWehI=;
        b=jyY/ctBi0eMTrrcZu3yVsy5AvCTQxaTacOw7GGwSLba16GRmbkdLw1ZznUiZnkqdDJ
         9kwgEWOnbha3O2n/WAL19oFgf9gWN9jdsFe3S/oB4dt6AJ1Rw1ggqfX5D8IsGWOtqD6N
         ytPBOS0D5sk73e+iSpCAkwqmaPOYlZ6EAHZsyKKDKAoBoJ0R7KgHHGxzACzIm4XDqeGQ
         O/12Qq8yqd4RnrYN4dPSZZmA8ujNjAgFqlw2r9Mx/dXDHxDmb0O7P1IfQTx4QAh1iqiv
         tQJszcz4OAXDRbilKz4HmypVMJC7dZQuf5Fax/mIAXp0DhGXyLUT+kw4VyNbuUnuTehp
         56Zg==
X-Gm-Message-State: AO0yUKXAasUenkt1C5qRdoc5MrqEcHWvVIqHeKuX9InBCWMLG/J6ufFD
        ugZyVwXmrTmvTV2gKWphcHxo8WJqTdkCRU4sA9xq4ywQPcrFpg==
X-Google-Smtp-Source: AK7set9FhHAB+vpsT8PHseqKoOmiMCUGfimAvnfxm9daLz4WWC85g8sF9YqbgRGSAiEkmCS9n4z/dckcS12SWxNlIvk=
X-Received: by 2002:a05:600c:1d03:b0:3da:f956:1ada with SMTP id
 l3-20020a05600c1d0300b003daf9561adamr544539wms.177.1675607922582; Sun, 05 Feb
 2023 06:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
 <20230202171821.10508-1-cheskaqiqi@gmail.com> <20230202171821.10508-4-cheskaqiqi@gmail.com>
 <xmqqwn4zsrr2.fsf@gitster.g>
In-Reply-To: <xmqqwn4zsrr2.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Sun, 5 Feb 2023 09:38:31 -0500
Message-ID: <CAMO4yUEMHFCkcNa_oaEQLUCTTy+iwrahyWzyX=HTE0USv2WgPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] t4113: use "<<-" instead of "<<"
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2023 at 4:05 PM Junio C Hamano <gitster@pobox.com> wrote:

> You forgot to explain "Why?".  What you did, anybody can see in the
> patch text.  Why you did so is what you are expected to explain in
> your proposed log message.
Thanks. I did make a lot of mistakes in writing a good commit message.
I will modify it.

> > -cat >test-patch <<\EOF
> > +cat >test-patch <<-\EOF
> >  diff --git a/file b/file
> >  --- a/file
> >  +++ b/file
>
> There is no need to do this, as the body of the here-doc is not
> indented/prefixed with HT at all.

yeah, I did not notice that , According to t/README says, Indent the
body of here-document, and use "<<-" instead of "<<"
to strip leading TABs used for indentation. But here do not have the
leading TABS in front of it.

> > @@ -31,7 +31,7 @@ test_expect_success 'apply at the end' '
> >  '
> >
> >  test_expect_success 'setup for apply at the beginning' '
> > -     cat >test-patch <<\EOF
> > +     cat >test-patch <<-\EOF
> >       diff a/file b/file
> >       --- a/file
> >       +++ b/file
>
> This is necessary but that is only because [PATCH v2 2/4] broke it.
> In general, we frown upon a series where a bug is introduced in an
> earlier step, with another patch fixing that bug.
>
> Let's not introduce such a bug that we need to fix later from the
> beginning instead.

Thanks, I will introduce the new bug caused by the current patch in
the beginning.

--------
Thanks,
shuqi
