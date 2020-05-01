Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12124C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 08:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3162166E
	for <git@archiver.kernel.org>; Fri,  1 May 2020 08:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/2wnQP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgEAINt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 04:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgEAINs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 04:13:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2078DC035494
        for <git@vger.kernel.org>; Fri,  1 May 2020 01:13:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x17so10663397wrt.5
        for <git@vger.kernel.org>; Fri, 01 May 2020 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ze7UiWMtyYqhEOQF91SsvUl6BZdGSfr6IAEbc4WO0/A=;
        b=b/2wnQP+OdAci+xKnUBldOgEvDcPV/Yd9/MdyC55qPhrbpQTRLPeNReP3bih9ZaPsA
         CGpD/waVvFKd0SiJPA8X5TpqadZ80DQIRWKHIPV+DN96Dtfo21cGpy/IsuLmpvu2Oc5p
         CV+ELNIh/1o6FdHHzoI00m+WL+9OJYBL62moG/dQaPK6HIfYAxsmUJRVEm6Z9GU/EGH9
         7r0NsUlVTrV2q/sk+2Zd9hWpJ6vFZYcCdgJegqCKYVwJoaUw7DCNu1fS7S4gTuU79SPO
         hjnKr0mKdsi4fyAdIZHTL9ObKghtAF56mXP20WboWC8gEhsdcYr5toi9ZPG1wVDoIIfp
         ySog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ze7UiWMtyYqhEOQF91SsvUl6BZdGSfr6IAEbc4WO0/A=;
        b=Mi+/aBp3B4FISmdRKIV2BhxVXSZDilW63BQCNt98/ocXqVhUEEw/vAOyZplNjCLA6S
         rPJzr4Jv6F53Gq+7/MDIMSrM0ic91fkZJEIXNo3zep6IvQ0lE9g33joIJ2aukPLIvrD1
         S35hTs8X2Vy5hEXpSIDOblnjfl9jb0xAGtQ3smaV90w78tMBeXGFSYWjyGMakOpMC52N
         QB2jSTlz/9maZ3tiNmmFZDHm+ebncCPGlPKEmE6EzTYCTlfwjyxR58PVP7Hyds2RKFKC
         gH6WIgNRR5oXXQjO79k+8ZBibpWweSPiz+wdQ9a9L1NgCYcXDHj6ShzHDTr+MXzuLUUV
         uh5Q==
X-Gm-Message-State: AGi0PubkqdEXZGnQxNhJDrcqtoNnMeX4umybPc3yoRWIdbhn7ndJgFDt
        Z2dlBXC/GODL07yWbTRlFR0=
X-Google-Smtp-Source: APiQypITqkmwzcX1tExPiJQDc2H91m3s3i60QhInWkhHXgNvS6yBYZYZxyxSQbjDpN4DP6l9T8l3DA==
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr2858831wrw.402.1588320826762;
        Fri, 01 May 2020 01:13:46 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:7894:cfbd:fd0:5824? ([2a02:a210:ca2:9c00:7894:cfbd:fd0:5824])
        by smtp.gmail.com with ESMTPSA id 138sm3077632wmb.14.2020.05.01.01.13.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 01:13:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Seg Fault on git fetch with fetch.negotiationAlgorithm=skipping
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <20200430202014.GB2014@syl.local>
Date:   Fri, 1 May 2020 10:13:43 +0200
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BFB84B3B-FB39-4217-A6C6-7599F6F755E2@gmail.com>
References: <450D5CC7-113A-40D8-9CD4-53786198526D@gmail.com>
 <20200430202014.GB2014@syl.local>
To:     Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

> On Apr 30, 2020, at 22:20, Taylor Blau <me@ttaylorr.com> wrote:
>=20
> Are you able to share a core file? If not, it would be very helpful =
for
> you to 'git fast-export --anonymize ...' and see if you can reproduce
> the problem on an anonymized copy of your repository.

I played a bit with --anonymized yesterday but export/import is slow and =
I still need to review
the history to see whether it could be released.

It might take more time than just a few days.

> I can speculate about the cause of the crash from your strace above, =
but
> a core file would be more helpful.

I have added perf trace2 in =
https://gist.github.com/sluongng/e48327cc911c617ed2ef8578acc2ea34#file-per=
f-trace2-L52
(git version is 2.26.2)

I think this trace is a lot cleared than the strace log.

> Thanks,
> Taylor

Cheers,
Son Luong.=
