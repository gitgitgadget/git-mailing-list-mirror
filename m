Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E733B20C11
	for <e@80x24.org>; Fri,  1 Dec 2017 02:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbdLACvL (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 21:51:11 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:35043 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdLACvK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 21:51:10 -0500
Received: by mail-it0-f50.google.com with SMTP id f143so937045itb.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 18:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ahZ8euNVEaLPr941UEGziO+xAnx6WanXo7CCT8rVCUM=;
        b=PHFhYquVRcR9255wGbOeKVjcY8rdsS4uLE5hgSL55tzDqQJW5Gfdh/gHfs4VuvItQO
         nXIBYag+x08LEBXtwupoAJFIrv7XVmh7aSDiP6hg+ekAc5LizWXzQk6VczxkSnbJbgUx
         v0dbMijZEsD95VP+YaECLfdCoYQJ7M528Mpo5OIe8mb4IbNQrmQxxGnCHvobsVLEnvJU
         mSNe3tLZ+NWMuFoWZKaxlDgcCQ2NQOapGna2bcycbkqgCu5kO8RZSaVoWQLCecWVMjXg
         g2vjBOHh9BzYojAVVdH+scjuJjnFNgof7YkT1v9VtaIO96a+a7hIukwx3Pe/882l2x7R
         /jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ahZ8euNVEaLPr941UEGziO+xAnx6WanXo7CCT8rVCUM=;
        b=ZVjKyiwvYYvLK13pIAQ+wRHx6JDEGQosKURPyZAXrBd0EghcPj4I1urC9ZqnFJxHi+
         9tw2CNHOd7YXRLQostV5gmqPZYPQVegtA6YKwDF/YQ5gHr0pzG/leHDan7NXmygHAPa4
         V7lWn50yr4C/EKAdQkgGJ1ozEAByhLd/Gns145qptyEO7DuVW8+6vlqmrbWaKNw/ArVA
         EcB1c6jdDJydsd4oHoxjOrYs908AZAU+DdjS/1eMF4yWOnIgbEZfbgs9U06L+kMofaXt
         kF046ADYLq38iRsKfjKmBgQzQnTa1mHDmwlTUh9ykDDkSF/bKJ0L6PsWB6AcgNpX2HXX
         3Mrw==
X-Gm-Message-State: AKGB3mJ79RNb5vMQdeOio8j6TAzbZFuOxok3YYskA5LW+wqIX+BEZyiO
        R98hG4h+d/MOYJhq4sbcc5g=
X-Google-Smtp-Source: AGs4zMb7AFPIx0qMiMGMHJN0vSHpiFNXy2nEywCpMLEqR3qCTPCkCQQFpZDBWaG81ww70ehbK+pkKw==
X-Received: by 10.36.192.2 with SMTP id u2mr14034itf.119.1512096669783;
        Thu, 30 Nov 2017 18:51:09 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l66sm2567930ioa.29.2017.11.30.18.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 18:51:09 -0800 (PST)
Date:   Thu, 30 Nov 2017 18:51:06 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Vitaly Arbuzov <vit@uber.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git List <git@vger.kernel.org>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
Message-ID: <20171201025106.GD20640@aiede.mtv.corp.google.com>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
 <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
 <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley>
 <CANxXvsM-q-MH3y94=tW8GmbWNjvrskPoGEhOkyAzsbZd8RrRbg@mail.gmail.com>
 <CANxXvsNuEmo+uaRY8t44csqzXAk3rS+D9E=LMvaLcZeg-aLvRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANxXvsNuEmo+uaRY8t44csqzXAk3rS+D9E=LMvaLcZeg-aLvRw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vitaly,

Vitaly Arbuzov wrote:

> I think it would be great if we high level agree on desired user
> experience, so let me put a few possible use cases here.

I think one thing this thread is pointing to is a lack of overview
documentation about how the 'partial clone' series currently works.
The basic components are:

 1. extending git protocol to (1) allow fetching only a subset of the
    objects reachable from the commits being fetched and (2) later,
    going back and fetching the objects that were left out.

    We've also discussed some other protocol changes, e.g. to allow
    obtaining the sizes of un-fetched objects without fetching the
    objects themselves

 2. extending git's on-disk format to allow having some objects not be
    present but only be "promised" to be obtainable from a remote
    repository.  When running a command that requires those objects,
    the user can choose to have it either (a) error out ("airplane
    mode") or (b) fetch the required objects.

    It is still possible to work fully locally in such a repo, make
    changes, get useful results out of "git fsck", etc.  It is kind of
    similar to the existing "shallow clone" feature, except that there
    is a more straightforward way to obtain objects that are outside
    the "shallow" clone when needed on demand.

 3. improving everyday commands to require fewer objects.  For
    example, if I run "git log -p", then I way to see the history of
    most files but I don't necessarily want to download large binary
    files just to print 'Binary files differ' for them.

    And by the same token, we might want to have a mode for commands
    like "git log -p" to default to restricting to a particular
    directory, instead of downloading files outside that directory.

    There are some fundamental changes to make in this category ---
    e.g. modifying the index format to not require entries for files
    outside the sparse checkout, to avoid having to download the
    trees for them.

The overall goal is to make git scale better.

The existing patches do (1) and (2), though it is possible to do more
in those categories. :)  We have plans to work on (3) as well.

These are overall changes that happen at a fairly low level in git.
They mostly don't require changes command-by-command.

Thanks,
Jonathan
