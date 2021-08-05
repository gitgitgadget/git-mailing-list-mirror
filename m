Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D707C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5D960F94
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhHEB5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhHEB5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:57:24 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ED9C061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:57:10 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 21so5329994oin.8
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fb/CmoAGLEAKDW/UvhHEcs2hbKP3H3+cxpJyxq6I9u0=;
        b=MFbjakt8n50YBDkz1vym1rIiqwI43rS3DnrRybuCjtwMKqY7lNNleY7bmUvo4lKvZC
         7KLOZogtZmFmF/WlG/7eeGougkYipajXz2xSFN5kyxpWAGPLEjG+MneyBc/1Zs5TpzH6
         AFiev+CAQh0nJEBU9laDhFAnNzrVPS8l1kYPaYTVTehjCnQxcOVHciBB4A4hvwT1Gfz0
         8fP7EOdoilI671IlJkWQRVKcWojioF094ARcn++veUZ+QdJXh0Blq4MkeLr5L6NnMOBn
         ZkUbCSGGqI9r9sN5RBg2q75qMK3uWaVva/tYetjBqANoZPxN6nRWPGmP2nEERwKxyYSR
         OTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fb/CmoAGLEAKDW/UvhHEcs2hbKP3H3+cxpJyxq6I9u0=;
        b=Sslfo6ehe9cp8ngeiPkkiyoBFORpAOF+3OmsRlX/yssPBdREDu2z8zEqUmaQDwYAVU
         yXs4kY6X+0Kd8AQTwUUMJTPVzKyNPjy5ME9YD8uzel+W2ZBUlzdQm3KsjC3Ljm5foxiP
         uGRQWgIxIMPwpzyeoXwb16e3qK9vmWOwjVMBYFb0xZjMisjBCzeblLZ98Vz1NxmNJxCp
         Iu08gyra3fHNT02H8XR8+Njqz96BJnzaWYlihO5LLnyclOl5sAIKKCiqjW7Dc1HY6OhA
         A2Z3x4cBlCEm+J1vp67rfKl3eHz1TDntjtIdmDhaiSlUMqB0e4uyWBlfe/QDOgKCARUa
         Htdw==
X-Gm-Message-State: AOAM5327WgAIlGY5rNvSfY346+jgyJJ/qZW6aSqYroAZl5qiw9S8cna7
        WNfcNwGZ7J4p9b6lwYvcJN4Acgv79Nwf//+x9Ko=
X-Google-Smtp-Source: ABdhPJyiwTkMztV1SZj+tWvGMJToFleAa1eya5Pcgn3rHXmyCvhXs66YdDrUvuMec6Vm90hnNfhF0UcXde4yYGOtv+E=
X-Received: by 2002:a05:6808:1390:: with SMTP id c16mr1648113oiw.123.1628128630028;
 Wed, 04 Aug 2021 18:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAAVFnNkW6Bc4bBDeea2v-VFydvEC0dBw+QXVA0-6OnmF8km3ZA@mail.gmail.com>
 <YQmsJUe6hAMy/QGA@nand.local> <CAAVFnN=W27rdE1EH-joscyJEooAsDrdtPropVVaBYwhte=cPJA@mail.gmail.com>
 <YQmuT2ZYe1mzHBjI@nand.local> <CAAVFnNmitHeimogaGUUwWGWhve+wbF6CXcSNUonGCWAgOSKzjA@mail.gmail.com>
 <YQm+PWAtc3rixqsw@nand.local> <74443c64-efe9-ea47-e918-d62b8c976abc@gmail.com>
 <YQtBezRE3l09cILa@nand.local>
In-Reply-To: <YQtBezRE3l09cILa@nand.local>
From:   Cameron Steffen <cam.steffen94@gmail.com>
Date:   Wed, 4 Aug 2021 20:56:58 -0500
Message-ID: <CAAVFnN=ynj8sa-5YPmU7=s2OcXzy8a_gsxRxVxFD_9LgWQOBtg@mail.gmail.com>
Subject: Re: git revert --continue --no-verify
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've updated my mental model to include "--continue is a shortcut for
`git commit && ..`". That is a big help and resolves the issue for me
since I know I can always fall back to running `git commit` manually.
Thanks for all the replies!

Cameron
