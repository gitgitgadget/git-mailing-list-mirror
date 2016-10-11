Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 695A41F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 17:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbcJKRo1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 13:44:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59024 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932254AbcJKRms (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 13:42:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23D4741407;
        Tue, 11 Oct 2016 13:42:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0fq/eOJntnNjbFaxTMh5NdXiaMg=; b=ttbzI+
        cWaZr1J8W+veBz9LbcfEjJEZopndy4waPw4fTqILlBH1uv2Q+iSrObRos1OC4ubj
        bbkDTfrHmCup2uPuoo9n92Y3KYx25hxE9pQ3XatfM1/swIWK9UYj6QiFh31/vp90
        sf3nJU+EtQjydDwoP7jcRwZ6X+ugW7mJi44Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hWCeUvRiNQLgn5CAudQS0ZVtIvlrm0eo
        G3QLsOyTpWR5z5iB+JOYF4o2iZvkU3/WDlr+YIfSSmtqslGKMizQu1wwSjaTPj8/
        jzLAPXntRhZ7ZHuS0h8eO72C3VF50KxHmnMyK1eDD1JwZSRyBEyktmHVURrqTTGG
        z38cQlp7bI8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C74641405;
        Tue, 11 Oct 2016 13:42:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7CD7341401;
        Tue, 11 Oct 2016 13:42:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        pclouds@gmail.com
Subject: Re: [PATCH 11/28] attr: (re)introduce git_check_attr() and struct git_attr_check
References: <20161011002115.23312-1-sbeller@google.com>
        <20161011002115.23312-12-sbeller@google.com>
        <20161011165936.GA9085@google.com>
Date:   Tue, 11 Oct 2016 10:42:19 -0700
In-Reply-To: <20161011165936.GA9085@google.com> (Brandon Williams's message of
        "Tue, 11 Oct 2016 09:59:36 -0700")
Message-ID: <xmqqinsyaikk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FFC8C92-8FDA-11E6-8FFB-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 10/10, Stefan Beller wrote:
>> From: Junio C Hamano <gitster@pobox.com>
>> 
>> A common pattern to check N attributes for many paths is to
>> 
>>  (1) prepare an array A of N git_attr_check_elem items;
>>  (2) call git_attr() to intern the N attribute names and fill A;
>
> Does the word 'intern' here mean internalize?  It took me a few reads to
> stop picturing college students running around an office :)

The verb comes from Lisp world where you "intern" a string to make a
symbol.

