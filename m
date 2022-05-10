Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0701C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 00:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiEJBBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 21:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiEJBBI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 21:01:08 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFF143EE6
        for <git@vger.kernel.org>; Mon,  9 May 2022 17:57:12 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y3so12548966qtn.8
        for <git@vger.kernel.org>; Mon, 09 May 2022 17:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tO2Yg/pdZ0vfwkOtsP6uZnINuVXWicCC+5S4TCgZQzE=;
        b=XicIEK8/zZobRvt9IvEVGDAmCga7ieBge4mqqPKXQ/Dbb0uVt5qYkImJPFV9Sf8ZSi
         Bm1fH//+lLTYpejSQh93T7F23n3Nuu+6SU+WY3+d6+o2GnKMJ9p0CsQit8mJ7VptvL0n
         Gofxf6VL2LRaWLew1msxgKy2jFFNS6ez4Qt5QfF285OV4Ku3B+Mmgja9ZkviKIo7XwG8
         lbQcQoYPE07gehbgrNeHEOWd9+ykXs/kTIZwCv0pkXu9ink2qBstVNEAd+6+WTDYrSMk
         Ej8qeI65Cet/qjWKd79wHsHkTlwqErWKhGQ1KCxuy7tURstDd+EZTdtnrxZu0Ul4vERu
         OopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tO2Yg/pdZ0vfwkOtsP6uZnINuVXWicCC+5S4TCgZQzE=;
        b=MW/rOuWBZMMBs36MLsprQ4Mcn6NL0cofA+MJUGxmcvFXhLo6n/R7rpMV8IdL7AuskT
         dvFgDD9rX0AkORnh/YdL7VzuwOLdYSsUU7lMsY2up8nZND3Ux6+YeVKJLF9UnOdHYCBm
         Lt40smhOTE74rx4jXp9vppX/vZS1GQv1ITWh8CLhtaamiQwPz0PJhJnvYT7iAiWwjUMm
         3qHrHm5cv4uH9ZH+ckVb3iU5bEZWrdEw864jKeLGW0DDybr2PvjO8N5kI1x1SyfyBSbQ
         GtxBeQC8Se/FAKbUCjaBrZ7fKcefnkYtbuhkx0nNwfMsGwR/fKuX3RgTCdcSP/hjfViR
         ArGQ==
X-Gm-Message-State: AOAM531hYYQFNQkTvO2SMqIa6X00yZ8wQqc6+Cx3dRTxytmMkiSOAjxi
        q62hcjUUb5kaLlmgvspEKQgz2jCcApQ=
X-Google-Smtp-Source: ABdhPJwvF9jiDLMrSMhGEXZuDNqs2/zErN8/OnXEvasyccJZ5dPYWYQj4J0XtA6qqVvMbs5e1nG+Zg==
X-Received: by 2002:ac8:57d2:0:b0:2f3:b3b0:ecbe with SMTP id w18-20020ac857d2000000b002f3b3b0ecbemr18248327qta.29.1652144231851;
        Mon, 09 May 2022 17:57:11 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id c138-20020ae9ed90000000b0069fc13ce211sm7521748qkg.66.2022.05.09.17.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 17:57:11 -0700 (PDT)
Subject: Re: Bug Report: fetch.recurseSubmodules doesn't affect git pull as
 otherwise stated in the git config docs
To:     Glen Choo <chooglen@google.com>,
        Huang Zou <huang.zou@schrodinger.com>, git@vger.kernel.org
References: <CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com>
 <kl6l5yme8epc.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <66468ef0-663f-7088-1c2a-1e2b46925a64@gmail.com>
Date:   Mon, 9 May 2022 20:57:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <kl6l5yme8epc.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2022-05-09 à 19:32, Glen Choo a écrit :
> Huang Zou <huang.zou@schrodinger.com> writes:
> 
> I've sent a fix at [1] :) I intended for the patch to be sent in reply
> to this thread, but I clearly don't know how to use GitGitGadget
> correctly. Whoops

Yeah, this is not supported by GitGitGadget (yet?). So it's not you :P

Philippe.
