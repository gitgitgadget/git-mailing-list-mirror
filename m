Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444611F89C
	for <e@80x24.org>; Sun, 15 Jan 2017 23:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbdAOX2I (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 18:28:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52347 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751087AbdAOX2I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 18:28:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A12D761675;
        Sun, 15 Jan 2017 18:28:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HllrbRGKKN/e
        aTqNPzUhIRzgc0M=; b=hr0nPl/K3YECDrTAFkM1dmqQsMYcdN2B1eDO4tDrTGB1
        6a2FsNcDNJ5nRQ0PD+ytTihfUIcJ8Gbl9wo4u9/kdhv0iMq4vix8ZGXCkXgl9voH
        yY6GfanMjLfc/urIo+4Gxz8wadFRlC0nzXrSlgZiI2HPgl+GOVAhu2Sisrd7b3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gZMPk6
        7EB/U7l1WZQEmGWQcM93YnKaJOi8Q2AMgY3gkHC90PYdZiD+EegwqIxDYwgEViEp
        SUh+cS4JJknNLTKRe1zu+dUFAb2FHdx+fFPF8hY5UrsZDqW470VUzoQ+upqDKkE/
        MSh7Rnx+o4D31pDAzjw3dZK91WwTm3ixN0Ct8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 922C161674;
        Sun, 15 Jan 2017 18:28:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D93BF61673;
        Sun, 15 Jan 2017 18:28:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] xdiff: -W: include immediately preceding non-empty lines in context
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
        <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com>
        <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de>
        <xmqqeg06hh6z.fsf@gitster.mtv.corp.google.com>
        <c74c260d-1a4d-39f6-a644-4f90a67d6d82@oracle.com>
        <xmqqbmvaecpl.fsf@gitster.mtv.corp.google.com>
        <48bdfd94-2fd4-bd55-d78b-2877e195fb82@web.de>
        <xmqqy3ydcaia.fsf@gitster.mtv.corp.google.com>
        <0c761135-2696-4b3d-0a4f-3d90edf5da2e@oracle.com>
        <2668771d-249b-659d-3a2c-a788d7d5ebd6@web.de>
Date:   Sun, 15 Jan 2017 15:28:04 -0800
In-Reply-To: <2668771d-249b-659d-3a2c-a788d7d5ebd6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 15 Jan 2017 17:57:45 +0100")
Message-ID: <xmqqeg03dhtn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4441C1B6-DB7A-11E6-A748-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> ...  How bad would it be to only
> implement the first part (as in the patch I just sent) without adding
> new config settings or parameters?

That probably is a good place to stop ;-)
