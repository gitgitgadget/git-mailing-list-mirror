Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA508ECAAA1
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 23:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiIBXlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 19:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIBXlg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 19:41:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7BBD155
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 16:41:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t5so3411027pjs.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 16:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date;
        bh=xtbQlTpz9LE8YjBGSWlV6Gxk9RgDJOy/T8kuyysPdfg=;
        b=TMNCuBE5XRS99uhxKTqmTMiwOYYaV9qAUZ172T/2kHvQfu50lBBVvrIJMWECyQzcgT
         SgVv3BDEewolJ/iYg+RjKJ61cS+UuwsDAug/tiQvKJi9aScPP24NULNhMrgGf2Up/hcc
         x+FLlZxhV8+FOLtK49IsiNjgNYyCJexsgv/efUXNngsqScggtbd22C8ZkH752ooUqb5e
         Am6h0Dr9NjnkfjneSGMaqy8+mo7Sopa7gXV7slTWY4hy+WSDoIIl56Px5Jo+KPYX/dx3
         4YbkJhy6eFnf0TAszxTrI6kMtNSyB2jUavvMYjwbCNE8ZHQ2/SM0zoBzpEPYFX2A1Uax
         82nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xtbQlTpz9LE8YjBGSWlV6Gxk9RgDJOy/T8kuyysPdfg=;
        b=zbBqTPDxMR87u5cQ+J91VjxaRPoIjWkUS2R/0g2IF9WIdH0uOXC/NiigWsPkh3+r2m
         qA+MGrCawKeaQFof5NNA2QyZpr7KC9ruor+3SWMlWIwWgZ8xX3LADOYCE1D/DfR7TjbJ
         EqbvvDlg8cF4gsqfb8mHkm6zTs7bUIT+3raKxedft7YXIALUJ976KgchoNKWA+SKfkaW
         +bQgdYJOvO06n0DZKkfxspnNYkaeC29vFfFnN4ipITEN3cBVGq6Hny+b/2hkuQmFokvC
         prL1F/knhLW7l3QWZOIeWc9IAIsB90hnI18dBbW/wp0DFGOV7ATTH1Wirxfj11L5+I8l
         U73A==
X-Gm-Message-State: ACgBeo35wsewYc3nhXtKbQfnO3Bs+tcOcw6IhWg7U7N9FX2quxvaXyT7
        gYei7yTb8dvEO++jQipbXerarscPaalisg==
X-Google-Smtp-Source: AA6agR5+UhVyEkwWJv37mcBz4s8OF+zqCZ7CUDl1VXmkh5LorlS6w3HvnBhiq9YihebBFSVy2FKc9Q==
X-Received: by 2002:a17:902:c944:b0:174:f62a:14f0 with SMTP id i4-20020a170902c94400b00174f62a14f0mr23385944pla.168.1662162094988;
        Fri, 02 Sep 2022 16:41:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:74f1:8209:5955:91e3])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090302cd00b00172cb8b97a8sm2214350plk.5.2022.09.02.16.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 16:41:34 -0700 (PDT)
Date:   Fri, 2 Sep 2022 16:41:27 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason via
         GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/7] bundle-uri: create "key=value" line parsing
Message-ID: <YxKUpyaejATs/3SQ@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r?=
        =?iso-8859-1?Q?=F0?= Bjarmason via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
 <49c4f88b6fd804f0bd5c62d523b45431846f4cee.1661181174.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49c4f88b6fd804f0bd5c62d523b45431846f4cee.1661181174.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.08.22 15:12, Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
> From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
>  <avarab@gmail.com>
> 
> When advertising a bundle list over Git's protocol v2, we will use
> packet lines. Each line will be of the form "key=value" representing a
> bundle list. Connect the API necessary for Git's transport to the
> key-value pair parsing created in the previous change.

Since we're not actually implementing advertisement via proto v2 in this
series, could we add an additional paragraph noting that this is useful
now for implementing the test helper in the next patch?
