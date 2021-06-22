Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42CEC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 06:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8784A6134F
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 06:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFVHAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVHAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 03:00:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F10BC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 23:57:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j10so5229394wms.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=D+n9bRsTKpnHO1zJVONK23ZIFzvX5ojdys/qj/4jqUg=;
        b=t43TCAo/FACAO2iiWtPRZVKM/RvH4gTcWOdHA/DryTpidAHgTL8m7q5m3Id+q1kjyb
         Ca9O89PnQWCa+n6L+4Lwoh/8Lgbt9yuH5bdibG/FahZa9CYW20mZEn6ghqzzwWBpEdsR
         53rhXeCSCKGCwNxDjDurlSQq4duCYERWLfFemCpBbNm7xIAPNdWAjqNBSCIhkAegaTul
         h7ghwPdeBGyQoa0khHHk3MRIRhoe1+qYF/g/e42OVwpbs8H2SPsqYHLMuofZuvdwrHJD
         qAzT6baT3TjUy+Xv/PMa+XRniQrsITeN/QDfEL/8UEfzR/v/zVgqEYZ8RQL5iy0o1gBy
         dqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D+n9bRsTKpnHO1zJVONK23ZIFzvX5ojdys/qj/4jqUg=;
        b=Od2NEqPoAXhCRZOuLCGheMHaF02TonCk14JyxnvRS2Q9n9JTMQID0qtPlqbNnkhyhg
         cu4pvm3v/5Pt3UJC3DBHcqaTY7Ha/eTdpwnNPZxYBvNS+a/+BAIlk9YiAM9kGy2gr16y
         XE5dsJEv25sSz8Af3m+FNqNp5e0sWcuOkm55wqf0Tj47h7I98MzWBWq/Hp/LMTkrnj3W
         lbN6CZ9qvzNtK1Js80ABhtOWo0G0zmYLSzF/P5NSwT6cWsSSPP+WRyLQ/MWzCU5EUrwT
         OqrJaWDFHwkeH9VRKXBByxYdrVzwywzXaFHYlWJB3OlIygFORQiyOpzwsNz6q7Vh2tVz
         Mksg==
X-Gm-Message-State: AOAM532ht3GOQ0rsQsCAGKOSKjaDDI0OaO6K5sF3NIIxbS53CFZ5E53B
        e+t4vFL05H3zqYcbZkqyQRHkARnXjjcrPg==
X-Google-Smtp-Source: ABdhPJxWL1Anw/Qd+qMVHhGt7W5irjJC5u2ovKMCfBkYMJLli49sYJ7fLwmJ6aUsBMa2JxTwI+ABSQ==
X-Received: by 2002:a1c:9dce:: with SMTP id g197mr2733908wme.176.1624345072373;
        Mon, 21 Jun 2021 23:57:52 -0700 (PDT)
Received: from [192.168.3.129] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id a24sm1355827wmj.30.2021.06.21.23.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 23:57:51 -0700 (PDT)
Subject: Re: [L10N] l10n: fixed tripple-letter typos
To:     Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?Q?Christopher_D=c3=adaz?= <christopher.diaz.riv@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Git List <git@vger.kernel.org>
References: <20210621020740.25577-1-worldhello.net@gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Message-ID: <75fc36b5-4f71-ae40-9939-4c3f560c3508@gmail.com>
Date:   Tue, 22 Jun 2021 08:57:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621020740.25577-1-worldhello.net@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

By the way,


https://public-inbox.org/git/20210520074214.40903-1-jn.avila@free.fr/

is also still waiting.

Thanks,


Jean-Noël

