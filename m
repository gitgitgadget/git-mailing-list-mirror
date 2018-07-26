Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04771F597
	for <e@80x24.org>; Thu, 26 Jul 2018 21:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbeGZWjH (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 18:39:07 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41591 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbeGZWjH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 18:39:07 -0400
Received: by mail-yw0-f193.google.com with SMTP id q129-v6so1117137ywg.8
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 14:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fH+lFs5En+GTG/SPCQw9mdAUQsCnGxpS5VDY8TVhkqQ=;
        b=Z5GHBbtrdQirea26RoAWadk1QSGocIuyuVhWS6ZXQlyC8m8ngv939yJoLQm+RItQK4
         f0abz81nyeCSjf9pHPnm8bInbQsUBDP16iH0ziqu/jQ0S27n/uN4gDphDXofheCfwlLz
         bf1C1O37Wa8s5wBZrUyJa56IjhksMT19jjOpSYh5frB+rDKvbBlnq2jjeXpbd7b+1pTY
         +PEyr81jzJ4IoGNolQB2FYzNM+EdGmuHjR39SlsIr+3GZlcArLDfZTNeL0GHq1Y5sh/W
         KJGjj9QnqrMIIOn4yzG/go6fjSoDBZdQMYUtjBEiIW3WOUKsLUBXOKWvRygGpNL/QKEx
         hA+A==
X-Gm-Message-State: AOUpUlGpiA0sdSB0qRN6/cPD1ImSawKyoRWf8vl3vUmsfTP5O9GI33B9
        +j/Ndn2j7fIog+LF/NR9gb4QcTqrypfxhorgc8o=
X-Google-Smtp-Source: AAOMgpeufEDpSF3LCamLB45CRFBe2HPlZDojMD7evWOEbpxOL2hXIoa83N9mYj5VtRzyGgmaGOFlV2IKqPXSERRE2gY=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr1832241ywr.16.1532640028718;
 Thu, 26 Jul 2018 14:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180725134345.8631-1-chenbin.sh@gmail.com> <20180726134138.12183-1-chenbin.sh@gmail.com>
 <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 26 Jul 2018 17:20:17 -0400
Message-ID: <CAPig+cQQmOpEpUNSjw58b-_+Ep3v0XA+vuqqqgHVOaFgtKt3fA@mail.gmail.com>
Subject: Re: [PATCH 1/1] add hook pre-p4-submit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     bin chen <chenbin.sh@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 12:49 PM Junio C Hamano <gitster@pobox.com> wrote:
> Chen Bin <chenbin.sh@gmail.com> writes:
> > +             git p4 submit --dry-run >out && grep "Would apply" out || echo "Abort submit"
>
> What is this last "|| echo I always succeed" about?
>
> Do you want to make sure "git p4 submit" exit with non-zero exit
> status *and* its output does not say "Would apply"?  The way to
> write that would be
>
>                 test_must_fail git p4 submit --dry-run >out &&
>                 ! grep "Would apply" out

I missed the 'test_must_fail' when I suggested this same rewrite[1],
which may explain why the suggestion wasn't used in the re-roll.
Sorry.

[1]: https://public-inbox.org/git/CAPig+cR2gYEwOTVBMRde35rn9oVsixeerbm5iJV+FmnOiBWxqQ@mail.gmail.com/
