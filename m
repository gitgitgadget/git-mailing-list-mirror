Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD43C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 22:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C5360241
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 22:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhBQWtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 17:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhBQWs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 17:48:28 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0203C061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 14:47:46 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f1so756103lfu.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 14:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LRtZgO+CKWIJmPQp3Hq2ktgGhhzQeCdgzlfZVxczSqI=;
        b=q0vP1fHJj7rN4Z9pMMdvmhNVs+YncK1gZVb3EPZhpuIBeru25P5IjIYFT/+owFQ3CN
         EUQ7I71AP7hkHuuk1ZNKfV3w0Bvw0mjd2IMk26M1GFmNy23O09FmQIhrp9YTBuv7bdXF
         TP6cXrWNrAtmWAhZ4+SkGLD0sfJlEnPQGomz12gt9fzfre55mFUE8BFYFXYxOsol/V3s
         TWEPc62HtkUH0WGXAhDKmSWcR0oLYqLDiAtKU+HYs9OyMlg5VD5GEgERlf6ErI47DwkT
         JnHf2PdlnKo+0QOJDMMWEFEvP2kvWdYh3UT8EqsL69Tb6CyYytMsVqia5bzPrIG7R2Lw
         x2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LRtZgO+CKWIJmPQp3Hq2ktgGhhzQeCdgzlfZVxczSqI=;
        b=XpDDRfGpt3w9x47YhnkB56RhSVDEC8d49rm2bfQzWehiYa1jmImQqpSWElVMCk+TcX
         ifGSBqMyJWJPVQEfZKTAI5lHBny3FgzhINQgQ4I4LlFc/F3pvacUmAK0RLZ4DGb5DcwT
         x8uHvDwV+mBq/dr8AAnE+GpNnVoh0Co9KxjN/xpWjYBcKIe+VxOIcXu77d0sCrWjo/Wj
         eS/uxlRI00CiOVmKqB793hRBHC+tFQRr1Y2HQqrWfHE1XFh2nLS6psxvodnXXgsnLMJ4
         yNBedx5egqsYtTfoQP0fwlYMlfTLXN4l/NvNQvkkqFTlSZmSIOKuBkdRR9pcuxsUMmDz
         erLw==
X-Gm-Message-State: AOAM533FAiy4iYkNNFKf9Edm02pmD8gCDH7dnQrkZBjVrZMQxu9Yrgkm
        YLRtoib9Y0GeHaaTuip524BHq91i8iz9NJkOzVo=
X-Google-Smtp-Source: ABdhPJwX7d0lT+5H/vM18TzHN214wr0WIiYF7KSETJMrUzGrzFleluUs7XTcFz5RTOREunnmHIGJyYggQ5ktul/hS+Q=
X-Received: by 2002:a19:c306:: with SMTP id t6mr673985lff.113.1613602065256;
 Wed, 17 Feb 2021 14:47:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613590761.git.martin.agren@gmail.com> <97c686dd7ba1bbd1c0be6f7f61a3a033adf8adb6.1613590761.git.martin.agren@gmail.com>
In-Reply-To: <97c686dd7ba1bbd1c0be6f7f61a3a033adf8adb6.1613590761.git.martin.agren@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 17 Feb 2021 14:47:34 -0800
Message-ID: <CAPx1GvdcFGmAi_zJ9H0+40uZw49qhTs8C_afnMMVj32EFJXqBQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] git.txt: fix monospace rendering
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 1:21 PM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>
> When we write `<name>`s with the "s" tucked on to the closing backtick,
> we end up rendering the backticks literally. Rephrase this sentence
> slightly to render this as monospace.

That seems fine, but one question (diff trimmed way down to
make it clearer I hope):

>  +           contain an equals sign to avoid ambiguity with <name> contai=
ning

> +       to avoid ambiguity with `<name>` containing one.

One replacement drops the backquotes entirely.  The other keeps
them.  Surely these two shouldn't be *different*...?

Chris
