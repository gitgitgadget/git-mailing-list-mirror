Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51C5C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiGRQ4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiGRQ4B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:56:01 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989A22BB23
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:55:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id l24so9732999ion.13
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oQo/1QnBIca5ro9Fdy0SbIpyZvZWYP7e2Vmnmp8HAgk=;
        b=HqRWU1NxPjF6KMHfUbL0d4BibiMfZzQdMv4G4rby8fjNvjwb2xtieZPZ/Gu38Vvjto
         GkGxanXtYiWd2YXjgYBS1sp/mrphdAefKaoNQMyCLUZLflrtWeNSvTDEaBYEGA9Gt0CF
         pvqkOBs+DM6wh0LcCBffr//1ssQJGFqawu3Uq7nzyCf900pPvxNSs61RBuxLeO3LOI9a
         SRR+fevv41wfA1BROsNbRak6Eq8EQUkL5pXGzV9rnDrfdP58nLcBmThAveCkWVhhNjFH
         zR9+0Ye3fk7qJ6ssmtSplKMk33m2uUy0DNV7iFBTQ/+JpNhtL4dzA8Cx67Yd5a2fHuW7
         VU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oQo/1QnBIca5ro9Fdy0SbIpyZvZWYP7e2Vmnmp8HAgk=;
        b=ePoJ9FOiGJ4qrmcBkh2msyy2Ohc/VBNKRis699oRJzWKlKolhTHNFvLOKiu+B3OWYT
         MfSDICP2PinbKhxZej6jdBXYzWHT/w9hep4l0abggjM7Nre/HKBFSPaSNAfA5Z0mHN+n
         0WD6DVVJmfXu9cfh0LQ3wq3kNNUQvZOwzofR6hHmHf0ojZIX52pSlCwlzu0SA7CkJ7Sd
         Xa11jYNQVDZUbygCkPGia7PO2upa0ngXVH/Jzwbq8Rm9YQN37F+97A00kk9snJjdvxyp
         vGWLxAuBGq68ULU+N6+RZPPy4lip4siH1KguwgqMCejtklpeOFyCTBAQ/xE+xqLl8D8o
         I6CQ==
X-Gm-Message-State: AJIora8tbWF6T2Y8mZGGpZq6R+kdU1S3WQz3jfaM0wQZ6zUvcXMAKb5C
        woobKdM5kZmpE4h7IlvwxNzQ
X-Google-Smtp-Source: AGRyM1uWXV9kyGRZ3fbUUQ3nna6j0yp2nILhDtX7bBAXMgr96YA/wSX11VVbfhbfwJK4usPgU0MrOQ==
X-Received: by 2002:a6b:5f03:0:b0:67b:ef4d:e3ed with SMTP id t3-20020a6b5f03000000b0067bef4de3edmr6026852iob.45.1658163356892;
        Mon, 18 Jul 2022 09:55:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:74b1:e8b4:99c9:4baf? ([2600:1700:e72:80a0:74b1:e8b4:99c9:4baf])
        by smtp.gmail.com with ESMTPSA id x1-20020a923001000000b002dc1d6652cesm4947151ile.13.2022.07.18.09.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 09:55:56 -0700 (PDT)
Message-ID: <11aa9b43-adea-4e90-9c70-ab3579aa445f@github.com>
Date:   Mon, 18 Jul 2022 12:55:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 07/12] rebase: add --update-refs option
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        me@ttaylorr.com, Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <3ec2cc922f971af4e4a558188cf139cc0c0150d6.1657631226.git.gitgitgadget@gmail.com>
 <20220718090557.GA5616@szeder.dev>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220718090557.GA5616@szeder.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/18/2022 5:05 AM, SZEDER Gábor wrote:
> On Tue, Jul 12, 2022 at 01:07:00PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>

>> +--update-refs::
> 
> So the option is called '--update-refs', but ...
> 
>> +--no-update-refs::
>> +	Automatically force-update any branches that point to commits that
> 
> ... its description talks about "branches".

>> +		OPT_BOOL(0, "update-refs", &options.update_refs,
>> +			 N_("update local refs that point to commits "
> 
> And its short help talks about "local refs".
> 
> I think at least the documentation and short help should use
> consistent terminology.

Thanks for catching this. I think I should use "branches" here, but
keep the name "--update-refs". The biggest reason is that it provides
a nice parallel with the "update-ref" sequencer command. This command
allows updating _any_ ref, such as lightweight tags in refs/tags/*
or even refs in refs/my/namespace/*.

The --update-refs option doesn't create the commands to update tags
or refs in places other than refs/heads/*.

Thanks,
-Stolee
