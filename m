Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75705C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 16:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BEB32078E
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xVy5WPxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgFOQ5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:57:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56882 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgFOQ5K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 12:57:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1B14CEB4C;
        Mon, 15 Jun 2020 12:57:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ez6gUPDSPpFJjm5MU83AkatTz7w=; b=xVy5WP
        xldLdUURmQpVdf1SY7ghEc2PsFGNjcieItxP/ZjqLx7J+SKR9BactjK8CHhoUtTO
        o5JpWJrNYh7SDRZzqNtXadJcUjqL/yRxstLrEw6aKyg8gd6FvHNdaM1hv3Z/9mWZ
        cGX/YCPj569QPw1XLCvsrs1Hk/Y39OGIuO4o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cRUl1eOE+fsP8D+u16IfrnDeklDkud/d
        1tkktJwjTSeqiaavIIhvzAXi+imgQfz9XZp7HF5UdbfZP+khRxn7wKhnOIPYMGIA
        2hk0drjMIbxbxCD1OD5vwow8Q4Dc0panBsVE7BG4Z3BMI72G5Qq8LEPHtpMMcr2n
        tQXc2oh/Q80=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6762CEB49;
        Mon, 15 Jun 2020 12:57:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 293D7CEB46;
        Mon, 15 Jun 2020 12:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     "Curtin\, Eric" <Eric.Curtin@dell.com>,
        Konstantin Tokarev <annulen@yandex.ru>,
        Christian Couder <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Geary\, Niall" <Niall.Geary@dell.com>,
        "rowlands\, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "Coveney\, Stephen" <Stephen.Coveney@Dell.com>
Subject: Re: Collaborative conflict resolution feature request
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
        <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
        <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
        <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
        <xmqqa716zs7w.fsf@gitster.c.googlers.com>
        <30661592138737@mail.yandex.ru>
        <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
        <c4ebf430-a69d-3d46-bfb9-37c9ece9f519@iee.email>
Date:   Mon, 15 Jun 2020 09:57:04 -0700
In-Reply-To: <c4ebf430-a69d-3d46-bfb9-37c9ece9f519@iee.email> (Philip Oakley's
        message of "Mon, 15 Jun 2020 12:31:48 +0100")
Message-ID: <xmqq1rmgxo67.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E4BFEDA-AF29-11EA-81C7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> It could be effectively a special strategy. IIUC the '--' separator is
> already supported by the underlying parser code, so may not be that
> hard? (perhaps a local contribution to the codebase;-). Just a thought.

Assuming that there are paths A and B that would leave conflict in
an attempted merge between commits X and Y, you somehow resolve the
conflict in A and leave B unresolved, what would you pass to the
other person and ask to resolve the conflicts in B?  It cannot be a
merge commit that records X and Y as its parents and a single tree
object as the result, because the whole point of this is that you do
not even know what to record for B.

I think the most important and useful part of this is to design the
data format used for that task of passing from you to the other
person.  The way to specify which paths are yours etc. are much less
interesting and trivial part of the story, I would think.



