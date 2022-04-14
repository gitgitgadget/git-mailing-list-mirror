Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7229C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 08:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiDNIXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 04:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240956AbiDNIW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 04:22:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB2113F9A
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 01:20:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id l127so2479438pfl.6
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0X0yAo1+JL7dUERYGJoU/8siA2YwnJfeByNDd8Tjj4=;
        b=WVc3SWB/hHu1uTJGlruilSm1qQoPL3llPFJwV3xW1C1wnHzZqrH7+SIXDeHTLTPwNV
         29NAGAMhiYGrz3UolsIRC8rOVy16cdQuLGl5hfvxAJqr4+1CoIrev+EIK1WWh2f2vBlK
         6QmtaCbBHIXDrlxsbMRn8AXLULDEna6Pq6iuNhkhayLzflSwRQtyvLPdDkzBSGin3fgB
         MaDhX++104oVhz2GqGKoqBceDloPdToKmvpwaD86f3ws8OphuWFMaLhWHVOKwZeGa8Zo
         ypsEfCrdhT3Venx1+34K0d65W4aEHNm3pXbrAfEa26w41i3378Ka6CdEyHmPjEIVoxl/
         +J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0X0yAo1+JL7dUERYGJoU/8siA2YwnJfeByNDd8Tjj4=;
        b=SFKPIiU/cJae69Lk/mV4k1i5ZcRtLlAfhKqmjVw0F7QBqjc8mUNlEEORpqP4BUWBin
         QXeQZR/65gM6A8B5jTBtdhGo8SsorX+saRhJ8SqFIysjOOyiyJWk1qbpDbX9eYWG8vFW
         blFZjHKWakvUdJh/RHBIxO3KQrsUhnEpy14uelooMWX+j4aBJ0WsA3rNLcxnlGrSPXrB
         5VEZbhUZWzO2DHnw+lcn7FUjtCKVieGY+banso/nNy35+BSFM2bKu1U+HmCX0Dpk8URE
         ImHvGMCLvR4WzHa3lip/eapNiBfXXDcjLU32b7RxKWbQ61P8huwAufDu+Rb0vR+d7ANW
         qXXg==
X-Gm-Message-State: AOAM532Jvu17wCHe/LdsYnQ598YHH8ZXuKCMXCujM6YPNrq2AnGGy6H9
        HYc3JRsPA+n07InZjTQR6c8=
X-Google-Smtp-Source: ABdhPJzZq8ITjFpZqlNripNdMhiwblSsueIuPO0Laqhuzmf7nf9junEV3BlEy0mvKJ77VJLTsP9Bgg==
X-Received: by 2002:a65:5b84:0:b0:398:fd62:6497 with SMTP id i4-20020a655b84000000b00398fd626497mr1366380pgr.179.1649924433938;
        Thu, 14 Apr 2022 01:20:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:4060:209f:3abe:ccb:90ec:502c:d6b3])
        by smtp.gmail.com with ESMTPSA id u10-20020a6540ca000000b0037445e95c93sm1233691pgp.15.2022.04.14.01.20.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Apr 2022 01:20:33 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [GSoC][RFC][PROPOSAL] Reachability bitmap improvements
Date:   Thu, 14 Apr 2022 13:50:10 +0530
Message-Id: <20220414082010.14217-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <c2190b9c-3393-730d-1bed-d793c1d32275@gmail.com>
References: <c2190b9c-3393-730d-1bed-d793c1d32275@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:

> That's good to know. Do let us know if you have any experience with C
> and shell programming outside of your contributions to Git.

Thank you for reviewing my proposal. I used C language in my B.tech
classes. I never used C in practical/real world projects before. So,
putting altogether, no, I didn't use C and shell in real world projects
before.

> Good to see your various contributions to Git so far. Good work!

Thanks.

> s/indexes/indices/

Oops, correcting it.

> > [ ... snip ... ]
> >> ## Estimated Timeline
> >
> > [ ... snip ... ]
>
> Taylor has shared feedback on the proposal and timeline which I hope are 
> helpful to you. Specifically, Taylor said:
>
> > 
> > So I think it makes sense to try and find a way you can dip your toes
> > into 2-3 of the sub-projects and get a sense for what feels most doable
> > and interesting, then focus on that before allocating time for more
> > projects in the future.
>  >
>
> I agree with this. It's better to be practical than ambituous when 
> planning the proposal.

Okay, I am willing to work on first sub-project then. Should I remove the
other subprojects then?

> Thanks for letting us know of possible things that would interfere with 
> GSoC! Do make sure to keep us posted in case you come to know of 
> anything else.

Yes! will surely inform you in that case.

Thanks :)
