Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FFBC5519F
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 20:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EA9221EB
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 20:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhOpLG2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbgK0Uoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 15:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732617AbgK0Un0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 15:43:26 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94001C0613D1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 12:43:14 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id d9so7156107oib.3
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 12:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/2B809KrPiHp4B0MnmK7vIQLvFAjDPTqwrDGYmWDXZE=;
        b=XhOpLG2QT9Z9jM7riqxAmo/La//gQNJx/GBGFC9kcgZB3DLYoKYF/kFE2Jh83qehqv
         cjMCl7n/5NjbPLrgQQHv2hNh+GxKyWr4HquDlc2REAHiVvUTV/2e9JJ5yciyj3jvV81U
         e5ElwOyouVWn+Wk9sfpKu9dNkxRsm6kjSCnbjWAUcXyZ7Qnw+roTU6NnKkDAc2QD2Gpk
         wcOm/e1Ov4WmEu7L2DzdfEaqE8C+OPq4GyPh7RktyQlHf11w79wPwHwnFFoN+4lwK5zn
         GksW8rrgek5Il6zZFibuODxleEDieSjVSLjj/Q4+bEavDU+CJTqYxLkKzW4l4kfF1OfX
         cz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/2B809KrPiHp4B0MnmK7vIQLvFAjDPTqwrDGYmWDXZE=;
        b=GLe0ZzvvAaUTmCuanvUU3LnoAqrpgxdtK4VKm8UdYUnHOxoDryWHVYsDBudHgWlgT5
         6FUKBwOOQssj0jvVOtY/YP604WK9k89FuE9s+7eu5ng5glrPa+qB223EruXFDxJW0lm0
         HgKXz2eG9tNDHp6zwzEBwMnUikZnT+As/3KENgwLq8Xx2yF67qn1i2bYmGbPMYWjgb3L
         DpHDwB7xnx9tECvtpElQtCnQpFb4HKwLm2R3yh0VEgHMpGoCQutI8PqMUtn8rfurKMwN
         Ug/dDMZxUaUGibEAEdEpmQYBSJ4Va2S3zKGU8zz2uYDrc16CSbx+UHrgz7keljRw9u2U
         IIvA==
X-Gm-Message-State: AOAM531KQWLq+ELN1kCyxzXHE5y1/17H/Ioic0CJc4fyUBYbHMRN2Xi/
        S6hnIYfV4R1IgsIxnldtTJc=
X-Google-Smtp-Source: ABdhPJxuihOcIAkx1HhHpzcBEBYyNC3iFALyQS2Xy/dMfv74I6stG5PgIjIf9rs7x13OMDHc2/1lBQ==
X-Received: by 2002:aca:1b0a:: with SMTP id b10mr6625266oib.9.1606509793906;
        Fri, 27 Nov 2020 12:43:13 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id b23sm5744491ooa.13.2020.11.27.12.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 12:43:12 -0800 (PST)
Subject: Re: [PATCH v2 1/1] maintenance: fix SEGFAULT when no repository
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201126204141.1438-1-rafaeloliveira.cs@gmail.com>
 <20201126204141.1438-2-rafaeloliveira.cs@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <712ca8f7-c936-e03c-cbb9-4a0432fc3131@gmail.com>
Date:   Fri, 27 Nov 2020 15:43:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201126204141.1438-2-rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/26/2020 3:41 PM, Rafael Silva wrote:
> The "git maintenance run" and "git maintenance start/stop" commands
> holds a file-based lock at the .git/maintenance.lock and
> .git/schedule.lock respectively. These locks are used to ensure only
> one maintenance process is executed at the time as both operations
> involves writing data into the git repository.
> 
> The path to the lock file is built using
> "the_repository->objects->odb->path" that results in SEGFAULT when we
> have no repository available as "the_repository->objects->odb" is
> set to NULL.
> 
> Let's teach maintenance command to use RUN_SETUP option that will
> provide the validation and fail when running outside of a repository.
> Hence fixing the SEGFAULT for all three operations and making the
> behaviour consistent across all subcommands.
> 
> Setting the RUN_SETUP also provides the same protection for all
> subcommands given that the "register" and "unregister" also requires to
> be executed inside a repository.
> 
> Furthermore let's remove the local validation implemented by the
> "register" and "unregister" as this will not be required anymore with
> the new option.

Thank you for this very clean patch!

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

