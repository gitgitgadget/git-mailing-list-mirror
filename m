Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79AAD211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 00:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeLFA6o (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 19:58:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55444 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLFA6o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 19:58:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A9A1121069;
        Wed,  5 Dec 2018 19:58:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S0SgiGH8xuMy
        sJW6h9Iim8aloXw=; b=M3PUDsg70/3z6oEoTloeMkoszPGKvfJ+RPYFJGLhFzJi
        3P0p1cY+x47gVdNzIvhCLlsT6fvNizsdmt2JXV9bJvWqCAKABo7aAAXcQGzNaTme
        ztVpC/WWQcgbOQVPtJWEtmOGIujEFwdYgX8Or8FzZ0FpO+u/Fa1UpiBYpHw+riM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FGphCv
        /f3EimlelE87M1/aXQuw+bVbcgm03UfCkCmTeiiqH6IbK3c3LGII+tYNHNJj/66j
        Th7BlEQLpq9zi1l54LRIWiQUTf5uX/HA7ZgAi1CqYrCzGk+Rg+VM/l0T3gXxLVET
        o9s9WOSWcNQMTrscGEfBrILXGkDLyPQdgYT+0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13D4A121068;
        Wed,  5 Dec 2018 19:58:42 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85D1D121067;
        Wed,  5 Dec 2018 19:58:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Frank =?utf-8?Q?Sch=C3=A4fer?= <fschaefer.oss@googlemail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the ending of the removed line is CR+LF
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
        <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
        <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
        <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
        <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
        <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org>
        <xmqqzhtwzghr.fsf@gitster-ct.c.googlers.com>
        <f06b734a-fc8e-221a-c983-f2ab9daba17f@kdbg.org>
        <xmqqva4jv2kc.fsf@gitster-ct.c.googlers.com>
        <3e24a770-47fc-50e4-d757-1e4a28dcd019@kdbg.org>
        <xmqqk1kwr5tp.fsf@gitster-ct.c.googlers.com>
        <7a4ecc75-2dc4-041b-3d12-46cddae0a27f@googlemail.com>
        <xmqqmupnh0lo.fsf@gitster-ct.c.googlers.com>
        <7796f0ac-d3db-68f9-89fa-9262d2187f57@googlemail.com>
Date:   Thu, 06 Dec 2018 09:58:40 +0900
In-Reply-To: <7796f0ac-d3db-68f9-89fa-9262d2187f57@googlemail.com> ("Frank
        =?utf-8?Q?Sch=C3=A4fer=22's?= message of "Wed, 5 Dec 2018 20:43:03 +0100")
Message-ID: <xmqq1s6vbhdr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 12C717C0-F8F2-11E8-B9D3-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Frank Sch=C3=A4fer <fschaefer.oss@googlemail.com> writes:

> Just to be sure that I'm not missing anything here:
> What's your definition of "LF in repository, CRLF in working tree" in
> terms of config parameters ?

:::Documentation/config/core.txt:::

core.autocrlf::
	Setting this variable to "true" is the same as setting
	the `text` attribute to "auto" on all files and core.eol to "crlf".
	Set to true if you want to have `CRLF` line endings in your
	working directory and the repository has LF line endings.
	This variable can be set to 'input',
	in which case no output conversion is performed.
