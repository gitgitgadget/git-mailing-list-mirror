Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CBCC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 01:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiLQB63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 20:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiLQB6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 20:58:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FEF656C
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 17:58:23 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso4078855pjh.1
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 17:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adjAw+8Or+labSJe3OgxcCrLSxvGc7EYMrGPnJ4DZy4=;
        b=Q2hsbv3UqcgrY2PgyQ8GElSIS9HAk0Y4Nn9NVa+DbL8f5pKGuSOhuVACC4uC4n7Ybv
         HD62LneGfd8oo78PFIQBr22RW++SODW1R7PaeWDjJe0sNa5P7e0Yz9q8nVu+9tNSss7G
         5IU/kJjksHCYbPrbQzdQWPWUtCFzRtKF3J6WCyKilrOHTVlv5ac2gey4mJC7F5LS1Mp/
         njOY6U0DaCpiimP3yYWbY5+DiG2XHlHRoCSye93PnbjwFHQaTOeuHeHKxlolB3uSAdfD
         R9C0Gvn6/c6iPJvwjObFe3mAvVTJ101Q6nA215Pt9y9kDU0SOAsbk/PoKmqt7i6J6TDZ
         6cDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adjAw+8Or+labSJe3OgxcCrLSxvGc7EYMrGPnJ4DZy4=;
        b=UiiuqGy/5AAA03f6yY38Oo9c/8sdLshMtKwiercyGzV00GF/H9oRng5DT25aPhI7v/
         u436dDhahhnnm1vkRaT4c0EB4EZhP5r/TgsQkHVDJkG32rMM6EZ7oMcPhzzCjJWwzLGw
         TDF/f48SU+FAbScDzLsPJiv9BlBfn6hUcw5sC6HucTOZX4utWc86ZlxToWns1mB5FYgv
         H4tSyh+syeMsi6V2kI5/5KCRhtCGQ7zP/gyZwQ6lorDPfJds58zATYU6scaoMoxjP590
         FVBEei1UI4qCc1yHpeGS8FAQToq5k9xNMxG8IE0fNbt9akX1oUZXUbvD8SKWKXDY+YCx
         X95w==
X-Gm-Message-State: ANoB5plhX//Msu+ncFiQNkT8G3N+JMpPDCWBBANCqZdHRy7jYYDKohqz
        F3SFP2F3Och/POEHWeXzBUyQGjPcB3g=
X-Google-Smtp-Source: AA0mqf4c3FyjkjFpuUVinPLLM78PBqUzrdlM5zZlflLcJO92/vuyQSg+chGlsmU7d7EJ4zqvSyZnuQ==
X-Received: by 2002:a17:903:324f:b0:189:81a2:d616 with SMTP id ji15-20020a170903324f00b0018981a2d616mr29863810plb.16.1671242302604;
        Fri, 16 Dec 2022 17:58:22 -0800 (PST)
Received: from [192.168.43.80] (subs09a-223-255-225-69.three.co.id. [223.255.225.69])
        by smtp.gmail.com with ESMTPSA id o9-20020a170903210900b00186b138706fsm2294385ple.13.2022.12.16.17.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 17:58:22 -0800 (PST)
Message-ID: <ced6bacc-3d77-4d24-33f3-a93d2ae7a131@gmail.com>
Date:   Sat, 17 Dec 2022 08:58:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Strange "git stash pop" conflict (one chunk out of many)
Content-Language: en-US
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
References: <639B074B020000A100050792@gwsmtp.uni-regensburg.de>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <639B074B020000A100050792@gwsmtp.uni-regensburg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/15/22 18:38, Ulrich Windl wrote:
> Here is how the conflict looks (to me both variants seem identical):
> 
>         # pre-allocate translations and accesskeys
> <<<<<<< Updated upstream
>         foreach my $attr (LD_SEARCH_ATTR) {
>             $attr{$attr} = [translate_attr($attr), undef];
>             $attr{$attr}->[1] = add_access_key($aks, 0, $attr{$attr}->[0]);
>         }
>         foreach my $attr (LD_SEARCH_ATTR) {
> =======
>         foreach my $attr (LD_SEARCH_ATTR) {
>             $attr{$attr} = [translate_attr($attr), undef];
>             $attr{$attr}->[1] = add_access_key($aks, 0, $attr{$attr}->[0]);
>         }
>         foreach my $attr (LD_SEARCH_ATTR) {
>>>>>>>> Stashed changes
>             @n = (P_P_SRCH_ATTR . $attr, @{$attr{$attr}});
> 

Both sides are identical? You can freely choose either side...

-- 
An old man doll... just what I always wanted! - Clara

