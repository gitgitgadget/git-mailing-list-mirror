Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2332C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiCITWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbiCITVy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:21:54 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350F01107ED
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:20:52 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id s20so3935740iol.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=3huokMZlM3FXPno1pinRemwlEXrdZK7U4ipxFz1pvLw=;
        b=htNUAqTvI0newz3OFK4GbTXW9tZiR0PtXHEcadg09nGL2Ti2CKMK1ShRbllydfosKP
         Ho9tgkqUfAIASoQOAHpFxK28+2QeBB3gq6d8g+R1tfp2o1JNUC8uC/JfQRuspqoR5FdK
         WEfdS6CUEYnbLBpTytD8qLtKZnnTjZBXM6MdEGm+2ViqPM7GPhLF4BQLilanWkhJ9rt0
         SIk2KCZrmaGBQpaoKZukB8kSnqxRAFt2a2Fk5HPf7WFl6qp7b+qRCO36zMeMeSwv/Ixi
         J1perLP2u07+JJjrtEc2nkZsvzws0U/lFEz/LIjTJzSY2q9ExA8D4aTFOp7mmnAutDhb
         8LBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=3huokMZlM3FXPno1pinRemwlEXrdZK7U4ipxFz1pvLw=;
        b=7lfcipgx11waeoqlK0QXn6epTW/buD+wJx0yp8Q/7NGiBCIp2DIy/daNeEsIU5MBrp
         uSs96nVEm3tFnxBkmnxCWUrEm7lWkERLfqdwlkb8+31oq+P8ouy3uqSEMiS9SpX3YXqQ
         QkTGPwSrWNq6TCwV+aCVJrwIF7Bu0DafIZPJ2zMQsaiHLf05G9TrMBp26VSxE0hGeyVL
         mViv8Pzwoce6Cipd0IJF2o1SMGvVM4l0u7fJqdLs3TyKksIGFoDhdF1AxIIBoe4AAwBj
         5OTcOOMaKxXijVvnUMdBu/izmicmZJz/tf8GlBxMMr61j06/C/Ss1dW4wUzR7k/tOfgV
         Ln0Q==
X-Gm-Message-State: AOAM531UM3hrGUP7ywftxeiEUha6f6dzEE3jwT2m8AkdEgenDDeRQsqa
        wpmfCWHa8psic8ESuYd3+1uV2LdvgsQ=
X-Google-Smtp-Source: ABdhPJy6tm4SkAqj0iZ5DfT+74cvlCqvPzIk6N1o7QNfnUKD/ZezeHGKrEOJPMN3RNf0wKEd1HKkPg==
X-Received: by 2002:a05:6638:2586:b0:319:ac56:5f2f with SMTP id s6-20020a056638258600b00319ac565f2fmr853175jat.146.1646853651488;
        Wed, 09 Mar 2022 11:20:51 -0800 (PST)
Received: from [10.37.129.2] (ool-45788237.dyn.optonline.net. [69.120.130.55])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d9483000000b00640d3d4acabsm1394750ioj.44.2022.03.09.11.20.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:20:51 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] name-rev: make --stdin hidden
Date:   Wed, 09 Mar 2022 14:20:50 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <F2D6D044-395F-40B6-9FBE-20B635A00741@gmail.com>
In-Reply-To: <xmqqo82fklb9.fsf@gitster.g>
References: <pull.1225.git.git.1646774677277.gitgitgadget@gmail.com>
 <xmqqo82fklb9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 9 Mar 2022, at 13:55, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> In 34ae3b70 (name-rev: deprecate --stdin in favor of --annotate-stdin),
>> we renamed --stdin to --annotate-stdin for the sake of a clearer name
>> for the option, and added text that indicates --stdin is deprecated. The
>> next step is to hide --stdin completely.
>
> May be.  As 34ae3b70 is not even in any released version yet, it is
> a bit premature to talk about "The next step".  Perhaps hold onto
> this change for a few releases?

Sounds good. I may have been over-eager :)

>
> Thanks.
