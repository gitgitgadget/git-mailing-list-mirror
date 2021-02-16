Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EF1C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ADAB64DA5
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBPLqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhBPLoc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:44:32 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A99AC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:43:52 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id b16so6317367otq.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yETHy4nmybH3ELjj88KrY7QFVyXRmzCFGeIJJA4wNSg=;
        b=pV347WvsCWijRkQszg9PompUggMU+OIP23Mw2hqCmMtAS1d0wRHzemhzkjU5EqZzm2
         oJHa7azXZt2sebd5NUz2eiD7kWjlw5gDxRWLnVYhvbwbyaBl2sNX1QThLOJfUL2fayBP
         39+iJW8nrWZQvn6m4ceAWAvw5ipAoEcszyrQK9ZVXupx57h/x/cF8F6SEZpWWYoiPbma
         UDmS/gtv37JuJxN/zC4Tf3ev26Lyquw4ZqxZdgSURnY/JYmBW6uNBwNEkJ4H2Yfd8Ek2
         lTjAnZ868IpmGMuuDMpymdJjSFsv+9SgMgyGZ2UYstnuegXSflyjgAJbZmR4T6BUbuv5
         rmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yETHy4nmybH3ELjj88KrY7QFVyXRmzCFGeIJJA4wNSg=;
        b=FcBsS+Pn6suEXQjffjP61p/91vkuYCdzVPgXevJ6Gj37M5rXATA/AZunuPvn+XVeAu
         jLh82ca7NjH00PlK6+NApbrLvKVzE67d1mSgkNClIYFechIWSygUOrT9Ncz50opC0Pus
         ZzYlhgt2BuxfB91ZJTkb78rPxSXmIrcJI48113tWZt9/eMeC8DWdFR41zJOZX/6JfIuG
         36+FgKPRNySHYkzK4n7HXcuVt48Q/BSN6ZYAkT3uxlMQtWroM/PDuK27Y63LJUa+Sr12
         +an/FemBhVKWJiNbjN5Gm+Xk14WP2m4FQYbnVCT7rMSwjMPWnOCX5AFUFZ0OUA8slbH7
         mE8g==
X-Gm-Message-State: AOAM5313EC1xME+tb+B27dTl9zbdPcqdCZiSkvGr+cpTnIKLbbX5u1ru
        rJRJmmm8Vd4bQVBL/pf0/DY=
X-Google-Smtp-Source: ABdhPJwB632uX4+VB4ODoZuWQXujd5D6Vl6NKCKoAhSr4crrVwrvGZJSLN8JUiUKT3PLI3iterTcXw==
X-Received: by 2002:a05:6830:2099:: with SMTP id y25mr12330158otq.268.1613475831536;
        Tue, 16 Feb 2021 03:43:51 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:bccc:aed3:3481:8d68? ([2600:1700:e72:80a0:bccc:aed3:3481:8d68])
        by smtp.gmail.com with UTF8SMTPSA id i22sm2826942oie.24.2021.02.16.03.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 03:43:51 -0800 (PST)
Message-ID: <e54a532e-713c-f01e-cafe-a826230abdbf@gmail.com>
Date:   Tue, 16 Feb 2021 06:43:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 5/5] commit-graph: show usage on "commit-graph
 [write|verify] garbage"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        dstolee@microsoft.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        peff@peff.net
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-6-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20210215184118.11306-6-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2021 1:41 PM, Ævar Arnfjörð Bjarmason wrote:
>  test_expect_success 'usage' '
>  	test_expect_code 129 git commit-graph -h 2>err &&
> -	! grep error: err
> +	! grep error: err &&
> +	test_expect_code 129 git commit-graph write blah &&
> 	test_expect_code 129 git commit-graph write verify
>  '

This extension of the test justifies its existence, so ignore my earlier
comment about it being redundant.

Thanks,
-Stolee
