Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C373BC433E0
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 12:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5FA22B4D
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 12:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ+mGxgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgGTMSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgGTMSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 08:18:14 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF727C061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 05:18:13 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b4so14939200qkn.11
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lpz48ng+dQvcdy8pInGemNnaFYdoDSu0QalxuIaXbLo=;
        b=mQ+mGxgfDbxIbV9qQw9MP0D6Yya66NpKdVS7PNROwZkQdot+HFCzc63ky74GilayHy
         k/J0JXwFlMB5QQYBjtnpaLgHOkzE1UqSbOUqRjm4kX3exbNYFYQY6sP1rQvNIYzBMQSC
         39jqyR5u2D2OF9qvIc9uTSnP8pI3RbVYQMcI+uL115ORB9xPEkrpDho/GLC9zgTWJ7D1
         E1D60pmMlEYZvnfzLrVoFK5ItaLB+ue3G9nFUNtVlim+OukQLc6vo33lMfDFnKL0yMjC
         rWWoieXzF+q4COWJ3D7LSWHRw1lFCz2GGI8w49KZEum+UlzzSuRiCa7gnAHe1SVciKA2
         +8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lpz48ng+dQvcdy8pInGemNnaFYdoDSu0QalxuIaXbLo=;
        b=sBKlBtYJY6ArtzY499XBXmSItU8hOiir/Wa5yi/du2Kskzy+QDbwttT0gqHH5JxTa4
         fJFoF3itCBXTKpFdYEfx9FrUcC7K5V6/3V6m0bZXDipciVNJelnc+iR4ULNdxhuOsFQw
         2rOK6zIMChYV9qm6ubIFtCLWXHiDzikhYpmq5RLqhtWQrG4T/n6PxQyG2NoaB5UlLNLO
         IaGAAG9oCixzCvy13DXQANCLxrpBj/G2cenWZSXhYcfc/VEyOXn7puST602nRyE9D/St
         JOh4Yhp3Eg/g9hg+qeZ4sXcn+ovxauDIK2k9OI8DCyZ3EmWSoIp/Llp9VY1ckqkgOupj
         O9lA==
X-Gm-Message-State: AOAM530pX4cOXZ7gI4GfKEtjaMPl9z/nycFdCfNj9peYMG3axKISWJWR
        aNaOW5uSs4Z4ZmOSs0vPyRo=
X-Google-Smtp-Source: ABdhPJz5ZBxzX/yyOyjj0lsQWfeJtyw75TH1twa+X2XC42ZvX22O6lQqZxuFPH+GBImdT3zhhT0kaA==
X-Received: by 2002:a37:6642:: with SMTP id a63mr21767723qkc.5.1595247492941;
        Mon, 20 Jul 2020 05:18:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:c181:e955:f180:d8ca? ([2600:1700:e72:80a0:c181:e955:f180:d8ca])
        by smtp.gmail.com with ESMTPSA id k194sm17057340qke.100.2020.07.20.05.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 05:18:12 -0700 (PDT)
Subject: Re: Pushing tag from a partial clone
To:     Son Luong Ngoc <sluongng@gmail.com>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <0DEFACA7-9D30-4DB1-9FDF-3E63945FAAB3@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3e68d3a1-01e6-4ce3-eee1-bc9fb07a1825@gmail.com>
Date:   Mon, 20 Jul 2020 08:18:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <0DEFACA7-9D30-4DB1-9FDF-3E63945FAAB3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/20/2020 7:44 AM, Son Luong Ngoc wrote:
> Hi folks,
> 
> At $day_job, we are trying to push tags to a repo from a partial clone copy.
> However it seems like this push would requires the partial clone copy to download more objects?
> Is this intended?
> 
> Reproduce:
> 
> 	mkdir repo && cd repo
> 	git init
> 	git remote add origin git@domain.com:path/repo.git
> 	git fetch --filter=tree:0 --no-tags --prune origin <commit-id>
> 	git sparse-checkout init --cone
> 	git checkout --force <commit-id>
> 	git tag -a sluongng-test -m "Test push from partial clone"
> 	git push HEAD:refs/tags/sluongng-test
> 	<git starts to download objects>
> 
> Ideally we would like to be able to push tag from a shallow + partial clone repo without 
> having to download extra objects if possible.
> We would like to keep the required repo to the absolute minimum.
> 	git fetch --depth 1 --filter=tree:0 --no-tags --prune origin <commit-id>
> 
> Creating and pushing tags should not require local repo to have trees/blobs in it?
> 
> Git version: 2.27.0

Could you try this again with 2.28.0-rc1? I think Jonathan
Tan added the "no-fetch" flag in more places since 2.27.0,
and this might already be fixed.

Thanks,
-Stolee

