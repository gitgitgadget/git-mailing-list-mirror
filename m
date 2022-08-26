Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395BDECAAD5
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 22:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbiHZWct (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 18:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiHZWcr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 18:32:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B4E40BFD
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 15:32:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id jm11so2728726plb.13
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:cc:references
         :subject:to:from:sender:from:to:cc;
        bh=iyJSnN5SGBRZLVpzB9bY8QvBwSyrqg+BtBDp99PMMSU=;
        b=dXwBMGgjTyHZ0gSLT+QPaBL3EvoVPzg6WvoixkPUUfF04OzZjk8hGnxVGN7A8cRTth
         ZKC5s8MzTdbgHQ6etuJykdAo5jttav8PK85WDFALdbFYgMwuu6zM6eKv4aEQEQ2qw+y5
         VEYZEvYKZMlpFt4kGDLmRSUT9RTnjeRUcdlKrAQGQFrOfsHxGHH7M+1xdloYD6/VYgOi
         E3xmIc+HJrLEbXmT5CWVsBG9umLP8GCltVeTgviMuWAIdrXCUeVPiAPjM6k1sA2Mrde2
         UofGDAQlyewa8QIPUooU2oFmJqEfAMLsV2xJ4ro49SP0cdkdd5D/bpfqilmarcRSqckb
         fqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:cc:references
         :subject:to:from:sender:x-gm-message-state:from:to:cc;
        bh=iyJSnN5SGBRZLVpzB9bY8QvBwSyrqg+BtBDp99PMMSU=;
        b=32Hdi4Jfwf+4PaLvltSWWZcV32h67l28X0foCcnoBbjndBc3sEOKufm/9Y8peAUKQn
         iVjNdAzzRO6dH90O2uY5bqObEzxxAcIicSYjT5Qcdd6qTKIlwmjU2EHIksNT28tJqzKu
         T2/9oLRzjr24coHzK8MO7sx6dcC9CxR50p4/g4xShemMBL2CN7cPaEpLjOKHvRzQb5IR
         i1y9IG5BxsCEVJCfwI+6+qJ+sjRN+i0NpHpmMzsS/DZ2VcpE4sjWT+7TJGCCyIonxrDz
         rZNNamKXNVVKFORjyzRMiu1M7dBd6uC5eRc9xqfVqLeHxdFTZkyNz3aM/F28hij0AVWo
         a0IQ==
X-Gm-Message-State: ACgBeo2Q7jx7tX+yEOXQCCntLsLdUkknJ9fKerGYQbKNB83QMEMaU51s
        zwq5/2EVIgj6NtIzTFp0cSYW7qIQjTo=
X-Google-Smtp-Source: AA6agR61k9ij+ES/xkXA5s9oMMar9Cz2oTZDu88lpAUs0vAX9XoSMvqGyMhy98PoVOF5NQ30Pwh7Kw==
X-Received: by 2002:a17:90b:1b4f:b0:1fb:5138:7af5 with SMTP id nv15-20020a17090b1b4f00b001fb51387af5mr6412746pjb.200.1661553165943;
        Fri, 26 Aug 2022 15:32:45 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l3-20020a170903244300b0016ed8af2ec0sm2190862pls.29.2022.08.26.15.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 15:32:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Aug 2022, #09; Fri, 26)
References: <xmqqbks6ya5d.fsf@gitster.g>
cc:     git@vger.kernel.org
Date:   Fri, 26 Aug 2022 15:32:45 -0700
In-Reply-To: <xmqqbks6ya5d.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        26 Aug 2022 14:20:30 -0700")
Message-ID: <xmqq5yiey6sy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> We are at the end of week #7 in a 12-week cycle toward Git 2.38
> (tinyurl.com/gitCal).  As we have accumulated enough material on
> the 'maint' branch, we may want to tag 2.37.3 early next week.

Just a head-up I promised earlier.

As we do not have anything else that is ready and urgent cooking in
cabal, we are not in a hurry to tag another maintenance release, but
since we have enough stuff...
