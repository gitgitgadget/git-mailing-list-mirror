Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48943C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E8320720
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RZNpFdAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404162AbgFXPmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:42:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62876 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391164AbgFXPmi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 11:42:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5C357615B;
        Wed, 24 Jun 2020 11:42:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wqSCqDhWQlOzD79pKGhuceZ31NU=; b=RZNpFd
        AIXHmduAjem3NTLd4yNaVpaQV9pr/Llj0aR+5iAMN96ErGkH0uZtlDAJUjMtLjUA
        5giw9rdeQ3H4+8MK8vTq0ceoXjdYKAAIfRQYCdy1WPIwt+rHZy/bfNYGx4QZcRME
        5sPBcNLIlO7h2QvgJq3I/7UXc6Q+RYhTbkup0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jLX1NhxEmJx/ci3bgNccvO2NBJk1Pl/6
        gFUKbU6LEH3E8Hh9TznrBPw8MpQOSWBuOkBi7FKo3w8ioojKpzJU0HYv1KrKazBc
        GT6KPGXSWRdzF5fNAyXFcv5JPx22TXe8DpbBdtA3R1WAOJ3PDZrAnpXkV1d18jFO
        p25bppgPQ+A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE4897615A;
        Wed, 24 Jun 2020 11:42:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C27376159;
        Wed, 24 Jun 2020 11:42:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Accommodate for pu having been renamed to seen
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
        <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
        <20200624152409.GA143253@generichostname>
Date:   Wed, 24 Jun 2020 08:42:34 -0700
In-Reply-To: <20200624152409.GA143253@generichostname> (Denton Liu's message
        of "Wed, 24 Jun 2020 11:24:09 -0400")
Message-ID: <xmqqpn9o8o7p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53361BFA-B631-11EA-A623-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Dscho,
>
> On Wed, Jun 24, 2020 at 02:48:37PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> Changes since v1:
>> 
>>  * Rebased onto master (no conflicts, so it is safe, and it is more robust
>>    than basing the patches on seen which already contains v1 of these
>>    patches).
>
> Out of curiosity, why would we ever want to base any patches on `seen`?

Never.  Even bulding on top of 'next' is discouraged.  

Either "prepare a merge on top of 'master' with all the topics in
flight that you depend on, and base your series on top of it,
risking that any one of these topics can take your series hostage"
or "wait until these topics graduate and then base your topic on
'master'".  I'd vastly prefer the latter, as it would become
cumbersome if one of the topics you base your series on gets
rerolled.



