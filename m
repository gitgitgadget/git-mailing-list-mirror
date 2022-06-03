Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEF8C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348359AbiFCS4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344214AbiFCS4S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:56:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FC9289B8
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:56:17 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64537186D40;
        Fri,  3 Jun 2022 14:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=om2amQIE6EmajzNyaw776mengksJsT6vcxfPgn
        s5fEw=; b=TblCjWdyScCiBlA5cJvIDokf9ZU3u72zRtNc4quH313cmbPq94KwGF
        EjA0zZiMHeruep9yWI0OCxEKRXDQegdXeLIIFDJW8q4OX4hDhtZPoe7x6+h87YGl
        uZnvs2MYPLgYNy88kgyTX4ctkm3niNOTT/RfxxtZMiq23KQ8FePao=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CFD7186D3F;
        Fri,  3 Jun 2022 14:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9ED74186D3E;
        Fri,  3 Jun 2022 14:56:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Molton <git-ian@mnementh.co.uk>
Cc:     stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
Subject: Re: AW: git log on bare repository fails if the default branch is
 not called master
References: <a1830e79-9503-3fd9-8c50-a2856206e219@mnementh.co.uk>
        <48bcd99afbca4c73b938c3ed4e104c64@atlas-elektronik.com>
        <9df6c37e-4c43-7697-0562-c49d4fa5b38f@mnementh.co.uk>
Date:   Fri, 03 Jun 2022 11:56:12 -0700
In-Reply-To: <9df6c37e-4c43-7697-0562-c49d4fa5b38f@mnementh.co.uk> (Ian
        Molton's message of "Fri, 3 Jun 2022 19:06:28 +0100")
Message-ID: <xmqqmtetfuer.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D71E75A4-E36E-11EC-B879-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Molton <git-ian@mnementh.co.uk> writes:

> Why does a bare repo even have a HEAD file? (genuinely curious). It
> seems like it'd be best to create it when it's first pushed to? then
> it'd match whatever is used in the pushing repo...

There indeed are things that have no reason to exist in a bare
repository, but HEAD is not among them.

It should have HEAD to indicate what the owner of the repository
considers the primary branch to follow the project hosted there.
Anybody cloning from that bare repository will learn the name of
what HEAD points at and that branch gets checked out when "clone"
finishes its job.

