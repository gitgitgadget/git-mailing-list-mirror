Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA0CC433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 16:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443743AbiEFQ1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 12:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443761AbiEFQ1P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 12:27:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0B26B0BD
        for <git@vger.kernel.org>; Fri,  6 May 2022 09:23:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEF6C1182EF;
        Fri,  6 May 2022 12:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UKpqbnwRtLpZ
        52ICDFLeLRxVkfRhIB9tWsa4gKhE58o=; b=P5SXeqbABSLDvdqh4sjN5/0Rh6/S
        BmZHIUwCidxpA1SJIwwmWOnLmWMTchCe3SXSk//21RVUdwJ7dVV97Osn2IkL6P5P
        qpnJlSI53B9A6QhaT4CrvuNoz4cUAZx4rsaUyRwjuihkXikVldOUT3WO27hnlYbV
        T9dKHflX0Q+H3wE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD8501182EE;
        Fri,  6 May 2022 12:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2459C1182EC;
        Fri,  6 May 2022 12:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc:     Christian =?utf-8?Q?Gr=C3=BCn?= <christian.gruen@gmail.com>,
        git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Halil Sen <halilsen@gmail.com>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Resizing panels in the gitk window
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
        <CAP94bnMHggYR=FOh8462tncFAxOUJ-db=yj7YPoTJRS-VwjEgw@mail.gmail.com>
        <AM0PR04MB6019000A6C54CF97447E7B6EA5C59@AM0PR04MB6019.eurprd04.prod.outlook.com>
Date:   Fri, 06 May 2022 09:23:27 -0700
In-Reply-To: <AM0PR04MB6019000A6C54CF97447E7B6EA5C59@AM0PR04MB6019.eurprd04.prod.outlook.com>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer=22's?= message of "Fri, 6 May 2022
 14:00:08 +0200
        (CEST)")
Message-ID: <xmqqzgjuocjk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DD1640BC-CD58-11EC-9FAD-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias A=C3=9Fhauer <mha1993@live.de> writes:

> It looks like the issue at [1]. It sadly seems like nobody ever
> reviewed or applied thos suggested patches, but there is some more
> off-list discussion at [2].
>
> [1] https://lore.kernel.org/git/pull.1219.git.git.1645386457.gitgitgadg=
et@gmail.com/#t
> [2] https://github.com/git/git/pull/1219#issuecomment-1113122632

Thanks for a pointer.

I do recall seeing [1] but I do not see anything happened on the
thread since then.  I didn't look at it back then primarily because
the patches were made against a wrong history (no, you do not want
to make a gitk patch against my tree nor throw a pull request at my
repository), and there was no way for me to pick it up.

As Documentation/SubmittingPatches says:

    Some parts of the system have dedicated maintainers with their own
    repositories.
    ...=20
    Patches to these parts should be based on their trees.

Having said that, gitk has been quiescent for quite a while, and I
wonder if Paul's been too busy for (or no longer interested in)
maintaining it and perhaps he can use a replacement maintainer?

