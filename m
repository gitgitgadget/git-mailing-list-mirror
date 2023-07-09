Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE35EB64DA
	for <git@archiver.kernel.org>; Sun,  9 Jul 2023 01:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjGIBi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 21:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjGIBiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 21:38:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BA7E45
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 18:38:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27B373041D;
        Sat,  8 Jul 2023 21:38:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=sd5v3oPx5vKNsKnakqyxjvQGuEo3Ch6MUMUfegaOijI=; b=Eu2V
        m4igSxlpqytFEnx/2JKD4RUUb5JeHV4NVv1UcrteLNorFa+YCvvMmnIYsxc4IMp/
        QrKwAL3bzBVxoX97539I32X51pz/xFX5J+07BJ4SItBludLKjuJja5RYmwXZ1+YR
        Jrhqn/EH+XAXgbly6bm1Z2VOm6racwMQ7+vtG0w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FBE03041C;
        Sat,  8 Jul 2023 21:38:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A9A963041B;
        Sat,  8 Jul 2023 21:38:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
        <20230706040111.81110-1-alexhenrie24@gmail.com>
        <20230706040111.81110-2-alexhenrie24@gmail.com>
        <xmqqttugbxds.fsf@gitster.g> <xmqqo7kobwpj.fsf@gitster.g>
        <CAMMLpeS9_P=XXMoOdTAM3jZbaxfLEJNwYArS6p9pMXisT3TRtw@mail.gmail.com>
        <xmqq8rbra9ti.fsf@gitster.g>
        <CAMMLpeQ2P+qQxo17dEdWhMHcmAfTiBoEifp2wUjWVrP+oGSzxQ@mail.gmail.com>
Date:   Sat, 08 Jul 2023 18:38:19 -0700
Message-ID: <xmqqbkgl6f04.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4931CB76-1DF9-11EE-928C-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> I agree, showing this message in the middle of `git commit` is not
> ideal. However, that's a separate issue that can be fixed later; it's
> not part of the problem I'm trying to solve in this series.

That is debatable.  Even "by the way you can pull and reconcile
early before you have fully finished working on the topic and are
ready to push back" is irrelevant during `git commit`.  "Reconciling
the differences is not the only way to deal with divergence; you may
decide to simply discard what they have with push --force" is even
less relevant at that time.  So it seems to be very much an integral
part of the problem you are tackling, at least to me.
