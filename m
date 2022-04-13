Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D9DC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiDMQuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiDMQux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:50:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9911A692A9
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:48:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46B8F1742E0;
        Wed, 13 Apr 2022 12:48:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FpdvBvR3tvfa
        x92QaTQEQH7LMqwwsZj0P2EnhQSLUhY=; b=Z7QJx3al7+OSiNTyqG3Q8Kmx/JQm
        iQkP1mtparJYBiFRjtReQqHMRqUgNrs0tSV1JHlKzmsHzaDTWhnTTdT8u7gWurB/
        4r1qfxfUTbjgVKdhgPHe28C9tcC/uOql8/9PuEVuKD9qIrz9mBAzlq1MLo5qtM58
        Voc8Lmza7cYwmsM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F75B1742DF;
        Wed, 13 Apr 2022 12:48:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99C641742DD;
        Wed, 13 Apr 2022 12:48:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Julien Palard <julien@palard.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?S=C3=A9bastien?= Helleu <flashcode@flashtux.org>
Subject: Re: [PATCH] Make a colon translatable
References: <-9xEw4skKJRhRp5v7WmxeS2n5xv-xmM0HWqmoiameagKhpiDOP9y3Yxj7WFy6M-jztxqug8DKopXIr_op09VlGPkUC7iG5V6xXjKh_SxHEg=@palard.fr>
        <xmqq5ynfh101.fsf@gitster.g>
        <220412.86tuayhga7.gmgdl@evledraar.gmail.com>
        <xmqq35iicle2.fsf@gitster.g>
        <10867692-7c2b-1f89-d575-3d9b6e696a24@free.fr>
Date:   Wed, 13 Apr 2022 09:48:27 -0700
In-Reply-To: <10867692-7c2b-1f89-d575-3d9b6e696a24@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
        Avila"'s message of "Wed, 13 Apr 2022 15:11:17 +0200")
Message-ID: <xmqqa6cp9bfo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8B587310-BB49-11EC-8B75-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

> Just to chime in, I would tend to approve Julien's proposal, but with
> a reworded commit message, which should convey that the segment to=20
> translate is not a full sentence.

Thanks.  I think that is probably a sensible thing to do.  The use
of "%s:" (or "%s") is necessitated by the use of status_printf_ln()
in

    status_printf_ln(s, c, "%s", what);

and if we had status_puts() instead, we wouldn't be having this
discussion, as the line would have been

    status_puts(s, c, what);

and it is obvious that "what" (aka "label heading") wants to have
colon after it.
