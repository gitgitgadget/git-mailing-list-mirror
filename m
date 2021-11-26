Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6EBC433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 07:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359267AbhKZHed (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 02:34:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52688 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbhKZHcd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 02:32:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B300105385;
        Fri, 26 Nov 2021 02:29:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X9SHEJuUZI9OLah/ESHWHX3C7vLOTzDna4+Afw
        Fge0A=; b=j/M3FeaGS0b4Sdf9GvGB+fI2jl8HaevwlI1bSkGymINkVc+em8evHa
        Qu9tP90J5sWQbvofYch6JP1fc5FbQIrcwOywhRy7DOX3eIR4ullpIghSic2VH0es
        LBvbRo4//TOzS5afctMawMC2eLCrgqKa8pStm2cTAznFixx4RzvnU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91F46105384;
        Fri, 26 Nov 2021 02:29:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03897105383;
        Fri, 26 Nov 2021 02:29:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] Makefile: error out invoking strip target
References: <20211125122607.26602-1-bagasdotme@gmail.com>
Date:   Thu, 25 Nov 2021 23:29:18 -0800
In-Reply-To: <20211125122607.26602-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Thu, 25 Nov 2021 19:26:08 +0700")
Message-ID: <xmqqilwf8je9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91CEBABE-4E8A-11EC-B9AF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Now that $INSTALL_STRIP variable can be defined since 3231f41009 (make:
> add INSTALL_STRIP option variable, 2021-09-05), it is redundant to have
> 'strip' target when $INSTALL_STRIP does the job. Error out when invoking
> the target so that users are forced to define the variable instead.

It is not exactly redundant for folks who like to build and use in
place without installing.

What is the reason why we might want to eventually remove the
"strip" target, making "make strip" an error?  I do not quite see
much downsides for having just a target with a simple one-liner
recipe.

