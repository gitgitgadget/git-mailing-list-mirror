Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA9BC4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 22:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiK3WzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 17:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiK3WzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 17:55:16 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C94891349
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 14:55:15 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p24so14431287plw.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 14:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:importance
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVa6BgbyHPICg8SBz2B6aJNcP6BF42EKea5kufVwcPA=;
        b=Z/QGS/4shQivkeXPMlfEaBzM5CmQc1TF/Mg7Tt2Z93CtCRpklAYxYbFE0zuKX/ARt5
         0E2ld3izk7CISnc1mpxzD6m/z6vvuBqO2e2OyPPaYEkIKxa3NhsdleuGJipJt9PQvZzr
         eym4pMBWNX4eOOvE9awbW+CXzfuj1pyPKkCGtzsdRC8d8K+9VuARq5NGR2Lu4uxT0VAQ
         8bXp4lpH7VvUWgA0RlAUSH8/tOkYtbROq1+ca9bh8pu9X6sfdJ7W2wbZLRu4uA3wVtel
         FrnvRflEkLyrmR9ksu5PdtDSsRkqctBPsjWJUTe618LiKVqguyPUK9j95HPTous6kvGx
         +reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:importance
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVa6BgbyHPICg8SBz2B6aJNcP6BF42EKea5kufVwcPA=;
        b=YzJTBSZTZgFit//XGi00uHvBZsoUJ5k1YnpF16FsB0ZkrHeH04te6jgTpRnQxXxufp
         j6JC3q3Oe2F57EmUmJcaNE+MA3U/rPkAOaZJcKsmzCBSB+sDXHmU3+/aZ32Pku65N843
         hNvoTNO0ibCCClbXmpEaImP9e4/tVNCKOuB2aKSARGFPJvurrdxIDwd9SSg1TP7c6DTE
         FXvHIvSeLxxYF9UWwh5AFsHEHvOuMqd+2YgeuXeFs5JkUo2m17ryKX5eGfR1efbaHulI
         tebmI2CrrabuuwsIvedkyq65UfqCBp4FE3Oz6hFbck6AFKphYCaDxwEEzDQuv/F58W50
         bKIw==
X-Gm-Message-State: ANoB5pmALt8UqT81J1bwEr8JROzb4tULK0DdL1TisUdIFzM2YfqK4m4R
        hgcoH0H2fTxrjKsF5sGPWFY=
X-Google-Smtp-Source: AA0mqf6TXXtipShu8oQ6cO8r8ZRRvlLIMeYyxyUGFEelMV5sdjx5Ms3SRoT/sBIjlMbp8cAYn0EuRw==
X-Received: by 2002:a17:902:a418:b0:187:edc:82f3 with SMTP id p24-20020a170902a41800b001870edc82f3mr44717607plq.161.1669848914793;
        Wed, 30 Nov 2022 14:55:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t3-20020a1709027fc300b00187022627d8sm2019511plb.62.2022.11.30.14.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 14:55:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2
 file format
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
        <CAFQ2z_MZd150kQNTcxaDRVvALpZcCUbRj_81pt-VBY8DRaoRNw@mail.gmail.com>
        <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com>
Importance: high
Date:   Thu, 01 Dec 2022 07:55:13 +0900
In-Reply-To: <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com> (Derrick
        Stolee's message of "Wed, 30 Nov 2022 10:16:52 -0500")
Message-ID: <xmqqedtkuk6m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I do want to say that while I admire
> JGit's dedication to being compatible with repositories created by Git, I
> don't think the reverse is a goal of the Git project.

The world works better if cross-pollination happens both ways,
though.

>> * Symrefs are refs too, but for some reason the packed-refs file
>> doesn't support them. Does packed-refs v2 support symrefs too?  If you
>> want to snapshot the state of refs, do you want to snapshot the value
>> of HEAD too?
>
> I forgot that loose refs under .git/refs/ can be symrefs. This definitely
> is a limitation that I should mention. Again, pseudorefs like HEAD are not
> included and are stored separately, but symrefs within refs/* are not
> available in packed-refs (v1 or v2). That should be explicitly called out
> in the extensions.refFormat docs.

I expect that, in a typical individual-contributor repository, there
are at least two symbolic refs, e.g.

    .git/HEAD
    .git/refs/remotes/origin/HEAD

Having to fall back on the loose ref hierarchy only to be able to
store the latter is a bit of shame---as long as you are revamping
the format, the design should allow us to eventually migrate all
refs to the new format without having to do the "check there, and if
there isn't then check this other place", which is what the current
loose + packed combination do, I would think.
