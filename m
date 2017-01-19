Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63AD320A17
	for <e@80x24.org>; Thu, 19 Jan 2017 20:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbdASU5H (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 15:57:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53079 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750874AbdASU5G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 15:57:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BF4D5F3A4;
        Thu, 19 Jan 2017 15:57:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9tm3CVAWPJDVb66rGrORxH7hH3A=; b=IAs0BL
        J3SeX2XxvAdCCpK6j7tDx3UrDaHF3A/Csg8Y8cjRU3h3mYcx07Ks437V5WSZSHPP
        Mtkp5E30wRkP/h61hZIJtBCnc0YTdR9zL6MjQEpONgdkr4JeW/SyEOhbDhS5Q4KW
        hbcx+R6bznhVAXTwGkNtRCJiMATcwruSQkSMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xqKnC++9RJ40zjiBCiR0dtWUieW1pHGS
        bEIlMQtMXXOb/G+aqaCaIGtRsFoADbBpoIbnAJrVBnL8nTuQji7rH0wcVuEJN/kL
        D7gL+7fICP4mx/3ME3BCYtWYclDSmaSZ4yMbhWKtZOaRec3daa41MClVoYHXpJ9G
        /FPTW4OOVX0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 429BB5F3A3;
        Thu, 19 Jan 2017 15:57:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91B9E5F3A2;
        Thu, 19 Jan 2017 15:57:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [RESEND PATCHv2] contrib: remove git-convert-objects
References: <20161228180205.29213-1-sbeller@google.com>
        <20170119202941.6575-1-sbeller@google.com>
Date:   Thu, 19 Jan 2017 12:57:03 -0800
In-Reply-To: <20170119202941.6575-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 19 Jan 2017 12:29:41 -0800")
Message-ID: <xmqqo9z2zs2o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4F5772C-DE89-11E6-9DE9-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> git-convert-objects, originally named git-convert-cache was used in
> early 2005 to convert to a new repository format, e.g. adding an author
> date.

I think this description is not wrong per-se but misses the much
more important point.  In the very early days of Git, the objects
were named after SHA-1 of deflated loose object representation,
which meant that tweak in zlib or change of compression level would
give the same object different names X-<.  This program was to
convert an ancient history with these objects and rewrite them to
match the new object naming scheme where the name comes from a hash
of the inflated representation.

> By now the need for conversion of the very early repositories is less
> relevant, we no longer need to keep it in contrib; remove it.

I am not sure if removal of it matters, and I suspect that we saw no
reaction from anybody because nobody thought it deserves the
brain-cycle to decide whether to remove it.  I dunno.

