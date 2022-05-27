Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2DAC433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 21:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351611AbiE0VYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 17:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiE0VYL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 17:24:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C493E6B7CF
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:24:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z11so5635092pjc.3
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9PkMj/icQcslOZmD/0+9ma9p30Fr9m83GxNCTWJ3/HI=;
        b=GKZpjp7nHPd9BxYtaofwAVaB7phxtcoxng9YaT50Eqffh4oBDYZ8vGhwrgddMt6Ixa
         zGdI+dCtObHD3TzSUsfMpBMfPtNU5lmKU8KciET9DlnL/BEkYKS/LX8HzRvm8/kb6cU6
         ciXvuZgwzI8oak0rDqI3lfti6bt5FPPgA/1DPLcKhk+ukyWdOgBlrC0CwlYnWOPV86f6
         fiBS1/DLZtuKuRDUAxAXY5kW3iXqDLveZLW7K5UYEvjtXbEemtqKjwpGG41TUk2/adYx
         iZwZ9ZOYHmcgFvhuH1BmnYarMYevaV29J8KsIa83h+dKQKCaC7gISS9F1NLjgjAR/nhN
         CPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9PkMj/icQcslOZmD/0+9ma9p30Fr9m83GxNCTWJ3/HI=;
        b=m+DB0DR/BeMiKSAyWeoT6dKrL9uyIAh7yioE9jIZNCi5l3fRULwrvyD+5tpXaP2Pd0
         FuhUTlCYYD4D3vSeGEIM93sHASsDauHVRPWbg/6u7JVabbz94s4Sb/ENRkRvh7GlUGLY
         LI3Wxjt0xOlYCVoXFtwp0GOqHFQNGAIgPfkmYcGU0o+4DwfxKMKlv7y4ljlGMw8+k7U7
         obdN3F1SAoSqT8l7QwIzqPRTqIPGM2fB0oy5ay03cWH3ycimAv1ACRvK+IIiwbH915WU
         9FWRAhjrX8Eyamk0p5iOcO2zqZDHN7ev+caexaiLe37Docl1+eG7hDy0mLL8OuLiUXK2
         39uQ==
X-Gm-Message-State: AOAM533IufVJJFvdXWRiRnBibfd6xZ2UAhYyBhsEkIjXnI7vvqqJPC7f
        D9hyrfP/dBY1EbDwDvYJ0Q9nDwWtWVK3
X-Google-Smtp-Source: ABdhPJyc/Msr49xQ0IN0rfLfxNLrygXpvavH6BqRF2a6CwwrbwEgQR7h2XBBa6wO2BMF3wKyPfrc2g==
X-Received: by 2002:a17:903:120a:b0:15f:99f:95bc with SMTP id l10-20020a170903120a00b0015f099f95bcmr44386151plh.48.1653686648014;
        Fri, 27 May 2022 14:24:08 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id h10-20020a63574a000000b003c25dfd7372sm3820821pgm.26.2022.05.27.14.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 14:24:07 -0700 (PDT)
Message-ID: <d0ac1bea-6d98-140c-0e46-d7569e80b29d@github.com>
Date:   Fri, 27 May 2022 14:24:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [WIP v2 5/5] mv: use update_sparsity() after touching sparse
 contents
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com, newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-6-shaoxuan.yuan02@gmail.com>
 <077a0579-903e-32ad-029c-48572d471c84@github.com>
 <xmqq8rqm3fxa.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq8rqm3fxa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>> Note that you'll also probably need to check out the file(s) (if moving into
>> the cone) or remove them from disk (if moving out of cone). If you don't,
>> files moved into cone will appear "deleted" on-disk, and files moved
>> out-of-cone that still appear on disk will have 'SKIP_WORKTREE'
>> automatically disabled (see [1]).
> 
> Does it also imply that we should forbid "git mv" of a dirty path
> out of the cone?  Or is that too draconian and it suffices to tweak
> the rule slightly to "remove from the worktree when moving a clean
> path out of cone", perhaps?  When a dirty path is moved out of cone,
> we would trigger the "SKIP_WORKTREE automatically disabled" behaviour
> and that would be a good thing, I imagine?
> 

I like the idea of the modified rule as an option since it *does* complete
the move in accordance with '--force', but doesn't result in silently lost
information. 

An alternative might be 'mv' refusing to move a modified file out-of-cone
(despite '--force'), printing something like
'WARNING_SPARSE_NOT_UPTODATE_FILE' ("Path 'x' not uptodate; will not remove
from working tree").

I'm not sure which would provide a more vs. less frustrating experience, but
both are at least safe in terms of preserving unstaged changes.

