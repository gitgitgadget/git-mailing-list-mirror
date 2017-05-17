Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E189201A7
	for <e@80x24.org>; Wed, 17 May 2017 15:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbdEQPFy (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 11:05:54 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:64650 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751531AbdEQPFx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 11:05:53 -0400
X-AuditID: 1207440c-9d9ff70000001412-c2-591c66cf26a2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 53.26.05138.FC66C195; Wed, 17 May 2017 11:05:52 -0400 (EDT)
Received: from [192.168.69.190] (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HF5nnp010170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 11:05:50 -0400
Subject: Re: [PATCH 10/23] files_ref_store: put the packed files lock directly
 in this struct
To:     Jeff King <peff@peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <dd7637060bac1a27e03563edc82649812dcf897c.1495014840.git.mhagger@alum.mit.edu>
 <20170517131753.rditx62clmkrdmeq@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <654c485e-f758-22ea-8ed9-884e1e904595@alum.mit.edu>
Date:   Wed, 17 May 2017 17:05:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170517131753.rditx62clmkrdmeq@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1L2QJhNpsKmbx2LtsztMFl1Xupks
        GnqvMFssefia2aJ7yltGix8tPcwWmze3sziwe+ycdZfdY8GmUo+u9iNsHs969zB6XLyk7PF5
        k1wAWxSXTUpqTmZZapG+XQJXxp1fM5kL7nJUtG2fztzA+Jeti5GTQ0LARKL3/l2WLkYuDiGB
        HUwSfz9+ZQdJCAmcY5KYMl0AxBYWiJdY+OIUWIOIgKzE98MbGSEaDjFKnH7ayQSSYBbYxCSx
        9aw9iM0moCuxqKcZLM4rYC/x588UMJtFQFXi15eTLCC2qECExMPOXewQNYISJ2c+AYtzCrhI
        zNrawAgxU13iz7xLzBC2vMT2t3OYJzDyz0LSMgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusW
        Jyfm5aUW6Rrq5WaW6KWmlG5ihIQ5zw7Gb+tkDjEKcDAq8fBGBMhECrEmlhVX5h5ilORgUhLl
        3f9AOlKILyk/pTIjsTgjvqg0J7UY6HUOZiUR3pw4oHLelMTKqtSifJiUNAeLkjiv6hJ1PyGB
        9MSS1OzU1ILUIpisDAeHkgTv/lSgRsGi1PTUirTMnBKENBMHJ8hwHqDhTSA1vMUFibnFmekQ
        +VOMilLivEtTgBICIImM0jy4XlgaesUoDvSKMK8YMCkJ8QBTGFz3K6DBTECDm0E+4i0uSURI
        STUwOvLO5rUU5IyXXbI66eIcoU4TQ2GJznW6ZWX9Sw/JF89f2eTt8OhPprdoGHdSxvug7203
        M1OtzY37pd6HNE3gYGgULFn9ZqYn3zs7lXV2c0PuM2SH6mtuWW9za9qmYMZtD28n/VyqnVO7
        UZ81+KD6L2Z2Hp690hx88ofPeU4K8as+ldm1X0aJpTgj0VCLuag4EQD3oD03HgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 03:17 PM, Jeff King wrote:
> On Wed, May 17, 2017 at 02:05:33PM +0200, Michael Haggerty wrote:
> 
>> Instead of using a global `lock_file` instance for the main
>> "packed-refs" file and using a pointer in `files_ref_store` to keep
>> track of whether it is locked, embed the `lock_file` instance directly
>> in the `files_ref_store` struct and use the new
>> `is_lock_file_locked()` function to keep track of whether it is
>> locked. This keeps related data together and makes the main reference
>> store less of a special case.
> 
> This made me wonder how we handle the locking for ref_stores besides the
> main one (e.g., for submodules). The lockfile structs have to remain
> valid for the length of the program. Previously those stores could have
> xcalloc()'d a lockfile and just leaked it. Now they'll need to xcalloc()
> and leak their whole structs.
> 
> I suspect the answer is "we don't ever lock anything except the main ref
> store because that is the only one we write to", so it doesn't matter
> anyway.

Correct. If that ever changes, we'll be ready!

Michael

