Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B76BC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 13:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLTNvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 08:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiLTNvN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 08:51:13 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC2519282
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:51:11 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id kh23so217149qvb.11
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b625hwBoZN26B0/Tq+mpUtpzAsZutiAtaOU9SNg5dcI=;
        b=eA442wkEZWte3vAHGnfa7Y+NwKNi4aMfUqId6gDtuALrTpQBTLakZjH6mCwI39/zut
         LYQbFR2HdeesInTfHTOYLTcZT0bLV1nyMbgsZSlqDLOLnwtiOCFFATXqflc1fhT/dsGk
         4PGyKiani0gPtB3l06DeV23Ne2QqCgaf1s9TJpupUOyl2sPmmDO9hZiGN/SzRAxY3yxR
         2t5UqE32tt3Bd65EidN8H6O3cK+DvNUq5FpQ8wvSsvPPOOBzFsw9iNYMaa1siMYmxZ+0
         pgQUsFPwi1NL2g8Nl53UsVjIkIntcEoJNppPizjjSz9P09xrf5wns2fYUajmxSRBUvEk
         fclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b625hwBoZN26B0/Tq+mpUtpzAsZutiAtaOU9SNg5dcI=;
        b=DivfgGar0m1EeGnIE0bVasAnaMuz39UY6YanIrhrbXtCWRQCxtOJPX3naQMdGBj9DK
         amiT+zYozjTlTWZdt/4qZcM2lS4OK4NOfqvDlK6b9pbxmfOJRG/71JXLOIkwUxXAZRPz
         6WpmOKoYz4/FsMfsWIhMm4MnNWCMa2WVOuLSFtqL8iX7AciKGkEf/2cJ4CPRJwppRZ2v
         yXz8apMRR1kcVQ3lSR6A4Dm7Mdk88oRHMcYQhAPhgLoAlALrL+tkbuK9J1u05o8/WdIE
         jlrduVtVNB5M7WL9Uc/hTqxrg2KTT0CszWs201VPyRyfrIu7IRqrMHskz5CzBQ8dTY6k
         mcEQ==
X-Gm-Message-State: ANoB5pmNxr6OlEkklf5A9ayH9JfMXrBYR+3OZ5Dh78I9skNgOswMY54q
        n/PsJCy4hBpKr3aICuFQ+ws0
X-Google-Smtp-Source: AA0mqf7LIlKwa1aDwSzVUm3G5Ii2YyJZIAe54HB9Lrb3FGGf26g7OymEAX9LMUcSaBwgSQGCi9hepA==
X-Received: by 2002:a0c:f70a:0:b0:4c7:26a4:9099 with SMTP id w10-20020a0cf70a000000b004c726a49099mr55235232qvn.52.1671544270296;
        Tue, 20 Dec 2022 05:51:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:6103:2a44:3e02:702f? ([2600:1700:e72:80a0:6103:2a44:3e02:702f])
        by smtp.gmail.com with ESMTPSA id 195-20020a370ccc000000b006fec1c0754csm8787305qkm.87.2022.12.20.05.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 05:51:09 -0800 (PST)
Message-ID: <de1aca07-dd03-3f46-9f56-1cc7616b573a@github.com>
Date:   Tue, 20 Dec 2022 08:51:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 3/3] bundle-uri: remove GIT_TEST_BUNDLE_URI env variable
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, vdye@github.com,
        gitster@pobox.com
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
 <aafee168fbae2a1887f53febc4abd15522b12bc2.1670866407.git.gitgitgadget@gmail.com>
 <221219.86len3zlqj.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221219.86len3zlqj.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19/22 6:09 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 12 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The GIT_TEST_BUNDLE_URI environment variable is used in the t573* suite
>> of tests that consume the bundle URIs advertised by the Git server. This
>> variable is equivalent to setting transfer.bundleURI=true, so we can do
>> that in these tests instead.
> 
> I think this is probably OK. I can't remember why I added both the env
> variable and the setting in what became 0ef961dda05 (bundle-uri client:
> add boolean transfer.bundleURI setting, 2022-12-05).
> 
> But I think this commit message really doesn't explain why it's OK to
> remove it. In general we do have GIT_TEST_* settings that duplicate
> config, e.g. GIT_TEST_PROTOCOL_VERSION.
> 
> We do so because we'd like the environment variable to override the
> setting, or the other way around (I think depending on the GIT_TEST_*
> variable it's either-or, it's a mess).

If the variable is named GIT_TEST_* then it should be intended for
use within tests. However, it provides _no value_ over the existing
config option, so the tests are updated to use the config value
instead.

As mentioned, the one exception is where we don't want to uddate
every test to use the config variable and instead want to set the
GIT_TEST_* variable across all tests and see how it interacts with
other tests. However, _as mentioned in the commit message_ this
variable would not have any effect in other tests because the
advertisement depends on other config options on the server side.

Thanks,
-Stolee
