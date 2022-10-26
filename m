Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C18C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 21:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiJZVis (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJZVir (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 17:38:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1EA8F968
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:38:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f23so15502839plr.6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWMPE9WTPeSaZlCdFztl/W3SZ80rHiF7tbqMDhMyJnA=;
        b=Fi6QuomiLJIWjbCWJN6DMS4G3nu+YJaIittR9Bx59OwY1sh1VNROfuntHJXztByAej
         vj7kDVyBjlAHbNFpr3rchy2uIZ7JIIWA5HhMLFQAb/CuHqgDeRwo0eMzILnUuXTEySpv
         dR7T6jXr0sceaYiqUd3wQEGGLOsmIWJEveGRnzk2vlRgyIOtNYg7REYZV2UAjuoR/pLM
         AuEcAx8XHjo9yGoWzCp38tNW+BlFTAAQnXZxzYDYmXkJkEz+16eGEYy+HPnKEWboKVUX
         p9duYOTKFmLV4XFl7JiX7mR/FaAxpo7kd+FiFQ4yjl0nBWDmjX7e6ao7fKnKp4rAplA1
         btSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SWMPE9WTPeSaZlCdFztl/W3SZ80rHiF7tbqMDhMyJnA=;
        b=NvJ8ylnFrXvonmvyhfDSc/60UQaVv03BaX8TSOZm2OdR0rLPPFreq7TAeg+q8BG4bZ
         gygTnQJv+4xgzPYJE+LgRGG63EnJPCBy/kryVcRkT3h0S24/PKmnCBK8Xir8KUNO15cQ
         lAq+RcC8XRzbchFbuFfP+y8lH/33q0Q72folaK2Vgm5VobkmJJso5cPYqMNKB40ORL6f
         o2wKAbsD9XKVXD0VgsFNoGu/U9cSRmUtdeIODSlb9FuDZFQaDCol0ryejF97BUPUuIxB
         C2t730BnGtSykAsgpG5SH3qbtndX83U1yDrbPMv1yNxMJ5e+ZnX3STUkNtlYmGD76BSz
         Kwfg==
X-Gm-Message-State: ACrzQf3AFuy+OGsch5VK9s047zTpW6atmGNpRJH8/NOtFHw7HpdT0Ffs
        mET/AOtBxVtDh2FJHDVgXbo=
X-Google-Smtp-Source: AMsMyM6e6KlRATVbUYr4tZtfD6g14CAvmGHadLpjjy6mwriEtSfofuwULhp3a87SOFUBivf97CJg4w==
X-Received: by 2002:a17:902:db09:b0:185:5440:1ea0 with SMTP id m9-20020a170902db0900b0018554401ea0mr47502395plx.113.1666820325851;
        Wed, 26 Oct 2022 14:38:45 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902ccd200b00186b8752a78sm3378521ple.80.2022.10.26.14.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:38:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>
Subject: Re: [PATCH 1/9] test-lib-functions: mark 'test_commit' variables as
 'local'
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
        <832e910aadc47309392feed69927c2e8693cbfc5.1666365220.git.gitgitgadget@gmail.com>
        <xmqq8rl8kht3.fsf@gitster.g>
        <3a41e02f-c1fb-64ed-377b-4e4168f2adae@gmail.com>
Date:   Wed, 26 Oct 2022 14:38:44 -0700
In-Reply-To: <3a41e02f-c1fb-64ed-377b-4e4168f2adae@gmail.com> (Philippe
        Blain's message of "Wed, 26 Oct 2022 17:21:31 -0400")
Message-ID: <xmqqbkpyfeor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> While it is OK to argue that they deserve it, we would have to be
>> finding and fixing them ourselves after all.
>
> Isn't the fact that the test suite passes with this change enough for us
> to be confident that nothing is broken by it ?

I am not brave enough to claim that, actually.

But even if the tests were subtly changing their behaviour and no
longer testing what they originally meant to test, I think that is
OK.  It will not be the first time for us to later find out that
some tests were passing for a wrong reason, or some that expect
failure were failing for a wrong reason.  We had multiple such cases
we later found and fixed, so even if these "local" introduced changes
in behaviour to some tests, I am OK ;-).


