Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343C2C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 01:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E423720637
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 01:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oGWUUK6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLJBqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:46:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57762 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfLJBqM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 20:46:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13D26A1DB4;
        Mon,  9 Dec 2019 20:46:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Km+9w0+A8IfkqOFTZNAbqEkzaYw=; b=oGWUUK
        6XoptBHmslqIfvXzYDN2kRdqXL1CvkE7Qmqvh402223DK7od92gYyejkHUMyt17/
        AtgEIOfKsAf5Xy1UVPlt7pBqe+wIEZ3gAOpl4uph1S2Pw93o+D/K1bZddlRG0sm7
        M1CArguXpSPoaj06rTOj74OtXpkgei9H9V+iI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IDs4NiNmVEvPiIs0NJsRnke4c/bgVzKJ
        oKZ+AXGyZ9CqlOkRkqmufEoqBSib7jDsN7UsbFQjYZ6F3KXVggRZyOJaAe2Ak0IX
        /hoYnOQyihuMnAPqXLeULgldOoz1NxEHSiMDby9gmkvnSHg2bgvZIYQweyTT/bvq
        srDPqKU4rgE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BAEDA1DB3;
        Mon,  9 Dec 2019 20:46:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3592EA1DB2;
        Mon,  9 Dec 2019 20:46:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 1/2] gitk: use --pretty=reference to generate the commit summary
References: <20191209182534.309884-1-dev+git@drbeat.li>
Date:   Mon, 09 Dec 2019 17:46:06 -0800
In-Reply-To: <20191209182534.309884-1-dev+git@drbeat.li> (Beat Bolli's message
        of "Mon, 9 Dec 2019 19:25:33 +0100")
Message-ID: <xmqqsgltrm01.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D68D5EA2-1AEE-11EA-9D71-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> Git learned the "reference" pretty format in 1f0fc1db85 (pretty:
> implement 'reference' format, 2019-11-19). Use it also in gitk instead
> of duplicating the format string. This way, gitk always follows the
> formatting convention defined by git.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
> Junio, this goes on top of dl/pretty-reference, currently in pu.

Sorry, but it will not X-< for at least two reasons.

1. gitk is maintained as a separate project, so any patch to it will
   have to come via Paul's gitk tree where it has this script the
   patch touches at the root level of the working tree.  It will not
   build on top of any of the topic branches I keep track of.

2. In order to use "--pretty=ref" in gitk, of course, it must be
   used with version of Git that has dl/pretty-reference included,
   but gitk program is meant to be compatible with any reasonably
   recent version of Git (to put it differently, it is not a
   requirement to have git version X in order to use gitk version Y
   where Y <= X), so it means that this patch has to wait for a few
   releases after the version of Git that has the pretty-reference
   stuff ships.

I personally suspect that it no longer makes much sense to still
require gitk to be usable with older version of Git these days, even
though I do understand that the discipline to depend only on more
stable features that appeared in older releases probably was a good
one in earlier days.  But gitk is not my project, so until Paul
declares that gitk versions will go hand-in-hand with git, 2. above
holds.

Thanks.
