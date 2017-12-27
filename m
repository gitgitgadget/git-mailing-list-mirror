Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A731F404
	for <e@80x24.org>; Wed, 27 Dec 2017 17:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbdL0Rlf (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 12:41:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50935 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751043AbdL0Rle (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 12:41:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0785BBDF4;
        Wed, 27 Dec 2017 12:41:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dV7U9lx/gIeRdy4UcS98wpw4tyQ=; b=jVxWAv
        zS2psXOOj5YJw4YlsR7VfgVfL5R7H3njMpfsdcDZE/udqg+kk1nDd2Be/K33LFrw
        /1qLIiZnld0ZrNpIwEoijFdMvflf8R0JiuZN4g4JTscFyBK3h24X/54l/22cA8Ec
        7nQiACFJXoSycobAbOdwj6d3nv802U8tDRXTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TtLOqXeZhYLZpehunArwDbCEvF068Ovb
        m3uk6CU6QRtz1UlyZjMFCYuj62kcj8eLzeE5IiHbSaxCSNcQt/G2EdtiFRUahVVQ
        PucBPrTiG5ar4cjd+pY/TATHZciqQtNcGNUGkxDrfYtctukysh+lzcdCbkv4lG45
        Ff53eFItQC8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7316BBDF3;
        Wed, 27 Dec 2017 12:41:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4691ABBDF1;
        Wed, 27 Dec 2017 12:41:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/5] core.aheadbehind: add new config setting
References: <20171221190909.62995-1-git@jeffhostetler.com>
        <20171221190909.62995-2-git@jeffhostetler.com>
        <20171221204356.GA58971@aiede.mtv.corp.google.com>
        <xmqq3742tyho.fsf@gitster.mtv.corp.google.com>
        <20171224143318.GC23648@sigill.intra.peff.net>
Date:   Wed, 27 Dec 2017 09:41:30 -0800
In-Reply-To: <20171224143318.GC23648@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 24 Dec 2017 09:33:18 -0500")
Message-ID: <xmqq1sjgoyph.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CAC8540-EB2D-11E7-B2B3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I, too, had a funny feeling about calling this "core". But I didn't have
> a better name, as I'm not sure what other place we have for config
> options that cross many command boundaries. "diff" and "status" don't
> seem quite right to me. While you can argue they are subsystems, it
> seems too easy for users to confuse them with the commands of the same
> names.
>
> Maybe there should be a "ui.*" config hierarchy for these kinds of
> cross-command interface options?

I had an impression that ui.* was primarily pretty-printing,
colouring and things of such nature.  I do not think it is such a
bad idea to honor a status.frotz variable that affects how (e.g. to
what degree of detailedness) status on frotz are reported in Git
subcommands other than 'git status' if they report the same sort of
information on 'frotz' that 'git status' makes.

