Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71F1E1FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 21:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbcIKVuN (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 17:50:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54500 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750912AbcIKVuM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 17:50:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 979A83E362;
        Sun, 11 Sep 2016 17:50:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bjSoM/cIucvi
        nZUMbQVNYvOYzLM=; b=vVuw0Sd3zoBkPieK/fLRC97AY8qrxS6uX/j2jd1mB7rw
        ZNe5bkEs6RoQC2b9ABDqg7HdJNX61D/OWuAQzmFIczjK9YRdt2+u6ZVFognCWrc5
        7rZfEqItRE232ZAOcqn2+aotnTRfX4dhh/MmKFz7ervS8EHQs4kHUdZvwS0RVvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Tx2aRj
        G2n5eUI/ye4SJe5xin2U2QqzH+CPSTetBIL0bQTAOiBsVorqT/loogR7URRoXv8Z
        FuuQ5ZWggQvEa3Fq+LxpBx+dsac+pHZ5ywJ7K/T38hHpoph0ezmIvnnHOyQzN0Zr
        m5w1EwVs7bi2qFh30q5xM643sNlxSPX1KZ8cw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FEFE3E361;
        Sun, 11 Sep 2016 17:50:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 174CE3E360;
        Sun, 11 Sep 2016 17:50:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Christian Neukirchen <chneukirchen@gmail.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git commit -p with file arguments
References: <87zinmhx68.fsf@juno.home.vuxu.org>
        <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
        <xmqq8tv1c5nb.fsf@gitster.mtv.corp.google.com>
        <23de5ffe-eaf8-2d62-2202-f1bf6087d44b@gmail.com>
        <87inu4bxt7.fsf@juno.home.vuxu.org>
        <b9d63103-011a-9486-2fa1-dcf3a82cbe64@gmail.com>
Date:   Sun, 11 Sep 2016 14:50:09 -0700
In-Reply-To: <b9d63103-011a-9486-2fa1-dcf3a82cbe64@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Sat, 10 Sep 2016 11:52:01
 +0200")
Message-ID: <xmqqvay26r8u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B68EAADC-7869-11E6-B179-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> I wonder, if git-commit is to acquire such feature, what would be the
> best interface.  "git commit :0:./<path>"?  "git commit -o -p <path>"
> (that is, "git commit --only --patch <pathspec>")?

Just do "git reset && git commit -p <pathspec>", I would say.
Anything more elaborate would just confuse the end users.

