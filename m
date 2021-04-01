Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309E5C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 20:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D8A60BBB
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 20:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhDAUty (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:49:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50843 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhDAUty (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 16:49:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7D49B1EBF;
        Thu,  1 Apr 2021 16:49:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=z7yyhRLpbwnN
        oh0G3ENh7L8Zszc=; b=m4hDcHWzQ8xB8NipsSQyLie/GaULPGg9GZ2rpgVOKE64
        hHebUuHaW7/b49uz9jZ4nl63BZtFs/Nf6p6RhgMtc59MsIUHGSQ2u16400LOlUky
        auznsyzn12phMuecB2fqj9oZd7Or0zHsBk+faoyTdghWho9XBCimrxZ29Mla3Iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SxEcsl
        86NRdua3K0lEMwAHTMJzf+XhwEqwPTYen3TzHLkkQrh3vPgQ5L38SJgcm9SGryXp
        uSohaoFfewKLgoqDdmg/wJyPCEq5yXuzV0CC9HDeRyE3cxijNserGvJtX5TtsaqE
        mnLZ6Q/ftQJX4VWJi0Cu3217J2c/Curx9XE1o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D7C0B1EBE;
        Thu,  1 Apr 2021 16:49:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E168AB1EBD;
        Thu,  1 Apr 2021 16:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 18/18] tree-entry.h API: rename tree_entry_extract()
 to tree_entry_extract_mode()
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-18.19-e961a0e8b5b-20210331T190531Z-avarab@gmail.com>
Date:   Thu, 01 Apr 2021 13:49:52 -0700
In-Reply-To: <patch-18.19-e961a0e8b5b-20210331T190531Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Mar
 2021 21:09:46
        +0200")
Message-ID: <xmqqr1jt20i7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CEEC517E-932B-11EB-9E80-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As with the recent split of the get_tree_entry() function, rename the
> tree_entry_extract() function to *_mode() in preparation for adding
> other variants of it.

I do not see a value in this approach over optionally accepting
NULL, for the same reason why splitting get_tree_entry() does not
show a value over optionally accepting NULL.  At least at this point
in the series.

There might be future changes that would benefit from having
separate functions, but I do not see how they cannot work with an
updated version of existing helper functions that optionally can
take NULL as "don't care" when they can with a different function
with one fewer parameter.
