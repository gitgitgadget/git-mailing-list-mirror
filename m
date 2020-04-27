Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79B4C81857
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 22:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5664B2074F
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 22:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Aw0BrMYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgD0WQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:16:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59889 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgD0WQo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 18:16:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB4675D4F7;
        Mon, 27 Apr 2020 18:16:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6mjph8PORfGMvVG9el/hCv/kPzU=; b=Aw0BrM
        YKE0xthaD8tF1ln4/pyHy09HvAGtZS02Adzp2UgjET8QAk82iAAty8fT15jWKBHc
        DRytNbiSCNSLZFI2Vb8uK+J6Dt1eVJT0q5L6lQIg0+6mlEdMMbq+DwW4Kq6l2034
        aA+x2QPIDE3nPSSCmzYlEFmyT0l23ukxut7fA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EPold65N9YmOMCg69UzDUToe0oFaw1ir
        4rhQqUqRbC2EJSBQPsyJaKgBaGiBBJWX7crRQ2eBkOba7QbHN8M92wIO100/ruy2
        bOxODWTgASwHz7zIv+o+lIx+Qeb8SyK8+tmU9jtKgrhAPIJ7HLvWAxfkXVecZEcr
        enIXIjWgBwc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3CE05D4F5;
        Mon, 27 Apr 2020 18:16:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BAFD5D4F4;
        Mon, 27 Apr 2020 18:16:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/2] fetch-pack: in protocol v2, in_vain only after ACK
References: <20200426002802.GD877@gmail.com>
        <20200427172736.61159-1-jonathantanmy@google.com>
Date:   Mon, 27 Apr 2020 15:16:42 -0700
In-Reply-To: <20200427172736.61159-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 27 Apr 2020 10:27:36 -0700")
Message-ID: <xmqq8sig7ewl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6676050-88D4-11EA-83E9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> not about this patch: can these return values from process_acks be made
>> into an enum with named enumerators?  That would make what's happening
>> in the call site more obvious.
>
> That sounds reasonable to me.
>
>> > +	cp trace /tmp/x &&
>> 
>> Leftover debugging line?
>
> Ah, yes. If Junio can't or won't do it locally then I'll send out
> another set with this changed.

Well, if I am expecting the "named enumerators" patch anyway, I'd
wait the fix to be done at the source ;-)
