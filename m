Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931C620437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932296AbdJaVcW (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:32:22 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43266 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdJaVcV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:32:21 -0400
Received: by mail-qk0-f195.google.com with SMTP id w134so536717qkb.0
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5B//8Vw3K48DDiBRmPUiMYvEgLuAHoRCPSG4dAkn3JQ=;
        b=jCP3r7CJF0lXVkqWSvfbocoxiNAzNMPcPI2K11d26Uqci4oS3rA3xkkkBPHHl1mhwZ
         0dGPwRSbVTQKeYm4YoiWaibyi44uHmViiyQUByFGH97nQSpy2t5voX0nksGdizhqAoPQ
         iGJ5vfTt5lbH/Qz5cgFXOTayflbyJrzjRmQ+M782w4HdLudLjgGW3kWxMvWyYYbzlDTO
         YIg8nNAtd0spDGyjfaAIDL07bQzee5IWNEfquiU9b5MaOnnOzUySRyFyaktINQKwUW4m
         7pRaeFhdAwrWq7XVWsSqXB+BqQEAeAzNw8oDxKjlKdFqZNgKtLxEDzHUfc+Edp5+t7Z5
         UQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5B//8Vw3K48DDiBRmPUiMYvEgLuAHoRCPSG4dAkn3JQ=;
        b=no4TwT7bChcfPqMbfr0wYrBOols8NprQj7IwXSgqMhbQjOmieTsFI+wu9LX08fmFqN
         UEdrkKbGSSZNgahg1JOtsrqvZoTCLldiMgwoGui4Ui/7/lVlBmQl7NQJ+h9nshF/Trag
         m/L+mjibFNxJWkAV1FUcTUHrxDxL/1n8P2Yo7LoIlDBIsHeaAjN81+vU9LSGfN1zGd17
         BtyIkwhCadec6fXduFZ7ne7xaMYPnHVfG5LeyISS8TW7elJfMXFIpVECY4f+gFP5A5FF
         TEGi/m3cAVGN41HesTUNaRqjrUhZDcuuLKhz0t9YuVQwncsms1Tv3bQA/Z+gw0DxuY0h
         2HNA==
X-Gm-Message-State: AMCzsaWYV/fch6LeG7VqutdWWt5O+Xdw/i16l6u2r05mZ18qzbHBYqmY
        efWs2otqxvewl5XTSkLwFZCocIlGT68V9jLskVuV3g==
X-Google-Smtp-Source: ABhQp+Q1JSgTbFV6DOaUmQu0JtWj5/3WiaPEBC8cWh/cnqIq22AJcprlpVHuO5BgFDEG0z/wzB1VAF4pmpO90G4+zWQ=
X-Received: by 10.55.125.196 with SMTP id y187mr5238982qkc.180.1509485540843;
 Tue, 31 Oct 2017 14:32:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 31 Oct 2017 14:32:20 -0700 (PDT)
In-Reply-To: <20171031181911.42687-3-bmwill@google.com>
References: <20171030194646.27473-1-bmwill@google.com> <20171031181911.42687-1-bmwill@google.com>
 <20171031181911.42687-3-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 31 Oct 2017 14:32:20 -0700
Message-ID: <CAGZ79kajX=FmGacDSv_dDzppE6WBHGqgyCpaG1zDyENcsDbwZg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] diff: convert flags to be stored in bitfields
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 11:19 AM, Brandon Williams <bmwill@google.com> wrote:
> We cannot add many more flags to the diff machinery due to the
> limitations of the number of flags that can be stored in a single
> unsigned int.  In order to allow for more flags to be added to the diff
> machinery in the future this patch converts the flags to be stored in
> bitfields in 'struct diff_flags'.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

Thanks for this cleanup series!
Stefan

> +struct diff_flags {
> +       unsigned RECURSIVE:1;

After some quick research our coding style on bit fields is twofold:
Most older code is this way and more recent code seems to prefer

    unsigned <FLAGNAME> SP : SP ;

If this turns out to be the only nit, I would ignore it for the sake of
faster settlement of the series.


> +static inline void diff_flags_or(struct diff_flags *a,
> +                                const struct diff_flags *b)
> +{
> +       char *tmp_a = (char *)a;
> +       const char *tmp_b = (const char *)b;
> +       int i;
> +
> +       for (i = 0; i < sizeof(struct diff_flags); i++)

I think most of the code prefers to put the variable into the sizeof
argument i.e. 'sizeof(*a)', as that is presumably more maintainable.
(If the type of 'a' changes, then we don't forget to adapt this place,
but the compiler can take care of it.
