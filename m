Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD01C47084
	for <git@archiver.kernel.org>; Tue, 25 May 2021 17:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E3B6141D
	for <git@archiver.kernel.org>; Tue, 25 May 2021 17:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhEYRN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 13:13:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64008 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbhEYRN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 13:13:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D55A7C0996;
        Tue, 25 May 2021 13:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=hNIfGYHgF20aqYWttqnELZAZ56mzT2f5+IDVYrli8iw=; b=O7/Y
        tqYojC+aNnKQrvpDBmKM9eGleTP5+rLYSg8d2ZWEyF1xEZqm1sqzM8PfpyAi6vLQ
        /jOdiRM3K/d1QiC3liGxGrql6yIZb0ajkMuTeoNUEYOt/v8FrFts2AGUlzTVpVJO
        wsJnzW+zott6KyQZ1ZuGKgKZk7bFcNOJ0UqZErI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD908C0995;
        Tue, 25 May 2021 13:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F0AEC0994;
        Tue, 25 May 2021 13:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] [GSOC] ref-filter: support %(contents) for blob, tree
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
        <19413cfdb1ea50de401ab958b954a550b6514688.1621763612.git.gitgitgadget@gmail.com>
        <xmqqfsybh0bn.fsf@gitster.g> <xmqqa6ojgy9h.fsf@gitster.g>
        <CAOLTT8TaJm=9mQNXMGxt-bME-ynOpv4CKZvZw+yo9zNueH_VPw@mail.gmail.com>
Date:   Wed, 26 May 2021 02:11:54 +0900
Message-ID: <xmqqczteeo11.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E5FD69A-BD7C-11EB-89D6-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> So I don't know if adding %(header) will cause duplication of functions.

I do not think you can duplicate the feature of %(header) with
other existing placeholders.  You may want to dump the headers of
series of commits so that you can find if there is any commit with
unusal header elements, but %(tree), %(parents), etc. would by
definition be the known ones, so any combination of them will not be
a substitute.

But nobody is asking for it right now, and your cat-file --batch
does not need it right away.

What I wanted to say in the message you are responding to was *not*
that you would want to add %(header) for completeness right now.
But thinking beyond your immediate need (i.e. the "whole thing") and
imagining how various pieces, including the ones that do not exist
yet, would fit together, would help you to avoid designing the parts
you immediately need in a way you would regret in the future.
