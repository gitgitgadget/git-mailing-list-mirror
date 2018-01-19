Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EAC91F404
	for <e@80x24.org>; Fri, 19 Jan 2018 20:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932440AbeASUae (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 15:30:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64324 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932393AbeASUac (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 15:30:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88D3EBE7CB;
        Fri, 19 Jan 2018 15:30:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CXJRBCtqUwoYk0TOqXC0Tur5omw=; b=WysIh2
        CLkovLIoW32kLp4Hln4F82Nw+vuaBQrDNkMyxYZ0BJC1Gjzu0EoF9pK+Tp95+isM
        gYYYgq1hzN+BSD154VfRX+VmGBGniqnzILBbUL640bghGzjEAvBcrVqAcpZ3Ey3F
        OVRpkARm5CZGEKrHr//qjo0XySUBaERuAJbvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mD0GnFJIEiCet0xmxabFDieNtYuitp5T
        XF8ezTH8xVSyf2Z4BL1EUUxpOkfw8MMMQjptey2bA/R1WbjRUrGdw8yM+ULfNOq+
        dFObEfIjpCEwlbtgpNsBLpqBiXc7iyBgo9IvNlVM02cpCZdUou2W57tQ4UZrbRDW
        7lHjgA+7FIE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80B00BE7CA;
        Fri, 19 Jan 2018 15:30:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 04133BE7C9;
        Fri, 19 Jan 2018 15:30:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jacob.keller@gmail.com
Subject: Re: [PATCH 9/8] [DO NOT APPLY, but squash?] git-rebase--interactive: clarify arguments
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <20180118183618.39853-1-sbeller@google.com>
        <20180118183618.39853-2-sbeller@google.com>
        <nycvar.QRO.7.76.6.1801182233480.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Fri, 19 Jan 2018 12:30:29 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1801182233480.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Thu, 18 Jan 2018 22:36:51 +0100
        (STD)")
Message-ID: <xmqqinbxpp5m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97E333E0-FD57-11E7-9EC1-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Good idea! I would rather do it as an introductory patch (that only
> converts the existing list).
>
> As to `merge`: it is a bit more complicated ;-)
>
> 	m, merge <original-merge-commit> ( <label> | "<label>..." ) [<oneline>]
> 		create a merge commit using the original merge commit's
> 		message (or the oneline, if "-" is given). Use a quoted
> 		list of commits to be merged for octopus merges.

Is it just the message that is being reused?  

Aren't the trees of the original commit and its parents participate
in creating the tree of the recreated merge?  One way to preserve an
originally evil merge is to notice how it was made by taking the
difference between the result of mechanical merge of original merge
parents and the original merge result, and carry it forward when
recreating the merge across new parents.  Just being curious.

