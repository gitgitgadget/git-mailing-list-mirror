Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA26E201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 03:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbdKMD4R (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 22:56:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59656 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751243AbdKMD4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 22:56:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC08598002;
        Sun, 12 Nov 2017 22:56:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XpccrWjEfO97zt6DSKhyz95TSXk=; b=GWK4A9
        kX0MhJb/vcpECUeL1RCNcZQcQHZy3XTqgXdXDdmhuHz3UEBemDQuYJpO1pkb2PL5
        +f5G3OUrFnpsM95QsQ9lnJBRUm3zQ0Roh5q6SeyGpcjTLpe4Em1YlzEN/MEAioCb
        xhKKGSIl+fK43rxrIWprf2DXITHfce4ejLFRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UT+pp2XBVRrjznSgNXtKGktV6DjH3OEs
        jziPrx5WGE29tGFoDb0Uqm5OcMlnJdP7HsvXoOIe+dXytTHJHjXiFl6dCv3yFjRi
        Rx3RDwyc2ePiG6LJXoZCauCtA1B8RC7m7ws40ZwImALDCOzqdiezwOnFAiZcxnm2
        fHqw0ZJDdrI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3E3F98001;
        Sun, 12 Nov 2017 22:56:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6912D97000;
        Sun, 12 Nov 2017 22:56:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v16 Part II 5/8] bisect--helper: `bisect_next_check` shell function in C
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
        <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
        <214cfc63-79a8-a46f-4440-5e223186f2ff@gmx.net>
Date:   Mon, 13 Nov 2017 12:56:14 +0900
In-Reply-To: <214cfc63-79a8-a46f-4440-5e223186f2ff@gmx.net> (Stephan Beyer's
        message of "Sun, 12 Nov 2017 21:03:45 +0100")
Message-ID: <xmqqineeal29.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98B5C8DE-C826-11E7-A491-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

> Hi again ;)
> ...
> In both of the above "error" calls, you should drop the final "\n"
> because "error" does that already.
>
> On the other hand, you have dropped the "\n"s of the orginal error
> messages. So it should probably be
>
>  _("You need to give me at least one %s and %s revision.\n"
>    "You can use \"git bisect %s\" and \"git bisect %s\" for that.")
>
> and
>
>  _("You need to start by \"git bisect start\".\n"
>    "You then need to give me at least one %s and %s revision.\n"
>    "You can use \"git bisect %s\" and "\"git bisect %s\" for that.")
>
> Stephan

Thanks for reviews (not just this patch, but for reviews on other
patches, too).
