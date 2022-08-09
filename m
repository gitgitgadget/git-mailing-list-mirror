Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4540C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 07:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbiHIHxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 03:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiHIHxw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 03:53:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8475D21250
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 00:53:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso11429671pjd.3
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 00:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WZ1RUsyzwgrfjwA+zjkW4KUgObaa8Vs7OvxkDNZZLzo=;
        b=Mab8huQCLWEFEId7n3ZKkU+I0tYlr7Qg76HXl58q0KjfW9KmJPEd3dQU9xSOeKSnL5
         +G+LX1SJGpFRdzpN0vNryPVSoEPZoxnylR51fZyysFfD6Bgh+qNCdQxdcJb6B+Q91Ut0
         y1xhWAvCVtZNvdNOV8XE/APrSqn4zlMIZe1qoTnGzvF5zRrGUFWjaCGkaOHqxO5ZQINH
         5OB3WWpZCi/8rZGGb0KeODAF9vtKSEgzQqZN5L7ufv0Rqn5OqmTUC7RKh+/6x4G4Kkkl
         jLDr+OsJdxpBSegPyzgZT1+FFjzLi18rGq2+sJpVzImJ1v38wGkHE3T2J1ks2bxVNcRL
         xEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WZ1RUsyzwgrfjwA+zjkW4KUgObaa8Vs7OvxkDNZZLzo=;
        b=6e1pgePoKE16bhvEiQGnYMgG/VZmxX3ekl3UECHHOFxqirCv5oD+ljyFfbx3rNMNju
         sb5FZghYCzvTfBtSb1UElhRsHsgf17UqHchhQZm6wD5W6e5oLDVFr7DcK+/CAV+iCw+Q
         11B55KuMfTdr950WiNRcwIuAzHhHPh7vWq1FADEZ85N/TLT8iOPzywhEnlgAz6F9qXKd
         tdsQsFV5IqIau24BCe/RyJCUn5Z0S86eooR9VbRvbeA6rcE0HIAHGGNEevv/7vHxrnLw
         m8kN00vk5Jo2X8qJcudmCI7uqXAnfzEJ5xW6M2MQCGTePNpR98Ed+qBmKmnvy0MFFzKh
         vg5A==
X-Gm-Message-State: ACgBeo0pkvM4bxBTcuFQ8chQEyU8TnIZ/t9CoFLhdudgnHnmHZAaqVvl
        Dxhgro7VHCOMoUg3keQZy6WZ6IaCTIF+yA==
X-Google-Smtp-Source: AA6agR73Tjy9HLb86aLqUP6Ix1EA4LJdo+ND4zTMnL/NjOET89jcn3sL8zQz7LTiQYwRgE7y0kJSqw==
X-Received: by 2002:a17:902:d487:b0:171:2818:6415 with SMTP id c7-20020a170902d48700b0017128186415mr926478plg.21.1660031630996;
        Tue, 09 Aug 2022 00:53:50 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709027d8a00b00170a757a191sm4016117plm.9.2022.08.09.00.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 00:53:50 -0700 (PDT)
Message-ID: <399f56dd-b3a7-9510-a45c-9b10a52dea09@gmail.com>
Date:   Tue, 9 Aug 2022 15:53:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/9] t7002: add tests for moving from in-cone to
 out-of-cone
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-2-shaoxuan.yuan02@gmail.com>
 <bd80881d-b2a3-c220-8f2d-a07a46e14207@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <bd80881d-b2a3-c220-8f2d-a07a46e14207@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/9/2022 8:51 AM, Victoria Dye wrote:
 > There are two other test cases I'd be interested in seeing:
 >
 > 1. Move a (clean or dirty) in-cone source file to an out-of-cone 
destination
 >    *file*. For example:
 >
 >     echo test >sub/dir/file1 &&
 >     git add sub/dir/file1 &&
 >     git mv --sparse sub/dir/file1 folder1/file1
 >
 >    I'm assuming this should behave the same way as show in 'move 
clean path
 >    from in-cone to out-of-cone overwrite'.

It's interesting that this test covers an aspect that was not properly
considered. When designing in-to-out, I only thought <destination> to
be a sparse directory, rather than a possible sparse file, which is
a totally valid argument. Hence, all the logics and mechanisms about
in-to-out are skipped because Git is completely blind to this file
<destination>.

It seems like an easy fix, but I was completely unaware.
Thanks for catching this!

