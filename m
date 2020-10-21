Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37335C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68E02415A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cKn0FzTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440761AbgJUUo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:44:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50322 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440724AbgJUUo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 16:44:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A94FFFE3B2;
        Wed, 21 Oct 2020 16:44:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qIyydt/UdbhA30qzn5n75wSHvVk=; b=cKn0Fz
        TEa3vN9Da/+8Y67dkLE/u206D1hsN1I8FbLhfhSYi79XujvB4aI+4lzF83XgkDRP
        BOp8SqzNW1dK8mN/sQ9hyBa8/C2FhIuQd2znEt47ZjyWWXX0OU2jwbwbOzLJE56p
        NiWtKdkzV85Asabuj5ovsHIV/CdxyzZimBvqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XELCfaL5EAzSHojVCAvxrHrL4/WyqjBm
        GjmCXwCJqaS5CrR5BvlShaqIEzB3CoKFzI1yR9RpTFmtITdsnhoW9kskNHZMqW3D
        Z/DxgdZTmFCi15ZTNN2RDi1sPgeTg3maIKuPCCict/8rHmtCvDB30xkwncwLCeOC
        NtFNiq/JaOg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1A1AFE3B1;
        Wed, 21 Oct 2020 16:44:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E885BFE3AF;
        Wed, 21 Oct 2020 16:44:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: mr/bisect-in-c-3, was Re: What's cooking in git.git (Oct 2020,
 #03; Mon, 19)
References: <xmqqr1put77h.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010211647050.56@tvgsbejvaqbjf.bet>
Date:   Wed, 21 Oct 2020 13:44:21 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010211647050.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 21 Oct 2020 16:48:03 +0200 (CEST)")
Message-ID: <xmqq5z7371i2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3352D05C-13DE-11EB-9EAC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 19 Oct 2020, Junio C Hamano wrote:
>
>> * mr/bisect-in-c-3 (2020-10-16) 7 commits
>>  - bisect--helper: retire `--bisect-autostart` subcommand
>>  - bisect--helper: retire `--write-terms` subcommand
>>  - bisect--helper: retire `--check-expected-revs` subcommand
>>  - bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
>>  - bisect--helper: retire `--next-all` subcommand
>>  - bisect--helper: retire `--bisect-clean-state` subcommand
>>  - bisect--helper: finish porting `bisect_start()` to C
>>
>>  Rewriting "git bisect" in C continues.
>>
>>  How ready is this one?
>
> It has been reviewed _quite_ a couple of times over the course of 9
> iterations, and I think it is ready now.

Oh, numbers I can count.  I wanted to hear "yes, all previously
known issues have been addressed" from those who did read everything
in it and gave their feedback.

Do you want to give your "reviewed-by" now?

Thanks.
