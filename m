Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5BEC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 07:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiEYHyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 03:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiEYHyD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 03:54:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37057C162
        for <git@vger.kernel.org>; Wed, 25 May 2022 00:54:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r71so18314055pgr.0
        for <git@vger.kernel.org>; Wed, 25 May 2022 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=po+vVlmqDRrn3lCTQVM9smkLcJ9MahLxh1lt6bpl328=;
        b=KTKsfoRnHONXl5Ye4HFeqZexFwre5HJFO7IyInOZI8gfhH65q0tOfgy4HdNXgD1w2o
         lMAjtMLjR6aDSH30NW2FtmsnuuGUEfkUWyN/g9faMIwh4z9V90bqsnucL7QDip4Wksj7
         kwQ8bVvVi4kMGhscUQvL7UA/EWyk7B02WdAnGSVOCwYfwe1ybOVDZ+xXMdHMYdAKHvZS
         2ywONAD9rwrMiAjfhXfjGfIPnd+nufGv1OOUDOPAeEESWIikG4p86DfVN8WP7lfBBltS
         bXsk2FPUjKnNiMlamVf1mpzfq21pgNt37zwdlRvusQCX7VVrh9TXffPQxi3mR92kXthD
         JwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=po+vVlmqDRrn3lCTQVM9smkLcJ9MahLxh1lt6bpl328=;
        b=RT0nuG8zJkUZET9kBylK1HbPVtEtquV0i3A57d0pnUifJTvmm3NDoMDxK0a9xF8O3o
         9PPNUWySVvUbS7CkSWsfY953C8adpAhCL6Pnbi1DuR9tTCH8iDtWI9uX20q6OVwVpwA1
         Pa8tqek4s57rvjZmGKF9IG5+9OX2zeIzu4CXk2Z2VzOc30ygwb3lUCStqqS5zFs9pt5G
         JGVasTVMgTgXeC42cmzeISAt6gdCP0L0xFRa/mNBJOBuWP7kXn3gy0UjGvyByb1tXDSG
         CI0Fa2Dx2LVybYroLfXtNan+ejqDjFtM7gmZagqH0uWUaAgOVuJjmkqyNWTyd85psJEF
         ECBw==
X-Gm-Message-State: AOAM533tUCvgke7yYlgoffUwg8l3V8vq8ryPR/wWBCrZ+PXddePiTu60
        RT1PxiWU2/4dqTQksx4HZ2c=
X-Google-Smtp-Source: ABdhPJwllSnpaGgQK0B0eGy/GaQApMYVtuFeWGGrIobu2ltTpDXZjhgiDSYvTXAzPN6hM1KhS7c0Gw==
X-Received: by 2002:a63:2026:0:b0:3fa:cefb:e408 with SMTP id g38-20020a632026000000b003facefbe408mr3137447pgg.57.1653465242159;
        Wed, 25 May 2022 00:54:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:52ba:872d:8735:1c87])
        by smtp.gmail.com with ESMTPSA id ig12-20020a17090b154c00b001df54afccb3sm1076431pjb.6.2022.05.25.00.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 00:54:01 -0700 (PDT)
Date:   Wed, 25 May 2022 00:53:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 00/17] cruft packs
Message-ID: <Yo3gl5Wv82mTZQb2@google.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <220521.868rqv15tj.gmgdl@evledraar.gmail.com>
 <Yo00X0NEu8N0MnZV@google.com>
 <Yo1TIQqvlxhvLZ58@nand.local>
 <220525.86sfoytwjn.gmgdl@evledraar.gmail.com>
 <Yo1YZM2dI6t+RsWv@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yo1YZM2dI6t+RsWv@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Taylor Blau wrote:
> On Tue, May 24, 2022 at 11:55:02PM +0200, Ævar Arnfjörð Bjarmason wrote:

>>> Moreover, I can't seem to find any formats that _don't_ use that
>>> convention.
>>
>> It's used in the reftable format.

It's also used in the formats described in
Documentation/technical/hash-function-transition.

[...]
> Sounds good. Unless others have a very strong opinion, let's leave it as
> is.

File formats are one of those things where a little time early can save
a lot of work later.  If there were a strong reason to use "1" and "2"
here then I'd be okay with living with it --- I'm a pragmatic person.
But in general, using the magic numbers instead of a sequential value is
really helpful both in making the file formats more self-explanatory and
in making it possible to experiment with multiple new hash_algos at the
same time.

The main argument I'm hearing for using "1" and "2" is "because some
other formats got that wrong".  That reason is the opposite of
compelling to me: it makes me suspect that as a project we should more
eagerly break the old bad habits and form new ones.  I guess this
qualifies as a very strong opinion.

Thanks,
Jonathan
