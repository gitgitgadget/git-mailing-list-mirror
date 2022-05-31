Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC10C433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 18:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346341AbiEaSSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 14:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiEaSSc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 14:18:32 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8D98CB3D
        for <git@vger.kernel.org>; Tue, 31 May 2022 11:18:31 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id u7-20020a170902e5c700b001621a781270so9262008plf.15
        for <git@vger.kernel.org>; Tue, 31 May 2022 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=q6KkiNAf429gsGo2orOYpTBhYCpHttUTLuWDO3sUxnE=;
        b=fL+DxM42fq7AsLVyIpS/nrosIj4Q25xXNUa05tzpIq8HAIqNoJf1sCumTOChSuPz+i
         fXFM6bBfPS/oQKu9hIWa3s/qH7mxOHEbfBBIE3fZ4aRwYqbbmsv6SS0t1Ml7bG2THPzI
         PtUGz/s3RExxX8Y/Q3Sh5yINFLmHGywdT0SQZwQonxNjhsVWTfT5J4kGIKGl1Ku2gEVK
         bCEc34clPRsg0/8t4tCNS8b1dldCD692cFtZ0FmyHApUXKTJBONmVTSXFu+liCOrdjR9
         PS2ks3JyQwoFPCXsMtTLvSY+SVXZFfO1Iy0p54e78GWg2WkxjRvW4Slq1ZCZePwXFtz0
         gzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=q6KkiNAf429gsGo2orOYpTBhYCpHttUTLuWDO3sUxnE=;
        b=gKtQsH9Au6Wtpv4GWnA8nz9v2E2S7XPppIFk6vUc3vSsaRcd/lJjGQP4QuIfZWUhBx
         kdd6KIiau5a3ZROuokHx4Wzi04PSD82YcTzvT7IH9UrTyZnkX3IbG+aDTi1elcMUjFSr
         qytV8bZNdnIeJj2BqpK09KvHp8lzahefkiBemDwtGXiv20AiU6w5Najoy4PrVidDmNPS
         JLbuLjaz+mfYe2PfIKPL5X90/NABBvQWbO3KN1pRDgVLIgtyIVICGSLco1YAmrc0fDm5
         GCIf7FUpAD1rUaGvOXYJMVTeUj58UfSUfd30Oz5lde8j4Unl3Uh0eGXBN6Dk6WKSETlu
         IF0A==
X-Gm-Message-State: AOAM532ZXVpPZ4LfkpzM4y8DhLIe1ncMxR7A9HECdXC4zoslyBGwsv+7
        //W1gla6ywyCqfEgz/DPmsKF4flhGUAvEg==
X-Google-Smtp-Source: ABdhPJzwJ9UMBNJLhqYjx6VfyyiidxEu93ikFzD21mXwBx64mUjQ90da+EaeKgzh+/3QUe1F2EUkHfoU7BLbqg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:230d:b0:4f6:ec4f:35ff with SMTP
 id h13-20020a056a00230d00b004f6ec4f35ffmr62606474pfh.53.1654021110604; Tue,
 31 May 2022 11:18:30 -0700 (PDT)
Date:   Tue, 31 May 2022 11:18:28 -0700
In-Reply-To: <patch-v2-2.6-2d0527f86dc-20220531T164806Z-avarab@gmail.com>
Message-Id: <kl6lr149efbf.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com> <patch-v2-2.6-2d0527f86dc-20220531T164806Z-avarab@gmail.com>
Subject: Re: [PATCH v2 2/6] usage.c: add a non-fatal bug() function to go with BUG()
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> +static void check_bug_if_BUG(void)
> +{
> +	if (!bug_called_must_BUG)
> +		return;
> +
> +	/* BUG_vfl() calls exit(), which calls us again */
> +	bug_called_must_BUG =3D 0;
> +	BUG("on exit(): had bug() call(s) in this process without explicit BUG_=
if_bug()");
> +}

Hm thinking out loud here, what if we set bug_called_must_BUG =3D 0 inside
of BUG()? Then we'd be guaranteed that BUG() will never infinitely
recurse.

Another benefit is that we can invoke bug() and follow up with BUG() to
unconditionally exit without a bogus warning "had bug() call(s) without
explicit BUG_if_bug()". This pattern could be useful for 6/6 [1], where
we no longer exit after printing the "BUG:" messages.

Just an idea :)

[1] https://lore.kernel.org/git/patch-v2-6.6-cbbe0276966-20220531T164806Z-a=
varab@gmail.com
