Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5836120964
	for <e@80x24.org>; Sun,  2 Apr 2017 03:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbdDBDpr (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 23:45:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65297 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750792AbdDBDpq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 23:45:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F9EA701CD;
        Sat,  1 Apr 2017 23:45:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=b+g2ETpLxuE+
        NYnFAcEPitJKph4=; b=xbTKj6apuvbmIWfXRaFuY3UHyEckB7PJPDOLsFqttXHQ
        GY2exmaBEanPnvEZzjmRvuqhvVxNr8mCGwaMZk1pGQFvw/HJK//9XMBdHxOr2aof
        X0W07/FE5PPMIU11gQCG0cFiiIzrKDjE0GDVqAtAz+7vQH1G2sCjGIPBV8Q3gz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JakrJY
        TmLW1N4NZVS6apuCyRpHJYP3FRlA1jzbfHTRqltLYm6KHOAfIMKstAca0Fddm+ID
        99yPMsk/+DW/H0lqJuw16gs6cVv/xIKdfMxiEhZr+xrQ9T3HS6BEWbY4qiWM3cJ3
        lEtl2uiAVWT1/ciTY4+7brNhNFwnpd5dh9PcY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8439B701CC;
        Sat,  1 Apr 2017 23:45:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB23F701CB;
        Sat,  1 Apr 2017 23:45:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>
Subject: Re: Very promising results with libpcre2
References: <CACBZZX6FcHcY7cYs6s_pv=E43cHNmzyUY5wrcuhPWWmUixCL+g@mail.gmail.com>
        <xmqqtw69vz9t.fsf@gitster.mtv.corp.google.com>
        <CACBZZX416M3YFDAACGAWCjJ4Xt0g78zpFF+iusMCarKb7SSfVw@mail.gmail.com>
        <xmqqbmsgugt4.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5mEMq2ZRKKc-5HxhauNRemPpN4P+wzmihO1YhZq_vJPg@mail.gmail.com>
Date:   Sat, 01 Apr 2017 20:45:43 -0700
In-Reply-To: <CACBZZX5mEMq2ZRKKc-5HxhauNRemPpN4P+wzmihO1YhZq_vJPg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 1 Apr
 2017 21:11:03
        +0200")
Message-ID: <xmqq8tnjtqu0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D9FA003E-1756-11E7-9916-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I am very tempted though to support them in parallel, if only for ease
> of performance testing and to be able to roll out support for
> grep.patternType=3Dperl meaning pcre1 for now, but add a
> grep.patternType=3Dpcre2 for testing (and make grep.patternType=3Dpcre1
> work, with grep.patternType=3Dpcre being synonymous with
> grep.patternType=3Dperl, i.e. whatever the default is).

Perhaps.  As long as the code doesn't get too ugly, I think we would
survive ;-)

