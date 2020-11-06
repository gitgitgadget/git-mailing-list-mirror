Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B439FC55178
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58532206F4
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tgdvf4B+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgKFRx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:53:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64389 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgKFRx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 12:53:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FFEE85985;
        Fri,  6 Nov 2020 12:53:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MB08M5CFTxpz/2Ib8j8KMnmSzME=; b=tgdvf4
        B+IuRXKy4K4iPXxj+L9k83RqZrNOIUaCVYapLrwmg3B0bx08tHCaPm5OT5aF5la8
        7keb49A9TK+GOGWhMyJEimYdqzYg0zsEFdgwhPQJUBulz+T1b1wKqd7CVZjIpfNZ
        nSwmNf9i93qJxFzvPW3MtVI4X8pFhEEHZpkYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qZP5FsvFRB6qrR24UGQxbA66lBtxcZdO
        eTPK1vnDH5ulYhEPImkEdsDFuBBbcXj1//+hk6oYWD980WeiUSxw40mF4IkMOjFw
        5TrdDeOeKg8XQRrEUIIQL4VXctKLBZCa3X1lWNVlHJvCCYHz37D+J3KFaipNwslf
        YCt5mQF4lQA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9925885982;
        Fri,  6 Nov 2020 12:53:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2424885981;
        Fri,  6 Nov 2020 12:53:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 7/8] Makefile: don't delete dist tarballs directly by name
References: <48fdd198-93ad-7282-27e6-9a0c6de93067@ramsayjones.plus.com>
        <xmqqr1p7h38t.fsf@gitster.c.googlers.com>
        <xmqqeel7h0aj.fsf@gitster.c.googlers.com>
        <0cbe821b-092d-a5f9-e2ab-13a3c01e9a02@ramsayjones.plus.com>
        <xmqqa6vvgs9y.fsf@gitster.c.googlers.com>
        <ec59a5d8-26fc-988e-4458-fd2cd421f9d5@ramsayjones.plus.com>
Date:   Fri, 06 Nov 2020 09:53:53 -0800
In-Reply-To: <ec59a5d8-26fc-988e-4458-fd2cd421f9d5@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 6 Nov 2020 02:39:10 +0000")
Message-ID: <xmqqsg9mfk26.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0917E4F8-2059-11EB-BA5C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> "make distclean" can still depend on GIT-VERSION-FILE and your daily
>> cleaning needs can use "make clean" that cleans only the files that
>> can be cleaned without knowing what GIT_VERSION is, no?  That way,
>> we do not have to use dist-tars file at all, no?
>
> Hmm, so rather than dropping the last two patches, you are suggesting
> replacing this patch with a patch that moves:
>
> 	$(RM) $(GIT_TARNAME).tar.gz
> 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
>
> to the 'distclean' target?

Yup.  FWIW, I consider it a feature that

    for m in maint-2.{27,28,29}
    do
	git checkout "$m" &&
        make distclean &&
	make dist || break
    do

gives me three distribution tarballs of from-scratch builds.  It
matters when I need to push out releases from multiple maintenance
tracks at the same time (think: coordinated security releases).

I could of course move them away before running distclean in each
step, but then I'd be following a different workflow from what I
normally use when cutting a single release---I would rather avoid
deviating from the routine when I have to be absolutely careful
(again, think: coordinated security releases).

> Well, that would address your concerns, but I was hoping to fix the
> 'your current branch has to be the same as the one you created the
> tarballs on' for the '(dist)clean' target to actually remove those
> files issue.

So we on this part have directly opposing wish, unfortunately.
