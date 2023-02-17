Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04380C636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 21:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBQVo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBQVo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 16:44:56 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FE95356E
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:44:54 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id k15so798083ilv.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxVgS5e3RaVQUKIABohyxk92lM9N51gFW/fDq0m5AjM=;
        b=TD4EUEAP4rdsL+lw+82FFPD7eY5xDkd8JYeUvVyc1MPjlxtesqqvB4Q2bt+eR+D2/h
         auTD5eZQUB1C9b21g5H+OuNCNJarUQZ0mRIXURDx4eKlB39Y0/6VZOpEB293ygC7av2D
         noq726rECeveDyzyfam960YdT0aOeFL/0Pknvay+ZBbULke9WKZY6gtKWPYgY+0ZfQeb
         GuEREe5wx+j8sVclqsGdpDNdLJIEO/LCkA2BXBKBWaN7ygVI9oMuEOvjcL4wk6awWAFk
         4n/+gOPzGXWSagHu5CMV3yxm9zxUE0gTS6YUek9+LkTLelmWg4/mI6HQE2Wi1vd+ml+p
         AteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxVgS5e3RaVQUKIABohyxk92lM9N51gFW/fDq0m5AjM=;
        b=5inJdMnyJR9187JAiCtFDFBjFmkTeOc6HYoceI7BVQsBagftJuromCtRyeqKrR9qrM
         gw8U4/VyhcWH0UV3pv3XbdNuoeW3kbFZpq5K0mKoQoXAZAvFQIeV1Q6NhWH52vTNVs2Z
         AusEyRWTKkCBx4mR5fKcFA0UarXua9AdNDhIlXGmd+3mRDtiqYTFkM7wKNRQq6vEP8uk
         R2xPMoChLoX8BTw5HbVaMQTpCkZplr0Av6OghKbwIhJp8qvAgZ9ZRBE4D/Q3lUUSQtnA
         TrPJPULcGZ3hnTpR2nfazD+hJI2lC0UMl/JeCSqAsl6TbAIjdh4xMGVRK3SDU7i0kwFK
         itPA==
X-Gm-Message-State: AO0yUKXh69XX1yX93bOwnccFl2Fn9C5T2jvohkhOeYRvXTc4ov3NFiCS
        fpnTSarW7mMgAATsKnzGCVQFWrlftBc=
X-Google-Smtp-Source: AK7set/p53RYyv8GTugazkDQ/wMbYehI6AEf0V9CXqt8uT5e6cHklUeTBi1E9eE6+aFa9weBF88CgA==
X-Received: by 2002:a05:6e02:164b:b0:315:7004:3e6a with SMTP id v11-20020a056e02164b00b0031570043e6amr1551637ilu.21.1676670294309;
        Fri, 17 Feb 2023 13:44:54 -0800 (PST)
Received: from [192.168.0.13] (97-118-197-38.hlrn.qwest.net. [97.118.197.38])
        by smtp.gmail.com with ESMTPSA id cu3-20020a05663848c300b00363362cd476sm1792753jab.101.2023.02.17.13.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 13:44:53 -0800 (PST)
Message-ID: <85ab572a-cd00-f62a-97ab-f344e2b6f68e@gmail.com>
Date:   Fri, 17 Feb 2023 14:44:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3] credential: new attribute password_expiry_utc
Content-Language: en-US
To:     M Hickford <mirth.hickford@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Cheetham <mjcheetham@outlook.com>
References: <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
 <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com>
 <xmqqmt5h80s8.fsf@gitster.g>
 <CAGJzqs=t7k2zRKKq9xN-Avbo2uXgqsg7i0Utfv-ee6yZ2CWNDA@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CAGJzqs=t7k2zRKKq9xN-Avbo2uXgqsg7i0Utfv-ee6yZ2CWNDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/14/23 3:36 PM, M Hickford wrote:
> Curious, let me take a look. I see that the tests failed on freebsd too.
> 
I was curious about this as well and took a look on my Windows machine. It
appears that errno will be set to 'No such file or directory' unless you
explicitly set it before checking it. This is odd, given that the helper script
I wrote worked just fine without this requirement. However, I took a look
through the rest of the codebase and noticed that `errno = 0` seems to always be
declared before this type of conditional check. That did indeed fix the issue -
tests all pass on Windows with this patch. I have not confirmed on freebsd,
though, as a heads up.

Thanks,
Lessley

---

diff --git a/credential.c b/credential.c
index d3e1bf7a67..b9a9a1d7b1 100644
--- a/credential.c
+++ b/credential.c
@@ -236,6 +236,7 @@ int credential_read(struct credential *c, FILE *fp)
                         free(c->path);
                         c->path = xstrdup(value);
                 } else if (!strcmp(key, "password_expiry_utc")) {
+                       errno = 0;
                         c->password_expiry_utc = parse_timestamp(value, NULL, 10);
                         if (c->password_expiry_utc == 0 || errno)
                                 c->password_expiry_utc = TIME_MAX;


