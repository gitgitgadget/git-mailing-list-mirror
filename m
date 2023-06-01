Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC99C77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 07:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjFAHLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjFAHLe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 03:11:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A395E136
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 00:11:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d577071a6so708695b3a.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685603493; x=1688195493;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pjx8BB+qTc2FeZ63l1xVVgAUsfLR5SZ6irXmuu/OqBw=;
        b=hJ1qxpdac/CsL6UYTQu9jYcJd+rbxAxuotJgQQNiLtUng7vvzeUw5eagZ/cVkQOUY5
         l3EWPtyLA/dBRkfA6ekFPSzEUQ8TXByqoYaPbl5fGUG+ffg2PWtWmH+AiYeQGSzi0LLs
         0S6uD8F4sxzehkn4d8ag6Z5bKAvlx5JqmqifR3i1ONPBbB7k6ALr5SnBZ3KTHEz2EIlb
         FGgCddx3aVHVIh46Vy6myrZZOPl7SkSpxdrtVyBOoxAWwyIewdvk4FspHKPu1W+O1sIY
         HRSSBmZo2tIrhwqnoE91zCA+k6zKCuk1Vwr75+2ggpWpDiJXEQ2HTfospKVKoBiSu4jM
         UoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685603493; x=1688195493;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pjx8BB+qTc2FeZ63l1xVVgAUsfLR5SZ6irXmuu/OqBw=;
        b=BWsCA3XSWH8f4v5Wtop09+0LAfukSs53NmAC1s1Wl5vLWEGvqXX4SUafv2b7NOwe9t
         zIJaInBeYHsOKnZAMZujx5dObI2k1iyqa+JmZWDqN5xQimW8IGqQBDPemeifsoJRBMus
         tJQo1btpEZ1oniNqbDHeYGrMfpduFMARQaNybu23FvqiIHvDtR8Cvoa1LZw/B8Sm7hkw
         eXa7/PNFfPUxYGqdW7vRd9kdGjoBCLKbcLp6vJtt29FQZFcSjIOMEQb7wXCWl7JMdiId
         jx3pJI44QwVojj+A8KLZxJTZhIqBufE0qas+4QCgonaLMsKOpElSKfInNEMjVL4CZDsQ
         biUQ==
X-Gm-Message-State: AC+VfDw5pslZ70yhyZNbXwMeZBP1eAO1Lpo/w84eI36zBgMs2UVZz/hU
        7ejHSgAW6DhMKD6GGETDcyw=
X-Google-Smtp-Source: ACHHUZ6EMAM2He8Z+eaFg2ZzpADYO97qQ4EvdMqMtrHiJLQfrSH57wljUmPd/ymA5gn6rLJrnyYtbA==
X-Received: by 2002:a05:6a00:23c8:b0:64d:1333:6f3d with SMTP id g8-20020a056a0023c800b0064d13336f3dmr10500832pfc.10.1685603493055;
        Thu, 01 Jun 2023 00:11:33 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7904e000000b0063d24fcc2besm4371993pfo.125.2023.06.01.00.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:11:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git l10n discussion group <git-l10n@googlegroups.com>,
        Git List <git@vger.kernel.org>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.41.0 round 2
References: <20230601003151.26771-1-worldhello.net@gmail.com>
Date:   Thu, 01 Jun 2023 16:11:32 +0900
In-Reply-To: <20230601003151.26771-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Thu, 1 Jun 2023 08:31:51 +0800")
Message-ID: <xmqqmt1jbqsb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
>> In this release we have a new l10n language, Ukrainian, thanks Arkadii
>> for contribution. L10n for Traditional Chinese is still in draft mode
>> at [1] and not ready to be merged yet.  Maybe another update will be
>> sent tomorrow.
>> 
>>   [1] https://github.com/git-l10n/git-po/pull/712
>> 

Wonderful.  Will pull and use them in the release.

Thanks.
