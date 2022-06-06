Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A881AC433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiFFR3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiFFR3y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:29:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1100A186B91
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 10:29:52 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 629F111AAFD;
        Mon,  6 Jun 2022 13:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L9PtgmyK8OXGUJv6HfnNW6hdqMeIVQhNr7X6Iu
        ljP90=; b=j7jrpTGGnxa4/P0iCXek5vNMAHp6ByGUTqd/n3EiXQRNWMp6BvHjcr
        h1CPn8ZXer7nNI0eelSFqztSGdC0zaCis76tOFND7hJThf1tjmfwFV2RJB3NaAqJ
        aBr0hrVynlA+z58Jef/dVaHlgjSyJ3dWGj9uvyMFVtVf1veyZf3SM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A10911AAFC;
        Mon,  6 Jun 2022 13:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE9E211AAF9;
        Mon,  6 Jun 2022 13:29:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org
Subject: Re: git push --delete <url> <branch> fails if run outside a repository
References: <20220606080528.rfugporpazoujceq@lucy.dinwoodie.org>
Date:   Mon, 06 Jun 2022 10:29:50 -0700
In-Reply-To: <20220606080528.rfugporpazoujceq@lucy.dinwoodie.org> (Adam
        Dinwoodie's message of "Mon, 6 Jun 2022 09:05:28 +0100")
Message-ID: <xmqqpmjl8zu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45B9DAC0-E5BE-11EC-BF5E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> When using `git push`, rather than specifying a remote by name, one can
> also specify a remote by URL, and this includes when the only operations
> being performed are to delete refs on the remote.  This doesn't require
> any information about any local repository, but it fails unless the
> command is run from within an existing local Git repo.
>
> This seems like a bug to me: there's no reason this shouldn't work.

Perhaps.

While I fully agree with you that there is no reason this shouldn't
work, I am not sure if there is a good reason to make it work,
either.  Any other push needs to have objects on _our_ side and
requiring you to be in a repository is a sure way to do so.  I am
not convinced that it is worth our engineering effort to add a
special case for this, but patches that are cleanly done without
making too much damage to the existing code in readability and
maintainability are probably welcome.

Thanks.
