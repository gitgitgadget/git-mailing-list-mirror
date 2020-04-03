Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41AEC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 00:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8345120787
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 00:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oH9Sw78o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389422AbgDCAUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:20:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54028 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388971AbgDCAUd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 20:20:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 210FF533B9;
        Thu,  2 Apr 2020 20:20:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J/sVZeYAFj31w93xvhPIdD3aGL4=; b=oH9Sw7
        8oT/LP9TGSrduRHbypBQCTCFwQhljr2MTv73QRr/0l6u4ApB/8n0xqIB5Gp+AU9r
        jDkKPiWuu8W/7tjiEcRqqWJf65AbsdDq1GLS5m14NUUfiLCoiwZoiBR0uiYCVmjd
        baAmar044SJxXK+dXGnNyq/4Mt6en4jfGFsG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hrLa3DO6quvSjZzReSyZOe662VBpXKHa
        PV3GDpUb0zymCl8EeiUPR5TqZZBKOsiPDyJJjFpJ9uBQYIjpBHOgRXeygcuNY4z5
        FwQs3f/AucjD6GvaJcxvihe94/l2wVCRN9ZL15KnIUFN7G3BwF7E2ri8yZxWpuHn
        NSmzHM3X3hg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17491533B8;
        Thu,  2 Apr 2020 20:20:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B732533B7;
        Thu,  2 Apr 2020 20:20:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
References: <20200402225807.8603-1-shouryashukla.oo@gmail.com>
Date:   Thu, 02 Apr 2020 17:20:30 -0700
In-Reply-To: <20200402225807.8603-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Fri, 3 Apr 2020 04:28:06 +0530")
Message-ID: <xmqqo8s91ktt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED38DD28-7540-11EA-98BD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Subcommands in 'submodule--helper.c' which give a callback to other functions
> have structures and macros named in the format: 'subcommand_cb' and 'SUBCOMMAND_CB_INIT'
> respectively.
>
> The subcommand 'foreach' did not follow this convention and therefore had the naming of
> the form: 'struct foreach_cb' and 'CB_FOREACH_INIT'. Rename these to: 'struct foreach_cb'
> and 'FOREACH_CB_INIT' respectively.
>
>
> Shourya Shukla (1):
>   submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
>
>  builtin/submodule--helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Isn't this already in 'master'?

