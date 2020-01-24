Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E198C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 17:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB8E2075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 17:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWZa/oxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbgAXRLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:11:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41964 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgAXRLW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 12:11:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so3281435ljc.8
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 09:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3ge44dF5sU8ckClnRehSAg+2zgEjJ5CCTY0tB9uIs9M=;
        b=XWZa/oxuKztb2PtxeXyR+p9FGQUHSXxnozRs0u2dHBL6yC+J0GWr0rOSV1YcHCRU9V
         YyRa9nlvBOjUamlrMEIeoYSJzOjJUFNO1qPEKolLcQdmeN2uhKXFfsC4D+wMFJfvMukV
         gPilpyTn59gjFHUQPmho0Scj+tGbq6w/4ERWp/6RQgMxeP6HCAJFUgFIIvQF/aVlzHFA
         g0qgpsE3OC0/Qopuyqb6M9qCP1l8g7zCWSDEVvEy58x0e9sJ704r6R2kaPiZiJQ2kdw8
         kf5uup8YOznMB3IhLi2mb8RU8d3dTsKcFWWysn0jOU8jAZPTt/m2Yq1mS8Ri4oUC4b62
         C/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3ge44dF5sU8ckClnRehSAg+2zgEjJ5CCTY0tB9uIs9M=;
        b=P7+XQecSk3P8UyCEkZI6GPpfTjMk+jnyM0uvPPYzy4WiJOpQVT7aujB6yH4IoRM/e/
         qOKzQ5N8Z13GY+19H86jPtA7LKobZf1qKsoWlPEof5HV2KSFkFtM7M7hfdnqe4Ss/WiN
         KOvTY7oVVtKXbUUsx2NUi+qAvxX5tjUS6s9jCjCbEhvZtA0qA6BVBhPJD6JxNOE67mHC
         ou0FphHeDl5qZ/jvWTEarQTTFAZaBavQ5wids62vGw+BxPTOPYMmbbKF17aNIarGhmMl
         VT2RYjLzjK1bFR4SVHVkMEjwA+KQd0ztFBtB+rIw/Cnw116dA9Q1jLca9wAZ8e2JzjOC
         ZE1Q==
X-Gm-Message-State: APjAAAX7jeOBSSvSVGKImLH6UJOx8pKondA8TiHWPxm3AJSfPvER/DxG
        XCABcDEzhZy7ifQEjuvO46wffZeiPjGIge8b
X-Google-Smtp-Source: APXvYqxZ9dMd7bsdfS3bpdxYA5sEyk3strw7Ke1XvHEeZkk8KjTV4TC+OWfPw59dPYliruL84rvDxA==
X-Received: by 2002:a05:651c:111a:: with SMTP id d26mr2813245ljo.153.1579885880535;
        Fri, 24 Jan 2020 09:11:20 -0800 (PST)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id v16sm3049388lfp.92.2020.01.24.09.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 09:11:19 -0800 (PST)
Subject: Re: [PATCH v2] rebase -i: stop checking out the tip of the branch to
 rebase
To:     Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200121191857.23047-1-alban.gruin@gmail.com>
 <20200124144545.12984-1-alban.gruin@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <71f3148f-22b2-d8f5-9db5-d17b56e022e9@gmail.com>
Date:   Fri, 24 Jan 2020 18:11:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124144545.12984-1-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-01-24 15:45, Alban Gruin wrote:
> Notes:
>     Changes since v1:
>     
>      - The first version of the commit message talked specifically about
>        `rebase -i', but this problem is common to all sequencer-based
>        rebases.  The first paragraph has been reworded to clear up the
>        confusion.

Would it make sense to update the subject line as well?
