Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0DDC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBFF20782
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jm5fed/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgHKTYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:24:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64236 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTYd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 15:24:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D7A8F5050;
        Tue, 11 Aug 2020 15:24:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M/jMJdNFyKF1Pd1ftA6TfKpH28s=; b=jm5fed
        /DN8up7N/iY8wyq/q6eJcFsUsT3U0Gcbj5/jGe+x3UoGbBdr+ADQ43IHRajIT/jB
        cvqHu6ImpmTdb+86+ygYS5rGQ61SFddx0FhHolwXVyFydte5z1dPoOCxNyqUCnuL
        odWQekaWOFXAjmlaH+aFI4GAkMnfnVJUSHSY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fiYpmb/5JGY+FVXZL7HISxO2GFBpZFOR
        Wid+4QCXT1r7kkE1ulmoPdtJNICH8N51lmS6WBz5i3bRp8SXsSJD/FpsI60AvWFD
        iTO4w1E5E4EJWwRAlHsYQHI+B7NFq57LnD/6op7WTvTfgyd0yce0rt5g7/izpYIe
        NuCQ/4dZJJU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 28CADF504F;
        Tue, 11 Aug 2020 15:24:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 76919F504D;
        Tue, 11 Aug 2020 15:24:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
        <CAPig+cRtS3iMp3zLRKBOvEchrDPrCmozndbFpWtjiosk5nqGew@mail.gmail.com>
Date:   Tue, 11 Aug 2020 12:24:26 -0700
In-Reply-To: <CAPig+cRtS3iMp3zLRKBOvEchrDPrCmozndbFpWtjiosk5nqGew@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 11 Aug 2020 01:01:27 -0400")
Message-ID: <xmqq364t9ead.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46454144-DC08-11EA-B32C-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Aug 10, 2020 at 3:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * es/init-no-separate-git-dir-in-bare (2020-08-10) 1 commit
>> - init: disallow --separate-git-dir with bare repository
>>
>> "git init --separate-git-dir" can be used in an existing repository
>> with a working tree to move its .git/ directory away from the
>> working tree. Even though this re-init feature makes no sense in
>> an existing bare repository, it was not erroring out. Now it does.
>
> This description is a bit misleading since it focuses only on existing
> repositories, however, --separate-git-dir is intended for use with
> both new and existing repositories. So, perhaps the description could
> be rewritten something like this:
>
>     The purpose of "git init --separate-git-dir" is to initialize a
>     new project with the repository separate from the working tree,
>     or, in the case of an existing project, to move the repository
>     (the .git/ directory) out of the working tree. It does not make
>     sense to use --separate-git-dir with a bare repository for which
>     there is no working tree, so disallow its use with bare
>     repositories.

Thanks.
