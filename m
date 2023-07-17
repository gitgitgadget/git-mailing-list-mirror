Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA34FEB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 21:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjGQVJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 17:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGQVJY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 17:09:24 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BD995
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 14:09:23 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C0861A9780;
        Mon, 17 Jul 2023 17:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VfgGr2y7mpkZ
        uYgImtAZ8bRj7oea+2h2fAlzKJVMWeY=; b=AJZvYC/xvf4QNCd2zQHeEtl6Z7d3
        BPE5NLyUbWtM4uTgTBNX7Rxb6ilp93G3OjcFk3W2iI5ncuMitW1X01V5G8fp/TQw
        acGCYJxpo16VAhpEh0x1ma8/5VmGQszhE1/IV0JWzUEsEtxbERFKoImoA+1qCFVI
        7mksFSbCGz+VMn0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 636FE1A977F;
        Mon, 17 Jul 2023 17:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0FA61A977E;
        Mon, 17 Jul 2023 17:09:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Adam_=5C=22Sinus=5C=22_Skawi=C5=84ski?= 
        <adam.skawinski@sinpi.net>
Cc:     git@vger.kernel.org
Subject: Re: receive.denyCurrentBranch=updateInstead won't update the repo
References: <CAGE71k3Ccm3hBrfNgXFqO9Zk0V9FkoskgD1ViJ6eSakxdBuqQQ@mail.gmail.com>
Date:   Mon, 17 Jul 2023 14:09:20 -0700
In-Reply-To: <CAGE71k3Ccm3hBrfNgXFqO9Zk0V9FkoskgD1ViJ6eSakxdBuqQQ@mail.gmail.com>
        ("Adam \"Sinus\" =?utf-8?Q?Skawi=C5=84ski=22's?= message of "Mon, 17 Jul
 2023 22:26:26
        +0200")
Message-ID: <xmqqfs5mgs8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3360293E-24E6-11EE-9505-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Adam \"Sinus\" Skawi=C5=84ski"  <adam.skawinski@sinpi.net> writes:

> needed. I made it output some lines and exit with code 1, so it should
> abort after producing the output - and yet the pushes come through.

Did the output come back to your client side?  "git push -v" should
show.

If there is no need to update (i.e. after a successful push, you try
to push the same thing), the hook would not even run, so you may need
to rewind the "server" side while experimenting.
