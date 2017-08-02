Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D099E20899
	for <e@80x24.org>; Wed,  2 Aug 2017 16:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdHBQf2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 12:35:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60122 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751162AbdHBQf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 12:35:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 772079B531;
        Wed,  2 Aug 2017 12:35:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b6RRWS+kxv92crjP/v7QZ0ARQIw=; b=xWOScO
        p7iwgfruxiqRyrcQivg/NZSLZj9rUTRNwl1j+DGZlkXG1MqrJKycHR35F2U1y1Ag
        k8OHjEM7HgZaRYboygrmBlr/0RbQdjGcUr8NQy6oJNc2huV/NQmCDbTcLX1FzPmg
        /+Lhs91K7gn3zU8cak2iuo3uvjaCRG91v3KvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XZo1R2IPPnTAc10DSoFey/GUFmWK6NM6
        E0BxtDnhGrI2b2x8z/LQXtbQAW5GD5QmodECE1smyDHR8BgIj5BUNIqtFXqTmnQY
        u60x0y3HRCo6qo7WHIIjUZcwdWHyCJWD/rlxKoB54bUo0tSvzlycMd1ruYdYr6lL
        CElZ2w53RWk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DC369B52F;
        Wed,  2 Aug 2017 12:35:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 833FB9B52D;
        Wed,  2 Aug 2017 12:35:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     git@vger.kernel.org
Subject: Re: git send-email -v n fails
References: <20170802134635.GA19311@aepfle.de>
Date:   Wed, 02 Aug 2017 09:35:18 -0700
In-Reply-To: <20170802134635.GA19311@aepfle.de> (Olaf Hering's message of
        "Wed, 2 Aug 2017 15:46:35 +0200")
Message-ID: <xmqqy3r2c4hl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9291590E-77A0-11E7-B7B4-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> I think send-email should understand all options of format-patch.

I actually think it was a mistake to allow send-email drive
format-patch ;-).

> At least for '-v n' this fails, one has to type '--reroll-count n' as a
> workaround with git version 2.13.3:

I wonder if "-v2" would work here, though.  It seems that the hack
send-email uses to "understand" format-patch options (i.e. the
subroutine is_format_patch_arg) is not prepared to take an option
with parameter.

