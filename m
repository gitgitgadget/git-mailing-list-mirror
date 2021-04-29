Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD4C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 19:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7EAD6143E
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 19:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbhD2TIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 15:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238503AbhD2TII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 15:08:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7260C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 12:07:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u3so22804719eja.12
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 12:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6d9gfVsh5Ae1UQ0PE5a6I8lBsw0vrucfoCSwm5FtPGQ=;
        b=MWilDHGW3Wcb1CmgkMjP+n/zcMIFZX29cItIk9uB8k0MlwfX/oHUywo6OcMCaex9BG
         TBFnjE+n1nkEokzX95mQLlLoUmV1IOKn4fe5uOtGORex8Usz4KYdvVG3Fy1b/e8j51wf
         lbdW1LBHT2G9GyWS0DEGRimwXYILzw6wgFrm9LSGi7O4AVVbZTrr1dEd+7i41PmbpWCb
         9Ec6Z02mTVpG2HsIe5QvW5S5H76s16QDK5Y8j9e4kmlHLJqySV2+HsIh9qQMzpEs+uQb
         vc7jO0wUsgYT1Rusmlr5BIXb0MonU2I+hw4PSQWJtF3U4NSF6QIFBuUXt9m3I87Q+Fx/
         2Rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6d9gfVsh5Ae1UQ0PE5a6I8lBsw0vrucfoCSwm5FtPGQ=;
        b=oDqvDAhpsClfZs6hHLWH0Wz2f61uHQ0syAICWzRvfceBzY+/DbsmRDxisnCwUrytFo
         4YAWlZ4aNYbV4UHQsQQDcnhofUAqLUbHuT5L/MsYPnIXNYlxwLKPD5nX4pFbwiXcDuFo
         DtrwouvJtbUXR6J1rO1IaHu/xlYSJGwpPpzFBGXz6/ug/mgJcoxtwkJooQaZDWdfTv3X
         m2I0zgTN/eHZPheuIZ/Ybj9IqHQAF9O7D2cQHrfMwBIBKYCjPG53XOFrbvzu0YjA06Cf
         kSZ8js1IQXF0EvOv8fCCns9E9r9IYiK6w9b/ownyEEAd37wFqMG0yuXtj9PgE+NnUBoC
         9RIQ==
X-Gm-Message-State: AOAM533s1zW0fgZb5NwO2gFw1kZzKfB2sbtKkXGfXKYhsAxunTplMj15
        xoTdpiBetMt0+49Cisoq94nzez27owho7YGft8A7lQyFNkY=
X-Google-Smtp-Source: ABdhPJzMJKpKaYTrK42RMpmbvErv2qnCKaNfk7PNKtO5++NTghW3c4mD7UBJTSEidbupR+IrbHKpk1al83WdsYPrTog=
X-Received: by 2002:a17:906:1a0d:: with SMTP id i13mr1440610ejf.197.1619723238644;
 Thu, 29 Apr 2021 12:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAALpVAsse7SvMTY7_wRmZvXAM7Y_mYYEcgsNwPg8jMDzjVW3Vw@mail.gmail.com>
In-Reply-To: <CAALpVAsse7SvMTY7_wRmZvXAM7Y_mYYEcgsNwPg8jMDzjVW3Vw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 29 Apr 2021 21:07:07 +0200
Message-ID: <CAP8UFD0GYWvrAm-G-TrM_6zm=XPdKdVcuwc-0xzbZDdpC7hjZQ@mail.gmail.com>
Subject: Re: GSoC Student Engagement
To:     Nick Vidal <nick.vidal@rocket.chat>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Apr 29, 2021 at 5:59 AM Nick Vidal <nick.vidal@rocket.chat> wrote:
>
> Hello,
>
> This is Nick Vidal from Rocket.Chat
>
> We=E2=80=99ve been part of GSoC for 5 years now, and as a way to celebrat=
e and
> give back to the open source community, this year we are reaching out
> to other GSoC organizations to provide assistance on setting up
> Rocket.Chat to engage with students (pro bono).

Thanks! Except email, and either GitHub or GitLab, we usually don't
suggest specific communication tools to our GSoC students or Outreachy
interns. We are open to using other forms of communication, like
instant messaging or video calls, and associated tools, if they'd like
it though.

> Rocket.Chat is a leading open source chat platform, and we=E2=80=99ve bee=
n
> using the platform itself to engage with our own GSoC students. With
> Rocket.Chat, it=E2=80=99s possible to create private/public channels for =
each
> student/project so that mentors and students can communicate, share
> ideas, and keep track of progress both asynchronously and in real
> time. It=E2=80=99s also possible to create integrations to display pull
> requests, mergers, and issues directly on these channels.

Nice!

> Please let me know if you would be interested in trying Rocket.Chat to
> engage with your GSoC students. Myself and the Community Engagement
> team are at your full disposal to help. Our mission is to serve the
> open source community!

Ok, we will contact you if we agree with our students to try it.

Thanks,
Christian.
