Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9039A208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 20:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbdHOUx6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 16:53:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57895 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751129AbdHOUx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 16:53:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A2E4AAB5B;
        Tue, 15 Aug 2017 16:53:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jv9EIOYAvpAcBRDbMrSDevGiceM=; b=MqBaeC
        PnZAJK++PDXUlgb2NiDa1qP+9QIkZyMy9PARmonGPdN12edabOpOjC2BRLZELgJX
        1tU6s+oSfhpupokh42a8cK722SRvcFxW95Nk6uTuoqlzXROYIE/2G4j8qYO2E72T
        HsgGJg0xX5CYFpeUz7P208/tpW0CLO+pUCtgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p9K8PG75heajYTkpayyzfPUouqQ/Ojdg
        wvFD+WmNcdtGJ2Xwqm1xMnnzHDhP6hjgvYa63ehIlsNZQGjXOADtMcJHvI3YnpjL
        XVBEfkkmQMcAG4eBWVOQDXW2IXjay7dTgYGxw8Mvg+Bf6u6bzLWg56aD3wtHcyfV
        nUtcegOUjuc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FE63AAB59;
        Tue, 15 Aug 2017 16:53:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92225AAB58;
        Tue, 15 Aug 2017 16:53:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] diff: define block by number of non-space chars
References: <cover.1502491372.git.jonathantanmy@google.com>
        <cover.1502754962.git.jonathantanmy@google.com>
        <41a7ff674072559415f98b81ffde798d94aed2fc.1502754962.git.jonathantanmy@google.com>
        <xmqqy3qkppxt.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kahg7q2CSg7OiaLNvHKzCUgTtq2-n=Km0N+eGRuNZ=yJw@mail.gmail.com>
Date:   Tue, 15 Aug 2017 13:53:54 -0700
In-Reply-To: <CAGZ79kahg7q2CSg7OiaLNvHKzCUgTtq2-n=Km0N+eGRuNZ=yJw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 15 Aug 2017 13:06:49 -0700")
Message-ID: <xmqqtw18pn6l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA3ADE8C-81FB-11E7-B2CE-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The function blame_entry_score is documented to approach
> this exact problem that we are trying to solve here, so I agree
> we should have a common heuristic.

While I do not think it is necessary to do such a refactoring within
the scope of this series, we should at least leave a NEEDSWORK
in-code comment next to the new heuristics code to remind those who
revisit the code of this possible small project idea, I would think.
