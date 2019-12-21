Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17445C43603
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 02:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABD0206DA
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 02:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n+tysPxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLUChc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 21:37:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54020 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfLUChc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 21:37:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F005A3BFC2;
        Fri, 20 Dec 2019 21:37:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UVqmMjOAvUbRAzXHo4rMowijlt8=; b=n+tysP
        xf+aMIozIB/nMCfH+iBBVtYCGmXwkId5UyFXHDJ13iPOZ6Z6s9sEvjspaJi6q1pv
        0UrT08Xc/0HCfaZ59x6DCsRitvEQoQI8gk/NjF+c45r0L+SzcfspfGRXwyHOxHw7
        oBNCijtIg3UXg+b+59ErqQ9+DfxobGtUKwMC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cRP9B/L/pN9LJC/AlofKhvxzBd95Im43
        N2YcpPJSzL8fABrQy7kxFEgkZBIn5GB3fwIaB43UAq48HWxuKAqLZoHWCiSgPiVR
        EJRy9D1YB4H7tgFsHD0Q+9dHIZI8RPgXau3dSg6H4DiAjSV+JbBeSCRlY/wMksO6
        KNMhgcrhKV4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7C5D3BFC1;
        Fri, 20 Dec 2019 21:37:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 502A03BFC0;
        Fri, 20 Dec 2019 21:37:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] config: allow user to know scope of config options
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
        <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com>
        <9a91caa0-72c3-3a38-3eb7-55a43537762e@iee.email>
        <03b001d5b601$09b950e0$1d2bf2a0$@gmail.com>
        <xmqqtv5wb3nm.fsf@gitster-ct.c.googlers.com>
        <CAOjrSZsiW-vxHKBqbEuBS6rpQ7m22wRp0UwGVVAJE2WE3bh-XQ@mail.gmail.com>
Date:   Fri, 20 Dec 2019 18:37:27 -0800
In-Reply-To: <CAOjrSZsiW-vxHKBqbEuBS6rpQ7m22wRp0UwGVVAJE2WE3bh-XQ@mail.gmail.com>
        (Matt Rogers's message of "Fri, 20 Dec 2019 17:58:22 -0500")
Message-ID: <xmqqtv5u76ag.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4FC3842-239A-11EA-8201-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Rogers <mattr94@gmail.com> writes:

> Philip,
>
>>The commit message doesn't fully highlight that the config list will
>>often be all the users config values, so each value will be
>>disambiguated/identified as to it's origin.
>
> I don't really understand what you mean by "it's origin" here.  When
> you say origin, do you mean in the "--show-origin" sense of "file/blob/etc."
> or something else? Because scope is kind of an orthogonal concept to origin
> in that sense as you can have files with different origins but the same scope.

I do not think origin and scope are orghogonal, though.  Can the
same file appear as the source for different configuration var-value
pair in two different scopes?

It is likely that you can _guess_ with high precision that given a
pathname reported by --show-origin what scope it is in.  It on the
other hand is not so trivial given a scope to guess which exact file
a var-value pair came from, I would think.\
