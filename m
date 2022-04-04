Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38131C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 22:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiDDWSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 18:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356149AbiDDWQe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 18:16:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B626E4F9D0
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 14:44:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADA34118F10;
        Mon,  4 Apr 2022 17:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GSFrUdoumvHQ
        0zq4vlEBs9moNSy121QpRu7siufkO3s=; b=i4VAPKozkcMGf3VcmUaVPbouGXdp
        VX15LUgkLpO6eUOCPyeEkMT5ssdSrxyyKaWJr0GTBt0N3TOsydm+WnP5L9HtSgvm
        obk9AJxifuzIkDvy3IxQdFGakacJ+7homdIYtBgyAEVScuckn4WszxL1C2jpwfiJ
        Y9Emcc1WnE54Xoc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4B26118F0F;
        Mon,  4 Apr 2022 17:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 14E61118F0D;
        Mon,  4 Apr 2022 17:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        xing zhi jiang <a97410985new@gmail.com>, git@vger.kernel.org,
        chooglen@google.com
Subject: Re: [GSoC][PATCH v3] Add a diff driver for JavaScript languages.
References: <20220304130854.857746-1-a97410985new@gmail.com>
        <20220403132508.28196-1-a97410985new@gmail.com>
        <220404.86lewljovj.gmgdl@evledraar.gmail.com>
        <660d068f-1c8c-7057-0a92-5100791daf80@kdbg.org>
Date:   Mon, 04 Apr 2022 14:44:27 -0700
In-Reply-To: <660d068f-1c8c-7057-0a92-5100791daf80@kdbg.org> (Johannes Sixt's
        message of "Mon, 4 Apr 2022 22:29:30 +0200")
Message-ID: <xmqqee2c34n8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 67AF5AE0-B460-11EC-AA31-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 04.04.22 um 09:12 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> While we don't use helper macros for these currently there's no reason
>> we can't, I thin the above might be more readable with e.g.:
>>=20
>> 	#define JS_AA "[$_[:alpha:]][$_[:alnum:]]"
>
> Please consider including "identifier" somehow in the macro name. And
> add the trailing '*', which...
>
> ... which makes me wonder why it is not present here. If that's an
> oversight: nice catch!

Yeah, and taken together with the locale worry, we shouldn't play
cute and use :alpha: and :alnum:, but spell them out, i.e.

	#define JS_IDENT "[$_a-zA-Z][$_a-zA-Z0-9]"

probably.
