Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23778C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 15:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbiGSPm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiGSPm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 11:42:58 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF0F4D81C
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:42:57 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o16-20020a9d4110000000b0061cac66bd6dso3499305ote.11
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h0A+pUSJEBsKtzP1me6+ycnWr9dMUo3OLjVxgex4Fnc=;
        b=P11kGSTxj4WZR2HD4CxVCvbARDqetYN3Gb3hvg+BIrLitd0Q06M7Dr93eEE7RmRJ0O
         cW4LH2kX8hsb7krkBNOnwWB9PYA7QeUe3GSmWVx3ECXe6Rhh8wlUurxAb78jWhOnjyiT
         JGLWnKipoqb5VBSXARDXAE2nVnT9fX8dkcfN0RMyGdpJjF5geSxjNgGN0e9dPxTBAvjy
         9dHPUQNiUL6x1Np9XNCdlDCocQBqPJFqviGXO2FxT26CAArJYXeIxvCkQZwIKYrzih05
         btPR+VjJ1cdd/i4Zo7oNUXKOZwGjos8JE5Hxecl/rUkrikMRJ/6WjtmQZgd5Z/nXJaPK
         ZMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h0A+pUSJEBsKtzP1me6+ycnWr9dMUo3OLjVxgex4Fnc=;
        b=iGNtQZc7v5FA0lHSOKfDvDYq6sqZ5e+SUa/5ODZTIRwlkcgFeToMaaE8U8mvNMzcD4
         vGaID4/8UhIxwvfW5WNz/T1S9QkQiUNcYa6YzrOPBZcfq5E8ZhpTe2pAPu1m2PKkCMB8
         OOd87ncRr9pbrTZ8z66sDK6PW4uDm4szK3HeUvwsKiYBJysDv3YY8e54bMv5o41ajv+S
         ZmIHyC9B6VJI8qxJ9obcdOwPeD3DDw++aFwho4pryzMhlMQk+6/Z7hiMFoaZS9XHiqSx
         nooU8ggCeZU0QL11rc/BgUrbSErEF405P7711xbio+dpPVX+VbRf461d26nq8CWLbszB
         dIzQ==
X-Gm-Message-State: AJIora/G4/cSNpj6PqMiRfu3IjOYsf3+KtxfMUCEvR6YFlXCeOqceh8V
        plIzqvcGn7S8unzTtDazMhVi
X-Google-Smtp-Source: AGRyM1uHPl+J7CMf55vboG+6GvIWGc8rZQu5gbhXVkFptOC4ZQJPuwxjMXTkzXqsL5YbaqOvYgotzA==
X-Received: by 2002:a05:6830:d81:b0:616:c424:6f22 with SMTP id bv1-20020a0568300d8100b00616c4246f22mr13630221otb.77.1658245377058;
        Tue, 19 Jul 2022 08:42:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id p83-20020acad856000000b0033a4a58fa19sm4733042oig.22.2022.07.19.08.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 08:42:56 -0700 (PDT)
Message-ID: <0c2fc2be-3d63-8df1-2113-bb2229f6d05e@github.com>
Date:   Tue, 19 Jul 2022 11:42:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] t/*: avoid "whitelist"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
 <3c3c8c20bcb4e570d25a676ad1f29877762adb82.1657852722.git.gitgitgadget@gmail.com>
 <220715.86o7xqzkt3.gmgdl@evledraar.gmail.com>
 <75cc0f43-d9a5-45d3-5e36-dd20acfebf50@github.com>
 <220719.86lespun6l.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220719.86lespun6l.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 11:26 AM, Ævar Arnfjörð Bjarmason wrote:
> Anyway, do you mind if this part is dropped from this series?
> 
> I have a set of patches I was meaning to submit to add a tri-state
> [false,true,check] support for this, which this conflicts with.
> 
> "check" being a mode where we check that the tests in "false" aren't yet
> passing. So for that I'll need to re-word this whole thing anyway. I'll
> rephrase this while I'm at it to something I think you'll be OK with.

I had just split the changes regarding SANITIZE=leak into its own
patch, so it will be easy for me to drop it from my series. Thanks
for working on it.

Thanks,
-Stolee
