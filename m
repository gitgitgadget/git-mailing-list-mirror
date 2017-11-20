Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAD5B20954
	for <e@80x24.org>; Mon, 20 Nov 2017 05:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbdKTFht (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 00:37:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58766 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750795AbdKTFhr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 00:37:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31129AAF90;
        Mon, 20 Nov 2017 00:37:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ZfvOdu5L+pnbSJT93qFhkF3jrk=; b=S1HefE
        WlUqqXf05xxdexsjARECghKJ1xox9uOv6T4dddIfd8Iu0VR13lRzK16uMfsgkx9j
        DJSRsleo0sPwRDMsd+JtGwkDI/lzxfeP/ZdXxf/xQorEpB8mpbtCcKrqgoN9SOxv
        IorF743rDl07d2EDIc/MLpwqDswbjZ/iKpC0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v2kdUKX9w2jt1KHv2bQgt0oRe73iz5j1
        mQ2q/MORgHbVwIMiaeiaoJum1Y0vTVfKE0mzXIG46FvOgghsv6a+X4UKkwkuoIHQ
        hf2/yrt8Z+6qgmmz/LvIxMXsoxmBb5Tp0Iw6TcVT6UWC8svItA/iS7evEJCmtLuw
        Hs/oHD4L0do=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2735AAAF87;
        Mon, 20 Nov 2017 00:37:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94FA2AAF86;
        Mon, 20 Nov 2017 00:37:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git pull
References: <20171113231155.GA26779@eros> <20171114110500.GA21175@kroah.com>
        <20171114213320.GB905@eros>
        <CA+55aFyMxkS=8JzZ+ROOAFkwR45EKBnQ0GUMQS4f+r_-fFWiEA@mail.gmail.com>
        <CA+55aFzhK+GPO1_Zm2PoQiq5-cHAq6nz1ejrBhGhWX-KAjTU9A@mail.gmail.com>
Date:   Mon, 20 Nov 2017 14:37:45 +0900
In-Reply-To: <CA+55aFzhK+GPO1_Zm2PoQiq5-cHAq6nz1ejrBhGhWX-KAjTU9A@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 16 Nov 2017 12:36:08 -0800")
Message-ID: <xmqqr2stldcm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F03A29B8-CDB4-11E7-8FBB-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> A few notes for other people who end up doing this:

[this meaning use of insteadOf to redirect public URLs to
ssh://git@gitolite URL]

>  (a) ssh is slower, and the gitolite machine is not as reachable.
>
>  (b) it affects your merge commit message.
>
> As to (a), yes it's noticeable, but the extra couple of seconds isn't
> really that big of a deal. Depending on exactly where you are, though,
> you might end up wanting to use https:// to the public servers
> instead.
>
> But (b) actually ends up being annoying, because I don't like my merge
> commits to contain references to repositories that aren't actually
> available unless you have a kernel.org account.
> ...
> Which is simple. Just create a .git/hooks/prepare-commit-msg file that contains
>
>   #!/bin/sh
>   sed -i 's|ssh://gitolite.kernel.org/|git://git.kernel.org/|g' "$1"
>
> and make it executable, and git will do that commit message editing for you.

This should work with any recent versions of Git (1.7.4.2 and
upwards), but it still is a workaround.  Should we mark it as a
feature request in the Git land to record the URL you typed as-is in
the builtin/fetch.c::store_updated_refs() function, instead of the
one that was rewritten by the insteadOf mechanism?

It would probably need an update to "struct remote" to have new
fields, to teach remote.c::alias_all_urls() not to overwrite the
url[] (and pushurl[] merely for symmetry) fields, to add a field to
"struct transport" and teach transport.c::transport_get() to record
the original URL in it so that builtin/fetch.c::fetch_refs() can
give it to store_updated_refs() instead of the rewritten one.

Many tiny changes in a rather deep codepath, but feels fairly a safe
change that is isolated and straightforward.



