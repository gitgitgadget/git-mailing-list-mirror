Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3121C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 21:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A578561073
	for <git@archiver.kernel.org>; Wed, 19 May 2021 21:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhESVqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 17:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhESVqO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 17:46:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB2FC061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 14:44:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s20so7812673plr.13
        for <git@vger.kernel.org>; Wed, 19 May 2021 14:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ivz637kLI6Z5ex/Yswx/wUJ4BYkeNOLkIOPFpcn89B0=;
        b=ErqggauNZ/V+nHHwLrn6qXT0L/v93QCFc/VhqrSznZQs8p8F3d8XBD7/VSC3CklEgn
         9CcO4UFKn9uJwMajVGryMbfncGA0CXSWcplAglm7MnY+tV5cyPWfAWnn1lYz/zar97j7
         DxKZJPynsi/7qv2FuISTdKPEcktWxOcVOTyp2N2r+WN9TbDLnaUCMpswNJmvS8dTarJV
         QBa3AE95oeBA3us/O1724TVQWlyVEBDQ24E7XV+iJgCYk5Kk4aenOpUwSJjfP7wAMfdx
         M5OJZhr6sI0kjQ/yt7C+rzyJny9O4tsFMUWoxE3BUJQ09vhDkwKNldGqmUEwX3dj39UT
         AuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ivz637kLI6Z5ex/Yswx/wUJ4BYkeNOLkIOPFpcn89B0=;
        b=qlN+d420YI4EO9iGQxnZLWcYX2f3xR6lK80Ei2CevUk4xBv2Rlazp9LJ/pOo4HKOV9
         lunPCRoLA7SUrtUYrSWXvqXX9BrFaiZLU2KmXtCRXimMksY2xULI1Cw7kgmJ7u2cZlUE
         WIWz9VjG7DNDztrrcHMCJZsWmy7irdS+c8demTCqNCv0L+FvXYgf7OMpjdZeKByAE1LY
         Wz3sBXfnlGVJ7W3adniuCVyPPSdQaBkj/79RgjU6ahfc8kdI0xHQoVz3JWiOK3M6ea5O
         oZglU8LwsFOQljopYZ6zDrwwK8w7L/cGziOh/4IjBSvwg4rmbwCtK+Hvw+lSvkxukRsR
         J2Sw==
X-Gm-Message-State: AOAM530vliDKKTAL3aOdrnJJpGqaPVIgYbDaXlKjtmDTOZG5vODBvSB1
        35gGJBVlL8AQQ+YyudIZKqk=
X-Google-Smtp-Source: ABdhPJzjKjShMETcg/eQI4IK7VMhYSjDBXHEnWsFDKmfvWq7UzfMpwIvrTQuZcBtGcVgFtbmMDPfNA==
X-Received: by 2002:a17:90a:5406:: with SMTP id z6mr1089022pjh.130.1621460694158;
        Wed, 19 May 2021 14:44:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4edd:d685:2ff9:b567])
        by smtp.gmail.com with ESMTPSA id m191sm249740pga.88.2021.05.19.14.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 14:44:53 -0700 (PDT)
Date:   Wed, 19 May 2021 14:44:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
Message-ID: <YKWG0jgYXAnKUJNR@google.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com>
 <20210510153451.15090-7-sorganov@gmail.com>
 <xmqqsg2toqik.fsf@gitster.g>
 <xmqqo8dhool7.fsf@gitster.g>
 <87v97pv04p.fsf@osv.gnss.ru>
 <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren wrote:

> Interesting.  I have a strong preference for --diff-merges=remerge
> (yeah, I know it's not upstream, but it's been ready to submit for
> months, but just backed up behind the other ort changes.  Sorry, I
> can't push those through any faster).  I've had others using it for
> about 9 months now.

I agree.  The --diff-merges=remerge behavior has also been the default
in Gerrit since time immemorial, and when I first started using Gerrit
it was one of my favorite things about it.

That is because it shows the human content of the merge: it shows
exactly what changes were made after the automated part was done.

I don't have a strong opinion about what the default for -m should be.

> I think --cc is a lot better than -m for helping you find what users
> changed when they did the merge, but I agree the format is somewhat
> difficult for many users to understand.

My experience in training new users has been that --cc is quite
counterintuitive for them.  Like you're hinting, I suspect it's
fundamentally just meant to be a fast approximation to
--diff-merges=remerge.

Thanks,
Jonathan
