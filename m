Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F49C433E0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 05:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4673464EE3
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 05:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBTFLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 00:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhBTFLf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 00:11:35 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4C5C061786
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 21:10:54 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id g1so29310541ljj.13
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 21:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/0MpIHuO70wg8aldZ85PRUVERYzqgPprao4eyrPuk4=;
        b=vMfDI5zkoplvoJ8JR17VjYBY3HvBIGZA1smXfvv9lnVCtM4deNTxVS7kOuhPyImJcU
         0F1qiYpg8q/jMbfqdu55IKr1PStYnUlml7UhEmUoOth6XNkjFYgHwzgJS5u187SAZFjZ
         spySB5U5PtVrq3BX07BlnIn6mbxL3xASYBc9eT+x4JCxaEZsaUEbanc7VU4GnCyrNZry
         2vZYchwS+dinorGxcE36wr6LpIuINWeHTD4K8i1/2etkDSw9GIDr4mT1HwMBLPScFogr
         6FKK4bciQkZplfzGYbZci/QOjUQhi6ahV5prU4xuLyWouw8Khc3Kh/46KBV3Io2Q8Rdr
         ahEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/0MpIHuO70wg8aldZ85PRUVERYzqgPprao4eyrPuk4=;
        b=Tw6og+11RyffmjjtHK/ntz+rGJc41VIccNkG5+FbaSrnxLfLs3CvVmHej0cZpcEp3S
         fg45o0oB5751J6dc6xXi0HWukwIeuLhf+RG9pfwfpPywW5wWbdCu+9KHfZ3bEC4S3v4O
         ZnXGNEYjeh25zQpD4OrJXEvItJV+/0YKG96Cl4BAAWMRevERRol4yXtdvGMP6N2dSwx+
         cO0N2H5ESlyIJKX5UfBY0NfpQ2IlKE9X1U5a5oBSuQ9bmU9LMwtF6W25SiZ3syhhmARS
         55JjgqHg1/kGiJV0TDKB9Um3OQbO/6ptrs1GuL2U21ezACEATnvZFAinOyU5pmvIaAG/
         Dd1A==
X-Gm-Message-State: AOAM530n83zxyqkN6XfbrJS/1IVpdlpvm26tjyF907d6s7hLRHOC1LGy
        CynfdV90yLVQHwa0LEDAB5CuX5FKCVfPSzJOhm/8ZN7UdUoINQ==
X-Google-Smtp-Source: ABdhPJz01Kjj93Pt6fn2DTCJmtDRRD8xyyN+ktYm9zFRzjqDd0JO/ZbgvZJo5rJ1nDJyopH7nrRSFsarqMNUJG3yBwM=
X-Received: by 2002:a2e:95cf:: with SMTP id y15mr181273ljh.464.1613797853411;
 Fri, 19 Feb 2021 21:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20210120044435.53509-1-alexhenrie24@gmail.com>
 <xmqqturbdxi2.fsf@gitster.c.googlers.com> <CAMMLpeQM7JCP0=TMqf0DxDCVJvkCGDEPSKN6vYTU_xc7+QaA1Q@mail.gmail.com>
 <xmqqo8hiaptn.fsf@gitster.c.googlers.com> <CAMMLpeQ5ga_e5-YeVuArYBrui+ps7HWzNjWNQgeJK3sEjo2zhA@mail.gmail.com>
 <YAoSIkCecZU98QD2@generichostname> <CAMMLpeTDNLUz9UVnL3aVK=J7X50Sq8L-OVGaoEsT5AY6EQON-g@mail.gmail.com>
 <xmqq4ki9c5u9.fsf@gitster.g>
In-Reply-To: <xmqq4ki9c5u9.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 19 Feb 2021 22:10:42 -0700
Message-ID: <CAMMLpeQDKtNb-i5tQgphceAgS+V+wcf66_Xf+EfENn3CHNg-1w@mail.gmail.com>
Subject: Re: [PATCH] rebase: add a config option for --no-fork-point
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 18, 2021 at 4:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Any progress on this topic?  It's been almost a month without seeing
> any activity.

Sorry for letting this slip. I just sent a v2 of the patch with the
specific tests that you requested on January 21.

-Alex
