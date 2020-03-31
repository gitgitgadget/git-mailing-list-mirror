Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96002C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 18:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F8C21473
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 18:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cNt4tbUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgCaSrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:47:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54268 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgCaSrL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 14:47:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 031F7B9E06;
        Tue, 31 Mar 2020 14:47:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4RBggfnmXBF8avUVdfhDJNi068c=; b=cNt4tb
        Uu+ND49970R2O4WzTXJOpRN2HE5Hznl2II+c0NyFDYM4k+7t8Sgx4TWQUpYgmoC8
        w7z6Zfi4Ge8wupsj7+pXQDCsNdEg+EiLdjyN6oZ0XqqgjZFlIp9vWBv8QQtm9tSX
        ZYI1F/rS5WupNMcyo3wTiIChh1BHSPJzMibKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l6A7fBg3Q7K2rPWMadduEtCV2EvAI0E7
        BNZ6TA9VN/wdUaDPWivjFG2mhceUnGXVdfCRe4Z1avJLPkrbqjkPWDU8ARRgtwY2
        FFpd4GJ93OPLk4W1wcXflFIGxsvLiWe2R2HAUvkC7kTzNtygQQ800roN5t1MTfR9
        HOMLbT0ZdxI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EEF3CB9E05;
        Tue, 31 Mar 2020 14:47:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 330A3B9E04;
        Tue, 31 Mar 2020 14:47:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/5] ci: replace our Azure Pipeline by GitHub Actions
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <20200331144648.GC15850@danh.dev>
Date:   Tue, 31 Mar 2020 11:47:05 -0700
In-Reply-To: <20200331144648.GC15850@danh.dev> (Danh Doan's message of "Tue,
        31 Mar 2020 21:46:48 +0700")
Message-ID: <xmqq8sjg745y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 056CBBDE-7380-11EA-BC32-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

>> The only caveat is that this will only work once the patch series makes it
>> to master.
>
> Github Actions also works in other branches, at least in pu:
> https://github.com/sgn/git/runs/548975243?check_suite_focus=true
>
> Anyway, this series will conflicts with my series for linux-musl CI.
> And, Github Actions' Documentation job in pu failed because of missing
> "curl-config".
>
> Attached patches can be used to merge this series into pu.

Please work together to have either one of them build on the other.
Thanks.


