Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A50901FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 18:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754149AbcKUSk5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 13:40:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51505 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754143AbcKUSk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 13:40:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3ED752209;
        Mon, 21 Nov 2016 13:40:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YpdpYHTvaN8eiOdmfmVSTWYtkNQ=; b=OX3fww
        5d5hVrqzJBrv5kGvH+kAkTVr9SFbtVj3UpQra/2wqrQUymPsBNP9AWI9td+Tez1o
        lBbsR0o1KWPRRaTHQpoc+D2pUMqvs2YVaGV/d6Uj8lgB1p+mH/j682eXz6S3W0gp
        AyoXIglMs+ytNmCXjbDsFf8uj0bO2EvQU3+3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aUxj10sj0ZVB/5RMbuUMKT6B3o3So3w5
        Qp/PTt9FM2lwH7xUooOVcqWZWSoQsFKMpn3MnILkd3aJ9u0ptxvFylF6ZVdGONYl
        R6H0/W9pbsmFiYtqPe6XVjvBnCf4HNkEdarRs0Q4UVSlpCuhVp0nnOuavYTWiv0Z
        pdY7iIoqcVg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E157F52208;
        Mon, 21 Nov 2016 13:40:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 540A852207;
        Mon, 21 Nov 2016 13:40:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 3/3] rebase -i: handle core.commentChar=auto
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
        <9ef529a4fbb60990a91d7bbfdd49c6d20d49e442.1479737858.git.johannes.schindelin@gmx.de>
        <975c0002-8afe-efa6-d967-72f2a0d21169@kdbg.org>
Date:   Mon, 21 Nov 2016 10:40:53 -0800
In-Reply-To: <975c0002-8afe-efa6-d967-72f2a0d21169@kdbg.org> (Johannes Sixt's
        message of "Mon, 21 Nov 2016 19:26:51 +0100")
Message-ID: <xmqq37ikk762.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08C60A9C-B01A-11E6-B90A-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> comment_char is a command? Did you mean
>
> 	comment_char=$(echo "$comment_char" | cut -c1)

;-)

> It could be written without forking a process:
>
> 	comment_char=${comment_char%${comment_char#?}}
>
> (aka "remove from the end what remains after removing the first character")

Hopefully nobody would include any glob metacharacters in there,
e.g. "core.commentchar='=*'", which would break that?


