Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC477C433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 20:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB09600D4
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 20:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346844AbhIBU5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 16:57:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55010 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346686AbhIBU5a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 16:57:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03E15152A95;
        Thu,  2 Sep 2021 16:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KfcDQYw+wtwQvJIrLtzq2tHX0XNmF1MUoVYvOB
        vm7RI=; b=Z41SSjz2Y6U8GdEEVeuCMJtmZs5b5RYSvQALHZtmzYdX/qOoRun7M3
        XZCogfeB5vYiXEvkbRlupdaprqJF13iFNouoTE/QVgioEjOus/jXYxhkdFZH/HnX
        r43fQWu1lKsaloprltPOVaQ/kOlmwULUcYk39/RaKFCMSGXID0hl8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EFD27152A94;
        Thu,  2 Sep 2021 16:56:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E51B0152A93;
        Thu,  2 Sep 2021 16:56:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Baumann <peter.baumann@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 0/9] remove dead shell code
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
        <CAJm9OHfN9iXDt-rzu-wb=67y4PPpmCUgMfmZPy1JMBJkHG256g@mail.gmail.com>
Date:   Thu, 02 Sep 2021 13:56:26 -0700
In-Reply-To: <CAJm9OHfN9iXDt-rzu-wb=67y4PPpmCUgMfmZPy1JMBJkHG256g@mail.gmail.com>
        (Peter Baumann's message of "Thu, 2 Sep 2021 18:53:31 +0200")
Message-ID: <xmqqzgsuitmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DFC5D98-0C30-11EC-B11B-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Baumann <peter.baumann@gmail.com> writes:

> Hm, I have scripts here, implementing some porcelain commands which
> follow the same approach as
> the git porcelain scripts, e.g.
>
>   #!/bin/bash
>   SUBDIRECTORY_OK=Yes
>   . git-sh-setup
>   require_work_tree
>   require_clean_work_tree
>   cd_to_toplevel || die "Can't find top level for the git repo"
>   set_reflog_action my-special-script                          # this
> will be broken by the patch series
>
> I was under the impression that this is how it should be done when one
> needs to write some custom git scripts.

The reason why output from "git log --stat -- git-sh-setup.sh" does
not have that much removal is exactly this.  These are part of our
published API.  It is very much appreciated that you raised this
point.

Thanks.

