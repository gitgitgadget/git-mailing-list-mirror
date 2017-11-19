Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44FEB2036D
	for <e@80x24.org>; Sun, 19 Nov 2017 02:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750910AbdKSCM6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 21:12:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52555 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750779AbdKSCM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 21:12:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9E10A2F49;
        Sat, 18 Nov 2017 21:12:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m4FfWcJwda7SkUUqRFagGAWjsMY=; b=c+P5uo
        fcBcnx9Oz0cWsCPt3pY3AMBbuveEWwaDZKCU0443QmrREMLZOjl7Io28XhvPocUM
        u+vOviK38Cm+nxzMRac1aIlO0PVfs1e5Q/ViZgtDrSJX/U18VmLX+gF0cL8OsldY
        Yu7pA/TtUskr4sJEAD4pZMCzHSmWFv8uNdQ8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K9NeeRVy9YHdgcKdruH0bO/+adp0WVhK
        6kR5e+njqKQRTS9oGnHPT9DOKAkar/SyRbLTOC5yPqyszLEhQGsjg79XF/iIMhxU
        qSCbuqUxDicoEyDc3djjNi6omdMiPMZON8//j+5NOPDHLV6VTgPDQopcb3P5fs/C
        jZ0iyFMjo+U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0799A2F48;
        Sat, 18 Nov 2017 21:12:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D7B3A2F42;
        Sat, 18 Nov 2017 21:12:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] git-rebase: clean up dashed-usages in messages
References: <20171118161810.16494-1-kaartic.sivaraam@gmail.com>
Date:   Sun, 19 Nov 2017 11:12:53 +0900
In-Reply-To: <20171118161810.16494-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Sat, 18 Nov 2017 21:48:10 +0530")
Message-ID: <xmqq4lprow2i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2713B6CA-CCCF-11E7-A7B8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
>  git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
> -git-rebase --continue | --abort | --skip | --edit-todo
> +git rebase --continue | --abort | --skip | --edit-todo

A good change.

>  test -f "$apply_dir"/applying &&
> -	die "$(gettext "It looks like git-am is in progress. Cannot rebase.")"
> +	die "$(gettext "It looks like you are in the middle of an am session. Cannot rebase.")"

Probably not, as 'am' alone would be confusing.

    "It looks like 'git am' is in progress. Cannot rebase."

may be a more sensible improvement.

