Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B178C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 18:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8276F611ED
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 18:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCSKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 14:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCSKj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 14:10:39 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729BBC06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 11:08:54 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s12so5061682qta.3
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e2GH1B/wnng+C0uY4ocvo61vzpnfxcH4/2RLXd979Fs=;
        b=AtOkrDxaKYM3VDdWcti+5Ebjm4R59begLZmI6aOdGYt2FJJAwleJdIVRv4yaNTcu+H
         PeHWjl3+VxjX7vfjKgi2cwBTZhDHAwLwTGo0PapshvqIIY7QKoTD0N4XXYQxsfqLuloC
         6CRFAEmlTsz+pG7uocS1uSYoTx/A/nR5l/5R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e2GH1B/wnng+C0uY4ocvo61vzpnfxcH4/2RLXd979Fs=;
        b=Y0+xI0Xx/mZES98vqO2iyMpMBPfA6bFEmwsGirfJ3N7789LJJH3m3g+mfkjN+3pZlf
         kibFitGcSxkPurmYBFVAFmo5CO/DX3tlC3lKSC5PFroG9kv1xiPgXv0TynugQnJ/Vh40
         2pxgWZ9OFTGTfNeC/9bfQL58D2JlKc6mzsik3ZHnnRvH1czh/wjItd6nouyGvoOMNs/Y
         d+2JcDCvZ4/Qxw7ZAOJgMkXhld0iHz+T4w835wxHyvxscEv+4hTQuUZcqnz/DiuUx+mu
         XB8QgiEh/OUeJeCMkgurqw5zhokux0ia2yE46CSIEWvSmnIAtE8NlU+Ppn2zdsx781xd
         k/IQ==
X-Gm-Message-State: AOAM531nuVzyQNEk1OdpnVLQ3xMbwbSp5lNezX+eAOMk62IV0D2c7Pyd
        Qin8EZi24Of5hRjtdkykP3VcRGDmTwK72F46FSc=
X-Google-Smtp-Source: ABdhPJwlK1TneyWzr8NEeYXekLnz4ppcOiOALKKA0boPs1/tbhakxy6dzM/KUPBLi8zn6LYYhbEJFA==
X-Received: by 2002:ac8:570f:: with SMTP id 15mr691063qtw.309.1622743733510;
        Thu, 03 Jun 2021 11:08:53 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id l65sm2342057qke.7.2021.06.03.11.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 11:08:53 -0700 (PDT)
Date:   Thu, 3 Jun 2021 14:08:51 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Message-ID: <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 03, 2021 at 12:02:08PM +0700, Bagas Sanjaya wrote:
> But for users that use Gmail (like me), we must either enable 2FA and
> generate app-specific password for use with git send-email

Is there a general problem with this approach? Gmail has been my
recommendation for everyone needing a free email account -- it's still
possible to configure it to be perfectly usable with patch-based workflows,
even if it has its own ideas about web ui treading.

The fact that Gmail forces folks to enable 2fa for app passwords is an added
bonus in my book. :)

There are other alternatives, but they are not gratis or don't work well for
sending patches. I'm also aware that gmail is not reliable for certain
geographical locales, so it's not a solution that suits everyone. We have
recently partnered with migadu.com and will start providing email accounts for
Linux devs who cannot reliably use any other solution either due to their
employer doing nasty things to outgoing mail, or some other reason. At $20 a
year, migadu's pricing is hard to beat, though I know it's not for everyone.

-K
