Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654EFC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 16:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiF3Qux (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiF3Quv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 12:50:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D485D338B1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 09:50:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7092B1A7650;
        Thu, 30 Jun 2022 12:50:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UAgIZB7AGGUBvWoOCKlV4lS1HjlE7CZItzFXIC
        AujIc=; b=tJizo1bqFQGAq8xRvgXMsy6Fx9+8e/agMTUPLx30/FfDQo5YY/tgFu
        nTlATGDcf6QIUMDZhY+kadPTeXY/954SXB8qEDjH/1mGLcZaFfNWECb9V3cqduYO
        LtMLDxdPhejec0IR6H6mUDkfFJO9itMVDAZMae6VBXqwudiwNmFXs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68D901A764F;
        Thu, 30 Jun 2022 12:50:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F39ED1A764E;
        Thu, 30 Jun 2022 12:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 2/8] branch: consider refs under 'update-refs'
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <2bc647b6fcd6032a1e97e67739ced31117bfbfce.1656422759.git.gitgitgadget@gmail.com>
        <xmqqpmisikex.fsf@gitster.g>
        <9d188e11-7bb4-cae7-b38a-f9f38c8c2fe1@github.com>
        <4907af96-cb62-1d7f-d9ea-18d0e646f4ea@gmail.com>
Date:   Thu, 30 Jun 2022 09:50:45 -0700
In-Reply-To: <4907af96-cb62-1d7f-d9ea-18d0e646f4ea@gmail.com> (Phillip Wood's
        message of "Thu, 30 Jun 2022 10:47:01 +0100")
Message-ID: <xmqqmtduf63e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA09B370-F894-11EC-8617-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> The commit is protected by HEAD's reflog for a while because we update
> HEAD after each pick but it is not permanently safe.

Ah, I forgot about that one.  Thanks for pointing it out.  It does
sound like HEAD's reflog makes it safe enough.

