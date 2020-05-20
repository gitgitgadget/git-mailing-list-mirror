Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36968C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0265620709
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kcxBvx3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgETRdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:33:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62739 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:33:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0D624456F;
        Wed, 20 May 2020 13:33:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q4UoDtB5wKycDTvC0wPlpwREoMY=; b=kcxBvx
        3iop6F11tyZnfZJD/45X76zLiJ3WUox8rDKQNZvCwZnwxNBbq9ufjSaphrVGHppN
        rOoNiwxRS7IT+093DBX1P7/sfVwts68It/vvtKA8hb2GJ3f2TC4TwtUva+N+BLxi
        TQg+LwC021b0aO/Z4maQav3JHYGQVxzjZV7bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ebjvBSYB7lGujDse2l6ZPVNWUqCr7x+C
        iqmia7GYd/LJb8ndlFV5iLLGKEBImQVfjvtaWvALKvM4nfdCljiEc0uAblWcmGKU
        EvI20h+XiYpJD9Rtv2c+qtOgcoKp7u2kIFfYOg2/yfnmz+1cPBCgE7zlAdvgmiHT
        FFiBb5rSXMM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D33C74456E;
        Wed, 20 May 2020 13:33:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5316B4456D;
        Wed, 20 May 2020 13:33:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jonathan Nieder via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v13 04/13] reftable: file format documentation
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <96fd9814a6753e87fb99c6f9d55a0728d3dba6cb.1589226388.git.gitgitgadget@gmail.com>
        <xmqqeerfzitt.fsf@gitster.c.googlers.com>
        <CAFQ2z_OazuU32Nm3geLCbu_R2u_JKTqCXX0NF35C0=9xV7Ow0g@mail.gmail.com>
        <CAFQ2z_P-cf38yR-VyvfDSgPUO_d38mgsi32UkRSPWMZKJOmjZg@mail.gmail.com>
        <CAFQ2z_NWT+Xp0zGc0OfjDd-=js5v9M9nqb3fbDFAtx_r21Jp=w@mail.gmail.com>
Date:   Wed, 20 May 2020 10:33:25 -0700
In-Reply-To: <CAFQ2z_NWT+Xp0zGc0OfjDd-=js5v9M9nqb3fbDFAtx_r21Jp=w@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 20 May 2020 19:25:18 +0200")
Message-ID: <xmqqa722wly2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0309E756-9AC0-11EA-841C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Wed, May 20, 2020 at 7:20 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
>> Jonathan Nieder said that this is used for git-stash, but I have never
>> understood why this is necessary, and would love to clarify this
>> better.
>
> The doc says this:
>
> "The `log_type = 0x0` is mostly useful for `git stash drop`, removing an
> entry from the reflog of `refs/stash` in a transaction file (below),
> without needing to rewrite larger files. Readers reading a stack of
> reflogs must treat this as a deletion."

Yup, I saw that and that is where my "I am guessing that log_type of
0x0 is *NOT* used for that purpose)." in my review comment came from.

The "git stash" itself is an abuse of the reflog mechanism, but its
"drop" subcommand is probably the worst offender.  It wants to remove
any arbitrary reflog entry in the middle of a reflog, not just topmost
ones (pop) or bottommost ones (expire).

> I should probably look at the code for git-stash to see how this plays out.
