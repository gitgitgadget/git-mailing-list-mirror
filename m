Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDF3C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 18:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiLFSDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 13:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLFSDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 13:03:39 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2057830551
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 10:03:38 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id z17so8105135qki.11
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 10:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WIE+oERzWH/R6HkRvusoHTYVGHKJs3CukOm5+olWFo0=;
        b=QUcGLBpVAzKVzKg49bcVrx3cH7fiRvNhvqQbIJ9O+YfWBxafN5xy6bDVu01ujq9Juh
         ToZNeFIwx9jOBzdIso7iPjmZK9GU1zXEKn8gxYl+avEzBFUf1/8PhmNmCj3fkPSuWrh2
         fDmq3y+1Bh05NsZpn5U85nh0yACsAH7lfzVzfhlRN7iK+b2q/yq9yjWlJAS8f9kdG3Vj
         QhAvV9y8WNAXSWdpa9VmymAfeOWKTC27HcSD0XO0rY/p4FOj1Ya3KhfbiLCEXqrKRRAK
         fF2F0fkj9XjYwZhswt78mFbw6svxEYv2m4RnGu7+QkuldaH5SyWEClkwjvJInwRzqZYc
         4gKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIE+oERzWH/R6HkRvusoHTYVGHKJs3CukOm5+olWFo0=;
        b=CgvaWBWKlxBoVgIIvq79kl9Y594o013+x+bZNUsA0+ijeHsCAiAGvpTUe9COBhjMlX
         YvMbR15ryi6HEEwDPkCgHqPJf+kIo4lDQS6ToJLocnmNG+eCjy0NnMHgeUCXZ1yf9U7C
         3jQb9Zfs6o9BynP5pzckux6ht5kKPOA///IN8cDQNlboqC7531UTw/Pw3JQxoqRAMJ4x
         F9lMCFa4MoKpqptDLhfRwNY7Tl/yeJ0elp0BUv5wO+1ecGy+hXBK6KPoZWo2SbEGTjvQ
         xNH1BSUH75HiebbqB7Ttf7EiQsNuSpd5O5J2FM/s0+48zSXLq4XWN/5iB1kKyTIE3xLn
         KHgQ==
X-Gm-Message-State: ANoB5pkVZtkDlKB17Zcxu0Zwde8n2wUHIx8y2or0KjeFy2w0GslNi3/k
        08NkhtiIEdaAlhV8TTOyx+Ach48GQbw/V6w=
X-Google-Smtp-Source: AA0mqf58GWQz0QJvT0WbW07QzU1O5R/zmeWcVYxvrpyLuBlK2sYDUnvTSf0Yw/bjF78DZacc6C7Rcg==
X-Received: by 2002:a37:6584:0:b0:6fd:70d0:184f with SMTP id z126-20020a376584000000b006fd70d0184fmr10983837qkb.478.1670349817155;
        Tue, 06 Dec 2022 10:03:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:155e:931b:e4a4:caed? ([2600:1700:e72:80a0:155e:931b:e4a4:caed])
        by smtp.gmail.com with ESMTPSA id w21-20020a05620a445500b006fa4ac86bfbsm15552501qkp.55.2022.12.06.10.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 10:03:36 -0800 (PST)
Message-ID: <4dcad1f5-9ebd-d15a-b663-a3513ae1bcb8@github.com>
Date:   Tue, 6 Dec 2022 13:03:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Auto packing the repository - foreground or background in
 Windows?
To:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
References: <CAPMMpoiN=Rj_z9VEJZ4EFhb8gBeqb6H7JhTUBbn-b-t-jHRVnA@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPMMpoiN=Rj_z9VEJZ4EFhb8gBeqb6H7JhTUBbn-b-t-jHRVnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/1/2022 7:25 AM, Tao Klerks wrote: 
> But my *question* is: Does anyone know where I could/should look to
> understand why the GC was happening in the foreground, even though the
> message says it will run in the background?

On Windows, Git's foreground process cannot complete without also
killing the background process. I'm not sure on the concrete details,
but the lack of a background "git gc --auto" here is deliberate for
that platform.
 
> I don't know how to create the conditions for the auto-GC on demand
> (how to create lots of loose objects??), so I don't know how to verify
> whether it ever runs in the background on Windows, or what that might
> depend on. I saw some discussions in 2016, but I can't tell what the
> conclusion was; is it simply the case that git has been "lying" about
> running GC in the background, on windows, for all these years? Or is
> there something specific going on in this user's environment?

Instead, the modern recommendation for repositories where "git gc --auto"
would be slow is to run "git maintenance start" which will schedule
background maintenance jobs with the Windows scheduler. Those processes
are built to do updates that are non-invasive to concurrent foreground
processes. It also sets config to avoid "git gc --auto" commands at the
end of foreground Git processes.

See [1] for more details.

[1] https://git-scm.com/docs/git-maintenance

Thanks,
-Stolee
