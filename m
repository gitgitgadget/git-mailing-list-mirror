Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169C8C636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 16:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjAaQf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjAaQfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 11:35:20 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E199E5422F
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 08:35:05 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id m8so6709963ili.7
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 08:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4F0MBc6smztOtR7mjMpPdxAyxPMzfJ/WxXBHS6G/FTA=;
        b=C9Ts/9bdvnvWfmjBADFj2Y6qcQsvCaSajazw1joF644vrH7+41UcDypSUnz9uBDwfw
         kW8CO1uIwNtnuE27XHlC6U2qzw69tUR37aNpMdAeK8q9CXIIZ3BkDJZLbG4n+DGG/4kb
         YPNxhVkD1apDVdFpVsL2AhXGfxfZ2nzduHAe1gy1E5ThYMTDOGalZye8o6s1RYsEOrVa
         0fHYkQD8gZK+Qvcp1zFmNY8+GbW9BlzFk3d3Fvje+KPuCE8apD+ABqvi8AVh/5Ocy8yJ
         YWKMwQeaDH5sySEVh9q5KB7u415LdUodVI7h9F9x9eSWoOMLD4IexiFtoXCEzBGIH8Hp
         to/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4F0MBc6smztOtR7mjMpPdxAyxPMzfJ/WxXBHS6G/FTA=;
        b=uU8l8g2BNbxKHuxyyEIy2IUCUeQprKZYT5UzqlU0Rqm3RvININBLorwj61AkIzvsIr
         yHimYd2d/fR/oRvVYkQOMGUQ+nTB/YpUuEN7hy0l8cxj1RT597rXEHjQqO1dhOZmEfga
         5liMPb7vvG6Z5ADoNQOKTjDQtFg+UvxDxtU23MzKXAcQIaGUFnuht5VqhzrW0MYVdLZ1
         2oO8Y5XHTqxhfyDzyyagiKgBbjOZg6++KYrmoNLuhGGjU98n89OVO41h3g0I+nDbXkP6
         2l7VVUNYBsSE6PCiCfjrucdf7cPWz+0BbS55MWi5RDzlPD1Ad5j0kWMQUwwQZqAUrO7H
         MNQQ==
X-Gm-Message-State: AO0yUKUms0iYEfoa1PBokecvZ4ummU/2tHEvhTvj2fYOfxIi7PgZbA0j
        vV704ZyF7JtFMy5Ko5AliDUpbsBCtfRFFA==
X-Google-Smtp-Source: AK7set+EEJ9FD6xK7NU/DoVM1Vks/2ljEE/VRj4ifUHRoXXyRLDh1VsVxqDTcv1+QiMpjeOwaE0YLA==
X-Received: by 2002:a05:6e02:d94:b0:310:c2d5:dfd5 with SMTP id i20-20020a056e020d9400b00310c2d5dfd5mr10206591ilj.17.1675182904938;
        Tue, 31 Jan 2023 08:35:04 -0800 (PST)
Received: from [192.168.1.72] (108-200-163-197.lightspeed.bcvloh.sbcglobal.net. [108.200.163.197])
        by smtp.gmail.com with ESMTPSA id k9-20020a02ccc9000000b003a961e5d33fsm5734540jaq.49.2023.01.31.08.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 08:35:04 -0800 (PST)
Message-ID: <df7b0b43-efa2-ea04-dc5b-9515e7f1d86f@gmail.com>
Date:   Tue, 31 Jan 2023 11:34:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and a
 possible solution
Content-Language: en-US-large
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <6fc8e122-a190-c291-c347-258a5a2ad9c9@gmail.com>
 <20230131162049.mgqdxcucjesw4afr@meerkat.local>
From:   Eli Schwartz <eschwartz93@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <20230131162049.mgqdxcucjesw4afr@meerkat.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/31/23 11:20 AM, Konstantin Ryabitsev wrote:
> On Tue, Jan 31, 2023 at 10:56:52AM -0500, Eli Schwartz wrote:
>> And for tarballs that are generated once and uploaded to ftp storage,
>> not repeatedly generated on the fly, we know the checksum will never
>> legitimately change, so we *want* to hash the compressed file.
>> Decompressing kernel.org tarballs in order to run PGP on them is *slow*.
> 
> FWIW, the most correct way is:
> 
> * download sha256sums.asc and verify its signature (auto-signed by infra)
> * download the tarball you want and verify that the checksum matches
> * uncompress and verify the PGP signature (signed by developer)
> 
> This script implements this workflow:
> https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/get-verified-tarball


This is just what I said, but with an additional first step for when you
are updating to a new tarball and don't have your own checksums
integrated into your own ecosystem tracking.

In most contexts, it's utterly unacceptable to not remember the checksum
of the file you used last time and instead simply trust PGP identity
verification. This permits upstream the technical means to be malicious,
and re-upload a totally different tarball with the same name, different
contents, and different PGP signature, and you will never notice because
the PGP signature is still okay.

Just because I trust you all doesn't mean I should ignore existing best
practices to make sure that I always use the same reviewed
byte-identical tarball -- or find out exactly why it changed.


-- 
Eli Schwartz
