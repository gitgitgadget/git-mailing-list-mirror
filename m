Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651B4C4708E
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 09:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbjACJyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 04:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjACJxr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 04:53:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DDB5A
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 01:53:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d9so309853wrp.10
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 01:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enterprisedb.com; s=google;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I29jPXeqO+blleCB5dossp92OeLYz96C00HXgQkLrQw=;
        b=fEGvdVOl6rY9Mf5qvL3MM9DiYxNp2sZD9Q3XHWzHx/lupwMz2tU6DsGAIxEw5STsvr
         b9gDdWbpjWG6mVuBHZKf5rpaGUxQg4uPgsm9JlfT6uGWN/aMqjsJ1+bI9B3/PxYcIyjC
         MhaO/zLUPhvHnsIE3yF6P5pVSdLAPCgkeuMFPqnks30lwSwu7iAOlAAV1b3GZyJqAfYy
         c6BQDw4EEY775z5l6hoSj1ifaN3lLyLH+AYoQcQxVvVIB7gxbw8tGYh8r568K/XgYQWT
         EEoyVtEuw0A3fFWW/UFuciIdTDBMQgak7VPznsKHq8KLR1v7bMzr59FrKQHtnsEw9WWy
         5UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I29jPXeqO+blleCB5dossp92OeLYz96C00HXgQkLrQw=;
        b=T16NoXLXPMFFpFTsafazFg+tgVaX2AacUVIYHh6yiSKlge4NUPoHgd1EQMUEynU90m
         FoPnY0Xyvwzs4Gf7LQPI+fRuw3i1ARAYT8P/NobsFmgJDSSIKaY35eAqBLCnRBtFj9mv
         4WvVW+3ldb7HitFXKbX8VCijqsZBiUUm8T8uJFWTtzPLh2t8T1als3zWLG46PdBzOq6l
         Aep2cb6HkKUiiYburDj9xyhJU4y95oekW1Jf0bUejJ7JlS/KmtuHYOg8y88UDo2KkowL
         xgVGdzCbWSMGV8UIqk7F4q2SeNtu2awZr499HVnWIq5AHu9y2Vs077uP/0RciMp87V9W
         yvcQ==
X-Gm-Message-State: AFqh2kppl/nCpLDD0Qjb74/mMS0n6Xw2FB2O3F10iGJnYNND/r38QQM3
        ky7PkycnO/xSRcxTDPcClY0gwGIhMgE3oUzr7hAXjKKH4SR+BwJaJ6wrD0ITKl86GOlj+hkdl94
        h1/myyeFY6TlFd+Yy1IwAc27k270a5K9T8fRZ35nTDUtNR5NALthwvoVIb6EzzR5YfZHU1viFie
        VZgK9+CsKLZTAganDE1mVh8s4fBRrXp8fMGInoT3LehU33WdPvH/L/a9xa/coqG6QgM+k/BuGsj
        sh8a56E1xS1VcRuOatjXtxqQLWnWdiP9gulAROuTo2+nEIjomDvvZ3mwVg8RUese53sNIKpffFp
        gjH9zw==
X-Google-Smtp-Source: AMrXdXseZqc6ZLu4/PXc5cG2aL1zvWp6hDeNNTzzGpRnTEkIKOpgYMlwDM/dwnXgYx+Ra7B2OMUb0w==
X-Received: by 2002:adf:d083:0:b0:289:845a:ec61 with SMTP id y3-20020adfd083000000b00289845aec61mr14002608wrh.4.1672739623840;
        Tue, 03 Jan 2023 01:53:43 -0800 (PST)
Received: from [192.168.5.172] (net-93-145-27-202.cust.vodafonedsl.it. [93.145.27.202])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c161600b003cfa622a18asm43884752wmn.3.2023.01.03.01.53.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:53:43 -0800 (PST)
Message-ID: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
Date:   Tue, 3 Jan 2023 10:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     git@vger.kernel.org
From:   Marco Nenciarini <marco.nenciarini@enterprisedb.com>
Subject: BUG: git grep behave oddly with alternatives
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CLOUD-SEC-AV-Info: enterprisedb,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've installed latest git from brew and suddenly git grep started 
behaving oddly when using alternatives.

```
$ echo abd > test.file
$ git grep --untracked 'a\(b\|c\)d' test.file
$ git grep --untracked 'a\(b\)d' test.file
test.file:abd
```

It should have matched in both cases.


If I switch to exented pattern it starts working again

```
$ git grep --untracked -E 'a(b|c)d' test.file
test.file:abd
```

[System Info]
git version:
git version 2.39.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.2.0 Darwin Kernel Version 22.2.0: Fri Nov 11 02:08:47 
PST 2022; root:xnu-8792.61.2~4/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/bash


-- 
Marco Nenciarini - EnterpriseDB
marco.nenciarini@enterprisedb.com | www.enterprisedb.com
