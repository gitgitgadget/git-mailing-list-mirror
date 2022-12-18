Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABBEC4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 10:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiLRKEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Dec 2022 05:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLRKEe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 05:04:34 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E812E55B0
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 02:04:32 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y4so6361751ljc.9
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 02:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJvsSvbXI7QiTRZQ8/0c7swBhhdoCNzDsAFYQjiWDeE=;
        b=QHCQqEwPxCbCqDhN2c/o8HIVNcsxGeeM8WyBnS5ftvs0t8yfAYGx7nFbXZGk1FP23m
         7RALud5kDXqO2RHBzN4jlZkexa0fPV1zyapWu9Nx1Ca9x7t4/VOb0kVFEHu64aku9jtF
         n7N1se/cRqJyX/GHnokbdOtv3uynrIsOVYos8Dd0aeqohVZYQwDU4ijcAmLWzkCzEZsp
         +YoEF5t728t8ZEMfAjGiRMFGxnQGmWGAy1MclRHj7TBHi6Dz/Nnrk9qcsHGIJ8jaXRCE
         KXSFUnW8k2G53k4oirZs1JOqWNQdU9NEx06ZQa/TKWwS0IgPGVzSMvL16PZ4mlVWNiDB
         //yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJvsSvbXI7QiTRZQ8/0c7swBhhdoCNzDsAFYQjiWDeE=;
        b=SM/7a/u6pLTbvf5rFHPYk7PLdD3Go+jcabNuXMPtXvdhQhauN5UC2neYtEwpszr7i/
         Kw4Y5agdroY8HhDK8gnYGoonap99KB3s7/lpC8YCX5n1hFlX75Ocj8DkTwgWKGdIEfHP
         d9uH0mQkhP8hNZPRvlJrNlIIVf0xQTTo293eMxf6H+3RkXpcR5CLk8LhMpTOxawU9DP8
         SHq9JZu54625RVmalVF59S/Mfyd5vJnSrK4FF1VTBbr6p23/ADYWcn/WOXQDipBTodWu
         tUfLzFj0FtxLEugj4aOvNJrnkuQqCd2/Wr2GU41W5uDWrSlSQctQk2moQ9GC2aqE7dSW
         TiZQ==
X-Gm-Message-State: AFqh2kohnxmAJ5W5WPEbw1YuX950nhHS+zCU6/ErBbyc/VglArdQm4Of
        Y5gQ/+UQ/1NEThiDaM+QAZ2aPjhiPxjoqL/rAoqSR9eC
X-Google-Smtp-Source: AMrXdXvmadMM4hNQNro6RacBkq7hfNG0/5wLHsUP+5fCe8PPnWxDHzgAKJIeFS5fDDtKONOGraEY2PIJ5p/7cjPAeTc=
X-Received: by 2002:a2e:7318:0:b0:27f:1537:2ba9 with SMTP id
 o24-20020a2e7318000000b0027f15372ba9mr444729ljc.260.1671357871176; Sun, 18
 Dec 2022 02:04:31 -0800 (PST)
MIME-Version: 1.0
References: <CAPnZJGABhczzs-6Pri2SAOkujJXT1+JDH9FiwdDns6=miZmvFQ@mail.gmail.com>
 <878rj6rnuo.fsf@igel.home> <CAPnZJGAMRY02s6UvMg7B6f=NSAgK0PJQAoftwnhXk-ufD2YknQ@mail.gmail.com>
 <20221218093734.GC3411@szeder.dev>
In-Reply-To: <20221218093734.GC3411@szeder.dev>
From:   Askar Safin <safinaskar@gmail.com>
Date:   Sun, 18 Dec 2022 13:03:54 +0300
Message-ID: <CAPnZJGBwFMPAJKj9Qa_Vv9yJWrGaNXqaNaPUSrYcjZ8J+OfLrg@mail.gmail.com>
Subject: Re: https://github.com/rust-lang/rust is not bisectable
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor, yes, in this particular case this helps. Thank you! (But
I still wonder how to tell git-bisect to ignore commits, which are not
descendants of good commit.)

--=20
Askar Safin
