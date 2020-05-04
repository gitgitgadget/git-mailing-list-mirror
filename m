Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C326C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64CE2087E
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n1eciGoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgEDXBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:01:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52041 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgEDXBn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:01:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9D7D4DE85;
        Mon,  4 May 2020 19:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ARdMagfuc8j2QQIslrMba+wf2lI=; b=n1eciG
        oIJI4qulW0noAHa6Av8zVRCg7KNtDQnlEcs26NErBoqIcxPQOc+baG5bjo/DXtXz
        egmYpkjTKcTTLmKVmpDKf11SmFlFIrdzLQgdCgs+03g7MJPuRAlibE/U44v4LIcb
        C8NNcbZ9H5BQHkiczrlWo+3+tapp52AqO1xmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=II/BOn8vmI3k8f6jxk02jasz6zQB6DZK
        JZsLORNmvSkb89d1DGBfu1W38+fbWDQHkQ6DNwPMvzMJ4P+YAu+hQTvNJ3mE0UxX
        fcvh6memPD+WvH1Em/8Cw/feU1FhM4FYGMhjix8B0bBKe16z/2R6hbjqqeR+Smd/
        8Wq/hqAzpbU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF5D24DE84;
        Mon,  4 May 2020 19:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3AEB44DE83;
        Mon,  4 May 2020 19:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Kevin Daudt <me@ikke.info>,
        Wolfram Sang <wsa@kernel.org>, git@vger.kernel.org,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: tig: bug when binding to 'generic'?
References: <20200502190433.GB25220@ninjato> <20200502190729.GC1838755@alpha>
        <20200502193102.GA1160@kunai> <20200504220517.GE45250@syl.local>
Date:   Mon, 04 May 2020 16:01:40 -0700
In-Reply-To: <20200504220517.GE45250@syl.local> (Taylor Blau's message of
        "Mon, 4 May 2020 16:05:17 -0600")
Message-ID: <xmqqsggfe23v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37812330-8E5B-11EA-9780-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Thanks for clarifying. I was a little confused when I read your patch
> series, since on first blush I thought that you were submitting it to be
> applied in Git's integration branches, and not Tig's.
>
> In either case, the heads-up is appreciated, but I do not think
> necessary in general. I am not sure about the feelings of others, but I
> do not think Tig-specific bugs need to be reported on Git's mailing
> list.
>
> Of course, if there are Git bugs that affect Tig (or any other project),
> we would be interested in hearing about them.
>
> That's all to say that I think the README there should be updated.

FWIW, I do not mind seeing tig related improvements discussed here
(I am assuming tig does not have its own development list).  That is
how we've been operating with other "projects around Git", like
"imerge" and "tbdiff" (no need to look for the latter these days,
though).

Unless Jonas and others who are involved find the list traffic here
is too heavy and messages about tig will be drowned in here, I do
not see a reason to kick them out.
