Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09D31FC43
	for <e@80x24.org>; Sun, 12 Mar 2017 07:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755702AbdCLHGk (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 03:06:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57540 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754375AbdCLHGi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 03:06:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BBDD7DFC5;
        Sun, 12 Mar 2017 03:06:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+M9P+TtnjDAzZywpllK/0d/gmow=; b=UHrWSJ
        Y/maQ5q7wx7h+pmIX+Qx1qkZ/nyYjCswjYZRH1hLtYAgvPoODPCEYqLwafxHbpL7
        e8WZ41ZIWenSC2E7m+dDLCJhf7/rbh12zk7tJW98E453r7MOYANaUQrcmJvCL4Pw
        rGEOnBR+gex22+Sx/qtnUemy+bECc94T+HWgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w7YJDcqWTk9xIfbnS+ATl1QYHTCxNY5t
        SKE9L3phssoEyFW3p1PX7NMDL4372vL1Y7er0W4BremIr1aLSJ7xFW6RSGkptbCh
        ehnE1qw+SVkmxubnjOF7hHFhc81TCYfKNVQw2JDFUR4Ojdgrzk4kedaoH/9nyCOT
        UlZUUOdTliw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8435B7DFC4;
        Sun, 12 Mar 2017 03:06:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E33FE7DFC3;
        Sun, 12 Mar 2017 03:06:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        novalis@novalis.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 07/17] connect_work_tree_and_git_dir: safely create leading directories
References: <20170306205919.9713-1-sbeller@google.com>
        <20170309221543.15897-1-sbeller@google.com>
        <20170309221543.15897-8-sbeller@google.com>
        <20170309232940.GC52558@google.com>
Date:   Sat, 11 Mar 2017 23:06:22 -0800
In-Reply-To: <20170309232940.GC52558@google.com> (Brandon Williams's message
        of "Thu, 9 Mar 2017 15:29:40 -0800")
Message-ID: <xmqqshmjug7l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 671FA128-06F2-11E7-A21C-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> +	git_dir = real_pathdup(git_dir_);
>> +	work_tree = real_pathdup(work_tree_);
>
> Just a note that this is a spot that'll be affected by the change to
> real_pathdup() which adds a 'die_on_error' parameter to correct bad
> behaviour I introduced.

Thanks for a reminder.  I _think_ I resolved this correctly when I
replaced the previous one with this round to re-queue on 'pu'.
