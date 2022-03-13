Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F7AC433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 23:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiCMXRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 19:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCMXRh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 19:17:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413298F612
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 16:16:28 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83649170765;
        Sun, 13 Mar 2022 19:16:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ff9NH/awVxd3rGn5PGqh2kbfcMr9C8zTQ0hnNR
        aITHI=; b=TH3Pf5zuTXwVrxu39usnOtTr5nPFXUs3RN0i3xjQPo/FopimdOyXfO
        IauCvLz84jmRZ2hwnVajP+CfLpAz3jvgLMd8IHnyu3BRS3oOfS18BM1J3XkBO1MS
        8SiR0Qr2rDZk7mByGsSY5cn22oG34PRSLq+0Hd6NFum0nP2motlSs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C0C4170764;
        Sun, 13 Mar 2022 19:16:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0987C170761;
        Sun, 13 Mar 2022 19:16:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sean Allred <allred.sean@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>, rsbecker@nexbridge.com,
        git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
        <01cc01d83671$0acd4a20$2067de60$@nexbridge.com>
        <87zglu9c82.fsf@gmail.com>
        <01f201d836e5$89247c30$9b6d7490$@nexbridge.com>
        <87v8whap0b.fsf@gmail.com>
        <01f301d836eb$5c7a6810$156f3830$@nexbridge.com>
        <87r175amw2.fsf@gmail.com>
        <f6ecca05-b669-0e36-302f-a6113571ac12@iee.email>
        <87ilsha2b7.fsf@gmail.com>
Date:   Sun, 13 Mar 2022 23:16:24 +0000
In-Reply-To: <87ilsha2b7.fsf@gmail.com> (Sean Allred's message of "Sun, 13 Mar
        2022 17:40:47 -0500")
Message-ID: <xmqqtuc1tpdj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A5C5CB6-A323-11EC-9E07-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sean Allred <allred.sean@gmail.com> writes:

> rather than use magic comments :-) Adapting to your suggestion, this
> might look like the following:
>
>     A. U. Thor <foo@example.com> <ada.example.com> <[ approxidate ]>

You'd probably want a timerange (valid-from and valid-to), instead
of one single timestamp?

Because at least three valid forms of mailmap entries should be
understood by the current generation of mailmap readers, i.e.

    Human Readable Name <e-mail@add.re.ss>
    Right Name <right@add.re.ss> <wrong@add.re.ss>
    Right Name <right@add.re.ss> Wrong Name <wrong@add.re.ss>

the extended entry format to record the validity timerange should
be chosen to cause parsers that are prepared to take these three
kinds of lines to barf and ignore.
