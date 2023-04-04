Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D35C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 13:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjDDNai (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 09:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjDDNag (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 09:30:36 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5988D358B
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 06:30:34 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w13so12813777oik.2
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680615033;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Dp5pAZeAhl6Dlb996jYKEzkjfchLLr1AyPpbuRPgDw=;
        b=f7xzAycoYYxR0LRVNhOuPX4T0SzCghUO46OAL99PyGqC3aloobFL44REoIjZH/vPn4
         dOxk1pJXXEi2uqD7zlRAi5UygBVyhjzpMhrj2rWDqQ7dxIg5SNg32+zaq2smNfCKCczZ
         cSmf2/DacyWm2TMLhViKLzqxqUZ/2+DUbswiwl/+ZEIk+Q0UH4lr9MuE+s41yY0Zko8i
         BhxNLwQb9I1k2xmCNjL3r5LfLQf+h1RxVAfBp8ALJXACvVOE7NqPIdjrh5j/3Fq7I6mi
         km+1u5cPgzwiAsNjFzyiWN3QbM1pNSnlIUSHAXyELW+86Pzm3KqhXMIzeAJ99dZUhhh9
         kKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615033;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Dp5pAZeAhl6Dlb996jYKEzkjfchLLr1AyPpbuRPgDw=;
        b=1t871AYnpUpzuvBT816DORRe4JrJUz2rr19fNDBFKFM0emg0Vx8udReDYA4CNqfUtV
         M/lXUnM4XFbv4qxCvUl8N/K0qr71xIp76GTdAqphWOIl3Z2npTwiH1KYM+oxfRmctg+F
         jX8sQiEKkiK2fOzmR3OpK6RuGtKyciisyekL0f5gU4i50Rkj5zdrXz0TbJfuqEIb/5OL
         O/h1Zmu1DwlYhxLy9eWOL4NFiQxnXOX1ZTqevorwS3QX8rgkjta4KyOEBBNrkKZHtm4P
         Pqku3PbRYgwybmMh+a6/K7o3ZlMDoWbcbfCYfaYgrxIEkkG+LdQGeMyK0RrI+2tw8L9j
         rScw==
X-Gm-Message-State: AAQBX9fznIT5MlKaYNYXHKeq1K01q9daR+8yaUiY4YGT+TafnjwjYRpn
        dbITbv48p5bAxUjXvAgMlf10qEj+vrbVMZk/
X-Google-Smtp-Source: AKy350a0hEHsqZDS/c3m+XnHX1rBFG5mW0Zj8il3T68qGk/fCSLdTCsKQ8rn8Fb8NvOP7E4nhdCW8A==
X-Received: by 2002:a05:6808:2813:b0:387:3a49:4733 with SMTP id et19-20020a056808281300b003873a494733mr1081544oib.59.1680615032130;
        Tue, 04 Apr 2023 06:30:32 -0700 (PDT)
Received: from [10.136.10.190] ([194.199.146.45])
        by smtp.gmail.com with ESMTPSA id r204-20020acadad5000000b00383eaf88e75sm5179469oig.39.2023.04.04.06.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:30:31 -0700 (PDT)
Message-ID: <ff7bb1f4-e35a-66ad-1116-6bb2b906fed3@gmail.com>
Date:   Tue, 4 Apr 2023 15:30:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] branch: improve error log on branch not found by
 checking remotes refs
Content-Language: en-US
From:   Clement Mabileau <mabileau.clement@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        ClementMabileau via GitGitGadget <gitgitgadget@gmail.com>,
        mabileau.clement@gmail.com
Cc:     git@vger.kernel.org
References: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
 <pull.1476.v2.git.git.1679515402379.gitgitgadget@gmail.com>
 <xmqq355wctjq.fsf@gitster.g> <cffce108-c39d-f13f-9fb6-60624f7e7cea@gmail.com>
In-Reply-To: <cffce108-c39d-f13f-9fb6-60624f7e7cea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/23/23 16:51, Clement Mabileau wrote:
>
> Well maybe it got it from the original commit or from my GitHub
> username, I can't know for sure. But sorry for that :/ , I'll make
> sure it's fixed it for potential future contribution!
>
> Before fixing anything about the code maybe I should first address your
> last point which is the interest of the patch in the first place (and I
> should have started with that...).
>
> A few months earlier, for the first time, I had to delete a remote ref
> (because of a fork I fetched but no longer wanted: maybe a designed
> solution exists but I'm not aware of it). However, despite being used to
> git I had a hard time figuring out how to do it, I tried different
> things, one was `git branch -d origin/<branch>` (I recently discovered
> that it was written in `git branch --help` but I didn't find it at the
> time). Even googling it proved difficult (because of a poor keyword
> choice I must confess), most results was dealing with deleting remote
> branches, such as `git push remote :branch`.
> In the end, I finally understood that I needed that `--remote` flag and
> really regretted that there wasn't an hint message to head me towards
> the solution when I was getting close to it.
>
> Now I hope you'll understand why I suggested this patch. Maybe I'm the
> only one that ended up in this situation, in this case I'd understand
> that you would no longer be interested in the patch!
> However if you still are, I'll be happy to make the modification you
> asked for.
>
>
> Yeah probably, I'll fix it along with the other.
>
> Thanks for reviewing this!

Well, it would be nice to have an answer in order to know if I should 
abandon this patch or not :)
Thanks!
