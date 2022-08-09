Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB8BC00140
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 02:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiHICds (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 22:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHICdr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 22:33:47 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8C18E32
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 19:33:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f11so10208351pgj.7
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 19:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qqstm+B+DckagJpBTbE2wgbxM3YsBtcTDn8eXyXw270=;
        b=MfKDD3KQ7JurPdHUtMKB0NBxfO7qihzh2yLHsd+58yuXo9YdUqOnhgNEI640C/5qSd
         DWNjrxB7/gJQubs5SPlO5HbyqBi3T90BrUY2fELI3jHoBOo5D0MVTAaEBZ4Jjcxq351G
         PTu7KnfpmFvfU+sKvTUAsczlxWAge8AkYrYgjwAxlQGqq3Q8w5mwTJz5QDBD32sul/Gu
         W0w4wMev7ZlrO+qI9hrdTSKNyuniEgeYrg63wnmOJbbqkywtZyhRqOhEPn2ZnKMLrOTq
         CA5LCEKiMQXAQLo+wcG0C5EeRbXnygSd7fnwbYKcce06/JWU/Hq3hKzcghBxhJCPgLwW
         Xujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qqstm+B+DckagJpBTbE2wgbxM3YsBtcTDn8eXyXw270=;
        b=uhxbnjC+yXvH+pmJWLHra+Dh1HVMpoE1M2xTD3fianWTAwLpHxmHCPJFxKTh8W484B
         SqzgDMHMB7Mwnwe5pOQ+zsEpXJZeZ7+Ta3vDTPhmDdjdnKv9kBVdKsiFz9MgOwd/iV0E
         gx/ZKCVSoecNHyeDcddMxvnTsTAtbSSVYuZ9WXiGcH2996ujnkIqNRfhcMeT17upSaKi
         tesjF1pJ6jnmCs0zYRgHNyDEPAm7cNNRa3MoammC9F9VCHzzf0NabDV8Uk6xRKQYzfB+
         fIfzQ/Dg20VXCY5Uj93J5GcpxTHw3TrCYCk5eGQJ77OKz1PcrH28BV1FhlX3jVwYpT4E
         rj1g==
X-Gm-Message-State: ACgBeo3tE01eAzezdOYINp+ZpTuPR6++zwxFFkg9fAwkUpIp3bpcvcTx
        ArOv9iw2+qlcfAq4nv8Kzn1a8IBrx8Btlg==
X-Google-Smtp-Source: AA6agR6pSwwS/uoAvvjuOro1sPzznV5YFfG4faawaXQSddm2lmaRnWAlaCY3HcbKxFnUlls/VkJgQw==
X-Received: by 2002:a05:6a00:1d9c:b0:52e:e0cd:231a with SMTP id z28-20020a056a001d9c00b0052ee0cd231amr14270231pfw.19.1660012426379;
        Mon, 08 Aug 2022 19:33:46 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id z3-20020aa79f83000000b0052dc3796cc2sm173906pfr.164.2022.08.08.19.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 19:33:46 -0700 (PDT)
Message-ID: <1c8cbb48-cf62-8105-6ef9-19e9eabf1b80@gmail.com>
Date:   Tue, 9 Aug 2022 10:33:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/9] mv: free the *with_slash in check_dir_in_index()
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-4-shaoxuan.yuan02@gmail.com>
 <69039db2-e7b2-f006-63da-e699d302c8ce@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <69039db2-e7b2-f006-63da-e699d302c8ce@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/9/2022 7:41 AM, Victoria Dye wrote:
> Shaoxuan Yuan wrote:
>> *with_slash may be a malloc'd pointer, and when it is, free it.
> Super-nit: technically, `with_slash` (no `*`) is how you'd refer to the
> pointer. `*` is the dereference operator [1], so `*with_slash` has type
> `const char` and refers to the first character in the `with_slash` string.
>
> [1] https://en.wikipedia.org/wiki/Dereference_operator
Oh! Thanks, I was completely unaware. Will fix.

--
Thanks,
Shaoxuan
