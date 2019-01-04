Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 332C41F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 20:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfADUEY (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 15:04:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36124 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfADUEY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 15:04:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so2257910wmc.1
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 12:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZrY84luhrtesOOO/GjeC7njXzBmtrLc+WMM00n+dkLQ=;
        b=ZOqs3bqar8yD57ZCcaNNJSuOIwYdMNR9kP9NdmQN6eIDut2qzUKWAHFLk807MnLbTZ
         dyVaXTTA6tIQ520PsbUpjCQdOb3+pLQ31NZJazzBas11vylT69jeSuamxSeXLMjUcACn
         +FlIrLebSvC9y8ZTNtWl2qG59QElNX5CMKae3G1C+rSCdx6pDlQ5HFy67Vj/G8x1LLIO
         yQ7ruM+gm3atvIUsbMAmOkGac5Yq0odQfqKS8zs3F56Vp8Jx9dF/7WE90+iC5AU6nI8P
         5YHPQ0xTDWaTueDTELINNK5PX9UnR3sy0kOiU5lSWdSUss765SeoWLtVFtArylKlBXvt
         z/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZrY84luhrtesOOO/GjeC7njXzBmtrLc+WMM00n+dkLQ=;
        b=EhnVtGiHqIK5HHJOQpGqYcc08hep26Wy7rM31ZjQoB+up0nMnyfwD4IYC4I0yiI8uE
         +R4YuAwhrlqvYXDBAM/W2VmbY4DgxdRS/5cV1c8jsHPT+PDeFmFwlPszLgNura1DcJkI
         24jBF201S+K3hj3Bm+ADWMQlfc5JTNpqUkFubFy5dvclS8cr3WSvqSfWk2hgJVc5GQYg
         OYV3k0u5w+Dj1B3LvArc33sR2faQXdV/ff0olfsSeeStPAgwKjeJqoqJ2d/j2yvLfLJF
         q+ldgA0WENUJ/v6CrzicWH3YmX54/FcIbwtHREjitYTqeytc0jCbXmuE1YOOutHDBYC1
         ytWQ==
X-Gm-Message-State: AJcUukfWP6/VUJYWwGHHEHYc923kY/fggG/gNxsT3TypmXRNZ35qrOqa
        qbyHKaCNhBlgvjVBtwVZKGYRYcFD
X-Google-Smtp-Source: ALg8bN4OzzCHUK1sraRRSReVAQZwDQxaA0vhb4r7v2KBx3Nu9Ceve8NF6vGpmbNYP5mvp1tbbFHP/g==
X-Received: by 2002:a1c:b53:: with SMTP id 80mr2161551wml.121.1546632262453;
        Fri, 04 Jan 2019 12:04:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n9sm36872393wrx.80.2019.01.04.12.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 12:04:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Max Kirillov <max@max630.net>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] test-lib: check Bash version for '-x' without using shell arrays
References: <xmqqa7kjknwp.fsf@gitster-ct.c.googlers.com>
        <20190103114317.11523-1-szeder.dev@gmail.com>
        <xmqqa7khh4cw.fsf@gitster-ct.c.googlers.com>
        <20190104093015.GC4673@szeder.dev>
        <xmqq5zv4fyuy.fsf@gitster-ct.c.googlers.com>
        <20190104123819.GD4673@szeder.dev>
        <CAPUEspga6Kjv0pSYiD-BmZUCTf0rd=y0vneY_XvAkj_cCmXC8g@mail.gmail.com>
Date:   Fri, 04 Jan 2019 12:04:21 -0800
In-Reply-To: <CAPUEspga6Kjv0pSYiD-BmZUCTf0rd=y0vneY_XvAkj_cCmXC8g@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 4 Jan 2019 10:42:09 -0800")
Message-ID: <xmqqy380b35m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> v2 works fine, as expected

Thanks.
