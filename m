Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639F320281
	for <e@80x24.org>; Thu,  2 Nov 2017 18:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbdKBSmT (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 14:42:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50359 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933207AbdKBSmS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 14:42:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id s66so795476wmf.5
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PETWm9jSOgYKYZ0skxnP5CG+ziUssQF1podSkoGstS0=;
        b=Atl5lVF3NQOdOGLeHLW40vT5p9A+UOm+ThJCgdxMzmsXqJKWEyTIRvy3HhnWIHbN78
         DxcLctdCxXvIKafLK0KpYoDiR2RtYHwp5UiqBPekE/fSTxTGk93wLiDh9rSFSHy0nwR1
         f7JLbM5EVpios15StP1jDvMn7jefWNFa+6Z4zPDRFFv4tIsxfMAByjTwyCicUJ5Uw/7e
         5E5YLXiCslRf034nTeN4TnN03VXEuyzLJLaDBFVoaJFlRyrTeeER2+UzgWu5FGcs+QeQ
         5qUVlw1BXNxaPpbNd5Dw66wSvepj/AJBUoteozisG10ORaoFcWYh6r7hlslky7oTamb0
         6+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PETWm9jSOgYKYZ0skxnP5CG+ziUssQF1podSkoGstS0=;
        b=qUCxigNMwSCLYpElsR266A1ARlKcqihQBhmllXEPfvNWDD0G0pOgTuUgRAlkIFDPLJ
         1tvkaituF5kxPrgrlj0rb+g6KdrlMYbe/XLIbpxXGiF1PYuKr6nC2C8bT/cl/o8xsCfL
         0r0y08Ck4/WqxNoz8lmyjP5ReM+KQ30hdl9w7GD5CDPOYohS4VVNRoeylQ1nvxS/Zqm1
         kAt241RfxS/3Hfchu/0jOAqCyfDY/uBof8BiNRKIFCPW7Sm/4/q4ICJfbRW2Ncx5i8yL
         De04NkA7Vsf/9KPdP+GXvpQuy9NNp5Ifd0mG0h7uKfYWNYPmMVs2yar8FTb5M41kQA+J
         aA+g==
X-Gm-Message-State: AMCzsaVq2dtJrRaJTsEWPARtOMnimlnpnJ6UoxvedrkzEMVL9jhSf1gj
        9ue7XdJAkluUae8NbYMrbS7dgPkSCkj+33HWq7Ighg==
X-Google-Smtp-Source: ABhQp+SANLeNC89fIv8kc/BsgkZ+6HFJNzt7W7xm/5afFBY6GqEJ6Yoe/VOcYaryIM2Gg1DTTobtYrpf0lobrEDe/f4=
X-Received: by 10.28.208.2 with SMTP id h2mr2267609wmg.13.1509648136671; Thu,
 02 Nov 2017 11:42:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.195.125 with HTTP; Thu, 2 Nov 2017 11:42:16 -0700 (PDT)
In-Reply-To: <e8a600d4-880b-4fb8-6901-78acbd720261@gmail.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
 <20171102065407.25404-1-kaartic.sivaraam@gmail.com> <20171102065407.25404-4-kaartic.sivaraam@gmail.com>
 <e8a600d4-880b-4fb8-6901-78acbd720261@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Nov 2017 11:42:16 -0700
Message-ID: <CAGZ79kY-1PLf2aOeNOkPz_MNSPtJHTtj=9eC-xdbbLq+WZbkwg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/4] branch: introduce dont_fail parameter for
 branchname validation
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 1:39 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On Thursday 02 November 2017 12:24 PM, Kaartic Sivaraam wrote:
>>
>> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
>
>
> I just now saw this small glitch as a consequence of recently
> changing my email address. I would prefer to keep the second one
> but as the other patches have the first one it's better to keep
> the first one for now.

If you prefer one of them, you may have incentive to
add an entry into .mailmap file, otherwise I'd kindly ask you
to. :) (c.f. `git log --no-merges -- .mailmap`)

> But wait, it seems that this commit also has a different author
> identity (the email adress part). If this is a big enough issue,
> I'll fix that and send a v4 (possibly with any other suggested
> changes) else I'll leave it as it is.
>
> BTW, I added the Ccs to this mail which I forgot to do when
> sending the patches, hope it's not an issue.
