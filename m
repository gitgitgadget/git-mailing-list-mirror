Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FEBC433E4
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941792075B
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 14:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YKQb60IQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgGMOot (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:44:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59931 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMOot (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 10:44:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E9735A321;
        Mon, 13 Jul 2020 10:44:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OzgMD59FFLmkXok3Ye7IgpeXGDk=; b=YKQb60
        IQmyJI3xk1WEl4sW59rvwMVsQ62hZdHVYPJ8IsNf6Nlfq4+V+oVxObFGp4hHTitj
        HIp7TbfiPK45j2E3uB2nHr4tupapNJYKHGLAgJs739k7zMM2oq4OKW4B/yKiaNms
        QFsuifSwOBLIU/4hQIaCKQXvOo6SqE+xw+rEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rb/mEV9iI1/624kjoRNge7TybAirPfnh
        LW5em0Wr9bXpOX4YE5cPxduUFlXvfIM94eEq/H0t1tShaCrHjrQriPBhTRTS+1Fb
        VhK9rVkN73jScVpjFmfffIBdIBpPV6r1pV3u/mAAhxtyM5B/nnAvH7K5cvp8KOyz
        rtSn/DgJrC8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 569495A31F;
        Mon, 13 Jul 2020 10:44:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6BA75A31E;
        Mon, 13 Jul 2020 10:44:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tobias Girstmair <tobi@isticktoit.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] gitweb: Replace <base> tag with full URLs (when using PATH_INFO)
References: <20200711203947.23520-1-tobi@isticktoit.net>
        <20200712183329.3358-1-tobi@isticktoit.net>
        <xmqqmu44phym.fsf@gitster.c.googlers.com>
        <20200712230508.GA1000433@isticktoit.net>
        <xmqqa704owwz.fsf@gitster.c.googlers.com>
        <20200713092928.GA1003518@isticktoit.net>
Date:   Mon, 13 Jul 2020 07:44:45 -0700
In-Reply-To: <20200713092928.GA1003518@isticktoit.net> (Tobias Girstmair's
        message of "Mon, 13 Jul 2020 11:29:28 +0200")
Message-ID: <xmqq1rlfpj8i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65AC8CDE-C517-11EA-89B3-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tobias Girstmair <tobi@isticktoit.net> writes:

> On Sun, Jul 12, 2020 at 09:34:36PM -0700, Junio C Hamano wrote:
>>And without this patch, the src URL needs to know where this
>>repository appears in the site's URL namespace?
>
> Exactly. Sorry if my lack of proper terminology made this confusing

No, I was confused because I did not know Gitweb showed README.html
file in the $GIT_DIR of each repository.  Any other cases that are
affected by this, or is README the only one?

