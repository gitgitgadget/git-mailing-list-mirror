Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7297C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 18:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjCXSUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjCXSUE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 14:20:04 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD3C1F92D
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 11:20:03 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536af432ee5so48869877b3.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679682002;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T26zSDmPrqGwYSR/LmfF1FYFVUjnxhRwHirGSuS9a/o=;
        b=fkiaEIuf32ihvt73NqK9a53sSgvSVB4WE2Kd+T0ELYp0lruwbK/GvKWi9/q/y5/+LV
         4xqRf4KN3sBTWk9GAYIeu/nIlX94apgPDipLwEZGQpYun8ZCWcjoZjKOQfy1MU+vmjNk
         ZS9UAwLmxslIgnGqy7PwnxJESjeiyW134Jqngw5RWAXTlo/4Rf2P0gRdOyTVfGsdcCxn
         Mz25aDV4XO9/GMPxVt6XUzi+8LnuS5UzfbXoXYtemDn++uAiYNCdC56jyC2F/IzC/BY7
         m08kkvHxo2OlhQaIZnrVyG7HCspLaYk56AOXmEO0RD3sxi5z8MP1q3dSrn33kfMC1e7V
         MS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679682002;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T26zSDmPrqGwYSR/LmfF1FYFVUjnxhRwHirGSuS9a/o=;
        b=4/NY1g6sj1Y/dWFcdj7aR2kaHSLqQBLOmoYE8caaJe/CQw4k0bL7CYIrnnfRBEJ2AI
         MXtr2wlKRCIYa+rjoZ0yp4k8CdvpzBUYRVXjbx03jtytjDqMrH7omV8al8ySqHq8YifP
         yQrU2jQLS6jToLmmzaecCP+c16zIQJ3Yc4wWrrB5oYmHdERHqIkSlxC9+m/cm+cHU3lC
         kkyRjksZPkf7Sw/Wnqs+QuIVsZHGEmWZKNmR0/KAsRTdyZDSgmlHL/4G7MNvHzW7eXjj
         ktMOZZ0iabWavFw/2Ks+Ot41D1BqAOxrid2KCUPHaOryhDnw7EAZNhmnkT+sf8LYjg2D
         1Wdw==
X-Gm-Message-State: AAQBX9euVBsLTPIRGH+ENO+/42bPxS1wUWPJtVFXfMym35MZLAKTZQjc
        p3VG0dV5PDaTJzfxv31/vBKYB4PmA44JfJhFeAtqWJhYC1I+PvcnLWgx0po8PSP4E71Aw2AG5RV
        KkAOBckOqjPWcxXlJ2m+0FZrEzc3HCW+Vf5LC44Hy/ZV9IY6RNCDDfrirJGLrsHLYSJ4GRfTYEB
        E=
X-Google-Smtp-Source: AKy350YiF0X3kWkeFe2Vj528hnAbDW/9KfVIthq98S/tOoBDkT8ovJHpTrFeesoXjpZaA7DdK870Tw==
X-Received: by 2002:a81:490d:0:b0:541:66e6:dc31 with SMTP id w13-20020a81490d000000b0054166e6dc31mr3623849ywa.9.1679682002034;
        Fri, 24 Mar 2023 11:20:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55e4:a877:13cb:cca6? ([2600:1700:e72:80a0:55e4:a877:13cb:cca6])
        by smtp.gmail.com with ESMTPSA id o5-20020a817e05000000b00545a0818471sm538123ywn.1.2023.03.24.11.20.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 11:20:01 -0700 (PDT)
Message-ID: <85f81579-5876-a573-6d35-88b35ab0f290@github.com>
Date:   Fri, 24 Mar 2023 14:20:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: limiting git branch --contains
Content-Language: en-US
To:     git@vger.kernel.org
References: <ZBygZbz5E6jVNp3y@ugly> <xmqqpm8z8dab.fsf@gitster.g>
 <ZBy6Ku+znv/wuOix@ugly> <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
 <ZB3o0seQJVbtPa+j@ugly>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZB3o0seQJVbtPa+j@ugly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/24/2023 2:15 PM, Oswald Buddenhagen wrote:
> On Fri, Mar 24, 2023 at 01:23:32PM -0400, Derrick Stolee wrote:
>> Could you make sure to run 'git commit-graph write --reachable' before
>> testing again?
>>
> i did, didn't help.
> 
> but regardless, even if this would improve things by an order of magnitude (or even two), it would be still wasteful, given that the expected working set contains a few tens commits, while the whole graph contains well over a million commits.

Hm. The point is that it _should_ improve things by several orders
of magnitude by using generation numbers to avoid walking a
significant portion of the commits. That is, unless the commit is
extremely old.

But what you were originally asking was also about filtering the
set of branches to pick, instead of just the commits that are
walked.

In that case, perhaps you should use 

  git for-each-ref --format="%(refname)" --contains=<oid> <ref1> <ref2> ... <refN>

or use ref patterns instead of exact refs, if you have such a
grouping?

Thanks,
-Stolee
