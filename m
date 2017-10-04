Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C8520281
	for <e@80x24.org>; Wed,  4 Oct 2017 10:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdJDKK2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 06:10:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51218 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751268AbdJDKK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 06:10:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80C6FA42E5;
        Wed,  4 Oct 2017 06:10:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FMoTNbGPZ8qK
        rb1gLp66ez4TbsU=; b=dEIyIV50wbWXSZVbh877iBThZZXb4oxOZG3xF6FZrANA
        ick++BpaU69ISmGHanMoCsXi/VQBlv+OE6BrTwxCybTjqLibv+TbuMRr2lE0j5tD
        guuv68wfk0oukGx1CXgUI1SuYJHTTD8YrEENWv+2/aC2UvqhsFjhbzIKPECiBiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qxu1XV
        RHkRZYvSxhQ8N2tRcnb9Y1Z0IlO97SrEUhg6bb6yLV12Rk6BgLQAg1HRkAyyjC6a
        AMRjFYzllN6kjxXiUWZEgu0Wq1tlqKZ3o73GP8vM3FzH7jYEWeIVUzIdAP5TkniZ
        kQeuH4vuKTguuhzZ56iLTvv/2YH9Y0R9qeZ04=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73E55A42E3;
        Wed,  4 Oct 2017 06:10:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB69BA42D2;
        Wed,  4 Oct 2017 06:10:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: Is git am supposed to decode MIME?
References: <24940e12-3f72-1ef0-0983-58523d8dec51@redhat.com>
Date:   Wed, 04 Oct 2017 19:10:13 +0900
In-Reply-To: <24940e12-3f72-1ef0-0983-58523d8dec51@redhat.com> (Florian
        Weimer's message of "Wed, 4 Oct 2017 10:44:31 +0200")
Message-ID: <xmqqzi979qbe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 37136C0C-A8EC-11E7-9964-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Weimer <fweimer@redhat.com> writes:

> The git am documentation talks about =E2=80=9Cmailboxes=E2=80=9D.  I su=
ppose these
> contain messages in Internet Mail syntax.  Is git am supposed to
> decode MIME?
>
> I'm asking because I have a message whose body is encoded as
> quoted-printable, but git am does not parse the patch contained in it.
>
> If git am is supposed to deal with this, I'll dig deeper and try to
> figure out where things go wrong.

The code to check should be in <mailinfo.c>.  As its comment says,
the code was not designed to be a full MIME parser--we just have a
code that (empirically) works in practice on messages produced when
a patch is attached to a message via popular MUAs, not written from
the MIME RFC spec.

Thanks for your interest in making the world a better place ;-)
Very much appreciated.


