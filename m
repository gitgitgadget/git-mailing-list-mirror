Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9A9C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 07:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483D922247
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 07:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wllno/AV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgJOHEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 03:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgJOHEA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 03:04:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D997C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 00:04:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p21so1286469pju.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TMaxbZ+3Otjid4wValJ9+YS0bww6CPGz1d0tdaRPFd0=;
        b=Wllno/AVnB8eSZbCR1xamDVPlsk1Kc9ht1ngey8hiVqhmIJI1CHzVOko2AWM8prZ/T
         xfRCG6vES6EGAfGN3dbzfSTVB82s6qDfko+Gl18paTTD9B9D1REdA1MCU2O4yTY7sdIy
         307k3c7GCNb8tGUw+GXV+p2IN2ERrsNmLZTEuxRBTORzvN38WJW4QRA1G6PDcidNHfpP
         q8DHFIFcJPwn9ybV9zzdNOqvTjfdrzoFNeKnSwisavdF7BgVfWl2ilQCiBiNOmycVcbJ
         pCJa9NmmKOi5LXPusK05IRT+fbD1ojf+vSybkopKoev80IwEPXNd+feaNovWuecU1gVl
         bi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TMaxbZ+3Otjid4wValJ9+YS0bww6CPGz1d0tdaRPFd0=;
        b=fin+oQeCnvLLzbn30j9lsufbNbe5C3WheNMy/sB9XBLGjerY/wbELNe6oWILk8kqSC
         /V8SdtISLq1zw0EaEUHTwt6O+UtrVuOrdXN2/4EQAiZETyGVKSF1IZbU1JFRuoefZpLT
         G1dERbtGz1hywjd7FQ+nGUfARqV++rYWi7SanPBkqIJ8HyljxKl3JvTbFfNqfxwFMxfk
         TiPUj1twDHqTG2qIpTQIGvqz22FTjrxG1VGNIHnaWsk9xfGts5/S+Zs4RXS8NjkfBh/y
         zynIh7x+2N93T3PdTjJQXNgaFlOUMkW1ZJInxd+xLKz2uOqmzPJTmb3U4GdrpzCKkSrD
         51cg==
X-Gm-Message-State: AOAM533LfdwujlsTWrFNI9R0SbgtwNCSD753scl1je3Dw9fD6RrT2tg9
        9qJpwNH3WZLroHbkd0RcHKi8awQ0+5rcSbriTZi1YgMI
X-Google-Smtp-Source: ABdhPJxlZmZw/zL6MmdwT+vstUjFDVAIOJ3UfPkKMJy5fzkLOGhhzI/Erm1YUiBmTo+UQQ9gRANyXCbfTLktMF+v5DI=
X-Received: by 2002:a17:90a:dc0c:: with SMTP id i12mr3076445pjv.67.1602745439082;
 Thu, 15 Oct 2020 00:03:59 -0700 (PDT)
MIME-Version: 1.0
From:   Zodwa Phakathi <phakathizc@gmail.com>
Date:   Thu, 15 Oct 2020 09:03:45 +0200
Message-ID: <CAGdqGXq2HtiS_ZD2k3y8y8enHJp+FUL+Sg8JiqQ05T7cjxAKbw@mail.gmail.com>
Subject: Outreachy
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good day,

I hope this email finds you well. My name is Zodwa Phakathi from South
Africa. I am one of the Outreachy applicants. I would like to
participate in the following project. The project name is  Accelerate
rename detection and the "range-diff" command in Git. I would like to
know if you guys have any suggestions on which microproject I can
currently work on. The microproject I would like  to work on is
Modernize a test script, Is it still available to work on it.


kind regards,
Zodwa.
