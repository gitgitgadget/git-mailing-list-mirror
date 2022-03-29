Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A229C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 14:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbiC2OMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbiC2OMB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 10:12:01 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2A82A260
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 07:10:17 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id bp39so15302945qtb.6
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yJgZkhc08wJs2e/Bkv6nuoShpBCAF/OVwvKBGWHflxM=;
        b=AOe7zHynoAPnAmmpRUiM8rrDyS1gK+JRkrRPt+8FhH7YpVBUsn7lPnCSSrwqLII0tg
         BNNUY/Hft22GAOodwDlShMnLQKeBG+fWNv5B+wZBHrwA5IpNmZTybFbY18HSMUGADWMf
         eWv2kQHts/sjQywYUwTC7fM8je83tRMWstq5QbX1MBxhpOMA4ShihF1Weho0BG/6CuEX
         kZ8x00Aqo4v7x8yQOgR+W/J7EVNS3zfYdvTr4UaBCPghzBKpimXh/KwdqCXCRxFdqWxw
         1uLiyqDFbXWjjeHgl7+hU7O2860Mwom63UAotDxw3ka8HGRRJGXs7Y7i9NfVnun7Uyt1
         2ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yJgZkhc08wJs2e/Bkv6nuoShpBCAF/OVwvKBGWHflxM=;
        b=uhYny7yUkVe1SCb4lshLLWOrJnfrK5Em9hsoEOYirJvO5S8IcZDpuptnjAnnZAc1sE
         Pp6VQMeVsKWQ6vXm+1HpNCw6sK5PoATnNfYsdII5rMdufeNnARr6G7YgKe7Luel+tHZ/
         RtxYEsZfr/vtmtjkrKokGMaIG39Qp7cSoZ6HoE+a1SvpYm6fGnBZL3ONPMokzp/8fKVD
         SJu2xYxo1YXvHFVUICUi/PpRDQiyCJFFDcOoLOJ3QkLrwqz/onczp7/3mdHPnRH5vd3Q
         Umgdsh9jwAh4/7doG4DJ+ET/vThu8YH6nZoLkkuLT9vqzvb1ivWafVOEalrXr9gH+ZrP
         8wXA==
X-Gm-Message-State: AOAM530Kp1OP+M5ItqkmRCiBpAYgjZrdDM724kR5Qz+aoS3VucIEI+BT
        sy8+Rym/E5t9kY9iKPa8ILA=
X-Google-Smtp-Source: ABdhPJyk/At0WKKqC/PxPbotr1YcJDTbvPTarMvbhn0GfLKg+EHDie+bPGAMNsfiLW1b+5O102pcNw==
X-Received: by 2002:a05:622a:1115:b0:2e1:fe6b:2f1b with SMTP id e21-20020a05622a111500b002e1fe6b2f1bmr28014686qty.118.1648563016936;
        Tue, 29 Mar 2022 07:10:16 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b0067d47fb5aa4sm40802qko.63.2022.03.29.07.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:10:16 -0700 (PDT)
Subject: Re: [PATCH v7 0/4] vimdiff: new implementation with layout support
To:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org, bagasdotme@gmail.com
References: <20220328223019.271270-1-greenfoo@u92.eu>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <374f45ff-ca55-780c-3b26-8b7c6a761725@gmail.com>
Date:   Tue, 29 Mar 2022 10:10:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220328223019.271270-1-greenfoo@u92.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fernando,

Le 2022-03-28 à 18:30, Fernando Ramos a écrit :
> Original cover letter (see v7 changes at the end):
> 

Just a small suggestion, it is customary on this list
to send later versions of a series as a reply to the cover
letter of the previous iteration. This keeps the whole series
in a single thread, and also allows tools like 'b4' [1] to apply
the latest iteration when given any message-id in the thread.

Cheers,
Philippe.


[1] https://pypi.org/project/b4/
