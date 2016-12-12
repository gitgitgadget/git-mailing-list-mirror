Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BC85203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 22:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbcLLWiy (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 17:38:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54574 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751697AbcLLWix (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 17:38:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A48E6583DD;
        Mon, 12 Dec 2016 17:38:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tUI20W/QDaK6jL2ZtJYz9m1nJAs=; b=YGHhu9
        haRUbdXTzUgixVo0nwqlA4Ll8Hf5inZXTbdoP8bh/w+opdJ+gLCUAsOrIyXnCVGF
        fnWD/Xpg4CcsuEYzyJnSLe2rAGmO/9QyhHg/YlrMHqOGym/Ip77AgJI47trJyJq6
        fiHa7+ABYh3pVmtS/o2Posm2kbZVhgD/EE4VU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tn2LUqt/zuZ5Eq68ZJchR9VX+K2JGHn3
        qzbs4evdEbtwCLuQ2aXxU/pbsaf2Rpd2K9aG7aI5jBoPV6klMmqfuSdUNy3Kti0/
        eYUcle3TCl4yXgFBDMA2+WLhKXoV81z8ajDmaumXuV3yaT5KVQpFWYwliP1uzMpP
        5kqdfKtM4s0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B890583DC;
        Mon, 12 Dec 2016 17:38:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 149E1583DB;
        Mon, 12 Dec 2016 17:38:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] send-email: allow a custom hook to prevent sending email
References: <20161209203449.17940-1-sbeller@google.com>
        <20161210091333.rhssskrvzjqnzelb@sigill.intra.peff.net>
        <CAGZ79kZVjsJjreKJgnOH1T-k-zfpfqivxw1gGm_dx4GU4tte2Q@mail.gmail.com>
Date:   Mon, 12 Dec 2016 14:38:50 -0800
In-Reply-To: <CAGZ79kZVjsJjreKJgnOH1T-k-zfpfqivxw1gGm_dx4GU4tte2Q@mail.gmail.com>
        (Stefan Beller's message of "Mon, 12 Dec 2016 11:35:43 -0800")
Message-ID: <xmqqr35c7oxx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C19BB57E-C0BB-11E6-84B9-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> $ git send-email 00* --cc=list --cc=bmwill --cc=duy --to=jch
> 0000-cover-letter.patch
> ...
> (mbox) Adding cc: Stefan Beller <sbeller@google.com> from line 'From:
> Stefan Beller <sbeller@google.com>'
>
> From: Stefan Beller <sbeller@google.com>
> To: gitster@pobox.com
> Cc: git@vger.kernel.org,
> bmwill@google.com,
> pclouds@gmail.com,
> Stefan Beller <sbeller@google.com>
> Subject: [PATCHv7 0/6] submodule absorbgitdirs
> Date: Mon, 12 Dec 2016 11:04:29 -0800
> Message-Id: <20161212190435.10358-1-sbeller@google.com>
> X-Mailer: git-send-email 2.11.0.rc2.49.ge1f3b0c.dirty
>
> Send this email? ([y]es|[n]o|[q]uit|[a]ll):
>
> ---
> This is usually where I just say "a" and carry on with life.
> The hook would ideally reformat the last lines to be
> ---
>     X-Mailer: git-send-email 2.11.0.rc2.49.ge1f3b0c.dirty
>     send-email hook thinks it is a bad idea to send out this series:
>     <output of hook, e.g.
>     referencing a typo in patch 5.
>     or a mismatch of patch version numbers>
>
>     Send this email? ([y]es|[n]o|[q]uit|[a]ll):
> ---

Yup, sounds sensible (the "... thinks it is a bad idea ..." line may
probably not be needed; the hook can say why it is unhappy itself).

Thanks.

