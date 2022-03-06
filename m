Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E738AC433EF
	for <git@archiver.kernel.org>; Sun,  6 Mar 2022 11:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiCFLXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Mar 2022 06:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiCFLXI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Mar 2022 06:23:08 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AE46C964
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 03:22:16 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id bx5so10897689pjb.3
        for <git@vger.kernel.org>; Sun, 06 Mar 2022 03:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=ZmqPELmkfE3Yc/sxmc8kdqm/vDzIpvTek6QcV9UayR8=;
        b=pgV0HHvbX4SyGOYY3pMtv+kLkxdxqHkhBJ5vP3VAwB1cP5BZcydLxraCKnwNfy5ObQ
         MnHP2lzOpEP/RzDZhtVzThCt1IKC6f809QOoc4aAm2nGgwn8JgUUl+NY+pUGYwmwrkJ9
         TQ8bW70gfZDpcOX/7zRhJ5n5gYA4YHH5mjdI4wEM76d3P2OW3sYnc42hibERQNhSVqz3
         FQWE3ThCNwS2Fz9cDrfvdHECpCCqZRUxtILcng0SPh8+55TyWnzd4R8Dqn/N7MFkMa9E
         SJzv7gnk7wiKuY2hyRht2A/HID27L8zKVWQo4FSpKTuwaqHs5JtespXDNabuAdpnSUEC
         QBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=ZmqPELmkfE3Yc/sxmc8kdqm/vDzIpvTek6QcV9UayR8=;
        b=5SVQm0YfEARMZSHoHmPFuKucqxxJVKRziLdC9QKJwsE6zq4neOfvYmI31T+Ed/O9eJ
         BJ5imD1KnJrwak0JrfOPXq3lcrjGAFAYCQCQRuzONol7dQZaRUpwSNYMygBTqSRROpBF
         /UsVl/yphKA4D99cGjWUB8xnW1oqkjHNCCFj2s2nxjhRUXEPI39trkWRgfecbjKNVWnW
         ESc1Aod4yaVMdexS//33yNFUp5hYWrRiAHsM5E3Ne7wuWGqrxEIRaMT6MDZ0vDsAml0A
         xIAVZgZKWiWQiyhIn9ZjnTuGg8boBnUnoflRmwK9HWsk9ZpZvwmUb6nT8vQARacFLbOI
         ug5A==
X-Gm-Message-State: AOAM5302vxK/5yopXUZ6t2wy7rYjQNuoFl4L8UmPSz7dzcwdkowhFYoU
        AGG0T8GrepsYP+rm0kFFmE5XLx/BCzpNfSt3
X-Google-Smtp-Source: ABdhPJyMh8OuAh4Et+LS6uunjpSUndyp/eas1EuXlvO76fl2+BBcbXGMDZZCn3EN7CwJbeeN98GsBg==
X-Received: by 2002:a17:90a:8405:b0:1bc:d521:b2c9 with SMTP id j5-20020a17090a840500b001bcd521b2c9mr19714461pjn.119.1646565736125;
        Sun, 06 Mar 2022 03:22:16 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:5194:c9b1:2d1f:598e? ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a450900b001b9b5ca299esm15519371pjg.54.2022.03.06.03.22.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 03:22:15 -0800 (PST)
Message-ID: <bb69a6f4-56ca-2f36-49a7-af4b6ac3990e@gmail.com>
Date:   Sun, 6 Mar 2022 16:52:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re:
Content-Language: en-US
From:   Jaydeep Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
References: <20220301070226.2477769-1-jaydeepjd.8914>
 <20220306111031.335489-1-jaydeepjd.8914@gmail.com>
In-Reply-To: <20220306111031.335489-1-jaydeepjd.8914@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please ignore this patch. I think I made some mistake
when copy-pasting the In-reply-to code.

Sorry for the trouble. I have sent this same patch on
the appropriate thread.

Thanks,
Jaydeep.
