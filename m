Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8558AC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA9A613F1
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFCTJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:09:35 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:42509 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFCTJe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 15:09:34 -0400
Received: by mail-oi1-f172.google.com with SMTP id v142so6908595oie.9
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 12:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=57pJ2BB6JzwXrbic/Jx3aAya7XiOfVJ4L0HNnrCt5sY=;
        b=oQProZQZuuT8yvPhPV2PowxgGXy9qYhm4DMLoHMLkWHeUub+JBNVYf5TawFwDUKYyj
         sGObWxx7e68pGqnKpX9Ry8VJwBQzWEQAf2Tfrw3+nN6NKdkLKtFrrBN1JJs8IgqVwBkq
         x4kEH4GZtakYDKlT3tSbzFsBqQVT6mllXlkkeQPlb46H4PuqsorAkFIansT5TLboe4ON
         xheRZ5mCj0ZSnPbwEIZ6jv8f8SCiZMf8oZ/yxgDBIFAOWowESFXX/E9DuMJ27xPIUDwL
         o3ZeeWfKtkeiQM51+ToY7JCmZw1YHH9XHihbyeImKkx6fQ92WWyhC5lgnE7LVDm/VRrU
         RefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=57pJ2BB6JzwXrbic/Jx3aAya7XiOfVJ4L0HNnrCt5sY=;
        b=E5b80PRNO6SOyATjVsPC1enIu5lVypo7kx3iw+WF/CT714b9tBSMa5El5S5eJHLrSv
         aUIp4D2TkcIcmWOJqvhPUgFzH00KQKPA6HXw/3TbDOteV4+KIv9nLYooOGN9CvAGB2HK
         kk7nPprNdr1oReVK521WApQxtkP0eLWA1KH4X8qWi3UktY9RvC7bivEg/ofzDLu/ZjLq
         bKBKNtARMrbTkW+g4GqOBwW7jZ842I7lHhTOiAvW4WEhDvdQBD5NF4lBvZuqDdj5KZ6P
         tal7lxYabkWGnOftYnkNCEXWccE4i0I6nUT19uIjJZFmOYzwCjNbkhpgyjTd7jvtvBjC
         cPGQ==
X-Gm-Message-State: AOAM530jYYtOEcqnAPH0gDGLPJHT87X64TOCCTNppiuqW6+G69L12Pl0
        J2V7knlVbsV5txpr1aC+5pg=
X-Google-Smtp-Source: ABdhPJxGRbp+DmxF+T+yLLSqVwvid4KXI/n8sahlpZL67M7E8K6hrushGFgHINltTsmEy6ctbH7hjw==
X-Received: by 2002:aca:b107:: with SMTP id a7mr8301569oif.170.1622747192741;
        Thu, 03 Jun 2021 12:06:32 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 53sm874357otu.21.2021.06.03.12.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 12:06:32 -0700 (PDT)
Date:   Thu, 03 Jun 2021 14:06:31 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <60b928374d90e_39cbe920835@natae.notmuch>
In-Reply-To: <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
Subject: Re: Gmail OAuth2 in git send-email
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> On Thu, Jun 3, 2021 at 2:09 PM Konstantin Ryabitsev
> <konstantin@linuxfoundation.org> wrote:
> > On Thu, Jun 03, 2021 at 12:02:08PM +0700, Bagas Sanjaya wrote:
> > > But for users that use Gmail (like me), we must either enable 2FA and
> > > generate app-specific password for use with git send-email
> >
> > Is there a general problem with this approach? Gmail has been my
> > recommendation for everyone needing a free email account -- it's still
> > possible to configure it to be perfectly usable with patch-based workflows,
> > even if it has its own ideas about web ui treading.
> >
> > The fact that Gmail forces folks to enable 2fa for app passwords is an added
> > bonus in my book. :)
> 
> The 2fa requirement is a problem for those of us who don't have
> smartphones or SMS.

You don't need either of those with an app password:

  https://support.google.com/mail/answer/185833/sign-in-using-app-passwords

And of course you don't need them for the second step authentication
either, you can use any OTP client:

  https://github.com/paolostivanin/OTPClient

Cheers.

-- 
Felipe Contreras
