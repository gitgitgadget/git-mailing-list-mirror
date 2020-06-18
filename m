Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0421C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB59208C3
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDZ4CaFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbgFRUk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731484AbgFRUky (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 16:40:54 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5577EC06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 13:40:54 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v19so3129501qtq.10
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qmG856c1JOfLjRIJWk9NW0Wgo/y31J3WNP86H1pL+M=;
        b=tDZ4CaFM15NNDCjzR0y6ydpmz0BKV/mdaU4i3mSD10WXBp2kyZ1bmfMw9yUPgq2oO8
         WJ0swcgsa5t4O61rhiBOSqBkLW24G14lJD+RzC2q4RLC7YOwXNyfq8OiAhYPdvJrYDi6
         rlksMosr1S6OfG94LCFiRUu4JjKXlx1k776EzgQ+NoIvM4uHk29c349pXfwZj95XRp6p
         tldfKUZY5l1zk06zx9SeAXJ0s39FL3P24w4BMP2PWMlv5J+npqdzFCSW/AHN1474EqYo
         C+1Qlmzystiaz1e3821yDvN1WUTWUR9S+bMGNzuU+c42obmarxOvTNK/rj9V19wOgpSb
         7+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qmG856c1JOfLjRIJWk9NW0Wgo/y31J3WNP86H1pL+M=;
        b=YKC4D4mHGOg1mC3+1I6cXPhTA9OT39XVUhr/V6sws+U8S/i32YOhATH4c1oTphtquJ
         mqk5A5TJW0kGEnvU67IcLr3QKLoW759kfqnYgadu3F5yvcKEdya9vr2U/6IfXnpVd7gn
         ktR0FlGBwaI4D7PSnTM0V5U67V8gFfHUkFYuxGuAwyDCgxiBq1b30OzwueLYHpHCR6a6
         cZj34F8tfSv7m1lYKzzxsAGyEwoV6N/0jdNq0pu/sbzlpZKQFN5u6WdN5o37P13Tdn1o
         N7Qo08+U4Bmsdmb827dJC2OdKPAsM1sJTemhFz3kEICCs1vWyk0m45dUbWFMEFdnNDRw
         Vk+Q==
X-Gm-Message-State: AOAM5317t4AGIFbnoFXw1jGIrXbxfnYGCzW6A9756C17VsC663rjYgDO
        bY4m8BLXqX4zvCN3tUF8EkWMB9ucwiAb47ze6CK6kg==
X-Google-Smtp-Source: ABdhPJwqDv86f++lI7xMly54aYeKjS369tofTIwO/reGDtoCLS14m9Fdt+c5w7ENCJMq8/4mAlVoZaZD0gzvyi9pRfw=
X-Received: by 2002:ac8:4243:: with SMTP id r3mr27302qtm.225.1592512853584;
 Thu, 18 Jun 2020 13:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <549f0cd5fffef38e8d85246a9aa2593674aad68c.1591986566.git.gitgitgadget@gmail.com>
 <20200615140349.1783-1-oystwa@gmail.com> <CAKiG+9X66yf_F8F3XuYFdFyBWiFRZ_rf0Y1mE5LVCjsi-AzKbg@mail.gmail.com>
 <xmqq8sglq8zn.fsf@gitster.c.googlers.com> <CAKiG+9VZUqDi=EbbqY2vLAiD6LEFMfR_2UHE+gbt_RpKNanUCA@mail.gmail.com>
 <xmqqk104nnll.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk104nnll.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Fri, 19 Jun 2020 02:10:42 +0530
Message-ID: <CAKiG+9UqvrxyMQufuG=oAP6Yo7+YSoicwqZBJjsZZFQT-Bscjw@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] cmake: support for building git on windows with mingw
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 1:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
>
> > Since this patch series has been merged with pu, I didn't know whether
> > I should wait till the patch gets merged into 'next' or do the change
> > immediately.
>
> Ah, OK.  Being in 'pu' does not mean no more than that the patch was
> sent to the list and I happened to have seen it.  If it were ready
> to be merged to 'next', I may have marked it as such in the "What's
> cooking" report, but otherwise, the default is to be polished until
> it gets ready.
>
> > One more thing, there is an issue with the scripts' permissions when
> > run in Linux. They don't have execute permissions.
>
> What script?  Your scripts you add in the patch series?  What is the
> reason why they lack execute permissions?  Forgot to "chmod +x"?
>
> It sounds like, in addition to issues pointed out during the review
> cycle, you have identified more issues that can be solved to make
> the series more complete yourself, which is a very good thing.  It
> is hard for anyone to review one's own patches and find issues, and
> you seem to be getting the hang of it.  These are all good thing to
> address before the topic becomes ready for 'next'.
>

Danh was the one who pointed this out, credit goes to him.
The reason I deferred modifying in PATCH v4 was because there was no
easy way(cross platform)
to change file permissions. The workaround is to juggle the files to a
temporary directory, and then copy them
to where they are intended to be with the required permissions. This
added quite a bit of code.
Since Windows platform was the priority, I did not address this issue.

I know that this issue needs to be addressed to make the script more
complete, so will have a UNIX conditional block for addressing this
issue.

Thank You,
Sibi Siddharthan

> And there is no need to hurry.  If you do not want to waste time in
> repeated rewrite and review cycle, the best way may be to go slowly
> and carefully to avoid "this was known to be suboptimal even when I
> wrote it, but I didn't bother fixing it before sending it out, but
> it was noticed during the review so I have to update it and send a
> new round".
>
> Thanks.
