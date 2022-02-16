Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B2EC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 05:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbiBPFCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 00:02:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239040AbiBPFCE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 00:02:04 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD8F13E94
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 21:01:53 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qk11so1916409ejb.2
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 21:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H371mldLe4RtWvo0ghC9IVeDySuoYMWEtKSz7XQ9P4k=;
        b=ExB7CqQ19/E5jc65Wepw9OaRihaFgdbfu87swfABM0cqV/ohmRP0KH3+fZL6o6Qg5K
         2Nc/maHEFPyaxamh2+PY6Z9M6/WfBhptlqAJ1GEAHQSEAdnDMmvub7u7JFBnRz+Gdt7s
         pvvTPx1u4735L5/uGvYHFOXJsaXbn0PWN1SlznMlGbKECuHUaYXVA2imWDMXS9IIZicL
         J4lS1bgp3TcnUEadHYfk7eT7z2Luzs9nxKWo6Fdx1V6bNFvDusJJRGSeo4yNh9Asr9+0
         b/J4OaHO3WsUxBWxclbgF0HRIhJ1QwA4rVHkNHD6MZBWqIcwEPSHHSvWcfUq/kEhzlEt
         ILHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H371mldLe4RtWvo0ghC9IVeDySuoYMWEtKSz7XQ9P4k=;
        b=PZW97RoGSyNBWHdRRKqdIxmZF+ZqPIWi8LX4bQATr5mLKBUbruuOxaYVT52vRZ2i5U
         s1fQrM7nuQ6HtHp6YAfZwh3HUAodGiwdzhAw+m2/1Qa/asQeoghkx8NiGdkKhBIGOEuc
         +Eurpgs6C/qFwiFxh1uKIRGTU6Nt3UefKWZcLWCiYDhQqRlRwVk0voXOeTbEbKhufQsj
         cFPr7UeN4HPdQxj8gxxzI9arAywx7Z78irH1gUP7beffzwfDop84F1QqCwShrzcKj72k
         oZjW3NaXg+y7FJ+AWGGqETvxLi4LodAIQveS9EaKyYLzU+TDKNPg/DXDBoqP1qJH03jC
         RNNg==
X-Gm-Message-State: AOAM533lwCTBZY6nQZQ149a/+Huu4poYwZqYpHoIGgBv6IFSipIAt3O8
        eIF4UdW8Ik+5begfjJGEVfSBmvKYuxdEv3LY3N4=
X-Google-Smtp-Source: ABdhPJysKLmeAXgHY/gtRICIztHbdaAZ7iareg+oNe8351FhZ7hEsYhraiLZ/uOxO4J8+AFkVAxsP5QkmMPM01xjf0c=
X-Received: by 2002:a17:907:11c1:b0:6cf:723b:37af with SMTP id
 va1-20020a17090711c100b006cf723b37afmr947495ejb.476.1644987711656; Tue, 15
 Feb 2022 21:01:51 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk0dwyrcv.fsf@gitster.g>
In-Reply-To: <xmqqk0dwyrcv.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Feb 2022 21:01:40 -0800
Message-ID: <CABPp-BG+-ZAX7DcKNc=Z9sXNAJKUEDvrESesJsH91=ze2zLm5A@mail.gmail.com>
Subject: js/apply-partial-clone-filters-recursively (Was: Re: What's cooking
 in git.git (Feb 2022, #04; Tue, 15))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 12:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * js/apply-partial-clone-filters-recursively (2022-02-09) 1 commit
>  - clone, submodule: pass partial clone filters to submodules
>
>  "git clone --filter=... --recurse-submodules" only makes the
>  top-level a partial clone, while submodules are fully cloned.  This
>  behaviour is changed to pass the same filter down to the submodules.
>
>  Will merge to 'next'?
>  source: <690d2316ad518ea4551821b2b3aa652996858475.1644034886.git.steadmon@google.com>

I think so.  Sorry for letting it slip through the crack, but v2
addressed all my feedback.  Further, v3 was Reviewed-by Jonathan Tan
as well.  I think it's ready to merge down.
