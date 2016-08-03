Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE121F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 17:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbcHCRtx (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 13:49:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752016AbcHCRtv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 13:49:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85C7F2E45E;
	Wed,  3 Aug 2016 13:35:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ukuSo54H1ZmOVqXtyYUhRGwdR+M=; b=PGcHUS
	V544+pNVuaWjaC98dDOEKU+jJ9XBipKYcBOucVkTSpvCVM6n8wBCISOUhGK0XaTG
	z8RFqh9IOh1SmOPYPFiDVJiWjKvDToZAOERxwCuPBgrDxMT3ZhWL9izTApq4iVwF
	AyHkwWo2GwdSDzpar9fWY2IgENu9sY/fuoiSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y9DC2g3GNCZAmCJR0lQv71wKJbqBeHab
	n1vsGyKq4/CrRafq9PVKRyjL/QWab9YvtQ/2Nu1To0HlUIzXGKunmkuPuIoRcvFh
	8R39BMMXdZgaAtBxE4MrpbOvMOXZKG/aIwlaidafRMyQmNWC2j+wGbcK9B0dTBSf
	uUlRloElPHc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E5F52E45D;
	Wed,  3 Aug 2016 13:35:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F07642E45C;
	Wed,  3 Aug 2016 13:35:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Santiago Torres <santiago@nyu.edu>
Cc:	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git <git@vger.kernel.org>
Subject: Re: [OT] USENIX paper on Git
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
	<20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
	<alpine.DEB.2.20.1608031721430.107993@virtualbox>
	<20160803152510.pgcd2edareqdxnmh@LykOS.localdomain>
	<CAGZ79kZPPvi2jpFgu1MZ97gZm=QqBBiZ-XcXUJphm3UzNRP-FQ@mail.gmail.com>
	<20160803172242.5jrd4saq7sga6iql@LykOS.localdomain>
Date:	Wed, 03 Aug 2016 10:35:54 -0700
In-Reply-To: <20160803172242.5jrd4saq7sga6iql@LykOS.localdomain> (Santiago
	Torres's message of "Wed, 3 Aug 2016 13:22:43 -0400")
Message-ID: <xmqqy44d92md.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBB101A0-59A0-11E6-8701-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

>> Submodules actually track commits, not tags or branches.
>> 
>> This is confusing for some users, e.g. the user intended to track
>> a library at version 1.1, but it tracks 1234abcd instead (which is what
>> 1.1 points at).
>
> I'm assuming that git submodule update does update where the ref points
> to, does it not?

I think you may configure the command to do so, instead of the
default "detach at the commit recorded in the superproject".

But then your tree immediately will be marked by "git status" as
"modified" at such a submodule, meaning "what you have in the
working tree is different from what the commit in the superproject
wants you to have", I would think.

