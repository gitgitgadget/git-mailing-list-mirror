Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4A2C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 11:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiDSL3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351333AbiDSL3l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 07:29:41 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86FE27B1B
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 04:26:55 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id f5so10268359ilj.13
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neulinger.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:organization:content-transfer-encoding;
        bh=ohwSlnI3UoElbL8nWXUKSpJp/BENfG5JZfXHbiWeJQk=;
        b=DBky7Pk0gxTjaO0K6iGox5KsrOZhdvFXCUjp2hEm0AISV6vlGHUuKfiXmZBryyhWeB
         DemPxabNSVZyWUFBREtJ3/XBRkeLQn5Wa4jjyijUNBsfywS09zvIJqr2Uj1yXZ3ilSv2
         11WeiCuG6McAXv6QPOES6qluEoNqriwWbTzIiQkDUXeqwnXGrJPBly255EifZEFtuHEX
         1oCLxdh8DZjXwJ+Ao5X26ep0qOSYKzT6kVYcRgu/RK7e00tegMYw8sZR4MOXdcwtarxk
         na99ZFRnVxUV9YeFl5SBuZeUFwwZqq+DZpK4mJQT6yCCAbIDiAugxjq0wGLz8+6ljJU+
         +kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:organization
         :content-transfer-encoding;
        bh=ohwSlnI3UoElbL8nWXUKSpJp/BENfG5JZfXHbiWeJQk=;
        b=S3fjiRJosId6djrIykVxvHwQU5iu5dUUUnkaPXUWMQDnvVn7kNkNCiZYNmNRphzI7L
         LC9CEMU/rWScsK/MZRw6VG+MHHq4S5pcse7duNuRpAXvfAVERt2v7MHd3KNHE3zq1eZi
         +bLMl/uvxuFFS088ry3Da6ziwQKCzxZS/2XiAHBpyd+NYvs+Dxxfvebp0Fi4gmhq5Ots
         rXyTeMTB3M9nMFatXK3izIeGBQ5oxkkg87Bf5IlgsoSCXIqdAm8Rkyj3AUbscij6pWOc
         GWXYAV96qui0y/0cIUnkKjV8D0u2rP3nfrSPHd63AEBBAufKJAdhO8OAIKtV2Cs3enqN
         SpFw==
X-Gm-Message-State: AOAM532qlmD90zOtpRfjUdTUW1UTc6zlhoQ1w2IPd1ACRWfBB7CsIfM9
        qpkh13q5/PkyR5O2MTWffOhClo3WqS/J/A==
X-Google-Smtp-Source: ABdhPJxhSwbv8efTYhj023gtS6H/MxKzD94EVp6+bUQ9Z6fJWZ6sIgpZdiGXKWL3BqeY8d1hWzwO6A==
X-Received: by 2002:a05:6e02:152f:b0:2cc:b71:5b34 with SMTP id i15-20020a056e02152f00b002cc0b715b34mr6382907ilu.23.1650367614702;
        Tue, 19 Apr 2022 04:26:54 -0700 (PDT)
Received: from [192.168.125.12] (67-43-241-123.fidnet.com. [67.43.241.123])
        by smtp.gmail.com with ESMTPSA id u4-20020a92d1c4000000b002cc14bf22ddsm4824651ilg.77.2022.04.19.04.26.53
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 04:26:53 -0700 (PDT)
Message-ID: <ec588ff7-b300-bc3a-b51c-67d190b27e9b@neulinger.org>
Date:   Tue, 19 Apr 2022 06:26:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Nathan Neulinger <nneul@neulinger.org>
Subject: Recent changes for the unsafe directory handling - TINY improvement
 requested in error output
Organization: Neulinger Consulting
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


While I understand the need for the recent changes (even if I'd prefer they be limited to turning off any 
filter/script/custom alias/etc. support) - there is one piece of the new behavior that could be improved for usability:

If you do a 'git status' in the directory - you get the "helpful" response:

   root@server:/local/APPNAME/bin# git status
   fatal: unsafe repository ('/local/APPNAME' is owned by someone else)
   To add an exception for this directory, call:

   git config --global --add safe.directory /local/APPNAME

However, if you do a 'git diff' - such as what you might naturally do right before attempting a 'git commit' - you do 
NOT get any useful response:

   root@SERVER:/local/APPNAME/bin# git diff
   warning: Not a git repository. Use --no-index to compare two paths outside a working tree
   usage: git diff --no-index [<options>] <path> <path>
   ...snip-long-diff-help...

Please consider a small improvement to have the git diff help output (if displayed due to the repo exclusion warning) - 
ALSO display the 'git config' suggestion at the end of the output, instead of me having to remember - oh, go issue 
status to get the command hint to go set the exclusion. Would also be useful to have the git diff output do the same 
'unsafe repository' message about ownership.



In case it matters for why I'm hitting this - server with various different application accounts. All maintained by a 
trusted list of users, but separated into different users for permissions isolation between the apps/repos/etc. Often 
edit/commit/etc. as other root or as other users (when facl's are being used). Running 1:2.25.1-1ubuntu3.3 on ubuntu 
20.04 in case this is already addressed in upstream and just not included in ubuntu repackaging.


-- Nathan

------------------------------------------------------------
Nathan Neulinger                       nneul@neulinger.org
Neulinger Consulting                   (573) 612-1412
