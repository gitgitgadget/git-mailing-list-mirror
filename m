Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE016C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BA460F90
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbhJHJg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 05:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhJHJg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 05:36:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE12C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 02:34:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cs11-20020a17090af50b00b0019fe3df3dddso6945738pjb.0
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=hbC1pTHOF2WroVuoRGH+um4K0slfCQ4gtit6g6WTJyw=;
        b=XCv04NfUbFEnA3OxSsK/7KJPs0/vf6sJWnBdf9Ug6n0uIHiPsrfRp9pP1OGI4utfpt
         cr3EJXXVAgSfN3KvvTkGNvasvTyYV8yGFONJz7AwEscRAIeGTI5AzTOCZ2DdogZLUyiC
         aGL4PkY9MVBwY3uiV/qlWqZasvPp0CjdADugTzS7dWE8Bl82xWhhv1vnhe8VPWCjo+h3
         A9ARvCajL1LFaV+QuZ2aoailzzZrzNMRyGSzVmnPo7k8+R5MpYpAdlvDqDOegwT3R/i/
         ZbpswxiD2RgpIUT1XzdOomk8jUI2JMJUFWli6OcVVPVgVYt5X5Y+kRxLMc4ELgHH/p8h
         BH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=hbC1pTHOF2WroVuoRGH+um4K0slfCQ4gtit6g6WTJyw=;
        b=18M4fwqB78pUiT04ovm16obcn5Fi0/8bCMcO/mxk2Oxgo6TADmcOvQjFQpgDBITZXB
         YbhPLboOtD3qVVVujDlkt6jzZvbQUKUnS8THNgwAgYY71G7N5xlLT/hM41XdXi+TCyDt
         bQi+8wUFtjBFK/L3wwOgouSPQMc2ZvuP4xiP6GdQAkj9K2G40cNjxlyIIKj1prCzO52Y
         tjnGchNmsHAia/91x/ZCHJ86R7A0aqYKUse/sfwTQ2jowzBk598Oeud1TMPUT6FyrrMr
         yFJcrHbj+HNdlUKF+jM4VWnn1ygxCghRRY1U1eXyMop7X+xrDVLOzbV5ZsUxM4aY1j+J
         8Tsg==
X-Gm-Message-State: AOAM531k5U8XWX1eAKsh1DavB3hEWspcJhgP6nd9onAd4gmDTHJen4sT
        p5agaGJJ1VKN24j09bjTMFGC/8n8S60=
X-Google-Smtp-Source: ABdhPJz81MlVe3OhOhTrxSQw21Xu5PcUjfjnXmlooDM0VsxlWn8yinrGo/3Z7WnyI+GcXDWSHZJNXw==
X-Received: by 2002:a17:90a:3fc4:: with SMTP id u4mr11031690pjm.127.1633685672045;
        Fri, 08 Oct 2021 02:34:32 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-49.three.co.id. [116.206.12.49])
        by smtp.gmail.com with ESMTPSA id p17sm10631425pjg.54.2021.10.08.02.34.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 02:34:31 -0700 (PDT)
Message-ID: <c2c5f3b0-dfdb-0f3f-4c64-8f44d3e74a07@gmail.com>
Date:   Fri, 8 Oct 2021 16:34:15 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: git format-patch --range-diff accepts non-quoted arguments (shouldn't
 it be?)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi,

I think it is rather odd that `git format-patch --range-diff` accepts 
<previous> argument without enclosed in quotes, since it is always 
multi-word (separated by space). E.g., below works:

     $ git format-patch <options> --range-diff=main..previous main..HEAD

but below returns nothing:

     $ git format-patch <options> --range-diff="main..previous main..HEAD"

Should the quoted <previous> argument to --range-diff be allowed, and 
forbid the unquoted counterpart?

-- 
An old man doll... just what I always wanted! - Clara
