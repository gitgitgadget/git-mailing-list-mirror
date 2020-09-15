Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697A9C2D0E3
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2CA212CC
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QAsKI8pH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgIOVQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:16:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51131 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgIOVOk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 17:14:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FF3374EC9;
        Tue, 15 Sep 2020 17:14:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QCzV14LLTnpG
        1ashGTz85KxYsC8=; b=QAsKI8pH2plxU538eQrf33pg2cdgG6dpGyum73+JcyiS
        DXsZK3vQ+WZXQsquTj40cKg+RzCN/ipGQuZaUqTsS+gGrH9XUv+IxDYdtYijI2+B
        a/pKjCZ1XMbA37IIe3AI5PJ/Hv9IZuSD3hLqm1+UuOk/MpzI8kF3uVAQgiuvbfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eoGHGZ
        wxxC2Ae9J/0VWtF0w+8mUTfxLfHyVYDvvUuT8/s51DAKdMYQYhzIl70LH1O+/QPx
        jmnLiXCpJIHDERQTv+62TPUvRKB+o+rdseqi9DcmQ4yHrDoS01vGBbFyQhOz/UOo
        2xDXlIXfKt6SqUxwWAYg7+UPtw8hlvQqVFW7U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9682A74EC8;
        Tue, 15 Sep 2020 17:14:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2416874EC6;
        Tue, 15 Sep 2020 17:14:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
Cc:     git@vger.kernel.org, Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Sep 2020, #03; Wed, 9)
References: <xmqq4ko6twc9.fsf@gitster.c.googlers.com>
        <85ft7ivp1t.fsf@LAPTOP-ACER-ASPIRE-F5.i-did-not-set--mail-host-address--so-tickle-me>
Date:   Tue, 15 Sep 2020 14:14:18 -0700
In-Reply-To: <85ft7ivp1t.fsf@LAPTOP-ACER-ASPIRE-F5.i-did-not-set--mail-host-address--so-tickle-me>
        ("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Tue, 15 Sep 2020
 21:05:18 +0200")
Message-ID: <xmqqimcezqs5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B1201A0-F798-11EA-BF87-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

jnareb@gmail.com (Jakub Nar=C4=99bski) writes:

> Those are patches that are part of GSoC project of Shourya Shukla:
> 'Convert submodule to builtin'.
> ...
> Those are patches that are part of GSoC project of Hariom Verma:
> 'Unify ref-filter formats with other --pretty formats'

Yes and yes.  What is your intention for highlighting that these two
are GSoC originated projects, by the way? =20

These entries in the What's cooking report will eventually be part
of the Release Notes, it is tempting to mention it there for
publicity of the GSoC program (and I happen to work for OSPO that
runs the program).

But at the same time, it becomes part of the published history
(i.e. commit log for the merge commits) and over there, I am not
sure if we want to mention GSoC---who the changes came from and in
what context is much less important than what the actual changes are
while reading the history of the project, trying to understand the
current state of the code [*1*].

> I'd like to point out that latest series of patches by Abhishek Kumar
> which are final part of 'Implement Generation Number v2' is at what I
> believe is next to final iteration:

Yup, I've been watching from the sideline and appreciate that you've
given the author quite a lot of help to make the series into a good
shape.

> Because corrected commit date offsets are not monotone, that is after
> value that doesn't fit in 32 bits (in parent) there can be one that doe=
s
> (in child).  It is extremely unlikely that in real repositories there
> would be that large corrections needed, but it can happen in theory, an=
d
> therfore we need some way to handle overflow if we choose this option.
> And of course we should test that overflow handling works correctly.

My gut feeling is that overflow handling needs there whether the
field is 32-bit or 64-bit.

Thanks.


[Footnote]

*1* Unless you want to have more cues to notice commits by less
    experienced contributors and want to focus more carefully while
    bisecting the history or something like that, that is.
