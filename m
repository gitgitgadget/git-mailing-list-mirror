Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A8C2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 22:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbcJYWy4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 18:54:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61062 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752987AbcJYWyz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 18:54:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71B6F481F1;
        Tue, 25 Oct 2016 18:54:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wQm9SlLR3+5KkgfcpPS0OsJW2Go=; b=WmA/69
        aPAX1AssHy0XSrDFxgtmyoqBAObm3uGi0fxEltx+4FFwGf1jhfEqmiQpEXiyEZ4c
        OBUhqACWf8xwf47squGuPw2EHilqK4KhAsq9P90l90K612N3HoP8EvWImQU/g/3z
        5/iPXqDZVMBnPDiGciRdQd9NzQiOI0fpeVlc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AX78pkwP/8CKq+fjEYOEXm6XlH3zaMQ9
        Z9aipS9y9hBDzyg8SN3Vwcc+kD8jGxFh51lnykcKhZNjSik18CRZa2U/G754YZWP
        ewEmO5D9TJHK4rq8IA1sGNeAK9dx95X0UfjA4o8arQYvEgjiskoaNMk34uuWoswp
        5+TpbBgGbn0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66C0A481EF;
        Tue, 25 Oct 2016 18:54:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C3898481EE;
        Tue, 25 Oct 2016 18:54:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/3] read-cache: make sure file handles are not inherited by child processes
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
        <20161025181621.4201-1-gitster@pobox.com>
        <20161025181621.4201-4-gitster@pobox.com>
        <20161025213318.GB8683@starla>
Date:   Tue, 25 Oct 2016 15:54:51 -0700
In-Reply-To: <20161025213318.GB8683@starla> (Eric Wong's message of "Tue, 25
        Oct 2016 21:33:18 +0000")
Message-ID: <xmqqlgxcm43o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B024A42-9B06-11E6-AB4E-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> But I have a _slight_ preference towards Dscho's version in
> <alpine.DEB.2.20.1610251230150.3264@virtualbox> in case we
> decide to start using another O_* flag in here.

Interesting.  The reason why I have a slight preferene to separate
the fixed part and the toggle-able part is exactly because I want
the code to be prepared in case we decide to start using other O_*
flags in the future.

I guess different people have different tastes, as usual ;-)
