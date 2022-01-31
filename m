Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B815C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 11:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350277AbiAaL6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 06:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378428AbiAaL5y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 06:57:54 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EBDC061758
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 03:44:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k17so12178336plk.0
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 03:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=koXjC0gDIiRh07Ww2Hd8/5Q3UswMlefuUz9tayYpRU4=;
        b=cQCG6PYkeqzE7aqofQgqffemhrjYeLbNJ5uidh5MwJ+hWf1cWyLk9heV40wD9GDBsi
         IFdcyl2mt3upO0udKGbLEHe8esmd+6I5rujFZIC0ONqoaPd0B6Q+EVzhbC+gbpc4SJB7
         pk4pOQ/NFUL2UbY4ZIU0z0l1BPb85uJ7Z47Lg5zLFl4v3SF7PbEt3qQtUf2DnyQR3IdM
         07pees+Emd+6fAIO6DlrAo0yqLNEOtkUepFtZ+wr8pLEwIxDg4eL97/snPQ3yPa7pWP7
         9E5UPVBD97dvmEqBuBiR6IsiZa8XBYrGHoeyP3887dFpPkNa0l47K6YmcLXfFVBIoBvZ
         ciFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=koXjC0gDIiRh07Ww2Hd8/5Q3UswMlefuUz9tayYpRU4=;
        b=DrZAlK7aSqbp46QtN33YMzl54xn+ivoXcFphATtfUOqKVabhY/s0SQVkhbI/4yMZ7H
         YK/VuQkBWXk074Tuehr+Hhdxx1va3NLPN/B1out21nfT++F6wmVgUNa7z4ZyVguHww9u
         mvj3dztX+bB336naoUdWk4yhSojwNdd2NympZexXfDEmVQKIV9JcYRaMYMe2Znxeuwt4
         yjL1pbMOjrocA9RFc6+GcwETCoFKW8nZtdWTHuKMKbbeCZnPIJd5kEAZIgk7QM6bkzIA
         JpZDB5zujrAle+kz88PKPyJL5cFEewoJZGzoJsVLnBAB74DTj2T3bLH5BMk6kNXW+DE3
         mhhQ==
X-Gm-Message-State: AOAM531vNomDG3hn0HeImmsjYrISloxBpeb/qnlS+iYgDgfySLeXLvKR
        H4Tl9UsmlVdYRCxrg3PwRuQ=
X-Google-Smtp-Source: ABdhPJz3kckzXaBZOn6CxnOJj8MB2AMR8u049P2aivLI4q0rf6C4JY89QyJp4oS6sajM5tHBaeCm1Q==
X-Received: by 2002:a17:902:e5c2:: with SMTP id u2mr20347725plf.33.1643629467548;
        Mon, 31 Jan 2022 03:44:27 -0800 (PST)
Received: from [192.168.43.80] (subs09a-223-255-225-67.three.co.id. [223.255.225.67])
        by smtp.gmail.com with ESMTPSA id x7sm28577301pgr.87.2022.01.31.03.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 03:44:27 -0800 (PST)
Message-ID: <56f851f3-946b-0524-1643-25799ef46b55@gmail.com>
Date:   Mon, 31 Jan 2022 18:44:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC v3] cat-file: add a --stdin-cmd mode
Content-Language: en-US
To:     John Cai <johncai86@gmail.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, me@ttaylorr.com, phillip.wood123@gmail.com,
        e@80x24.org
References: <20220128183319.43496-1-johncai86@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220128183319.43496-1-johncai86@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/01/22 01.33, John Cai wrote:
> Future improvements:
> - a non-trivial part of "cat-file --batch" time is spent
> on parsing its argument and seeing if it's a revision, ref etc. So we
> could add a command that only accepts a full-length 40
> character SHA-1.

I think the full hash is actually revision name.

-- 
An old man doll... just what I always wanted! - Clara
