Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79FB91F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 14:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750911AbdKKOen (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 09:34:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65059 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750818AbdKKOem (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 09:34:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4126C9CCE8;
        Sat, 11 Nov 2017 09:34:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a+JJtu/4ydvZiNLwCDMWcCeyULc=; b=fD9gi8
        nWnlOyVFLRrvxU6V15lm00g924vB/nP6yMcTy53WKqtS5shCdwj6WrEwcUtK5Gk6
        RTYd5T/huMWPfNAo8OYijPkvU/G9Q/Pn0CRWBPkDMrJNvrtoBS8H768R8wqWb5lD
        VYDx9uRa7s1D3axSZ8H45JGzkwEAKUp5y5jLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ondVDnANWOas1olxegKRDeUdVj9mPptJ
        AZAoJO4v2UhA+VLoonW+i4AdnvVooCMA/+T8X9ml5qOopQsMBKGx1K3RS4nFKfjA
        cGjqUZyjEx9qNIhYFsUJRrtSopz+13wO2uDOZapAEnmjgB7dEt6irOl+NQmHskaL
        qPUdGYMduEE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 388789CCE7;
        Sat, 11 Nov 2017 09:34:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD0F59CCE6;
        Sat, 11 Nov 2017 09:34:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git bisect" takes exactly one bad commit and one or more good?
References: <alpine.LFD.2.21.1711110612290.5087@localhost.localdomain>
        <CAP8UFD1=idL51XDzE_RKc_7z9NghTd7GHoZ-T61y0rQ8ZYXomw@mail.gmail.com>
Date:   Sat, 11 Nov 2017 23:34:32 +0900
In-Reply-To: <CAP8UFD1=idL51XDzE_RKc_7z9NghTd7GHoZ-T61y0rQ8ZYXomw@mail.gmail.com>
        (Christian Couder's message of "Sat, 11 Nov 2017 13:01:43 +0100")
Message-ID: <xmqq8tfcevev.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F6F99E4-C6ED-11E7-A631-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> "You use it by first telling it a "bad" commit that is known to
>> contain the bug, and a "good" commit that is known to be before the
>> bug was introduced."
>
> Yeah, 'and at least a "good" commit' would be better.

Make it "at least one" instead, perhaps?

I somehow thought that you technically could force bisection with 0
good commit, even though no sane person would do so.  For the
matter, in practice nobody starts with more than one good commit,
and for that reason, I doubt that the proposed change to overstress
the fact that you could give two or more "good" ones when starting
has that much practical value.  The tradeoff of losing the clarity
coming from giving only the simplest usage pattern for trying to be
technically more correct that is proposed by this change does not
sound too good, but it may be just me (who prefers white lies in the
end-user docs when it buys us more simplicity and clarity).
.

