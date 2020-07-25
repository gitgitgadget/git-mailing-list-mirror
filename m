Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71B1C433DF
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 15:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888C220674
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 15:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VIA0jqJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGYPAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jul 2020 11:00:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51462 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgGYPAR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jul 2020 11:00:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E61DC7AECB;
        Sat, 25 Jul 2020 11:00:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7QkTgcZTrjRlGKs6bWDTx0pHh8U=; b=VIA0jq
        JH3AglNJq+r5Z6cwD8B9jv8LfzIBXtbjIiEBHWjLHqLGpexHIa9piDPtWWELIsjV
        0DdW7xz+6xhc9zJ512unQmqWaNawtLeXc9R0FRD+ZNzwrC5io29hpTv4iDSxsJMX
        nMzUX0gHRohwhDlU0OUPacKYfr2yNbNXZSxaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FtAXL5uYJuNiYm2n2oiEmz3lBaxM5kOz
        YVStHePp/01CtuQ/+BKrHW+PyJqpJDMPj3+i5Z3LAKrEfPjjtIpcz6wQvmagnKsO
        DC59ejSg6vksMN4H+F9REbACU4zo1n63YwKP54r5tT12fRxM1a8ShMDodbxpnXyr
        zlSC7SruPXA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCD297AECA;
        Sat, 25 Jul 2020 11:00:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E7E57AEC9;
        Sat, 25 Jul 2020 11:00:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Maxime Louet <maxime@saumon.io>
Cc:     git@vger.kernel.org
Subject: Re: Verbose commit message diff not showing changes from pre-commit hook
References: <CADv3qkGq3jA8iXsjhrqfsUX=gW+KOuLyeVgDzmku1tUpsMdvtw@mail.gmail.com>
Date:   Sat, 25 Jul 2020 08:00:13 -0700
In-Reply-To: <CADv3qkGq3jA8iXsjhrqfsUX=gW+KOuLyeVgDzmku1tUpsMdvtw@mail.gmail.com>
        (Maxime Louet's message of "Sat, 25 Jul 2020 16:47:19 +0200")
Message-ID: <xmqqr1sziqrm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B78562C-CE87-11EA-BA0E-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maxime Louet <maxime@saumon.io> writes:

> Is this expected behaviour? I find it somehow confusing that the diff
> in the commit message isn't the actual commit diff.

Since the designed purpose of pre-commit hook is to examine the
contents to be committed and reject the attempt to commit if there
is something wrong found, and Git does not expect it to munge the
contents to be committed, if the hook does so, you would get an
undefined behaviour.  So anything is totally expected at that point.

Thanks.


