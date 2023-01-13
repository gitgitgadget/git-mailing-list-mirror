Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806E7C6379F
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 22:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjAMWBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 17:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjAMWBH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 17:01:07 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B42D5AC54
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 14:01:03 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id y7so1738428qtv.5
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkqCXsNUC43z8GSy1DBf+EdPf1ithr+/7o+TLa8FeXg=;
        b=Fpq27Ut5gG9f5mzHkqRaLqcgO7uaBCG8EbwEDALe89hyIYDQ4CmReQcVHIYq+VMbV4
         rhN9Nqu8KsywmU6g+CoUFPtHfoka9T5uOgbGEvIcKPOiVJAiKzz1wKo+WfTrdnb9YH3S
         vcreqCE8ay3Jbe1ffgO5o9z3i3o+UW1dT1oNpa5fyl7OcDgZ9hQVlxU/mtxIApY66RJZ
         hxoNpme/f3fbrchpSYS3bQ+fQxsXcWrdbxnfDwfSbThmZzpQFTpW3bDb4v96l/VUpc6x
         enpnh1/57W+sjvCyM16TtzYTq2xQRhO/Jfl/bwnxt/KoRbhXN6BpBvtEjKN05QeXoxjo
         hWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kkqCXsNUC43z8GSy1DBf+EdPf1ithr+/7o+TLa8FeXg=;
        b=ydNQdxXQrdr1ezeBrhRgcFjtioYQHd9tEwQe0+NZmWBUr/Gtk5Ii8PIODpmTPinNO5
         TP/YJleRihDlsC4OceRIpaRT/n92yapU4bmvv0xK4HNGsPPFBdtThDfvyuS3bCQ9z8nv
         9gbYLgesgk+yQlxxwZsdf9RVc481o7onPpEjR3KJWSGa2SuwyskosDU5nmzgOlr1XRot
         Xz3iXnToc7ZMx8y9TNCrB8pQ7cFOxzMIvxsJFRMmlOt67TjH/j+8f10Wj/jkXv20gSgO
         qkRuQO3rm+pWHEWHbRhJ1O6fhQKrtZee77maxOqQ7qJBP9fHnswy0taFZltQus2JscTc
         cjKg==
X-Gm-Message-State: AFqh2krQ1RTLNQX30UEQw7ZlJzav1/S7k6hndArcljPLm6Wr+jyqhWeE
        JZbo330NGUoh1nrK43kJg0r31OvUcb7uuw==
X-Google-Smtp-Source: AMrXdXukglUYL3v2zdqzwt6ENtPGQ9XAenT/K21PTnRhdfuL4w5vNDkLpN6HGyKf3okqfsssuLxXkw==
X-Received: by 2002:ac8:794f:0:b0:3af:ba3b:db80 with SMTP id r15-20020ac8794f000000b003afba3bdb80mr21291146qtt.33.1673647262300;
        Fri, 13 Jan 2023 14:01:02 -0800 (PST)
Received: from ?IPV6:2601:6c1:c281:3430:223:24ff:fe37:484e? ([2601:6c1:c281:3430:223:24ff:fe37:484e])
        by smtp.gmail.com with ESMTPSA id bn39-20020a05620a2ae700b006fed2788751sm13198072qkb.76.2023.01.13.14.01.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 14:01:02 -0800 (PST)
Message-ID: <632d051b-d81b-b35d-0641-c2488a124810@gmail.com>
Date:   Fri, 13 Jan 2023 17:01:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
To:     git@vger.kernel.org
Content-Language: en-US
From:   Crls <kaploceh@gmail.com>
Subject: ctrl-z ignored by git; creates blobs from non-existent repos
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ctrl-Z is ignored by git; Git-clone injects blobs even with non-existent 
repos

Steps to reproduce 1- git clone github 
whateverrepo/whatevernonexistentrepo or 1- git clone gitlab 
whateverrepo/whatevernonexistentrepo 2= Git prompts for a username

3- Press Ctrl-Z to stop *git* from running either on the virtual 
console/tty *git* automatically creates blobs with directories and 
disregards

^Z altogether It goes ahead anyway and creates pleases. It looks as if 
^Z is not enough.

Expected: The same issue does not happen with other non-existent repos 
e.g., git clone git.zx2c4/ it returns the message of fatal repo not found

   According to console_codes (4) CAN (0x18, ^X) and SUB (0x1A, ^Z) 
abort escape sequences should be clear enough


git version 2.36.3

