Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED740C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 23:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F98613B4
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 23:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFBXLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 19:11:48 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38717 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFBXLs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 19:11:48 -0400
Received: by mail-lj1-f170.google.com with SMTP id a4so4705576ljd.5
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aOv6pm3ew/4Hten6VwGs45zhY79Lx/KvJ04THHbqPfQ=;
        b=u6XnHriwj7XgXr//Fe1rqxJN4z+JQ+RTCiTfytrwebdcPK4gnq0aQGl3k8Zz81wVyW
         Sv4001E2bcVuMj0u0psW4rN4ma1UIB2qHUeFc3TvAf2gpaexhSTtMihDQgkE5Mht9gQh
         jRVoqPxVEuIrhpVqbZG61MaMXiQJC1pH54J48/NiZvDc3W0/u+W3urvckR89Ez/Jgd/r
         zMJItdnaQukuwQJtWOu5hpO/JbOMNglMXlg4Sb+ffo1/JN5DPYZZwE9xAWD9HwPabwWm
         V83kudMczilcUo208KXlVORIpYiwl6qHh95NPyijZ6Kwe1dyfJW8EUYkNDq50d76oalM
         SoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=aOv6pm3ew/4Hten6VwGs45zhY79Lx/KvJ04THHbqPfQ=;
        b=Y1IcTiY6m5HwuLCIUvCiWFEV2rYJU6Mnx8JNEVKH9JGWbX6DtuhOlsFUvKElBpxVyA
         PRzcff00vvXyVSpna/+XIrcxs8S1ysKoDaLB4I0HHXU/Ae5Ba21GXABVmvJV6CuJtyKZ
         YXPKmyp8etZAHkMsJ8zdzVoP5t1TCFAf5EAo6A83bEW6uY1mAO5SJclRHAGcE7XZL4YA
         w6w3cm5QQQwqVFzfyZZRsrouIn3raL1zBiMlPdmt0mQCfw69wOX6jvCrbveMpGPG2Ppg
         oWFirU3qvzoGYqJR+075cBMcI0rsRTE5Gp1RmThhlYX1+JB+khiC2ajBqyEN4h1S6Qis
         W23A==
X-Gm-Message-State: AOAM533AOqPJqNPFqyvZXB1rnItNOE2hRTo/ue9duAA7mqMFGIjKLGp7
        iIL5e8kGo/wUqutpgDdPqwCN+aKbHyI=
X-Google-Smtp-Source: ABdhPJwQi57RtGRj+QIaIMNLhaUJxmhtUs6CH7OxwJFBhGoiXBgwop8L3CAMhVC6jLzsaOJahimgsg==
X-Received: by 2002:a2e:890d:: with SMTP id d13mr1971222lji.327.1622675343527;
        Wed, 02 Jun 2021 16:09:03 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u1sm147208lja.99.2021.06.02.16.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 16:09:02 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
        <87wnrd6wqj.fsf@osv.gnss.ru> <60b6c08f75c1c_40442086d@natae.notmuch>
        <87eedktq4x.fsf@osv.gnss.ru> <60b7f7e03fc64_16925f208d4@natae.notmuch>
        <8735tzncr0.fsf@osv.gnss.ru> <60b80752a4c08_16dbed20839@natae.notmuch>
Date:   Thu, 03 Jun 2021 02:09:01 +0300
In-Reply-To: <60b80752a4c08_16dbed20839@natae.notmuch> (Felipe Contreras's
        message of "Wed, 02 Jun 2021 17:33:54 -0500")
Message-ID: <877djbkgoi.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> > Sergey Organov wrote:
>> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >> > Sergey Organov wrote:
>
>> >> >> [pull]
>> >> >> 	rebase = merges
>> >> >
>> >> > Can you do `git pull --rebase=merges` for a while?
>> >> 
>> >> I never use 'git pull' for merging, and all the time with rebasing, so
>> >> what's the point? I mean, whenever I do 'git pull' I mean 'git pull
>> >> --rebase', and whenever I need to merge, I exclusively use'git merge'.
>> >
>> > So you can remove that configuration.
>> 
>> Sorry, I can't, see below.
>> 
>> > And afterwareds set pull.rebase=true so you don't need to specify
>> > --rebase.
>> 
>> I don't get it. What's the point using pull.rebase=true instead of
>> pull.rebase=merges? The former is plain total disaster in my opinion as
>> it silently breaks history shape.
>
> I think there's some confusion here.
>
> You said you always did `git pull --rebase`, not
> `git pull --rebase=merges`.

Yep, I was lazy and didn't say `git pull --rebase=merges`, sorry for
confusion.

Though in fact my phrase was meant to stress that I use rebase as
opposed to merge, and I left the details, in fact because I thought
--rebase=merges sounds even more confusing in this context.

Thanks,
-- Sergey Organov
