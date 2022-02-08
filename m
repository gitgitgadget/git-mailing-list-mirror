Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D8DC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 18:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350651AbiBHSJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 13:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiBHSJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 13:09:56 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDA1C061578
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 10:09:56 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DEE5616B12F;
        Tue,  8 Feb 2022 13:09:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EC3svJ/vK7cwBC8K0AeDFomz+cQrF48yGtobMh
        l/o/o=; b=nV8cwt9m6f8GOkuivPsvX6Oa+Q/E0yv94KyrwY8y3dWTG1a1GkGX5e
        /ltSO3OeOHpEWCHj9gj7UNlORxRBEMrJ39mPKW6XfPNMQ3O8hlEYd3ikVC3PGX0z
        5MGL34i0rnDb9D7MrKcCaVAQHPXyKmElt5YqyEWsMAyHP0W/PiYmw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CAE4516B12E;
        Tue,  8 Feb 2022 13:09:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2721216B129;
        Tue,  8 Feb 2022 13:09:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     phillip.wood123@gmail.com, git@vger.kernel.org, johncai86@gmail.com
Subject: Re: [PATCH v2 2/2] cat-file: add --batch-command mode
References: <83ab0f7d-96d5-8730-edd7-693f10b09002@gmail.com>
        <20220208175651.155629-1-jonathantanmy@google.com>
Date:   Tue, 08 Feb 2022 10:09:51 -0800
In-Reply-To: <20220208175651.155629-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 8 Feb 2022 09:56:51 -0800")
Message-ID: <xmqq5yppdyc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50507E64-890A-11EC-9946-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> There is overlap, yes. I'm not sure of the best way to resolve it,
> though. John mentions a substantial reduction ("roughly half") of Git
> processes [1], and if they foresee needing to access things other than
> object info and contents, it might be better to start with something
> more extensible, like my proposal for a specific batch command.

I agree that it would be ideal to have just one way generic and
extensible enough.  I do not know if there are much difference in
that area between the two approaches, though.  The RFC I saw did
look more complex and rigidly specified with framing and such, but
that is only the syntax part---in the way in which interaction
between two processes happen, I didn't quite see fundamental
differences.  I'd expect it wouldn't be too much trouble to add new
commands to code written using either approach (although I haven't
seen yours yet ;-).

Thanks.
