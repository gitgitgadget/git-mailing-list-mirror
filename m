Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FE8C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 13:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbiHDNW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 09:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239162AbiHDNWy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 09:22:54 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454C26544
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 06:22:52 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id s16so6295066ilp.3
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3ns8T//fQEZioP850bh7xmWuzW5ABlfjaWdX6VcNY0I=;
        b=DFne0GCSvg5y1jyGVcqOxnpKg5udkxFuwDM4EYVd9lM8mgk7DrP02FuANguntNzL8p
         bSyF9O7NEwRKIyNXk9az7P6pK77qOdZ6UTI6dZZr5a4e7FhlVEdPXSu5Nhi/vRRdrU5m
         SMSjskawUiO35shmlC8k7sUhQ/3HSpEJbv6LHx4gVOGwitWPSQc+4Je9cmZz/5uuEo1H
         ooZ9+75jnuxwXZoKoIJttGwWWrAw/frQkmrNtuYl5UABb33z0TRUaLX7RAQvr4K2It0Y
         DlgH1oOSvgtkPJmt6JaHr5ltYTLSArlZt9nvVzIAf9LntLVZhvVSSd5HZU5WdIDP1yAk
         oXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3ns8T//fQEZioP850bh7xmWuzW5ABlfjaWdX6VcNY0I=;
        b=l+WrY1yNB+Gl3Zl2EKxeC0DISFp+UceoxnjQtqKOiMEUSsOD+ne/+riMlgolxfWPnx
         W+Bm0IHPxG29ibEMg6+kaMNN4pi2dqQ8EXyVvXzqH0uDgxl2H/gmxt5jAxBDqzPZbFWY
         +FWKOjWov06FTLnbTQeY2u9t8b3a1OHVtKE3+acy33txM8SVqtlswMjX84nUrl666NM9
         rNQFaH9qa9oVOzQAyeKz74QXSfyQrgdjAjMCMEDNDQRk7e+Imf7d6n263qVnC6wKa7lO
         iSrRVfnt4lHup1JQn9pIibxlM7CAoMcJwSWVCScSIin4KXAkSekT/HczqBDIIznEccrI
         bTjg==
X-Gm-Message-State: ACgBeo3DL9/25we9LgqcKAxYEqVcC5pwWnDPML+IejQMsCrokR9bvWNg
        BhKmQCfcO3LKrMpIJH4eW8H6
X-Google-Smtp-Source: AA6agR42aoxTs3Zp3vSnaGRMF5yge3exs9/pDMa5yhhIWeUnydlmDu6Pbhecy7nWR80waRo9WlT9ag==
X-Received: by 2002:a92:ca47:0:b0:2de:a702:7a20 with SMTP id q7-20020a92ca47000000b002dea7027a20mr859608ilo.307.1659619372277;
        Thu, 04 Aug 2022 06:22:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id j19-20020a056e02125300b002dea1e18a94sm427852ilq.47.2022.08.04.06.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:22:51 -0700 (PDT)
Message-ID: <d5cc4280-3f17-ceec-ac96-97e896898a91@github.com>
Date:   Thu, 4 Aug 2022 09:22:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 01/10] refs: allow "HEAD" as decoration filter
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <c2e5a0b3a50237f3b7f5ceb5d05faa83fd41de68.1659122979.git.gitgitgadget@gmail.com>
 <xmqqedxxeued.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqedxxeued.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 2:03 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  	if (prefix) {
>>  		strbuf_addstr(&normalized_pattern, prefix);
>> -	}
>> -	else if (!starts_with(pattern, "refs/"))
>> +	} else if (!starts_with(pattern, "refs/") &&
>> +		   strcmp(pattern, "HEAD"))
> 
> Perhaps leave a needswork comment to remind us to later consider
> covering all the pseudorefs like MERGE_HEAD, CHERRY_PICK_HEAD etc.?

A comment is a good idea. We should leave it for later because it
would make a visible change from the user's perspective.

>>  		strbuf_addstr(&normalized_pattern, "refs/");
> 
> Style:
> 
> If you plan to add more code to the bodies of this if/elseif, then
> have {} around all arms.  Otherwise, let's lose the {} around the
> body of "if (prefix)".

Yes, thanks for the close eyes.

Thanks,
-Stolee
