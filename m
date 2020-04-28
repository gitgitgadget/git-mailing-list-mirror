Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAF8C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F4B20B1F
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 17:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y/BbO7nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgD1RHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:07:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59452 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgD1RHr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 13:07:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2DBF64040;
        Tue, 28 Apr 2020 13:07:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u4ZnQsdvuJpgcyc3cdiml20tJes=; b=Y/BbO7
        nuBQHoejTTVcBm5DxWvKhIPi3onvGIgGJE2TMmT3GOGI+tEKzE/Y2gVjDvOmCzZ+
        Xmf8ZwKMNwl3Ar39PcyWojj/IrNxHtWt7EnXBO2l0XqGTzQtuC2GMTmug+GjXkor
        bP2OtsSd6SaTUUrVgrGm9f2E0J0SrHLV0tu/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m6tbuLqlHNIrX0dox8NTWzdYJaoWmXLD
        ir2MfozyIrwdX5Q7ewAOFPVkjlvNaVdpb6esK1AmfXLgYGXcA2bu5Sugw2oNueHG
        ZQMEYfkpoIJwGPcsF6nbmDqH/QRGZwi5+Z/SbxGJC0n/GVeNleSVgCEmEDMAPLgA
        Sgxdq4GS/l0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8A126403F;
        Tue, 28 Apr 2020 13:07:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 507C96403E;
        Tue, 28 Apr 2020 13:07:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, peff@peff.net
Subject: Re: [DRAFT] What's cooking in git.git
References: <CAL3xRKdrATjL0+xUH9p8XtgXKd7tD+wCW-+TASJ8saVxBnJVZQ@mail.gmail.com>
Date:   Tue, 28 Apr 2020 10:07:44 -0700
In-Reply-To: <CAL3xRKdrATjL0+xUH9p8XtgXKd7tD+wCW-+TASJ8saVxBnJVZQ@mail.gmail.com>
        (Son Luong Ngoc's message of "Tue, 28 Apr 2020 07:10:25 +0200")
Message-ID: <xmqqblnb4jz3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C76F1C06-8972-11EA-8FEC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Son Luong Ngoc <sluongng@gmail.com> writes:

>> * jt/v2-fetch-nego-fix (2020-04-27) 3 commits
>>  - fetch-pack: in protocol v2, reset in_vain upon ACK
>>  - fetch-pack: in protocol v2, in_vain only after ACK
>>  - fetch-pack: return enum from process_acks()
>
> Would it be ok to just proceed with the fix and skip the revert?
> Or do we intend to revert 'jn/demote-proto2-from-default' after the
> fix has landed into 'master'?

The demote patch hasn't even hit 'master'.  

My preference is to merge the demotion down to 'master' and 'maint'
while merging down this fix to 'next' and to 'master'.

And immediately revert the demotion on 'master', which will make the
tip of 'master' with v2 as the default, with "this" fix.

That way, those who want to help us polish the code further for the
next release would use v2 as default with the proposed fix for this
breakage and can hunt for other breakages in v2, while those on the
maintenance track (and v2.26.3 JNeider wants to see happen soon)
would revert to the original protocol as default.





