Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF24C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 13:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BCC160F22
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 13:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhKLNbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 08:31:44 -0500
Received: from mx05lb.world4you.com ([81.19.149.115]:57798 "EHLO
        mx05lb.world4you.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhKLNbn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 08:31:43 -0500
X-Greylist: delayed 1305 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Nov 2021 08:31:43 EST
Received: from [78.47.150.33] (helo=mail.schuerz.at)
        by mx05lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <6a50120e@schuerz.at>)
        id 1mlWGn-0001Yh-IF
        for git@vger.kernel.org; Fri, 12 Nov 2021 14:07:05 +0100
Received: from [194.24.159.128] (helo=[192.168.1.87])
        by mail.schuerz.at with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.94.2)
        (envelope-from <6a50120e@schuerz.at>)
        id 1mlWGm-003sYt-NV
        for git@vger.kernel.org; Fri, 12 Nov 2021 14:07:04 +0100
Message-ID: <5743c211-bf8b-b485-3b81-a71b1b64bb4d@schuerz.at>
Date:   Fri, 12 Nov 2021 14:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
To:     git@vger.kernel.org
Content-Language: de-AT
From:   6a50120e@schuerz.at
Subject: Password for proxies from external
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there!

If searched a lot and everywhere i found the same information...

when i want to set a http-proxy for git, the configuration goes to 
~/.gitconfig

```
[http]
     proxy = http://username:password@proxy.dings.bums:1234

```

So the proxy password is in cleartext written down to the config-file. 
The git own password-store can not be used... even no external like pass.


For aliases i can set something like
```
[alias]
     blafoo = "!f() {do something on shell}; f"
```

But this does not work for proxy-settings.

There should be a mechanism to read a password or the credentials from 
the shell in proxy-settings. Something like bash-subshell-construct.

```
[http]
     proxy = http://$(pass show key|grep login):$(pass show key|head 
-n1)@proxy.dings.bums:1234
```

or

```
[http]
     proxy = "!u() {pass show key|grep login}; !p() {pass show key|head 
-n1}; http://u:p@proxy.dings.bums:1234"
```

This would close the security-hole of cleartext-credentials in 
config-files...

thank you

Jakob

-- 

