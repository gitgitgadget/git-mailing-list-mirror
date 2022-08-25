Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36AAECAA25
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 16:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242997AbiHYQRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbiHYQR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 12:17:28 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A594298CA1
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 09:17:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v23so13661376plo.9
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc;
        bh=8hflHfS4TorCnld/esx0N+QMEGpzO+zcwaHnTsHMBYY=;
        b=VBDGegE57YNwF6EnaGVDfJ5O5YY89yv1rK+qlEHx+5HP140ScqnacmGhmx4eqRg0Xm
         KwPJUX7qmyNtNhvSldzQU0gOd++Povke1hxKZUk+De7DOY5NsRIsbXZenF2GYsJt8xkF
         QhMhD5EUNBBLZiMJ0qiVv9tbqwdMaHatQQPuJKtBONk+Qp1BqRqa6yczCrvANHkGZiFn
         NtrWh0py1Cfsa9pOHOgJnU6mH3NpFWuwPqMmSG9815oqDLxFr1kqwsRXbwjJQC5f8XzK
         efveM7TptP8/Axl/qUBKMgpSkH4abi+IlnVEGhvraCFC+sC2fdo8QLJvd4PX/j5F/BIf
         fLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc;
        bh=8hflHfS4TorCnld/esx0N+QMEGpzO+zcwaHnTsHMBYY=;
        b=1ln17ZQX11QQvw7tn4f3sj78bZEXFJfteOXDTcafL+Ev/MKlonvMIJg9Xxqf0t8ky5
         2GBrja3kTmJw0mNo/ldQjPwzPbnpJy51wa/YWneASdKRX5eyUUVYwilEJQhqCyONMfyp
         3w3MkA5g23OGjuAoUUlC2LBwm79vBhl6d2QK/cJI4o5ko2tpIPadlnrYos2p73Oy/Rw+
         JlXdBMCLMLxQLG1vrdf6pAiu4G5c8p1J0N/Dh6LDhmUK52XQIgIXVw06htAnfGsi6d0y
         0lwE+2JsRPUZqYBea3ZJ6l26pq2SLTDeCcDu6cD5ECQlfdl/xbIncokie1Gcu0UBfflT
         CWTw==
X-Gm-Message-State: ACgBeo1kdT3FH6/SN1DeYMyxehgDSfpIYV6de0TdM5arop4kVYwh45AQ
        5XdDtTyK1zSdHGHN0d0p3JA=
X-Google-Smtp-Source: AA6agR4pGQ0wFhh1p8gKtEYU1kzaMHWgKUs9u/Cwz/n6uR3iJcbeGXMEiEAf9csOh0/RmPKSsVK+SQ==
X-Received: by 2002:a17:902:708b:b0:172:5267:ed95 with SMTP id z11-20020a170902708b00b001725267ed95mr4308350plk.3.1661444247050;
        Thu, 25 Aug 2022 09:17:27 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id nu13-20020a17090b1b0d00b001f54fa41242sm3784122pjb.42.2022.08.25.09.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:17:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
        <220825.865yig4bd7.gmgdl@evledraar.gmail.com>
Date:   Thu, 25 Aug 2022 09:17:26 -0700
In-Reply-To: <220825.865yig4bd7.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 25 Aug 2022 16:57:35 +0200")
Message-ID: <xmqqwnaw2t7t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> -    runs-on: ubuntu-18.04
>> +    runs-on: ubuntu-22.04
>
> I think it's worth mentioning in the commit message that the reason
> we're not going for "ubuntu-latest" here is because "latest" is a
> misnomer, it's not the "latest", but "latest-stable" or
> whatever.

I think we are naming an exact version because we do not want what
it means to change under us until the situation stabilizes.  

If we know that the version after 22.04 that will become "latest" is
already reasonable when 22.04 (or later) becomes the "latest", maybe
we decide to use "latest", but I suspect that right now is not the
time to do that (yet).  We just have proposed to go to 22.04 and
haven't even used it long enough.


