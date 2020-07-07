Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAAFC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747542064C
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D1VTHOfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGGTKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:10:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65251 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGTKi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 15:10:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68DA3D3FAD;
        Tue,  7 Jul 2020 15:10:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EDnBQae89MTlkJBsu4O8RQQ7v6o=; b=D1VTHO
        fwu7Gt3uWGtlm6YEp1Ktnfs2b0hv8dky3ZuqD7Vt7CkXA+lxoMh+8+WYpL3WDVnR
        BtpTPhImhu91QoxuUeMxtnwRbIVtu8TZ7OrnY6vDgcKOJF75/dAnDgP4j1dZpFal
        74vsW7fexV5Ee0cfmWKnJGVsKeXl+MH/PhyYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IJTIXkzYCc6QCtrwLb0xNesv/UVLT23h
        CN4fzteBG1KjhCQVzHPEtVshfogphCHNkTauCVaI0ru08tFgJUIhv4Vrz0knSRvl
        6Wk3UXirS2p4++2kFYr17T4xYy3Rd0/7PJCKzfeFlN8AcE4NDRiI+PZy1ASrEFjB
        zjBMQxz8nvY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6194BD3FAB;
        Tue,  7 Jul 2020 15:10:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B081BD3FA8;
        Tue,  7 Jul 2020 15:10:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jimit Bhalavat <jimit@rams.colostate.edu>
Cc:     git@vger.kernel.org, David Huseby <dhuseby@linuxfoundation.org>
Subject: Re: GPG Commit Signing Project
References: <3942AC4E-6798-442B-81E9-B3D9B10A4A56@rams.colostate.edu>
Date:   Tue, 07 Jul 2020 12:10:31 -0700
In-Reply-To: <3942AC4E-6798-442B-81E9-B3D9B10A4A56@rams.colostate.edu> (Jimit
        Bhalavat's message of "Tue, 7 Jul 2020 12:01:30 -0600")
Message-ID: <xmqq1rln5efs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8840D4B2-C085-11EA-9B3A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jimit Bhalavat <jimit@rams.colostate.edu> writes:

> When we last spoke, David Huseby, my mentor for Hyperledger Git
> Commit Signing Project, proposed an outline of what we are trying
> to achieve. We have come to the conclusion that me and him are
> going to spend the rest of the summer analyzing the format signing
> infrastructure and will have proposals and questions as we go.

I thought the conclusion was that there is nothing to do on the git
side as your project would wrap the non-GPG signing tool of your
choice to have an external interface that is similar to how GPG
looks to git and that has the added benefit that the product of your
project to interact with tools other than git [*1*].  So...

> I am also going to write a technical design document which will
> help us analyze the problem. I realize this is a larger long-term
> project that I think deserves a topic and how would I set a topic
> up?

... your longer-term plan may very well deserve a detailed technical
design document, but I am not sure what help our project can give
(other than obvious things like saying "good luck").

Sorry for not being able to help all that much.




[Reference]

*1* https://lore.kernel.org/git/xmqqd0642p3q.fsf@gitster.c.googlers.com/
 

