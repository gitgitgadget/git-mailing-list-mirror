Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3942C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 02:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiLVCpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 21:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiLVCpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 21:45:09 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075D11C431
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 18:45:08 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t18so298881pfq.13
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 18:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkusS7L9R6bSIZk6uVL2wiv4CjJTbRadEXo9uS5Z5b0=;
        b=UGTP0qemqxPme3att9UXbwmyMi6qASzPzjKPuP91eY+YAgjNFytFFAOCt5mjQITbQ1
         Z73EtidcQmd1y2LmGNK695PYcOosEYM/ZKFgLJBkZDMdg62zjFCnzkl80R9VpOcORLAw
         tkzOm5gbt8J8wZs+478z3cwr9ndOsCPLTHHRN6/4FkpKId3CZbhsvl8lBpbSb1pSb8YR
         mvrQga+C/27WIZ+gFWq31/qkubc1PTQikMf+qOVEzZ25/6IzYWRFYKNhCC5D5BSeq8N0
         smhCCBDJmZCebCRXLgBEIShl5aFriDQrXKeuNFjgHCVKTaE1/CQ2H05EIBloJdT+b7k9
         VlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rkusS7L9R6bSIZk6uVL2wiv4CjJTbRadEXo9uS5Z5b0=;
        b=TJIgLwU42LaIlmcYcnygQJF9tEex0tMTElRtICVGjtZaqlZKvAOWOsnTHrgPaEMQa7
         KjZI9q/Ku3EyJxjmxJ85m8AhpX7nJIrdRFVXvnJGArVHPd4m061FIi1ZGGxW0lNEwXKY
         KV7WCYWJNc8rrXjrUNIzYak7BME2xmsaEGK2+FNW7k86pe7HDuLdjwETEh/NW0V+0Jji
         y23Km4ZEKHR2ZFFqZ+euCAKztc8XDfIyvOXwc/chboPjJnlnMXcfFiy+k487d/g8F7VK
         PKrwr5aSD0cyTv0b8s6OTmNLHIFmcnzJ73vCmfoA8Aj3Zcvj3KbA657R08sThbM6tG/B
         9QnA==
X-Gm-Message-State: AFqh2kq6UHiB+V1lag1tWwQsMwTISS7IECrUU96aP9L9aXfcs8xN+t5H
        MH0XLqsgvtOGry+1Kg4WCrtH3R57COk=
X-Google-Smtp-Source: AMrXdXs82xwZl8XpXF20T8DDd4kYrpAvaJzT/p29T1laRC8lVBV4XvYmuQv3Qn2VSHJOIDyNTZyT6g==
X-Received: by 2002:a62:ab16:0:b0:56b:d68d:7136 with SMTP id p22-20020a62ab16000000b0056bd68d7136mr4675891pff.11.1671677107528;
        Wed, 21 Dec 2022 18:45:07 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-7.three.co.id. [116.206.28.7])
        by smtp.gmail.com with ESMTPSA id y28-20020aa78f3c000000b005774d225353sm11290687pfr.137.2022.12.21.18.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 18:45:06 -0800 (PST)
Message-ID: <cb56a570-d555-699d-b699-6bf23e63193a@gmail.com>
Date:   Thu, 22 Dec 2022 09:45:03 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: feature-request: silently stops ssh-agent.exe when upgrading
 (windows)
Content-Language: en-US
To:     Jean-Michel MERCIER <jeanmichel.mercier@newsbridge.io>,
        git@vger.kernel.org
References: <CAOLx1BgQinzZBkHvvmDrGUedEyQa_7ZVsyVGmWjF4gYhxc3P+w@mail.gmail.com>
 <Y5u/E04V0QWQTDhu@tapette.crustytoothpaste.net>
 <CAOLx1Biwd9KzqipoEPaw0M2AecW7XfuyvNeVW4F59e696gMt-Q@mail.gmail.com>
 <CAOLx1Bi189tdo1Yn7njv9BjMzjuVOT8MSZH-bx8o-nS6gQpQTg@mail.gmail.com>
 <CAOLx1BibKcxrPp3fyUbGXM-d_JZKot_MLznB9EXF3CkVKkHtZA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAOLx1BibKcxrPp3fyUbGXM-d_JZKot_MLznB9EXF3CkVKkHtZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/21/22 22:58, Jean-Michel MERCIER wrote:
> Hi everyone
> 
> Just for the record in the archive if anyone is finding this thread:
> It has been handled :
> https://github.com/git-for-windows/git/issues/4172
> https://github.com/git-for-windows/build-extra/pull/453
> 

OK, but please don't top-post here; reply inline with appropriate
context instead. The context has been deleted, though.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

