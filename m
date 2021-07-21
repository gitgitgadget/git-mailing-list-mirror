Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDC3C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 19:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A454B6120D
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 19:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhGUSiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 14:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbhGUSiL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 14:38:11 -0400
Received: from mail.aixigo.de (mail.aixigo.de [IPv6:2001:67c:13b0:ffff::60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20191C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 12:18:46 -0700 (PDT)
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
        by mail.aixigo.de (OpenSMTPD) with ESMTPS id 7e2b0763 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 21 Jul 2021 21:18:44 +0200 (CEST)
Received: from vmdpcl078.ac.aixigo.de ([172.19.100.218])
        by mailhost.ac.aixigo.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPS id 16LJIhJv3182888
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Wed, 21 Jul 2021 21:18:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aixigo.com;
        s=default; t=1626895123;
        bh=W7Ycno5mL6shRsuJwb1cmNKs21d8UF7laIivYzqef10=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=y9lyKePcJ3VlX3NrmLlZLqnBZWJp+Cd7g3ja1LFDCx0OK9Iz/SHU/6uB4U5a/embO
         MILVK0gC5wriEuJ/OT2usmwtT9L9AUn0Bx71Wrh2cPjEACPh6AspXWV1RqVHkrJZ6a
         JhUxtwvTzpJ0056wgQHatVPYUW93lNTYNw0PEd/w=
Subject: Re: [PATCH v2 4/8] pull: since --ff-only overrides, handle it first
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
 <1a821d3b1ddf22b62b14d3b573015c3d8c90e2de.1626831744.git.gitgitgadget@gmail.com>
From:   Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Message-ID: <5f334459-26ef-6bf6-d72e-31564b10cd2c@aixigo.com>
Date:   Wed, 21 Jul 2021 21:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1a821d3b1ddf22b62b14d3b573015c3d8c90e2de.1626831744.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/21 3:42 AM, Elijah Newren via GitGitGadget wrote:
> There are both merge and rebase branches in the logic, and previously
> both had to handle fast-forwarding.  Merge handled that implicitly
> (because git merge handles it directly), while in rebase it was
> explicit.  Given that the --ff-only flag is meant to override any
> --rebase or --no-rebase, make the code reflect that by handling
> --ff-only before the merge-vs-rebase logic.

Great. That now will work as I would expect it to.

-- 
aixigo AG
Karl-Friedrich-Str. 68, 52072 Aachen, Germany
phone: +49 (0)241 559709-390, fax: +49 (0)241 559709-99
email: matthias.baumgarten@aixigo.com
web: https://www.aixigo.com
District Court Aachen – HRB 8057
Board: Christian Friedrich, Tobias Haustein
Chairman of the Supervisory Board: Dr. Roland Schlager
