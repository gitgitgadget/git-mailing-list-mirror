Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0EDC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 22:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88091601FD
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 22:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhFBWIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 18:08:40 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:42888 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFBWIj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 18:08:39 -0400
Received: by mail-lj1-f173.google.com with SMTP id a4so4508741ljq.9
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nrjxaADUu8SPR0IQSm4JknTx2QRYh3aMwjeWj8M1b3Y=;
        b=shEXtGmEMwKCY7Y+iZhOQ97wVPKjTmngBTvX+TUq2jSivVMxy59rUBwrYWAQtNj+Ns
         PmzqD/cLDhl2kwb7pSP5RiyEBfTaYqnm4OWC3l/9/znPGPJdHpgQsieU2loqloi5PsVl
         drOPKFXDrGhzg57pUq2FQwhQ7/Frk3PZPHOL7qo3QyzqdiEoa0GwCEMQCvi4kYvuC2ui
         qxDzMTCEhvRaL2wLIWDnsUA1tTeDwdbk88LY+4GOiVUQ5bTbRbO4qiZHfN8liw9oS6RU
         DDbtgEd1NbRQ62NsflpOjIMOkQoAJLyPvUN1MdZ3iGFE1QFvGHFlyu+4qwcHZPSXgjmD
         xscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=nrjxaADUu8SPR0IQSm4JknTx2QRYh3aMwjeWj8M1b3Y=;
        b=ArVpcvse3KKIHr6WPH8frjvDHZuWqej2R+TzTqpq4kgoCDFo4xsNSCB/ZFKaRLfAJ6
         XaxZw/TySOIq94G0c7Kz1fFZtsaVQnaFGpuTU7E/lLSa5I2eDx1iXHqRx2UH+KTiEoih
         s3PXOonTdsL3ANRZOSCBiuAU285C5RErujQMvvkxfEMAY7WHYzHJKPd12Wg+nF8P3Puu
         U7zqw9o7P3VfU1PlfBgfiiV3J5ovUZNi90/aji5JJ7trfJ7lI9z7r6TIvNJS/SOB/0/Y
         sgl1BMeZQv9QQgTj6rJoGnZSNXu/8fqUJ0xzXrXKpvQZZffvvxBafnvmtz/qqNP/dfaX
         V0hQ==
X-Gm-Message-State: AOAM532C6rQMescJjzSQGk9jBmYFAtOOIEPP3kGJR2okO6PGxQmPz9Ny
        FZwG0lO3bFIj6PJ7Q6Dl6OQP0GCSzpA=
X-Google-Smtp-Source: ABdhPJwEgUbKS7gITPoHbR6couoOj1tM6mdayBd1XI3YRz3ZfO5cG7fNLKKUji46sSj8/K+oYjSOnw==
X-Received: by 2002:a05:651c:151:: with SMTP id c17mr4715586ljd.314.1622671540700;
        Wed, 02 Jun 2021 15:05:40 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b21sm134104ljp.0.2021.06.02.15.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 15:05:40 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
        <87wnrd6wqj.fsf@osv.gnss.ru> <60b6c08f75c1c_40442086d@natae.notmuch>
        <87eedktq4x.fsf@osv.gnss.ru> <60b7f7e03fc64_16925f208d4@natae.notmuch>
Date:   Thu, 03 Jun 2021 01:05:39 +0300
In-Reply-To: <60b7f7e03fc64_16925f208d4@natae.notmuch> (Felipe Contreras's
        message of "Wed, 02 Jun 2021 16:28:00 -0500")
Message-ID: <8735tzncr0.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Sergey Organov wrote:
>> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >
>> >> > These are the configurations I've chosen:
>> >> >
>> >> >   [merge]
>> >> >     conflictstyle = diff3
>> >> >   [sendemail]
>> >> >     smtpserver = /usr/bin/msmtp
>> >> >
>> >> 
>> >> [pull]
>> >> 	rebase = merges
>> >
>> > Can you do `git pull --rebase=merges` for a while?
>> 
>> I never use 'git pull' for merging, and all the time with rebasing, so
>> what's the point? I mean, whenever I do 'git pull' I mean 'git pull
>> --rebase', and whenever I need to merge, I exclusively use'git merge'.
>
> So you can remove that configuration.

Sorry, I can't, see below.

>
> And afterwareds set pull.rebase=true so you don't need to specify
> --rebase.

I don't get it. What's the point using pull.rebase=true instead of
pull.rebase=merges? The former is plain total disaster in my opinion as
it silently breaks history shape. I'd rather suggest to make
pull.rebase=true a synonym for pull.rebase=merges.

Thanks,
-- Sergey Organov
