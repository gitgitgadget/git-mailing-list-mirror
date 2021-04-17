Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46DCC433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 03:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0BD06113D
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 03:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhDQDgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 23:36:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56541 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhDQDgu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 23:36:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39C4BCB05A;
        Fri, 16 Apr 2021 23:36:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qqOIOdpP4ce6FrhW/y0JC4E8H6Y=; b=q3nP+H
        aOXW2nVeKbwJTSiFsUKNerNfig0RIxlNDWEsWvWTJ2aRDn2x2c/5ty5eKyU2FCT8
        mlPUAOkoMMw3LY1+forJi9L5eOVeCVi4pNU1Ac/Q1UH2+lAz9j3jJagc/QsL4g6B
        12ZxRZm1Xr1H/UesTqxsjtGl2wbvh0gAwC6r4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sp9d8YxcRM9aJvcndpWL2r/iuXRPnIl5
        4iUhZa5r0clhcunRsS5PwnRz7tjYdxFv1WvQYpD17ZhkF9FB47vLTvtNxNvmX00r
        Iqqp5jdyMWGcbwaeDRNZjRwIouN6FiJ49v/xVT8Uj5SuTtNH/ujRCQWaPpmac4AL
        ILdv3rpxLW0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3182DCB059;
        Fri, 16 Apr 2021 23:36:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0284CB058;
        Fri, 16 Apr 2021 23:36:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v10 2/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
        <daa889bd0ade1111eb8b1471fe7e953fcb41d12b.1618562875.git.gitgitgadget@gmail.com>
        <xmqqy2dikpc1.fsf@gitster.g> <xmqqr1jakp57.fsf@gitster.g>
        <xmqqpmytiplw.fsf@gitster.g>
Date:   Fri, 16 Apr 2021 20:36:23 -0700
In-Reply-To: <xmqqpmytiplw.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        16 Apr 2021 19:58:35 -0700")
Message-ID: <xmqqlf9hinuw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 152AF4D4-9F2E-11EB-BC0D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> And continuing this line of thought, I think it would be a perfectly
> fine extension to allow the script/program that is launched by the
> .command or .cmd mechanism to signal interpret-trailers that it does
> not want it to add a trailer as the result of this invocation by
> exiting with non-zero.  And that would be a reasonable way forward
> without having to add yet another ugly workaround .runMode.
>
> For example, trailer.signoff.cmd could be this script:
>
> 	#!/bin/sh
> 	if test $# != 1
> 	then
> 		exit 1
> 	else
> 		git log -1 --author="$1" --format='"%aN" <$aE>'
> 	fi
>
> where the "implicit" invocation is signalled by not passing any
> argument, to which the script reacts by exiting with 1, and the
> interpret-trailers would discard the result of the unasked-for
> invocation.

The beauty of this approach, compared to say .runMode, is that the
program specified by .cmd (and .command, except that it cannot tell
if the invocation is in response to explicit --trailer=<key>:<value>
request, or the extra one that is done even without being asked)
have even better control in squelching the trailer output.  Not just
to silence the extra unasked-for invocation, it can inspect the
value given to each of --trailer=<key>:<value> option and decide not
to add a trailer in response to it.

