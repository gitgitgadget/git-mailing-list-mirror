Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F59EC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 21:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiEIVtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 17:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiEIVtT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 17:49:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8785C245C56
        for <git@vger.kernel.org>; Mon,  9 May 2022 14:45:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60C72135744;
        Mon,  9 May 2022 17:45:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=weB3DnrXaUiu
        621VhyGL0I6G2r9EFPVucqh9vk+lRdw=; b=brDIqCTGf5TdJP5UB1xxvhSLXYW8
        /jCQM6lN4m3CuDy6DQRJ/NoJMBE8BKBUnutWra2iMLPe7P/vt6ReZfiGTNMa3G+S
        DXgTHAL6gOF8xo0IMBk8putoOFKBzhdSUuCumYtsrEzWiA5+H5IiJByrjpa9a8Nv
        HCM4P9xfXYKokvs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55569135742;
        Mon,  9 May 2022 17:45:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA60A135741;
        Mon,  9 May 2022 17:45:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/3] safe.directory: document and check that it's
 ignored in the environment
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
        <20220427170649.4949-1-szeder.dev@gmail.com>
        <20220427170649.4949-4-szeder.dev@gmail.com>
        <xmqqlevql0lj.fsf@gitster.g> <xmqqee1il09v.fsf@gitster.g>
        <20220509213915.GA2043@szeder.dev>
Date:   Mon, 09 May 2022 14:45:21 -0700
In-Reply-To: <20220509213915.GA2043@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Mon, 9 May 2022 23:39:15 +0200")
Message-ID: <xmqqlevabcsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5418FA80-CFE1-11EC-8D8E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> repositoy could trivially safe-list itself.  However, it's unclear (to
> me) why 'git -c safe.directory=3D...' is ignored: 8959555cee
> (setup_git_directory(): add an owner check for the top-level
> directory, 2022-03-02) only states that it's ignored, but doesn't
> justify why.  Now, let's suppose that there was a compelling reason to

Correct.  I do not think it is a restriction with any sensible
justification, just that it happened to be implemented that way.

IOW, I am saying that GIT_SAFE_DIRECTORIES may be a lot nicer user
interface than fixing the "we ignore 'git -c safe.directory'?"  bug.
