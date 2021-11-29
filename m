Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527FBC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379414AbhK2Shv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:37:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57538 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379303AbhK2Sfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:35:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D9C015F704;
        Mon, 29 Nov 2021 13:32:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fuuAGr9b2sMH
        ZYsFmPtq5Lt+yoA2yWW++RKw79YvDBc=; b=MAOYCFic157QUWVFclnPm7mMtZuz
        v5BH7wdRRcAadULL4/VqvUzLQ2tD/KDX9TB/4x7AgTUWYEce/kJCdQg53WNnn9ua
        Fwb1W9YMYwzmDaT/aL9EYzoOxUIrNmVAaWowdrNpGH3JU9IFSdJvcKgmavTdUxSV
        Dn2AProNGrVua4E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 16A0415F703;
        Mon, 29 Nov 2021 13:32:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3172F15F700;
        Mon, 29 Nov 2021 13:32:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] test-lib.sh: set GIT_TRACE2_EVENT_NESTING
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
        <3d1bbc91aa3a465ecec2de130456b9ccc08f3032.1638193666.git.gitgitgadget@gmail.com>
        <211129.86fsrff36j.gmgdl@evledraar.gmail.com>
Date:   Mon, 29 Nov 2021 10:32:24 -0800
In-Reply-To: <211129.86fsrff36j.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 29 Nov 2021 15:12:20 +0100")
Message-ID: <xmqqfsre3j9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B375C396-5142-11EC-8B53-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>  trace2.eventNesting::
> -	Integer.  Specifies desired depth of nested regions in the
> +	Integer or "false" boolean.  Specifies desired depth of nested region=
s in the
>  	event output.  Regions deeper than this value will be
>  	omitted.  May be overridden by the `GIT_TRACE2_EVENT_NESTING`
>  	environment variable.  Defaults to 2.
> ++
> +Set this to a "false" value (see linkgit:git-config[1] for accepted
> +values, i.e. "false", "off" etc.) to remove the limitation on nesting
> +entirely.

If the value of 5 set to .eventNesting allows up to 5 levels of
nesting, I would imagine some readers expect that "false" or "off"
would forbid nesting of events altogether.  For "false" to work
well, the variable needs renaming to trace2.limitEventNesting, or
something like that.


