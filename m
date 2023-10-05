Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBD9E93713
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 20:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjJEU2C convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 5 Oct 2023 16:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjJEU2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 16:28:01 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CF59F
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 13:27:58 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7740c8509c8so89391185a.3
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 13:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696537678; x=1697142478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEKVYqdZWqsZp9YoQ3wDaQu3zlj93zb35/JuuXWfn74=;
        b=qKy0J62xhZ/Kfg+XX6va7ug/PodNZP/OaH9F5mUnSbwcHgDB1RxE5BlOw51rq1BjJv
         riqpFXyyHyGik5ywyE98Wg5NnnSmYdHBjLTrbjlYofrdrcgW2BzNTdZ8tXDSRUHIgljQ
         abke2FNd8uArVFYgUD53HCqZ5NASubE/E0Y6wxn7Llv5LZQTrua3eM1BPT+KHbNUJN00
         xpcZnZayTsCPKg5CQKWQTz5kpCJqUBOFpTK1xbp4HEmt2UzIqgqfetHy5zXE8naSGb0R
         aYQqR26N6QaaDCiI83Qc1fl0ETxjBRrOPAfwb3HyBS8e6ojoM50gYR2OasqKVeekwr5a
         R2Tw==
X-Gm-Message-State: AOJu0Ywn+c5fCCv0ZnYjkz7O6lKF83Wce5akTQHHPDvs1tWCy4FLXcRF
        z2DmQYi6diKzwjqZpcQOZwzdWJB+fe+pThZAH8Y=
X-Google-Smtp-Source: AGHT+IFI2vEYFU9AmD1T3r4IOTPVMvx2urtHyF0u4XLuL4+GZ1UaSNZtGoEwXkOmBMUECkWEnChdJNqWghSjZvpXWhs=
X-Received: by 2002:a0c:a9d4:0:b0:65b:d75:129d with SMTP id
 c20-20020a0ca9d4000000b0065b0d75129dmr6290823qvb.34.1696537677834; Thu, 05
 Oct 2023 13:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
 <035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com> <ZR6ajQa8bh5HKsnr@tanuki>
In-Reply-To: <ZR6ajQa8bh5HKsnr@tanuki>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 5 Oct 2023 16:27:46 -0400
Message-ID: <CAPig+cSp1MVVikAxtuq8XQPeoEtsaXETOywMTqM_CBDguASMUA@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/repack.c: avoid making cruft packs preferred
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2023 at 10:46 AM Patrick Steinhardt <ps@pks.im> wrote:
> On Tue, Oct 03, 2023 at 05:54:19PM -0400, Taylor Blau wrote:
> > +             /* The largest pack was repacked, meaning that either
> > +              * one or two packs exist depending on whether the
> > +              * repository has a cruft pack or not.
>
> Nit: this comment will grow stale soonish once your patch series lands
> that introduces a maximum packfile size for cruft packs as there can be
> arbitrarily many cruft packs from thereon.
>
> The rest of this patch series looks good to me and makes sense. I don't
> really think that this comment here is worth a reroll.

If you do happen to reroll for some reason, though, perhaps take care
of the minor style violation, as well. Use:

    /*
     * Multi-line comment
     * style.
     */

rather than:

    /* Multi-line comment
     * style.
     */
