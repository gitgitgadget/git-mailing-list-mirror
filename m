Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0123C3276F
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 22:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B9420848
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 22:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OL5ppdOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgABWsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:48:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65349 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbgABWsG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 17:48:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29E8BB5F7A;
        Thu,  2 Jan 2020 17:48:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KxpQZM5dkA1WKCB8asT9AkGDnNs=; b=OL5ppd
        OUxmKXSoDNJRIkaA+MPE7A5Hc2QAl6tclKpAlmTC3ZrPdwE9eWGhQpb1sozfANLD
        xYYq+A+unQc021gX/hlpxVLwNRaEBra55z0KVwF9N8vIdJrIdAtxNMVpDcPravFr
        bBObDbSduFW0FiE3dCubGIpfM/24ti4epowIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZLPpmwnkgxNkbhuHsZ1K4ZR2Zr42GG2V
        YA+kWp9rQjsPdE8/KdRe6dwEQ2W1tQ/e1qHTp/UzcPTH2A0XA7R25PIa0ZpowEV1
        fU+/6ahz6RiBTD5A89HYrwMXzdlXEIi7wlapT7yj96zwjDSdjQ47ZIHVQ8xRESOj
        kKKGuZyPteY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 225D7B5F79;
        Thu,  2 Jan 2020 17:48:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A666B5F77;
        Thu,  2 Jan 2020 17:48:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/1] add: use advise function to display hints
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
        <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
        <xmqqpng1eisc.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 02 Jan 2020 14:47:58 -0800
In-Reply-To: <xmqqpng1eisc.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 02 Jan 2020 11:54:11 -0800")
Message-ID: <xmqqzhf5cw69.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDF90B1A-2DB1-11EA-A84C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Use of advise() function is good for giving hints not just due to
> its yellow coloring (which by the way I find not very readable,
> perhaps because I use black ink on white paper).  One good thing in
> using the advise() API is that the messages can also be squelched
> with advice.* configuration variables.

A side note.

Right now, the advise() API is a bit awkweard to use correctly.
When introducing a new advice message, you would

 * come up with advice.frotz configuration variable

 * define and declare advice_frotz global variable that defaults to
   true

 * sprinkle calls like this:

	if (advice_frotz)
		advise(_("helpful message about frotz"));

I am wondering about two things:

 (1) if we can update the API so that the above can be reduced to
     just adding calls like:

	advise_ng("frotz", _("helpful message about frotz"));

 (2) if such a simplified advise_ng API is a good idea to begin
     with.

There are a few advantages the current API has, but it cuts both
ways.

 - Any new advice toggle MUST be registered to the
   advice.c::advice_config[] table.  This table can later be
   extended in the future to allow a list of the toggles to be
   produced at runtime.

   This can be seen as an easy mechanism to force programmers to
   keep the list up to date.  Or it can also be seen as the source
   of extra work.

 - advise() calls can be made without being guarded by any advice.*
   configuration variable.  In the overly simplified advise_ng() API
   shown above, we cannot expresss a pattern like this:

	if (advice_frotz) {
		... make expensive computation to
		... come up with values that need to be shown
		... in the advise() message
		char *result = expensive_computation(...);

		advise(_("message %s about frotz", result));
		free(result);
	}

   without adding another helper function. e.g.

	if (advise_ng_enabled("frotz")) {
		char *result = expensive_computation(...);

		/*
                 * advise_ng("frotz", _("message %s about frotz", result));
                 * is fine as well, but slightly less efficient as
                 * it would involve another call to *_enabled(), so use
		 * the unconditional form of the call
		 */
		advise_ng_raw(_("message %s about frotz", result));

		free(result);
	}

