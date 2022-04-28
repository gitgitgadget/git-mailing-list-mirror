Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEA3C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 20:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiD1U73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 16:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiD1U72 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 16:59:28 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859D12ED55
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:56:12 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id z144so5741640vsz.13
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYs+Sg58xiR9aMfB0zRT+qMmcmNnR/WFvHxkBCr+3lo=;
        b=leYIj6AiA+liwTBaWS7eOQG9jEXd/iockxNb/Ihpe9Sb8WTecduvUyK8uPLPavzm3R
         qrnKnxDt3Np55tKcJV52du3W6mnuQ9b6lrNLemGmSWJZxwqX9lWBa+L126fk/G4GfMA2
         zU8qIDtmz7wil32HsJpYgmZBrxC4CAJtxAK1FMfDhgWPrhN1v2Nvr+lUDObelfmK8U+2
         1+NshFPl7AUuJ+aehQZDqNSPSqudZlthZ0kfoIjN7EzVu5Hx2UR106K6bScYKSa/aoNP
         B6yJFmveQH0wRr1ShZS26weZ9lBKEAf9dTjJSQfA+expXGMhqzzm5WwKhdmUtGAd0zUT
         elVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYs+Sg58xiR9aMfB0zRT+qMmcmNnR/WFvHxkBCr+3lo=;
        b=BmFDHztiXYm1jsytMpCOEP7taoA4QK9uhDW2yYz1VtvtcnOr3CNrIsdeHI8uw9rKFl
         kUzsO3i8o0oWdmXRDUVqmOiBlsKXwWVe4MiM9xW/racOqPXgZpnzEbT/qQfg/Zyft6lk
         a0dkTHImpaoLhWxLyU8blglUddhNNe4HbpYqybrgY9GfUeJNh0d1HNfqdNeTUZ1yB3mk
         y11Rbvs6KCpsmZiHS16qPmGJi1eXFs++PlJY7BwRSRItOjwMUMv0udcd4gFbzyqclYy7
         iOxaqIphlFNo8Wc8qg3XI02SZQMOuKO2dx7YmGq71v2W0IOsOEFpEHA4sBIEfZRlU0ow
         EIHA==
X-Gm-Message-State: AOAM530rN+zsk35X/wHzwBcvO62NlHipoDnP4oLtBHcBVSgKslPG1ehP
        C5bv+cu/AdcFqmkMKf4Mp9HPBe0ifJkmm4A6WV0fh/txL0M=
X-Google-Smtp-Source: ABdhPJxv2+sTJiiKD0seV6DB6rVc+KPGUOsOwH6ljRkQfkgB6XeB1UMMWt7J0DCJ+ZhP54LuH1f9ktSGwxohoHj+I5k=
X-Received: by 2002:a05:6102:ed4:b0:32c:ea17:c6b5 with SMTP id
 m20-20020a0561020ed400b0032cea17c6b5mr4813791vst.52.1651179371665; Thu, 28
 Apr 2022 13:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220428033544.68188-1-carenas@gmail.com> <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-4-carenas@gmail.com> <xmqq7d79du6c.fsf@gitster.g>
 <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com> <CAPUEsph+p-fD8vMOMU4Djkc8cFUmm=9JVFdgaxkQ4-CpKZgnCA@mail.gmail.com>
 <000801d85b40$ac11ec80$0435c580$@nexbridge.com>
In-Reply-To: <000801d85b40$ac11ec80$0435c580$@nexbridge.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 28 Apr 2022 13:56:00 -0700
Message-ID: <CAPUEspgcd1CYTfL=ug3WtnOrJscWbyQXeF-2SQ_24KcCTkuRkA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
To:     rsbecker@nexbridge.com
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2022 at 1:43 PM <rsbecker@nexbridge.com> wrote:
> I tried to find is_root in POSIX but could not. Do you have a reference? It is not in bash 4.3.48, which is on our older system.

my bad; is_root is a helper function i provided as part of this file;
the latest version which should work in your posix system AND was
specifically written to hopefully not break with NON-STOP based on
what you told us about it looks like (hand edited and not tested) :

is_root() {
  id -u >u
  id -u root >r
  cmp u r
}
