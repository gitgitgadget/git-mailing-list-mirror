Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40E451F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934239AbcJERlc (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:41:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61223 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933544AbcJERl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:41:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3E5944936;
        Wed,  5 Oct 2016 13:41:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HZqTrVKy2+zmefYwX+9D4FRlriM=; b=htszx7
        N5BMIay8Ooz3fuk6xVueMDsNKWiVL+zruTQ1MJmeqa5e5dYgHCz5PaeZ4KYxrE7k
        8JtaJoiNjtcOIKrmO91ptAsoiP2Of/EvK9CwFFfzUf+/6sjF8jzj1O+Iv0Esq42N
        /O63n7rPsUEEsZE4JlMc+4PA/d5UTqc4n8sCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E+H0gKudxPpZYyG7VBHx3i9Ev6/cr0Oa
        STNVCCDPZpiXglUbCj9TJD/z5LuBF0GV+5S0K9vBQt2t2JleF13TAneg39kCdg+7
        6net1rg1SndpJbatSDerqHgVDDQnzsa+jZ8e2H2f9CW8QQnlj7NAlCMBYRVeL7r4
        3LhbpNElJt8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBB2044935;
        Wed,  5 Oct 2016 13:41:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2607244934;
        Wed,  5 Oct 2016 13:41:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 04/25] sequencer: future-proof remove_sequencer_state()
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <d6b92cd7aa56ceb515c50467a0e6030401e2e1bc.1473590966.git.johannes.schindelin@gmx.de>
        <xmqqinu028tx.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610051342490.35196@virtualbox>
Date:   Wed, 05 Oct 2016 10:41:24 -0700
In-Reply-To: <alpine.DEB.2.20.1610051342490.35196@virtualbox> (Johannes
        Schindelin's message of "Wed, 5 Oct 2016 13:46:03 +0200 (CEST)")
Message-ID: <xmqqr37upubf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F083FB68-8B22-11E6-9494-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I briefly considered consolidating them and using .git/rebase-merge/ as
> state directory also for cherry-pick/revert, but that would cause
> problems: I am surely not the only user who cherry-picks commits manually
> while running interactive rebases.

Good thinking.
