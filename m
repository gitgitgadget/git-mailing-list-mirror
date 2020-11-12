Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6044C2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 19:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED2720825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 19:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gb4n0K8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgKLT6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 14:58:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55921 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgKLT6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 14:58:24 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EBF7FA714;
        Thu, 12 Nov 2020 14:58:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=6Xw6Xbf/WFk9PsapGQzbEaU1/vA=; b=Gb4n0K8d2W2XPSrpWQJX
        F4TutoE/4CWrwfcMBJaouZ5xZp7qT28mmx4pe+zG4CJX7fXK5ZGc+rfLx/Ve/jH3
        4IRJa77h8VfnPYezsoW2hdF2e0obZOAntQgApjf/tDZoje5IFB+o9tEv3zJW+BFH
        0jv/gqN2QYh53xJdzAIka2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=pJWE0iDWqMuIBjFBKOrA+88qGWIkXojqAeVAHZOl6HZgZB
        b+clMQDk+bUV3yU3I3LEroDhfxT3qdyxpUi5Hjq2CSlfQJaClOscPX0YJHESP8JG
        Hk00nTxyCmuNW0zvRAba2NVfT1K1yx3Bum8K8f+z5ma1vTM2hmkwj9ZoK2d8M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46086FA713;
        Thu, 12 Nov 2020 14:58:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 75304FA712;
        Thu, 12 Nov 2020 14:58:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 12/26] completion: bash: refactor __gitcomp
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
        <20201110212136.870769-13-felipe.contreras@gmail.com>
Date:   Thu, 12 Nov 2020 11:58:16 -0800
Message-ID: <xmqqo8k2cppj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68A82672-2521-11EB-878F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We have to chunks of code doing exactly the same. There's no need for
> that.

You mean "2 chunks"?

>
> No functional changes.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
