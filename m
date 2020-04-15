Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0967C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F39F20771
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p/BRt8NZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410256AbgDOTGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:06:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64222 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416826AbgDOSeT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 14:34:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D5DAD30C3;
        Wed, 15 Apr 2020 14:34:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yLu2y44UhAj1
        jCw2ol8WJ/USyUU=; b=p/BRt8NZH499KQ7NgAxzfrbnSsfBsJ72SO+WUQv8RR88
        CNHBqfh2HnWmDjd1hAGML26Fx0sOqB4W7XPtl1JsH116GKIDqzaH1q2UVmV9fZeJ
        eXt0uGz+SFaPa3zZa8bG2udQFTtWrlJLcyB1x+kmrL54JGlKBmvIjryH9CSVzo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tq9g23
        2FCeuHp+W27YHlixm4RLwbR7yXl9VEg++4xCaUV+XjpNsr3phKxo0o6esW5HyT9c
        lVgEMhdmltGQuObdUYE8T1+nCa9CoUmRZIGubimPcRyDerUw2UbHxm51j836ML/L
        veK+LkfVmRArJ+tx8naecXVdI4MAe73M/XYbc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26770D30C2;
        Wed, 15 Apr 2020 14:34:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7126AD30C1;
        Wed, 15 Apr 2020 14:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v12 3/7] receive-pack: add new proc-receive hook
References: <xmqq3697cax0.fsf@gitster.c.googlers.com>
        <20200414123257.27449-4-worldhello.net@gmail.com>
        <xmqqo8rs7ntb.fsf@gitster.c.googlers.com>
        <CANYiYbE84Jj46m0ZTfAepc7t4v4KcqU9R99WGY9b7cdTXBfw_g@mail.gmail.com>
Date:   Wed, 15 Apr 2020 11:34:12 -0700
In-Reply-To: <CANYiYbE84Jj46m0ZTfAepc7t4v4KcqU9R99WGY9b7cdTXBfw_g@mail.gmail.com>
        (Jiang Xin's message of "Wed, 15 Apr 2020 23:55:25 +0800")
Message-ID: <xmqqzhbc61jv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B506F794-7F47-11EA-8852-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Will correct it.
>
> What I am working on for reroll v13:
>
> * Add new commit "receive-pack: feed extended_status to post-receive=E2=
=80=9C
>
>    When commands are fed to the "post-receive" hook, `extended_status` =
will
>    be parsed and the real old-oid, new-oid, reference name will feed to
>    the "post-receive" hook.
>
> * Add test cases for "git push --porcelain".
>
>    I found some changes not covered by test.  So I decide add some
>    test cases for "git push --porcelain".  I will split the test cases =
into
>    multiple files inside "t5411/" like:
>
>        t5411/test-0000-normal-push.sh
>        t5411/test-0001-normal-push--porcelain.sh
>
> * Other minor fixes.

Thanks for a heads-up, but given that nobody seems to be reading
your patches and commenting on them, you might want to slow down a
bit.
