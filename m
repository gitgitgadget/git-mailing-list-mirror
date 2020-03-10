Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D53C10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B5821655
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wyA2MvJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCJTqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:46:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59848 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCJTqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 15:46:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FFAB5F0B2;
        Tue, 10 Mar 2020 15:46:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pCvHmkYoZYCE
        1J3XaJlT0esI9uc=; b=wyA2MvJy2VeffIehC+gc5c5Jlc52RzhUggjEaAscAR5n
        YF0uzaUC1bkt2nfXw5/AkleV+eSebsVerWSwjQHQGwo3rRHIzf3dMHyB0oTruJrZ
        X3UEdhIDh6qc54LvPrYUalNu9kMpYpGtn+ov24Ja9zPvwCeu/4USt7rlvAk6XEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kQLKfr
        ApY3ggVU4hB69WOm53xqkul/mhal96uuGG5u5j05sOUBVQ2h9OMUjFKA+KQJrqE6
        IKp7u679NCPKQoqrdHqQTnHxnLGvqd5wRlRpub+T/2wv8FtojH56nrk6uPb+umSk
        HIdvEl9KgX3dOQQcmWQc/+LeZjXUP93f+EbvM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E8D95F0B1;
        Tue, 10 Mar 2020 15:46:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C2575F0B0;
        Tue, 10 Mar 2020 15:46:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?J=C3=B6rn?= Engel <joern@purestorage.com>
Cc:     git@vger.kernel.org
Subject: Re: new file mode 160000
References: <20200310184111.GD1443@cork>
Date:   Tue, 10 Mar 2020 12:46:06 -0700
In-Reply-To: <20200310184111.GD1443@cork> (=?utf-8?Q?=22J=C3=B6rn?= Engel"'s
 message of "Tue, 10
        Mar 2020 11:41:11 -0700")
Message-ID: <xmqqsgighu2p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C8E52382-6307-11EA-A7B0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

J=C3=B6rn Engel <joern@purestorage.com> writes:

> Something weird happened to us and I have no idea how to reproduce it.
> A developer managed to create a git commit with the following content:
>
> diff --git a/foo b/foo
> new file mode 160000
> index 000000000000..b7e7816c1266
> --- /dev/null
> +++ b/foo
> @@ -0,0 +1 @@
> +one line of content
>
> File name and content obfuscated, the rest is verbatim from the git
> commit.
>
> Now, file mode 160000 doesn't make sense to me.

These are gitlinks, that are used to implement submodules.  I cannot
tell if this is an expected behaviour and there is nothing to worry
about, or you found a corner case bug, without looking at what the
"one line of content" says, but if it says "Subproject commit "
followed by 40-hex object name, then that is a perfectly normal
behaviour.

After doing these:

	git init bar
	cd bar
	git init foo
	cd foo ;# in bar/foo
	git commit --allow-empty -m initial
	cd .. ;# back in bar
	git add foo
	git commit -m add
	git show

anybody who has a working Git would see the "diff --git" that shows 16000=
0
you showed above.


