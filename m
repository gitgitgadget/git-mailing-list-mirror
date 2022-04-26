Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64B3C433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 16:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353015AbiDZQii (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiDZQii (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 12:38:38 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F238785
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 09:35:30 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id z144so8401407vsz.13
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKapnm5zrI8QUO/iQLzduMy6jGByeNpvB8znQXeeHl0=;
        b=Ul9jcyHnDjdCrDKmCwIXGi+HSq/rAMLlkPV+2oiVNpuF1CQha1K42xWm/aJltlbFPl
         ogozfUNIHMqAmAKp/BgBIzew2SDvfJhyZfAq4BRRL4+YDW9VeVrwjlYJRk09ArXqhra0
         BU7wZzKkhcBEujmD5XUNKx/ZVa96AJiGCxk23Xk11hmTrK4rOEpwGceGDa0VY8nKv9ij
         Pw81Cfl/bJ0VOoOFjJWReMSlbwxDZcuTACbJgNGQP7AELlk3aYrQgP56WVOTygfzzqSE
         0BOIY+e03f/M/9m7pEHlZIo/H+PIs6Wl0IKt4woQttryg227MLQXeWei12dxaocmnY6m
         U0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKapnm5zrI8QUO/iQLzduMy6jGByeNpvB8znQXeeHl0=;
        b=c81/NQMhrpzj8pRGzie22GUU1HZTq1xAXnZhgOQ7WN1/NT2xS2qdx4xvsrEA3P+eSy
         lbZNtbuqwH5ktZqr/euRrYS76xc8eB1kM4KiMUFIHRGLYQINLh5onWv8G9HdVrVtcwGr
         /zg9k/8skxSB6UkhBhQQCa3Et/mr4Lwp4M62R+CXxos3R2sOLUmL29BsWLMQuDv/P7AS
         MQ4OEjOcsOYU763fwAtKDswSS15vZiJgnkPgS2JOInpFCzXOnnmJ34YEZh65iE09p8lN
         0/o3jsbDcEw6D4/UjkVohs9of7Zbi8BoOvHrZCqg3h3wfRsDExmcayHC9D9QPQb+Etft
         NKBw==
X-Gm-Message-State: AOAM530DIjLtdh4oTPe6AHHVIpRoreJfVbqcMJ+wJaqKDHClHLj/nw+w
        fwkoldp+QWfmvvOPrcrQ4bxohevxuAEOUOZQIoE=
X-Google-Smtp-Source: ABdhPJwkLbYWFwbkQ2PC+MSPD8QZzUAal/DfdzwBPyJLFRJr3heRApPp0+zwZmTcrzajNSqDPAp1juZM2xmL3wzY+OU=
X-Received: by 2002:a05:6102:ed4:b0:32c:ea17:c6b5 with SMTP id
 m20-20020a0561020ed400b0032cea17c6b5mr891474vst.52.1650990929459; Tue, 26 Apr
 2022 09:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
 <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email> <xmqqczh73hns.fsf@gitster.g>
 <xmqqk0bf1i12.fsf@gitster.g> <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan>
 <xmqqy1zty8dc.fsf@gitster.g> <20220425070245.ta6wibzkezlfwzxp@carlos-mbp.lan>
 <20220425084003.nf267feurpqyvmsd@carlos-mbp.lan> <nycvar.QRO.7.76.6.2204261742120.355@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2204261742120.355@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 26 Apr 2022 09:35:18 -0700
Message-ID: <CAPUEspiufPMZOfZFunTFYmX7KwPxsKsAeHnfBjKgosA1ZJWqzw@mail.gmail.com>
Subject: Re: a problem with git describe
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2022 at 8:43 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Maybe a better idea for the `sudo` scenario would be to make use of
> `SUDO_UID` (assuming that no adversary can gain control over the user's
> environment variables)?

I like this idea, and will prepare a formal patch soon also including DOAS_UID
for anyone that might have used that instead of sudo to elevate their
privileges.

Still think that (since we are already touching this) removing the
restriction to
root owned directories might make sense though, ex the following (unrealistic
example) would work:

  $ mkdir -p r/t
  $ sudo chown root r
  $ cd r && sudo git init
  $ cd t && git status

IMHO any directories above that are owned by root and might have a git
configuration must be safe, and therefore shouldn't need to be
explicitly exempted.

I also think that Taylor's suggestion to ignore and warn instead of
abort might be
a better solution to the "configuration file shouldn't be trusted"
issue which is at
the root of this regression, and obviously doing that would make this
change less
critical (users will just get a warning instead of being prevented to
do what worked
for them before and is a safe use case)

Carlo

PS. yes hardcoding uid 0 as root would be avoided, not sure where yet though
