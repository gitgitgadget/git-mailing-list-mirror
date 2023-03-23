Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8932AC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 19:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCWT0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCWT0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 15:26:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5815493EB
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:26:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id br6so29199778lfb.11
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679599574;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0b5RwBpBlJNfWnq5+o8JI8P91JcCRWGs86zaBI9vA1c=;
        b=cUHnDxB7j197fv4EQA2gwEiLXvUhMOYfL4GBtELHeRKhxx6A0qjfBRYLYFl8Kkys1B
         mYZ4hzJX1FJTqe4xKT+Rt8J+wQmPRf+WD9kLFo+kWEDFfocZLSt9ARxqkivybf8vPDvi
         NyaQOKWwoc+5EGb0QvtXErkK0lYdQrccH7IBySSKzZMntdO1Prcugt3PtVadQJq3BPc3
         jP5JA2ePoC3dorpx67C4sHO2Dxigr0L4A5HD0hjJzZMwKv6i4UdCdIegGAfiw9m0u42W
         r6dfwpyBNK31HPdiNtoHMvqchpfKKndcnJHk8Bj/2+8Fd49q8bcxQe9B/bnAW977ZPer
         6A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599574;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b5RwBpBlJNfWnq5+o8JI8P91JcCRWGs86zaBI9vA1c=;
        b=UsHFyrZTB403mhOZkZQyumVVbDR4IE3mTaRhm7JEsK7tG9i2kWRQo7dcoqi79RPibL
         6TbSZzXB0aNmLwRdvLXzdA470QmSVRVU+BcwK4adYW1cwZs2toxV2o+Zu2UWgyNSu+4p
         Jjk3hDA1RqhkPt2CeO4Y++mOu7NZoqWD89m6OFDZPEvjh+Tf8Bb6cVPh8SEp3Wxx/76w
         W20yGxk4wDFHc4LMxwpSum9Bm+vj2ijRWn9ymYbaVj5+V82Df8VQaSIsZVKYutEUGgu/
         OBNEKpTtgxsVig7egoI9lf5OGGXDlTq9zPNck4Ojq8zKB8JfDq0ZUfjNGPdXeb08vmy+
         HyyQ==
X-Gm-Message-State: AO0yUKXjLNGkKZsuailS8fHu084nGdbEmbDd66x2s+mzIuhvGgeLdTGq
        +O2OtXgV1ODmNm+5JtmQDNn5gZdaUaDxMw==
X-Google-Smtp-Source: AK7set+e9aTgDOtD+HQZdP4nBO6vM/Df+6uZCS7N5g+KT7aoNOCwfTsib86/VY2akN/Djvt3KbS5dg==
X-Received: by 2002:ac2:51c5:0:b0:4e9:b08c:b37c with SMTP id u5-20020ac251c5000000b004e9b08cb37cmr3252918lfm.14.1679599574353;
        Thu, 23 Mar 2023 12:26:14 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (178235188095.dynamic-4-waw-k-3-0-0.vectranet.pl. [178.235.188.95])
        by smtp.gmail.com with ESMTPSA id j1-20020ac25501000000b004cb24a027d2sm3063427lfk.48.2023.03.23.12.26.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:26:14 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     git@vger.kernel.org
Subject: What is the status of GSoC 2022 work on making Git use roaring bitmaps?
Date:   Thu, 23 Mar 2023 20:26:11 +0100
Message-ID: <858rfnb770.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Could you tell me what is the status of the Abhradeep Chakraborty work
in integrating roaring bitmaps (using CRoaring) in addition to, or
replacing current EWAH bitmaps (using ewok)? The last communication
about this shows that the patches were on the road to being merged in,
see e.g. https://medium.com/@abhra303/gsoc-final-report-feaaacfae737 ,
but there is no mention of 'roaring' in Git's code or documentation.

Moreover, there is no proposal to finish this on the GSoC 2023 ideas
page: https://git.github.io/SoC-2023-Ideas/ .  Is it because it would be
too small of a project?  Or maybe it turned out that roaring bitmaps
were not a good idea - though I haven't found mentions of any benchmarks
of roaring vs EWAH in the mailing list archives?  Or perhaps there is no
one to mentor this proposal?

Regards,
--
Jakub Nar=C4=99bski
