Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0310FC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 18:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B239561968
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 18:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhC2Svm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:51:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54264 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhC2SvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 14:51:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D342A12FC7D;
        Mon, 29 Mar 2021 14:51:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nplD3vman5Mn
        ipOgZvpdZBzhJ7Q=; b=nlxYKPprIWRGEVG7n4iYYMmS5WCQDv2QztDw4ghhH3ie
        3hMy2fDlx4EmnaWmTD8Fn9V8kmQcTYsfTfQgUEQdkWOx4s7OugWHErp4SpzwXwca
        B5J5B4OJhtNw1XF13qB+oSztwP92prU6Je2qZrz/7Rp2JxzjbXa0UoZPEroG7Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M6uJwt
        aEBNTm2VzxCVX3ejqJ3qTwBc/7wzAfmOpS2bqz4mbaAhBhE270GmVZGAskmV/TNN
        RFf5sbnNRfqDd4HgZJg4x49PA+Hc+oN3nKhzx+/lsFqJZgGDCX0U3JqML5lLDDII
        PIgGNneq3hVM2J4E7CyOQI7PKujdz/ByPeZz4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C473312FC7C;
        Mon, 29 Mar 2021 14:51:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C01212FC7B;
        Mon, 29 Mar 2021 14:51:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/5] Makefile: add the ".DELETE_ON_ERROR" flag
References: <20210307132001.7485-1-avarab@gmail.com>
        <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <patch-4.6-2ff6359c273-20210329T161723Z-avarab@gmail.com>
Date:   Mon, 29 Mar 2021 11:51:04 -0700
In-Reply-To: <patch-4.6-2ff6359c273-20210329T161723Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Mar
 2021 18:20:11 +0200")
Message-ID: <xmqqblb1kd47.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B7BC135E-90BF-11EB-9713-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Use the GNU make ".DELETE_ON_ERROR" flag.

Yay!

With versions of $(MAKE) where this feature is available, it is far
more preferrable to use it than "generate into temporary and rename
to the final" dance.

We do require / depend on GNU but I do not offhand know if this is
available in all versions that still matter.  If we know we can
assume the presence of this feature the I do not mind if we jump
directly to this step without those "do the same for $(CC)" steps
(which I deem crazy) before it.


