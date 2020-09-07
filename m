Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93844C433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 18:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40355206B5
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 18:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5vwbO+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgIGSAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbgIGSAR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 14:00:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FE2C061575
        for <git@vger.kernel.org>; Mon,  7 Sep 2020 11:00:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so16585820wrm.9
        for <git@vger.kernel.org>; Mon, 07 Sep 2020 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QUT5CzGeeLvMW9/TNQx+CFrcsv1L7wwCTej5+f5WOtU=;
        b=S5vwbO+R8w8F/Lm6O4CGpkFtjXVI2HzNh665qMsIN+ErP/TalLYxhiSnt5a9m+mUcf
         UoN7VZbh1zCUMqlwir2ZYkHtgn/iXgoMQ4P21mv4EYGZ9OF1IqLp1+/XLaZzytMgIc3t
         wYapm2BA8OQoEa19aCxjEQYWc0oipR+nJVh5aKk+TkRoqY0Qu0j3SRnfEJ8Nu7ZB7R+l
         4gYk3dGJQpuRIE2xyXHN8++PBGli5t03iMzwlzwUxGTl0VjXCg0uXArYmMpIIjuFLfAm
         E5z0nYRXTgm9CMNYHpdOxErlkA5Lh1Bp+cGWp3tl+OVaws3kPcfjdnQ61VyAVC54CDgf
         I+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QUT5CzGeeLvMW9/TNQx+CFrcsv1L7wwCTej5+f5WOtU=;
        b=fQ943g70R3Rl/FrI0BNIvUyxA9iciHWsIs48DuOqjtQ/cVEVihVTM4wuOttkx0sp47
         ls7W6VPAxhm/7r92u9HvK7xfAUup9G1kjEGsrODYdxiyoTjki6oj7YCTSaE1h7UhrWrk
         hi+0G6rq/ah6pVa0/Cmzmef1WHZ2T5VwmBuQkCF+YZ5rJ5iI4uqO72nzm3PKDex+IvpR
         ixTQLgOUTQ+aHm5LQPRWrTp52MbJVGrwZqlUfq3C+ZrisHKP/lKzFcGczsNMnohgImBR
         XfmxK50rwUbIM21wS0K6IkzVCbiKHbKh3k+xBQHJChBhdreyRukzlZQnnnmBLwJ6/UFr
         ZrVg==
X-Gm-Message-State: AOAM532KCAszIrS7f8Spxl+sC7V25/EcNKp8M+uEfEvE0/cwUvX561XW
        jyLji1YFNRz1fUFgyANoLQxW+vhis1o=
X-Google-Smtp-Source: ABdhPJzShWUFvbrm2TiR4wGNZNotczcfFPpB8dSy+vB5Y8//+xKxiGwY9VwSutVPPDdUCzItxqWvdQ==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr24103412wrl.419.1599501614761;
        Mon, 07 Sep 2020 11:00:14 -0700 (PDT)
Received: from [192.168.1.201] (151.252.189.80.dyn.plus.net. [80.189.252.151])
        by smtp.googlemail.com with ESMTPSA id k8sm28081412wrl.42.2020.09.07.11.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 11:00:14 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: git add intent-to-add then git add patch no longer allows edit
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>, phillip.wood@dunelm.org.uk,
        Thomas Sullivan <tom@msbit.com.au>, git@vger.kernel.org
References: <C55J4YTSBL48.171K3FSJLUQOA@ziyou.local>
 <1071d841-a030-30c2-e50e-6d97eb494fea@gmail.com>
 <nycvar.QRO.7.76.6.2009040831570.56@tvgsbejvaqbjf.bet>
 <xmqqd02y7rwj.fsf@gitster.c.googlers.com>
Message-ID: <a8099cb4-97e0-5596-72a1-10402762015b@gmail.com>
Date:   Mon, 7 Sep 2020 19:00:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqd02y7rwj.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/09/2020 18:10, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> Thanks for reminding me, I did not really think about it anymore. The
>> built-in `git add -i`/`git add -p` has been available since v2.25.0. Since
>> v2.26.0, we also respect that flag in the `-p` modes of `checkout`,
>> `stash`, etc
> 
> That is 9a5315ed (Merge branch 'js/patch-mode-in-others-in-c', 2020-02-05)
> 
>> And from the way at least _I_ read the commit log, it seems that the code
>> has been pretty stable (except for that bug fix where `e` was allowed by
>> mistake).
> 
> As long as it has been widely used, that is. 

Exactly, I'm not sure it has been that widely used yet. (I'm
interested in this area and only got round to using the C version a
couple of weeks ago so I wonder how many others have)

> I do not think we
> deeply mind a bug like the `e` one that does not affect the utility
> or the correctness of the command that much.

The bug with editing in this thread is also fairly minor I think. I
suspect the main area for serious bugs is hunk splitting and
joining.

>  If we do not flip the
> "use the built-in variant" for those with feature.experimental we
> really should do so to widen the canarying population immediately.

That's a good idea

Best Wishes

Phillip


