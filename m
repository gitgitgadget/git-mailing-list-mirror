Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13702C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B365120731
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wcEdezEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgEJQri (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 12:47:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62339 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgEJQri (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 12:47:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0760A445F9;
        Sun, 10 May 2020 12:47:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kbb/yuDIspuLcwoJSwxBSuKJIzc=; b=wcEdez
        EL6wTl3RLvKmHm3IAoV4TQ5Dp7K5ku2a1Ld5te0PDq60yyBUIZ5X7W0gTynTG6tV
        Ix+WnYvtpRX8kdF/6Vuz8g+l1F4x3FfAIp1cPF363BdXlMUHzTyOeGEpVuIzf4zT
        nbobnooSBh8BqTjKEsg5eyWTJ05sAztuC61p4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EYTwSGOPeyMlyRSD7RxtnvzlGICQYeJy
        8gA6eUHsq4TLwfioGCGgNqy+bSlsAINdJKa6cfVbzmShG7jEGEM8/ypxSY4Nhxis
        y7ag/aIS3QcUK2lPTMaDRihLS2EDoT0boDyfUVYdkQnasZuUNmSf7UGaB8LCFla4
        okCogrFhPKI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE559445F8;
        Sun, 10 May 2020 12:47:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41C0D445F6;
        Sun, 10 May 2020 12:47:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     George Brown <321.george@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
        <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
        <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
        <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
        <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
Date:   Sun, 10 May 2020 09:47:34 -0700
In-Reply-To: <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
        (George Brown's message of "Sun, 10 May 2020 10:03:59 +0100")
Message-ID: <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F324174C-92DD-11EA-AE59-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

George Brown <321.george@gmail.com> writes:

> Running "git jump" from a shell prompt works as before with this patch.

I am not worried at all about that use case.  It is clear that you
had the "shell prompt" in mind from "test -t 1".

Given what "git jump" does, wouldn't it be natural to expect that
GUI programs that have no "shell prompt" interaction with the end
user want to use "git jump"?  It may even be driving a graphical
version of vim---or is it impossible for such a GUI program to
exist?

As long as such a regression for existing users use is impossible, I
think the patch is probably OK, but doing a hardcoded "cat" smells
like a very bad hack, compared to a solution on the program's side
that *wants* to read the prepared file to arrange that to happen
(e.g. via setting the GIT_EDITOR environment to "cat" within that
program).

In any case, I am not a "git jump" user, so...

