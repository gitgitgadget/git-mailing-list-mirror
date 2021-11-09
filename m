Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974CDC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 01:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8089061104
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 01:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbhKIBoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 20:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhKIBoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 20:44:09 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD046C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 17:41:23 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id h23so19041737ila.4
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 17:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BOM3BRh2yzCl7W3TvRCukbi3/DSlTbKYXfL+HZQi1zE=;
        b=fVuoZ/BCNNn0UUOTIJwYWZAJ1gFww1fAAHPYkxZzxDR2GPDrII2kJOhJGc/LMRIFX2
         o8V9czj/vUbR3R0QANGaw58tJTKPfGFnPyIbZ/a7r4xjh6Qu7cm0c0HFIgkfABzYI1fW
         rRGiXUgAO/9v668HLXA2w9sPx40mKYUJ2gSkj4TbNEeOXZzEL2xkckY4ckBus0vzrFNQ
         YgOWajNr+iCSJak3RsjNt7bJx7ZMcs3KLyWfcQr3K/cLWFH27vaEDJSAGhzv42M8dP+r
         kEZm7Ux7Iw5DMLh157p6wlEGRlULn8GqeA7//JvhC7zErN6R0wLJTaJDMl4xw5fbdwEf
         HaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BOM3BRh2yzCl7W3TvRCukbi3/DSlTbKYXfL+HZQi1zE=;
        b=wLB1ftdhoZq0TjQuHJhKgnYXjzTCLJSla0F8GFjZeamCdjWP1qvmYn7F+6hl0PScWu
         MouY2tRa40eg2+Yns3pH20srul4Xq4YhGGjAu1apTqZ+rlA09aPL+qDaRd7eLFkTaZH9
         cUZ/n08IU+EAhRD9y4+0QV3wZjFnO7xmL9fFfEm5pndT9n/vNPop0++pF6QyxbZCWSyl
         FnrHTC7e2aM6xnooOM/NALobmS4R46zbXzORbhx2JGzKCs8VYqLCHLOxX0rO7rVBEVgc
         0v5NW6uYoBQmeV4EGXIZFH7doP0laAH3hq/VNufRDtlPAO43LpKuORR1YBWabGoDZU+2
         eMKQ==
X-Gm-Message-State: AOAM530lJX28bya4tHHngUXRj9eogzpAq+GyG+vy5VYb2bqXiYf7eNhB
        +SfBNbkOJUpb1ypJl5iMatY=
X-Google-Smtp-Source: ABdhPJx08n1Cb+QorKZ7UnIz+IRrdz96m8OS0JGkA9SmhkyI7jfz938ty8W0QVrtHRJd7eyk1tB7yg==
X-Received: by 2002:a05:6e02:148d:: with SMTP id n13mr2630426ilk.100.1636422083104;
        Mon, 08 Nov 2021 17:41:23 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e431:4a0d:99ff:9e5b? ([2600:1700:e72:80a0:e431:4a0d:99ff:9e5b])
        by smtp.gmail.com with ESMTPSA id w5sm11440560ilv.83.2021.11.08.17.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 17:41:22 -0800 (PST)
Message-ID: <defd82c5-a197-d52e-8386-c54d7d8e0770@gmail.com>
Date:   Mon, 8 Nov 2021 20:41:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [ANNOUNCE] Git v2.34.0-rc1
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     git-packagers@googlegroups.com
References: <xmqqsfwc4yne.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqsfwc4yne.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/2021 7:17 PM, Junio C Hamano wrote:
>  * Drop "git sparse-index" from the list of common commands.
>    (merge 6a9a50a8af sg/sparse-index-not-that-common-a-command later to maint).
Late correction for the release notes: this should be

  * Drop "git sparse-checkout" from the list of common commands.

It's confusing because 6a9a50a8af (command-list.txt: remove 'sparse-index'
from main help, 2021-10-24) is the source of the typo and I didn't catch
it, either.

Thanks,
-Stolee
