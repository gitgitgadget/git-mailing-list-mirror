Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CF42095E
	for <e@80x24.org>; Sat, 18 Mar 2017 17:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdCRRYV (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 13:24:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54962 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751637AbdCRRYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 13:24:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8129482ECF;
        Sat, 18 Mar 2017 13:24:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=udwy1uqWOjU13SgiHwSuWVQcpEM=; b=Yqlguz
        SK3DiQtmZoZYHvIpck5ZWbpUJ6Hsy/rVzLMCZZuW/LwZeuGfSEId5CKO5pRdDdKl
        v5WAbjV0ZwpHOK9csxO5+HeR64jtyKJ/fXFMLYmHeSZfiiDjxYXm9qeDl9mSL/kq
        xm04df8r6HV82lW+sOGfT8GdUdBF2DAYqWuIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cq5gYXpJotXJ3ccHaC//NGL/wa/YwyHz
        +Y+yCNqKmNddPPcdot9hVkVLDdP6y4OKKK5i1p8VZ5bm/2NL485XoW9Oi7kZhyso
        jJrl6bj9uhy5HF+PXc0VptFHDLD9HESaSXSlKwQttZNY/hduhn0zfP/PG1wuncf3
        v9uZw5s21+8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79D2082ECE;
        Sat, 18 Mar 2017 13:24:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E65B382ECD;
        Sat, 18 Mar 2017 13:24:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on the file system
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
        <20170317225110.13417-1-sbeller@google.com>
        <20170317225532.GR26789@aiede.mtv.corp.google.com>
        <CAGZ79kaL=mHsqURqrnUMav8W=Hr960PHw6WDoBncVZA4AjmsJA@mail.gmail.com>
Date:   Sat, 18 Mar 2017 10:24:17 -0700
In-Reply-To: <CAGZ79kaL=mHsqURqrnUMav8W=Hr960PHw6WDoBncVZA4AjmsJA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 17 Mar 2017 16:04:09 -0700")
Message-ID: <xmqqo9wy4hxa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7FE35FC-0BFF-11E7-8728-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Unfortunately gitglossary(7) doesn't make this clear at all --- it
>> uses the term worktree a few times (and appears to mean "working tree"
>> when it does --- e.g.
>>
>>         Pathspecs are used on the command line of [...] and many other
>>         commands to limit the scope of operations to some subset of
>>         the tree or worktree.
>>
>> ) but never defines it.
>
> So maybe it's time to look for volunteers for a cleanup patch. ;)
> I tried finding the discussion on worktree vs "working tree"
> and did not succeed. :/

A rough rule of thumb.  Anything that was written before 2014 or
back when nobody knew df0b6cfb ("worktree: new place for "git prune
--worktrees"", 2015-06-29) was coming that says "worktree" is using
the term to refer to what we call "working tree" these days.

What Jonathan quoted above came from 3bd2bcfa ("glossary: define
pathspec", 2010-12-15) and certainly predates the one that replaced
contrib/workdir, so we should update it to read "working tree".

