Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13957CD13DE
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 22:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjIRWnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 18:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIRWnP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 18:43:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19AA91
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 15:43:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 034D81BAB20;
        Mon, 18 Sep 2023 18:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=n20Acp4toLPqpO9ahwBIB9LctFS9a4Xa3Tmj2U
        n+fHk=; b=Z/Az1diK05F6T4T4UGn97OGSVEiBEPA3xdnI8T55DTRQJ4UMVopW/j
        gs4L4fcpmy4GN0i25P5+vFXMqOdLv6qIkTl+jjQkMrvO/XioFD+NCaLWoPtPpB0c
        1K5BBL8eiBLBP7ltTWx7vDssDZyJs0CoIbrWCb0pp6e1z52SxCy+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA8CF1BAB1F;
        Mon, 18 Sep 2023 18:43:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1B431BAB1D;
        Mon, 18 Sep 2023 18:43:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 0/3] Simple reftable backend
In-Reply-To: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 18 Sep 2023 17:59:35
        +0000")
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 15:43:04 -0700
Message-ID: <xmqqfs3bje6f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB800C3E-5674-11EE-8C44-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I think the first part ("refs: push lock management into packed backend") is
> a good improvement overall, and could be landed separately without much
> tweaking.

It looked quite nice to remove more knowledge specific to the
.git/packed-refs backend from the files backend, and instead have
the files backend rely more on the backend-provided methods to make
it work together with whatever backend happens to be in use.  There
were a few minor things I found puzzling, but other than that, the
two patches looked mostly sensible.
