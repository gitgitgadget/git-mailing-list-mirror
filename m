Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E86C433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 00:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiDEAnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 20:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiDEAnF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 20:43:05 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB71623D587
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 17:31:03 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id a5so8862969qvx.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 17:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aCKEXt7s3efgAYAJq9anLoeiXMn1lWfcovez9KbkMjQ=;
        b=OvuvB1MrWyAoFa0RVY0Sv+oH5NO5pDbfwAlzmS2Oim6FXmq6et6+EJoGWWQOdcIXZS
         pd48ts/Xs/PRnoNc/U7GLs/kMGAXnDlIwb4077BOIFSNkJI5GRPSh6MMVxqNMyMLpQL+
         gbkyy1oQkjwXaLnEr6HFunC3I0h+7emhQuHQ/Qsdpvg1J/PaETFa77WbXhgeRKkO3jYr
         GGYGRJR+91SSEH7qc/JQaSMlLDT4eLJDcIjs2WF1RVfyyzxV+2wFjCLPge4wur6gemua
         jKVJq3hxhHvuXhRoklmph3HppKw0OxqSF5Z77hxvYoNHluK7cdw5H4HvpA68Ad2YNPZr
         Vf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aCKEXt7s3efgAYAJq9anLoeiXMn1lWfcovez9KbkMjQ=;
        b=sFjY0jmiYn9aozZP3dAefi9nOB91iu+ZsPbqkrcE98w0gMj2zAFET9Bxbkps4njgc2
         9q8sb5q6oz+WpeqKazO1RhBofzvNQPYSvxRyFQ2Z80OH+bBEbDSSMKlIB6ZOaog9FH+l
         fVROSuL48IvJVgPKPn5xQSPbhZ0MnnY5Lsu9+7cAObJrg36z0rVrPqq2YJlh2eoF/TWf
         0I20FASHwu5mrI5Eis1yg5Nk0CA7SodnYfXLmDWaopZqtH9IHZclJcTmsgIYE1pa6CqS
         cpxWqVsKAHDOsD45EnOclWWKjZWFdAKmYzaFNufjhEyZKzr2L5fWOyTmsdvaBWvZxn2F
         Q+8g==
X-Gm-Message-State: AOAM530lK9Li8Fta+Y2/YGlF4qExjW4FxQXsCvUNxpSLMjh2SBu1DQGr
        KG1NJhCLl8CcKUPGxeejcM0=
X-Google-Smtp-Source: ABdhPJxfxcMczXKKSg/IUoigsEbzHvRQpjKXfLmkzMvmI64S5n3mpLzOPat+F115SisiO7xrkBCsGA==
X-Received: by 2002:a05:6214:1c83:b0:443:6749:51f8 with SMTP id ib3-20020a0562141c8300b00443674951f8mr578824qvb.74.1649118373773;
        Mon, 04 Apr 2022 17:26:13 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id e13-20020ac85dcd000000b002eb9458498esm9323430qtx.95.2022.04.04.17.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 17:26:13 -0700 (PDT)
Date:   Mon, 4 Apr 2022 17:26:10 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Git Mailing List' <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
Message-ID: <20220405002610.27sgjva5wfryrcio@carlos-mbp.lan>
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com>
 <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com>
 <034701d84875$030bfb40$0923f1c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <034701d84875$030bfb40$0923f1c0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 04, 2022 at 06:40:35PM -0400, rsbecker@nexbridge.com wrote:
> On April 4, 2022 6:33 PM, Junio C Hamano wrote:
> >To: Randall S. Becker <rsbecker@nexbridge.com>
> >Cc: Git Mailing List <git@vger.kernel.org>; git-packagers@googlegroups.com
> >Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
> >
> >CSPRNG_METHOD?
> 
> We already have
> 
>         CSPRNG_METHOD = openssl
> 
> In the config for NonStop. Should that not have worked?

only if you are not telling your openssl to hide that function[1]

Carlo

[1] https://www.openssl.org/docs/manmaster/man3/RAND_bytes.html
