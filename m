Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47071C4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A7B61373
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhHXKcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbhHXKcq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 06:32:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99270C061796
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 03:31:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so2036030pjt.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZrCJ35/GRD0zclS7HwGjmd9XS1HZrANSFdWT1W7kq1o=;
        b=ROYJSvKwh7r5zpz+U4C7Q7wMbuRx8FVncFeJH7oVxo9EhaGZ6sDxVajKl+J/20W/u+
         P3c8Oe+2DH27xiL+yBRwbN79FpLGifZ9XrEkt3Pz43/oo9BTO8qfR85ZkTmYFJCCvVB6
         xuXDl6af/gBksNaM0jeDwb7IYcdtZmzz2GAjIwTPiXPEEbseH8cM+KcF9PuqVaustl0t
         IyPfsKye4fUhfd9Md5bHb5/Mykw/PQQBVVXqINZ0n4lDU093cQS/gPVNLDS4IceFR63w
         anzcbFlIfqEBbyxzuS5IAco4Mtd6HYG4yX5jtewfTQzHgfYMyoGNzjYtzpNVEpt9t2Jg
         7qYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZrCJ35/GRD0zclS7HwGjmd9XS1HZrANSFdWT1W7kq1o=;
        b=pK6CIV3PCPnxkcEocSd8f6ePswWB/9zz/oo6wLiD/1SkE1BLIsDX+jUsmTRdG2XGX/
         TAfd5jVqD/oY6HfnANYeEv5JLDtw/3c/yvYAOh7+0VgaM0WyGT488QEaOZJoFIb0w2H/
         ESEdv6YwWeQWfoSWsgmghr4ix3NXBaLM87JtlvWbjE/rjXS36nusDNV1ltGnGsTqL63P
         NqVkuerhCbWZOsezbjMDDLSX4pnsP6rfl/SRwy5ge50F4bpTOOTokHk1VTOS8wDipNIm
         U1i/RuNW6aflLw4KUTMAFOMzZkTW96D52SVHpkKqwK5m4mi2nDAKYeGU/4LeVeTAd5zI
         pn3g==
X-Gm-Message-State: AOAM532jIcjFBuCuS4YWbpxPPQUnL6EEardd/BFG/eE4yzl09VEbNF0f
        PUfjUIxiDacunsI3xwe4nU+LFyDlI1E=
X-Google-Smtp-Source: ABdhPJxPIAW84UN6Imw7ERD++9N5SrIty7NYP3trNVaVqPTRrMBl9mlO2EV+BqfQd5cR0UI3NKUKIg==
X-Received: by 2002:a17:902:ab53:b029:12c:57a6:13ae with SMTP id ij19-20020a170902ab53b029012c57a613aemr32523312plb.53.1629801077256;
        Tue, 24 Aug 2021 03:31:17 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id i5sm1932067pjk.47.2021.08.24.03.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 03:31:16 -0700 (PDT)
Subject: Re: git log --encoding=HTML is not supported
To:     =?UTF-8?Q?Krzysztof_=c5=bbelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org
References: <9896630.2IqcCWsCYL@localhost.localdomain>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <22496693-cf63-a278-c85e-d9e4376e2a59@gmail.com>
Date:   Tue, 24 Aug 2021 17:31:14 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9896630.2IqcCWsCYL@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08/21 16.00, Krzysztof Żelechowski wrote:
> Co robiłeś/-aś zanim pojawił się błąd? (Kroki, aby odtworzyć problem)
> { git log --oneline --encoding=HTML stl_function.h; }
> 
> Co powinno się stać? (Oczekiwane zachowanie)
> 828176ba490 libstdc++: Improve doxygen comments in &lt;bits/stl_function.h>
> 
> Co stało się zamiast tego? (Rzeczywiste zachowanie)
> 828176ba490 libstdc++: Improve doxygen comments in <bits/stl_function.h>
> 
> Jaka jest różnica między tym, co powinno się stać, a tym, co się stało?
> Znak początku nazwy pliku jest interpretowany jako znak otwierający znacznik.
> 
> Inne cenne uwagi:
> Błąd u klienta:
> <URL: https://bugs.kde.org/show_bug.cgi?id=441255 >
> 
> Implementacja wtyczki:
>   "--pretty=format:
> <tr>
> <td><a href=\"rev:%h\">%h</a></td> <td>%ad</td> <td>%s</td> <td>%an</td>
> </tr>"
> 
> Podobne zgłoszenie:
> <URL: https://public-inbox.org/git/CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com/ >
> 
> Proponowane rozwiązanie:
> W odróżnieniu od omawianych powyżej trudności używaniem formatu wynikowego
> JSON, moim zdaniem w tym przypadku wystarczyłoby zakodować znaki [<] i [&]
> w treści w sposób odpowiedni dla HTML.
> (To rozwiązanie nie zakłada wykrywania i odrzucania znaków nieprawidłowych.)
> 
> [Informacje o systemie]
> wersja gita:
> git version 2.32.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.13.12-1-default #1 SMP Wed Aug 18 08:01:38 UTC 2021 (999e604)
> x86_64
> informacje o kompilacji: gnuc: 11.1
> informacje o bibliotece libc: glibc: 2.33
> $SHELL (typically, interactive shell): /bin/bash
> 
> 
> [Włączone skrypty Gita]
> 
> 
> 

Please speak English here (in other words, re-submit git-bugreport 
without l10n).

-- 
An old man doll... just what I always wanted! - Clara
