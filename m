Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F9A20562
	for <e@80x24.org>; Sun, 29 Oct 2017 00:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbdJ2AOc (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 20:14:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61955 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751209AbdJ2AOb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 20:14:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC252AC207;
        Sat, 28 Oct 2017 20:14:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+1lllziZRL9BcUiK1jiW36IT+Ps=; b=ZXtQOy
        9i3c6nmNCqgBiRScbYV5aurDrxsUjMEnRXKu39/9S0bYHBYnqz9iNg8vbt+Uwu2b
        p1J6l+q9cQaJ/lbVwyzCcOw2b3x26JBLlnkQGfx7hBZKP4wwXiHgOBCpCCKEIUre
        0NYnBcWaLvU0DMSrzuPZI05k++MhAy/MDLGyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vw/yxUmLZeeCDRM4IQPg/uI+d5Fu0kI/
        IuNK2F35quJbWRHekK2TLYOsE5sIV/z4L4OFBg1Pqt5lCfSgoIEJQCUVOUXkWnf6
        1UrPOiiPoULFv4LwQrpm346pvfU1/1iYA1wJoyQg+yXZdM9P2/tx9Ywn7E24b+qQ
        A12Wdo/RW8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A32D8AC206;
        Sat, 28 Oct 2017 20:14:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C218AC205;
        Sat, 28 Oct 2017 20:14:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>, Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/6] t0021/rot13-filter: add packet_initialize()
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
        <20171019123030.17338-5-chriscool@tuxfamily.org>
        <xmqqvaj8dlyz.fsf@gitster.mtv.corp.google.com>
        <xmqqr2tpcn6g.fsf@gitster.mtv.corp.google.com>
        <09393EDB-19A3-4244-A88F-68EDA8470898@gmail.com>
Date:   Sun, 29 Oct 2017 09:14:29 +0900
In-Reply-To: <09393EDB-19A3-4244-A88F-68EDA8470898@gmail.com> (Lars
        Schneider's message of "Sat, 28 Oct 2017 16:59:00 +0200")
Message-ID: <xmqqfua2byje.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21EE53EA-BC3E-11E7-B206-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> BTW: I am using this little snippet to apply patches from the mailing:
>
>     PATCH=$(curl -L --silent https://public-inbox.org/git/xmqqr2tpcn6g.fsf@gitster.mtv.corp.google.com/raw); 
>     ((printf '%s' "$PATCH" | git am -3) || (git am --abort; printf '%s' "$PATCH" | git apply)) && 
>     echo && echo "Patch successfully applied"
>
> Does this look sensible to you?

Sensible?  I have no answer.  I wouldn't trust printf well enough to
stuff large value in a shell variable and feeding it myself in the
first place, but I would not be surprised if you did

	VAR=$(command) && printf '%s' "$VAR" >output

and ended up with a file with an incomplete line at the end.

