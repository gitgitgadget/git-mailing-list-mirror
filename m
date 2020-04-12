Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE96CC2D0EC
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 21:46:28 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA40C206E5
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 21:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cr3+g006"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA40C206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgDLVq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 17:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgDLVq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 17:46:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AA5C0A88B7
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 14:46:27 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75C66D4090;
        Sun, 12 Apr 2020 17:46:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pY5fGMUNuYgEvmtoCnXuK+iAtUA=; b=Cr3+g0
        06Q2gGlMilsIOOJI76ZagG/KhW4XAiQHmpaBLtMbsyMiHISSBWedBCF/DaS1vNf5
        p5Na6RRlU8CRWsPOvIu5ukRomY5OM+a5/6egdub16lR0PMhrlFqRd7y51HjUsGAx
        VOtzp1KBmZEUD+J93e3iS0PbivONGtvkVInFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AEkILtsUCQNiT3/37BCB3LCSWQZvmli/
        C2vzxYnZKrRNUezkaKWaQ5l3DDINFFxf+1pEaBguGVVoYWk1uAJ65lhubVDi7rPG
        lRQhQB4JwRyyKuiImEUe6fkdeNnnBafGxY4nG9vA56UUpnnC0nlwbiutxXsWqpzY
        9dlvFRit0UE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E14FD408F;
        Sun, 12 Apr 2020 17:46:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 68345D408B;
        Sun, 12 Apr 2020 17:46:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v10 4/8] receive-pack: new config receive.procReceiveRefs
References: <20200407120813.25025-1-worldhello.net@gmail.com>
        <20200412133022.17590-5-worldhello.net@gmail.com>
Date:   Sun, 12 Apr 2020 14:46:20 -0700
In-Reply-To: <20200412133022.17590-5-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 12 Apr 2020 09:30:18 -0400")
Message-ID: <xmqqwo6kcr83.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CFDBF98-7D07-11EA-8714-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> +	if (strcmp(var, "receive.procreceiverefs") == 0) {
> +		char *prefix;
> +		int len;
> +
> +		if (!value)
> +			return config_error_nonbool(var);
> +		prefix = xstrdup(value);
> +		len = strlen(prefix);
> +		while (len && prefix[len - 1] == '/')
> +			prefix[--len] = '\0';
> +		string_list_insert(&proc_receive_refs, prefix);

This smells like a copy of the hidden-refs configuration parsing,
which uses string_list_append(), and its result is used for look-up
routine you split out in [3/8], so we know it is safe to leave the
string_list that holds the prefix unsorted.  Is there a reason why
we want to use _insert(), which spends extra cycles to make sure
that the string list is sorted, instead (e.g. if we were updating
the look-up routine to take advantage of the ordering of the
string-list, perhaps)?  If so, would it make sense to update the
original to match?  If not, copy more faithfully to the original and
use _append() here, too?

Thanks.
