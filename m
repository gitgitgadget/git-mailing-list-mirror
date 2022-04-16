Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992A2C433EF
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 13:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiDPN6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiDPN6d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 09:58:33 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C600742EFF
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 06:55:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t12so9097023pll.7
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0FjD/JrjnLw5zQNlTLsmqD1hjTaOuZaJj7OlN1gtpjE=;
        b=dyuwS/mmusXvfSSSfPp6c0MHb9Z5tpqiQRNwFoncGMUUlb5crhjRA9j264MNORdz7z
         leDXhirKqAhiv7X5QmZObcf7DMQvksQ3JvQsUj/tKRpxvyBm3TIxmK99CyP54WR1/KDo
         ToNeMvZMkbrwS59WIyRW+R2YIyiUjT1Ra6NIlhVxu4CBrDLKui35TicnPn5DDiaRf6aH
         SUXs0T0HIFmrDbFafn4aWY4J2HC883/Kwgf8y5VN2/WQ9uOVPLw09LAmO1hIXL+sLjWK
         auRE3LI0U9WBBUxeJ0Qzv42L1y/UC192+OqPcTZQNtR0TKuqJYrJnnkN0fegj3dCw/2e
         5q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0FjD/JrjnLw5zQNlTLsmqD1hjTaOuZaJj7OlN1gtpjE=;
        b=ym7KSeyZ6QKTlJ1tGK95IuCzXMNoBjCbGxxR/phNBhIKE2w12rEBg1NPj2gWWShPgn
         5Gd0evHwXRUEn3/c5vXeARWOtFr72TBB+VvhljDrv772Cymz02z0+fuJbznBstSMIR36
         eCmo4vm6+okPKX7rOxlL57o5gFK2LS8qi8ffVZnH/V/i5H8KHeNzU/FbRKnkQNDGR1/T
         EUQuI0hlqq/HLwfWpGZVEUK45RnVNrAGLjgyCplJGlYmH/vg7qW2dl8WPTE+/DwDDSSD
         q3m2qsMQDLE003af37EJJT09Y4nAlwM4ZODe/y0BghGiXoWn7cYThUKp5t7vNhzZKWx8
         l6yg==
X-Gm-Message-State: AOAM530ocFyDrHrknYhOogtWJOgpaM4CEdKRx5k46wF5jz0ucuoKKxnu
        anTHO7r+gUFynuwWjShhHqo=
X-Google-Smtp-Source: ABdhPJw8BaU83yRpsgaT/qr6FjOFpUH0IuUNCUNR0ci3dN6PHpy2ye9j4W1SMLJuUePgnl2fvKbqzg==
X-Received: by 2002:a17:902:e154:b0:158:71b7:ca8 with SMTP id d20-20020a170902e15400b0015871b70ca8mr3504216pla.21.1650117347115;
        Sat, 16 Apr 2022 06:55:47 -0700 (PDT)
Received: from ?IPV6:2409:4043:4d8c:dad:5b69:8790:ab20:744f? ([2409:4043:4d8c:dad:5b69:8790:ab20:744f])
        by smtp.gmail.com with ESMTPSA id k17-20020a056a00135100b004fa9df39517sm6389275pfu.198.2022.04.16.06.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Apr 2022 06:55:46 -0700 (PDT)
Message-ID: <a1199b2f-c7ad-5d50-e36a-0d47b05c16c4@gmail.com>
Date:   Sat, 16 Apr 2022 19:25:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GSoC] [PATCH v2] t1011: replace test -f with test_path_is_file
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <xmqq1qy3igif.fsf@gitster.g>
 <20220412203722.10484-1-siddharthasthana31@gmail.com>
 <CAP8UFD3RtQecxOQWVeapH1CYsMiY2+MoHeugb9bvOsFVnozy=w@mail.gmail.com>
 <xmqqy2071urp.fsf@gitster.g>
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqy2071urp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot Christian and Junio for the review. I will send a patch to 
update the commit message.

Best Wishes
Siddharth
