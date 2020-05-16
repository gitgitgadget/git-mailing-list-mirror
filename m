Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACEFC433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 18:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247E720727
	for <git@archiver.kernel.org>; Sat, 16 May 2020 18:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx301IaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgEPSqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 14:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726361AbgEPSqd (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 14:46:33 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A93C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 11:46:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r128so2985580ybc.6
        for <git@vger.kernel.org>; Sat, 16 May 2020 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=g3zLYH4xKxcPrHOD18z9YfpQcnk/GaJedfustWU5uGs=;
        b=Gx301IaXPSMYRREp2AYKVZfQV+a3+NPNv0llK4vupsGn+Q4fAn0+Ln960Bzr+yqh0I
         WVomg0MZh6Tar/fWOuN1/IbzGp+wAjApzT2n6DvCL9+7y8RgFHc+krYtofOr0N/Ysd2l
         qT8FS3ZLqZlECtQb1ZO6JDxVpqck9+ts7SG9irw+LjKI93myE5L9DciPTQ85NU6hjkcz
         BHfGyXkD8AcFt/l/egFTgznNyNVV1Mw9XTr6XdUTZjZIwWEMn4ZhO3mG0T38HZNVI/t9
         T9CqnGIMRtfN9IuRKnFn/wDbMVxoAhcJrDra06lYmVH0wS2t6dR3SngLSznJlod6GiUf
         gLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=g3zLYH4xKxcPrHOD18z9YfpQcnk/GaJedfustWU5uGs=;
        b=MD2l04Fnqj7jvGar8vIIKUDofVDiM/ruxSfHQMMWASSXJn2tkogofF6KeDjGCgmepF
         aNpwtsQ8yQoWyX6gIv1gxk6EU1Sn9xAFtpf6LrSPHalgBMq1l+9V3ZrAHMU9qpOFjOkS
         ZJ2WWkSJ7OBH2pDgMPmMFZ54I2dXyLo3M9Nb0JAYO/8PuHG/F3RDZLpFwQ5Qylz2zxaj
         QsImckY2AfYOyNeD7+YOUBi3aJedo5TmnaKnFe/EkJTfuGsujDDgIuWwO2OaAqu+w0vP
         5XB8B/2kPhDrXs8qMJSMOinFh98LPwImW/11jq7lhoc7jhWgDWFxHVXlnFjQHWrPrKUE
         vueQ==
X-Gm-Message-State: AOAM532NQBaipH3HyRIg3bKh6qckuXYYK7NL9tnpQjDWOqhjj8U2luPV
        tpBHSh8WOFx+ZliOG6XbXyqJXq/zTjvtHpPVNohXNMEv
X-Google-Smtp-Source: ABdhPJwawmNe4ewDm9ixNFMKiLxB+8K0geDZsB/X6cGVGP5rvPgiZJUVu6gLstO/exJalH6DMnWO8sLGbnyT06pdP0o=
X-Received: by 2002:a25:d914:: with SMTP id q20mr15131145ybg.262.1589654791748;
 Sat, 16 May 2020 11:46:31 -0700 (PDT)
MIME-Version: 1.0
From:   bruce <badouglas@gmail.com>
Date:   Sat, 16 May 2020 14:46:20 -0400
Message-ID: <CAP16ngrYJ4V-h4cF2DE+emGnTJ2mQNCx0Ht4D6qHMju4i8LnMQ@mail.gmail.com>
Subject: test
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test
