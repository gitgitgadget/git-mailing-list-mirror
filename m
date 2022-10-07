Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBF3C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 21:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJGVNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 17:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJGVNR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 17:13:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2851A27B2F
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 14:13:17 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE3941B7D47;
        Fri,  7 Oct 2022 17:13:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Qlw8KJJWI7l6
        r2YHpuVMUfV3Id32zD/CmAo/vIajx3I=; b=qmaaPy5unKr6MmrnddvW8Vdry+O5
        u9pdDgypbCEr3l53aqXM4r9+utpom20mBL3V+G9ZX4ihNCEknS14/AI6bEplxOAe
        u3RFrGaPM5DdZHLE9xm/7KxOaqS7E78fAoyhOJ3nVbCOt3RIhER+xpQ32Ln8jfD3
        iPcgse425amW0vE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A69C51B7D46;
        Fri,  7 Oct 2022 17:13:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C21711B7D45;
        Fri,  7 Oct 2022 17:13:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        =?utf-8?Q?=C3=86var_Arnfj?= =?utf-8?Q?=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: sudmodule.<name>.recurse ignored
References: <20221007060713-mutt-send-email-mst@kernel.org>
        <221007.86wn9bq458.gmgdl@evledraar.gmail.com>
        <20221007085334-mutt-send-email-mst@kernel.org>
        <kl6lpmf3wdk6.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 07 Oct 2022 14:13:12 -0700
In-Reply-To: <kl6lpmf3wdk6.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 07 Oct 2022 14:04:25 -0700")
Message-ID: <xmqq35bze3rr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DAC1B3F0-4684-11ED-82A9-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> - where to get the submodule from during a fetch/clone, e.g.
>   `submodule.<name>.url`, `submodule.<name>.branch`
> - information needed for submodules to work correctly, e.g.
>   `submodule.<name>.path`
> - default config that gets populated in .git/config via `git submodule
>   init`, e.g. `submodule.<name>.update`,
>   `submodule.<name>.fetchRecurseSubmodules`
>
> With respect to config, the general stance is that .gitmodules is meant
> to provide defaults for .git/config and _not_ to be read directly (see
> =C3=86var's answer).

I think that is a sensible way to think about this.

It is more like "suggestion made by the upstream", to be taken after
examining it, just like you should type "make" after examining the
Makefile.  At least enough to trust its contents ;-)

> There are some very limited cases where config is read
> directly from .gitmodules, but that approach is very frowned upon and
> it's unlikely that we'll add more of them in the future.

Yup, we should be careful and see if we can get rid of existing
uses.

Thanks.
