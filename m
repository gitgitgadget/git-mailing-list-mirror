Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CF7C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 15:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7CB20897
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 15:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaYERN62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgHRP6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgHRP6I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 11:58:08 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BC0C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 08:58:06 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f24so22713087ejx.6
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LiqDBNpyXN2bifSjS0LJ/wTAfNT4QbYorryIHKjb52g=;
        b=VaYERN62LPDgYiqPpH2YB+lGSv1zCk47HoSRxgxdvcQiZDDzSm6SX92h4alt8bD2vm
         IhVTz+u+0VzKlQgVJeIbkPIFYZB5jiqbgsAs0I23DvsOgu2ZZmME9tTeNxzh5IRLangK
         ex3mexx91U6utqNCQYHF7XkFqZwsBVz7FHFJzEGR47kualXCYXG7QFcklbGnIpPpC1tn
         ijBxkVNVEuCsg0PWwsiPlSdTRiUH7XoQwf1WXG4qNAg2/Z+54lOisG0eKVL8uMazIAVz
         GD0RarAtr9Qp98XqVdgszo6CF+hRRSzEANRZNg0+yc5PM9iTjHb80s2KhNMrtycobb7u
         SQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LiqDBNpyXN2bifSjS0LJ/wTAfNT4QbYorryIHKjb52g=;
        b=cHNBY6b0pVhxlF0qI/7MMvgs9TmzPJtt2XLMjgjieuWNKhJW+5tR1vMsKAjzcRNava
         eM89eIJTmt2npwKDLY7pbUA6mFP7WXsmSG4O25pmdjgZHbLZ5odAOUwicOKEbHcIJrX2
         /7nk56AwHBHZSV9Z34TAvzNylSNfcG5Olbp4I2a1C3Qnmi36NA2PBhK4nN4l1p2HFYQL
         bsU6OCi8h0U0XdHwUbBqxsLtxauH16MPmfUxGS9YGF3+BDd/4VKiUjyN91xKhNspVdNo
         bKjAwG6hJ9kJTfWz5t4WxOnRMUs6dX9lzmM4Gq3SUMww7PlvSsRdq62V64tcFfqXmC+V
         7DTw==
X-Gm-Message-State: AOAM533O69Ol4cByX5/q+PcEyvSg0omoYs271ZTF+s0zfnkZJ0JZeMlG
        xoDuxpl073l5YNmiWZT75s49hgmSWFFmSw==
X-Google-Smtp-Source: ABdhPJyQJ0qGQBxyBK02LI7oKXsobdVwOZNcZGsMRijbtbBXmXDlUhx2dmyXL9xFJGl3Bi2fhQIoug==
X-Received: by 2002:a17:906:fc26:: with SMTP id ov38mr19907165ejb.99.1597766285218;
        Tue, 18 Aug 2020 08:58:05 -0700 (PDT)
Received: from [192.168.1.21] (xdsl-31-165-199-9.adslplus.ch. [31.165.199.9])
        by smtp.gmail.com with ESMTPSA id g9sm15066096edk.97.2020.08.18.08.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:58:03 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] submodule--helper.c: add only-active to foreach
To:     Junio C Hamano <gitster@pobox.com>,
        "Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
 <pull.631.v2.git.1589697023.gitgitgadget@gmail.com>
 <xmqq8shq7edu.fsf@gitster.c.googlers.com>
From:   Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Message-ID: <91f0cfdc-dfba-80c1-6581-d8a240cbcc4b@gmail.com>
Date:   Tue, 18 Aug 2020 17:57:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <xmqq8shq7edu.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 17.05.2020 à 17:46, Junio C Hamano a écrit :
> 
> Does updating the cover letter needs a better support from our
> tools, I wonder...
> 

Hello, well there was an issue that some markdown and new line of the 
cover letter was removed by GGG. How to move forward?

The original text before GGG was:

On repository with multiple submodules, one may need to run
a command based on submodule trait.

This changes add flags to `submodule--helper foreach` to fulfill this 
need by:

Adding the flag `--[no-]active` to filter submodule based on the active
state.
Adding the flag `--[no-]populated` to filter submodule based on the
fact that it is populated or not.
Adding the flag `-b|--branch <branch>` to filter submodule based on
the tracking branch.

