Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435D4C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 07:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B93420663
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 07:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4lAxCw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgFPHhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPHhM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 03:37:12 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760D1C05BD43
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 00:37:12 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n11so18285768qkn.8
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 00:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A67HzjYCjUQPMpM92TFaoZSI6i4svf0Y+4oZ/NPIMBU=;
        b=N4lAxCw7qqbL+wEUJmCHyN/ky40qdh4gnXGQFfXNuf136xXOxPi2/k6wB3cSUJgf6u
         giV8n2AJ83Bf05KwJdvv05XkMs7EfkLzxueCn/itEy51EkD65Uc3e7f02hxB49204fTO
         MIRC3hxVfu6EUBQDkuEu/x+aTEBpU2XgKk2pgNQ8Dv2KJ0rgjZC36quPQiuzL3rUvy5M
         QZGuL7v1RDMzFlUJma24/ovGEB664N0L4QQN8Y1w4KR+gxBjdNX6hFAt0AqlOG6Yed26
         UZtJuP+Wf4opOkuGPkWYRFq2r3D+fKzqBcmOFes02pKwxWBZeuM37smV0fU5FIXra3wG
         CPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A67HzjYCjUQPMpM92TFaoZSI6i4svf0Y+4oZ/NPIMBU=;
        b=uKfM8/cp7R+xCMFWZTvyrqrd4X/OFUIvCez3Rg1HFmZQtZH76zcOIifmTmTHzKIcmF
         pzexpThWwsy3LfVtIUrJc4Pni3nXB5hYBdeMRLO1sMfJJ6PbBhMn8E+dTvI/vFaP9Xu6
         4M4YdF54QQceWRbDI7crN37C40XqoOk4MGTI0Vb+f5wt8TKFK1V8HKJBFVHYzwXJkobN
         HMKT/lkTykxeb1lMdiaL3Wxp36e724sfUfNVriT991i/eDpc9aaqiZZ3FOeEOYyrqxuw
         mLaC58SOd3Y6XIwD9OJJUOdHk1tm/YJp2vXwcHw1bQ34Q2RTKwy/FRKAgm3b/u3CPllf
         pUDQ==
X-Gm-Message-State: AOAM533T7ZIDy75O9v+HpiFeinehAhcaA9G6X6bD/F6nnizAZCONIVwp
        GTZID9XX7Eb/EOgGThcGaXAbWCcOSi4ABaBdTwQWq+qn
X-Google-Smtp-Source: ABdhPJz4Vy450YvVYGuvqr+rdbkltl0y3u6RuF7ew5k1PfhrE4MGpYfdn5MSLqQN6O7JgWDu+IcqFWkwi3MmTn2qs1c=
X-Received: by 2002:a37:9bd7:: with SMTP id d206mr19733465qke.113.1592293031724;
 Tue, 16 Jun 2020 00:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local> <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
In-Reply-To: <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Tue, 16 Jun 2020 09:36:59 +0200
Message-ID: <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Cc:     konstantin@linuxfoundation.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        don@goodman-wilson.com, Git <git@vger.kernel.org>,
        msuchanek@suse.de, newren@gmail.com, philipoakley@iee.email,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 14 Jun 2020 at 20:24, S=C3=A9rgio Augusto Vianna
<sergio.a.vianna@gmail.com> wrote:
>
> Ok, can you show me a single instance where "master" was confusing or
> not descriptive enough?

A: "No you need to fetch master from the remote, then you need to
merge it to your local master and then push it to the master master".
B: "remote master, local master and master master. wtf kind of master is th=
at?"

Yves
