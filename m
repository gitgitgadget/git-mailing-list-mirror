Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C85C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 07:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhKWHoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 02:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbhKWHoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 02:44:09 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E55C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 23:41:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso2202775pjb.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 23:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zTsTf6PgxAzdbE0zhXJxclNfm9nvY9ojWHi3NRjoFTs=;
        b=Cu5BaMrmVjGiWL1uxitrqy+/7T9zyGpPXuR09cCuR9MmyL7z/utxZaEqkaVJwWPL9E
         VhAG5iKDJbcxj+pF5ryc7k9QFNFVjSsiL6is6uCeMAz8vwUAid5r1fFAX77xdGoXCfv6
         vDlDWo5QaeU0jaqeKcOpgzZYmSje+wA0gjH4WlMXgICzfzLTKDIht65+Yw/TsQ8cJz9a
         J7xwbQguKRRaxYqFgY7f4CcN+PU4SrEzqoI8G838zYLKz9yFONYUeWEFIBovfwhrQ20n
         dI+8iQtN5SvRMm0n+8lsZHvw0OMuK3u47CZIFBPzn+SGcAo3r4SwhDUFqm1aaLz6obIk
         Pxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zTsTf6PgxAzdbE0zhXJxclNfm9nvY9ojWHi3NRjoFTs=;
        b=azbHNCUZXW0XqbMP5k+zhSYih1KIdIoSZefpTNwASFpM9KFUXuOq0wVUhTM7Z3eGxT
         71aiGLKQCj1vT8bjr0+svV0auTfnd+RO5hZf3lWFICYSz+i7CmuwwhFM5Cx6cjq02hxy
         njTn5pIY/pTOlngNrjOE5xyVW7ok5meiKucvHJCPQLLDiYZrdcX99ZCsGbnPjEJWgGuB
         y74Kckrf9ZaThKdi6hn0l+fLsevw5sxK+CAza4TJZFdwwragf9IzWhHwK3N2Pk8tw8Ts
         a5Iu9cKEXo++kwlNheaKz+UlVw4GnCoPXXU5PeoCX8aAo5dAUm2Q8lPNMEwlehM1QPGj
         fDyA==
X-Gm-Message-State: AOAM531a3XFr03OiNoVsDtoUxs8Xz0FgJ+XUInBJ439I5RkWAhOITo92
        dRMOuuZ/U7kOLB4pXCynBjQ=
X-Google-Smtp-Source: ABdhPJxOjKKWvp50xMe022QlP2pm+r/hUaWzNLsFCCVN3s9DgvgPe2pZ3F28O098g/rb4f9JpbxjRA==
X-Received: by 2002:a17:902:c7c2:b0:143:bdf7:1670 with SMTP id r2-20020a170902c7c200b00143bdf71670mr4380289pla.61.1637653261229;
        Mon, 22 Nov 2021 23:41:01 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-11.three.co.id. [180.214.233.11])
        by smtp.gmail.com with ESMTPSA id k22sm10908574pfi.149.2021.11.22.23.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 23:41:00 -0800 (PST)
Message-ID: <3ff61d01-ddd1-6b67-d8cb-4bd22736738e@gmail.com>
Date:   Tue, 23 Nov 2021 14:40:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/4] show-branch: show reflog message
Content-Language: en-US
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <fd2595d370a8a257c44693fdc98194cd8447e22a.1637590855.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <fd2595d370a8a257c44693fdc98194cd8447e22a.1637590855.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/21 21.20, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> Before, --reflog option would look for '\t' in the reflog message. As refs.c
> already parses the reflog line, the '\t' was never found, and show-branch
> --reflog would always say "(none)" as reflog message
> 
> Add test.
> 

Add what the test?

> +# arbitrary reference time: 2009-08-30 19:20:00
> +GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
> +

Why don't you use oneliner `export GIT_TEST_DATE_NOW=1251660000`?

-- 
An old man doll... just what I always wanted! - Clara
