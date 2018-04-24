Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02BA61F424
	for <e@80x24.org>; Tue, 24 Apr 2018 00:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeDXAi0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 20:38:26 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:43954 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932611AbeDXAi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 20:38:26 -0400
Received: by mail-yw0-f172.google.com with SMTP id y3-v6so4181272ywi.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 17:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=TQwoWky4W/NLpEKgCfnWy+QAHHGc/UZp23HwIQ6at74=;
        b=WawPxpIPXqJRMqCZwryDHCMxbCOslU4wctT1foJ9177NZIwE36Y3d4+hAEXh44on7i
         MGqnZS4jWcF66ucag9Pdqgw0xtTl6nq+5wJl1U8PDrtuTXUadYrNBe5g0EN1jy6727Ah
         D5KaP2k7065mtJvvO5she3L6xdTamI+CqZTc/RN/7HEbpyBTvQaCnJaiCJWYXx9t86jq
         Q6Koj4a7DhwmanDmEYkmHAZNnk8bsoN5jiiiUhdUodSXShm7kVZx3CKfUqrW31ZJjA/j
         VbDi4HZKzQV3VJk3oy0nnVggsO0pS0Q3ZLH1vVID2lp6YjFzHEsWV20NunHBCv/1H0l7
         tR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=TQwoWky4W/NLpEKgCfnWy+QAHHGc/UZp23HwIQ6at74=;
        b=dNb1rEVudxBlyq0MRZ/SDQXdqRxRUnbqsBQS8Wa/UTkPmH2xLnk3OdzhKIrgFUsMv9
         VrU6brOH7g4mo0kQrhI6VrGsYyy0xCzQEVb9vqadNtJqH3/HLylYZKQu12VkkZA8eLyU
         yzN3gw1GHcxWzvPOGv6HVK4y2ZkBxOApk+MCxHq+hyKARCk9R5S1gSz0slQmN7g8ZtcI
         Zjqo0hQ957J/d7NuuaWMP3hBkfDGh5pJvMLWpQytT9gxXPP7A1pWRPCGYwmj66po1NbY
         I3ybTc/bi9dEAlpHmQmCrOzy7Di6a6S0jz7B0HX1ne87YFZT18sK+wfwUmQRHhqoq9Qi
         LG6Q==
X-Gm-Message-State: ALQs6tCwZ4SyklkFc61zymO42qYwncsA6qnzQZYljempdLTwwOcPBmOs
        d47blZ53XpXMraXqXGE6TE9PZNwPBsCG7fwNud4sdg==
X-Google-Smtp-Source: AIpwx48ZLJ+BKF/pBx5gbJMCyiRigl6Z36UViycJykGCkiwEdEZ04F1LgOSeKDjGKXR/HWGrCHdF72/FpRhTuyEnY2w=
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr11823498yws.414.1524530304941;
 Mon, 23 Apr 2018 17:38:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 23 Apr 2018 17:38:24
 -0700 (PDT)
In-Reply-To: <20180424003414.GB245996@genre.crustytoothpaste.net>
References: <20180423234327.250484-1-sbeller@google.com> <20180423234327.250484-10-sbeller@google.com>
 <20180424003414.GB245996@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Apr 2018 17:38:24 -0700
Message-ID: <CAGZ79kYzUbR-OSUn-174f9SwKjNQ7LTw2FcSiSpnZmmdPrAuMA@mail.gmail.com>
Subject: Re: [PATCH 9/9] cache.h: allow sha1_object_info to handle arbitrary repositories
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 5:34 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Apr 23, 2018 at 04:43:27PM -0700, Stefan Beller wrote:
>> This involves also adapting sha1_object_info_extended and a some
>> internal functions that are used to implement these. It all has to
>> happen in one patch, because of a single recursive chain of calls visits
>> all these functions.
>
> Ah, yes, I remember that recursive call chain.
>
> Anyway, other than the one item I mentioned earlier, this series looked
> good to me.

Thanks for the quick review!

Well, this very paragraph that you quote also mentions
*sha1*_object_info_extended, so I'll fix that, too

I'll wait until tomorrow for a resend to give others
the opportunity to weigh in as well.

Thanks,
Stefan
