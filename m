Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC121F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 16:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754350AbcJEQN5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 12:13:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60679 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752027AbcJEQN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 12:13:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDD4A4197B;
        Wed,  5 Oct 2016 12:13:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WKBWpkosoaaZOH/byRZtA0a9lA0=; b=ihjCFu
        2gevb001t3sbBWRVtDu2yTHAVBqgDm+tk+cj/OeKEAW866N/ytGYpnxZQECTD/49
        DeCF4IUtX9rAbBimie5gHhtisjXSqjb0nGu5e/ZBUSMgK7jwz2wwJg743Dg4gIST
        +iKXi9ih7BSF/cAaVl97zkh8IlYJzgqiAjGeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nJctAPRy1p+kQK/0sr+7daawSIVbMLTy
        1h9K/a1yNto0MfogIDFAAfePt3tGW7YU2IPLYp/wzZeGgodNCmSVBk4AHU5mj/vz
        rBjLaI2rrlDova1eIZQqO0PYnv+iOjByYuOF2R2Fo0M36W5zjkUyn6evWdjAaaN+
        qG3u6oCJgME=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5C574197A;
        Wed,  5 Oct 2016 12:13:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3795941979;
        Wed,  5 Oct 2016 12:13:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeremy Morton <admin@game-point.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reference a submodule branch instead of a commit
References: <57F29FEF.30700@game-point.net>
        <xmqqfuod6yw2.fsf@gitster.mtv.corp.google.com>
        <20161004113625.GB20309@book.hvoigt.net>
        <CAGZ79kZWtAU6YG4Qz9_Gwk2db5L2kPCCKrN+64hMYDovRjiLRw@mail.gmail.com>
        <xmqqshscuilh.fsf@gitster.mtv.corp.google.com>
        <xmqqlgy4szuu.fsf@gitster.mtv.corp.google.com>
        <20161005141439.GD30930@book.hvoigt.net>
Date:   Wed, 05 Oct 2016 09:13:53 -0700
In-Reply-To: <20161005141439.GD30930@book.hvoigt.net> (Heiko Voigt's message
        of "Wed, 5 Oct 2016 16:14:39 +0200")
Message-ID: <xmqqlgy2rcxq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6B765B6-8B16-11E6-B3E3-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

>> It IS a hack, but having this information in .git<something> would
>> mean that it can be forced to be in machine readable form, unlike a
>> mention in README.  I do not know if the .gitmodules/.gitignore
>> combination is a sensible thing to use, but it does smell like a
>> potentially useful hack.
>
> IIRC the tree entries are the reference for submodules in the code. We
> are iterating over the tree entries in many places so that change does
> not seem so easy to me.
>
> But you are right maybe we should stop arguing against this workflow and
> just let people use it until they find out whats wrong with it ;)

I didn't say that, though.  I am fairly firm on _not_ changing what
the superproject records in its tree for the submodule, i.e. it must
record the exact commit, not "a branch name", for reproducibility. 

I am OK if people ignored the unmatch between the recorded commit
from a submodule and what they had in the submodule directory while
they developed and tested the superproject commit.  After all, it is
not an error to make a commit while having a local uncommitted
changes to tracked files, and it is equally valid to have a commit
checked out in a submodule directory that is different from what
goes in the superproject commit.  But we do show "modified but not
committed" in the status output.  In that light, submodule.*.ignore
may have been a mistake.

