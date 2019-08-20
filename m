Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4FEC1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfHTSsC (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:48:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55762 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbfHTSsB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:48:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 972CB7ADBB;
        Tue, 20 Aug 2019 14:47:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vwG19IYwaXEKqWy1VrV0SH+GHfY=; b=eYCVZ4
        3TMsCq3afq9EYtM3EeTTxYE7IiA/aZTqYEYt+l2AvLEIuPXGDzsnb/n3myfEG8ny
        Bo+Epogz1GfLG6FHYbw1b6aUGn2JAb84uvNR6Ec4lJhbmyZRbWkCMWPc5M4I276D
        ZYcSkqbkuKLu+NNOvQirN2MK4EfsqauOrEuCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X1H6gYHUbiXEqwFM92Vr1p7da6fSqt9n
        jqhv1+4ETqW3WesdQOu1k1BYDK8LfeFOTP81ENbYiRERv34OcRaoORn6pmMkEE52
        EqAnSS2boUR43RhQ3srNyxSHB5+ud7X82I+0Rx5piHcZpaMnMPMqj6ErFQZ/LfPv
        pzqZzVM60yU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F16D7ADBA;
        Tue, 20 Aug 2019 14:47:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C36487ADB8;
        Tue, 20 Aug 2019 14:47:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] git-gui: Add ability to revert selected hunks and lines
References: <20190819214110.26461-1-me@yadavpratyush.com>
Date:   Tue, 20 Aug 2019 11:47:54 -0700
In-Reply-To: <20190819214110.26461-1-me@yadavpratyush.com> (Pratyush Yadav's
        message of "Tue, 20 Aug 2019 03:11:07 +0530")
Message-ID: <xmqq5zmrvfl1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 067377DA-C37B-11E9-856C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> This series adds the ability to revert selected lines and hunks in
> git-gui. Partially based on the patch by Bert Wesarg [0].
>
> The commits can be found in the topic branch 'py/git-gui-revert-lines'
> at https://github.com/prati0100/git/tree/py/git-gui-revert-lines

Please don't do this.  

I would strongly prefer keeping the contination of history from the
history in Pat's git-gui repository.  If you clone from

    git://repo.or.cz/git-gui.git/

you'll notice everything for git-gui is one level up, and nothing
for git-core is duplicated in there.  You'll work on top of that, so
the patches to the git-gui project should not say things like

    ---
     git-gui/lib/index.tcl | 27 +++++++++++++++++----------
     1 file changed, 17 insertions(+), 10 deletions(-)

    diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
    index b588db11d9..cb7f74af45 100644
    ...

The leading "git-gui/" should not appear.

I have a fork of Pat's history with a single topic on top at
https://github.com/gitster/git-gui/ so building on top would
maintain the continuity of the history as well.

Once you prepared your changes in such a clone of the git-gui
project, in order to test them with the rest of Git, you'd make a
trial merge with the -Xsubtree=git-gui option.  Perhaps you have
git-gui's clone in $HOME/git-gui and git's clone in $HOME/git, like
so

	$ cd $HOME
	$ git clone https://github.com/gitster/git-gui git-gui
	$ cd git-gui
	... from now on, you'd work on git-gui in this directory  ...
	... do the work of this topic perhaps on 'revert-hunks' branch ...

	$ git clone https://github.com/gitster/git git
	$ cd ../git
	... trial integration ...
	$ git pull -Xsubtree=git-gui ../git-gui/ revert-hunks
	... do whatever testing necessary ...

As an interim (and hopefully evantual) maintainer of the git-gui
project, you'd publish from your local git-gui directory to a fork
of git-gui project you host somewhere.  Your patches for review
would also be taken from your local git-gui directory.

Thanks.
