Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E735C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 07:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE756113E
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 07:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhIKHme convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 11 Sep 2021 03:42:34 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:36380 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhIKHmd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 03:42:33 -0400
Received: by mail-ej1-f51.google.com with SMTP id bt14so9095313ejb.3
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 00:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WoLtpfaga4lyqb+zt5zs6Vyz7CeTIffOtsRSTCytGyY=;
        b=yMlRT/rtRdYxVUWpYZIihCxPNaINLdghETerLb4QpYXrjhpn7iDIDavmEjHiS1V38l
         BVniDbbNtkVxJxl3OS+h3YBQF+zqRDYIw4CkNJONi7Wr8scrYlQtQTPyBjy1dMyIRaFr
         1nM0JUyrI1JR09buOHsPJRpf19me17CcI3W1qkazq+MCDtKsype+wu8mbstwa1rIHFux
         TRsOfv3Y3feV6yZQVHijrhgOEU9IWdZ7eBKkxD23r1QOOojQWKuaqRCmgFtV/WZctCuN
         zsctNSFmIAa0JmcLohuDwaUGEbibGeSMk8fG2Qc8Lkt/GGj+cpJbJhIEiDYbgVLQsTj6
         kWmg==
X-Gm-Message-State: AOAM530yuU1Qjl12hytWYotIwT0zsZU86vVV0MwdczgsYmU3q/XBsrvG
        cdgnH7IJV9eKL972en6CCgGV5wzEbTfqjhseGscOH7k6
X-Google-Smtp-Source: ABdhPJxTL0M9lLzS7idF3bF4mqGvCaWF+4juIJvfFOIyRmkXpjHy/DvCzoDocfLmC+cPDkEZHpqOBMRCL2+1pwsNBBs=
X-Received: by 2002:a17:906:318c:: with SMTP id 12mr1745592ejy.28.1631346080475;
 Sat, 11 Sep 2021 00:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
In-Reply-To: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Sep 2021 03:41:09 -0400
Message-ID: <CAPig+cSrjx=okjqyOtD7=wwcAt2QZ30OMr8rKNoy9Z42_Ux4ew@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] parse-options: properly align continued usage
 output & related
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Carlo Arenas <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 11:38 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> This series changes usage_with_options_internal() in parse-options.c
> to properly align continued "\n" usage output.
>
> This v2 now also gets rid of the support for "" in the usage string
> array. Eric Sunshine had ideas[1] for how to simplify the code in v1,
> along with a suggestion that we could just get rid of the "" from
> "builtin/blame.c".

To be clear, I only asked whether you really needed to add support for
embedded newlines in free-form usage strings following a "" line; I
didn't actually suggest dropping support for free-form text following
a "" line. Perhaps I didn't articulate that well enough, though, in my
review(?).

Aside: I did, however, _think_ about suggesting that free-form text
support be dropped since I only found one consumer of the feature,
however, I decided not to make that suggestion since the feature
seemed like it had potential value and the current implementation is
good enough and simple enough (though undocumented, as far as I can
tell).
