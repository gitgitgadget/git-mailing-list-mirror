Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E76D1F461
	for <e@80x24.org>; Wed, 15 May 2019 01:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfEOBu4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:50:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63973 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfEOBu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:50:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E79913A312;
        Tue, 14 May 2019 21:50:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j7pA5QnQJ3O4KHYe/MTxgjH5O+g=; b=Yo5ppg
        lAf4Mjk5qdGJAk8Xh52Ic7sDBDBrbl43Yg8X1nx97JqJmKm6B90NtFO9AfgIqKv8
        nPfbVOwFC49bD/RiDqda6An1AKH1O5UMjwp4ncT8Bi+hgdGbcYh8N3yXqxs4IISe
        smVPkr0ofWYZpZgCWhgFdqCkT58h79tq+4hAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A/jyx3FtSGjBzEpOLERaI450mrGN1ofz
        CQa8i+e4VPoOn5/4AGVbuL9Zz7EaUIXF7Eu1sAvTOFdXSAo6xnmJr3gWCcZLiBJy
        fE37n9yrh6nZwFKWQ78YwEFUXp5EmLU2BBx/AuPxBAkOC6RtlssMudzWFnbbds9q
        vPYVknsEVEw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 472D713A311;
        Tue, 14 May 2019 21:50:54 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B772F13A310;
        Tue, 14 May 2019 21:50:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Missing branches after clone
References: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
        <CACsJy8AX9Wp3W=d1=ozF9nZXGE1muooMf7fKCtdOOi1g8QRmig@mail.gmail.com>
        <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>
Date:   Wed, 15 May 2019 10:50:52 +0900
In-Reply-To: <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org> (Philip Oakley's
        message of "Tue, 14 May 2019 11:33:05 +0100")
Message-ID: <xmqq5zqc8ozn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFCF8F92-76B3-11E9-9851-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> It is a 'branch which tracks a remote', and it is has the 'last time I
> looked' state of the branch that is on the remote server, which may
> have, by now, advanced or changed.

Yup, I thought we long time ago decided to discourage use of "remote
branch(es)" in our documentation to help unconfuse users and stick
to the term "a remote-tracking branch" (the "remote-tracking" is a
hyphenated one word)?

> So you need to have the three distinct views in your head of 'My
> branch, held locally', 'my copy of Their branch, from when I last
> looked', and 'Their branch, on a remote server, in a state I haven't
> seen recently'.

Yup.  FWIW, when I need to refer to the last one, I'd always say "a
branch at the remote" to avoid the confusing term "remote branch".

