Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D37EC54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED14D215A4
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IIHxlgn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgDXVnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:43:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63176 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgDXVnv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 17:43:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20E93572BE;
        Fri, 24 Apr 2020 17:43:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lwHZ7pdv9NNACkNigRifKOHeLu8=; b=IIHxlg
        n5cynX3UPVzgipPcgIE9yFMzsnL9WcunHuZhvsbrrwjJLqMwrmFHqS/3bh11LSNn
        s4EkR4uHtrqbG85vwBP7Dzf1pu6SfxlnaPUOwyztVNNk2qq+7eSVXYKYyzEZiXRt
        y8byF7CRx8IlJAk6CqpwkveGGbcjIQoQsMfL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q0rpeXaoy28J8yNM6Xck9WbY+/PAyYqA
        O2jTyEpETA1YAhVDI0ZBDx9ul3XC5FjEIFbLnwRWOyHYM7E3/rFphByTcHe7a9Ds
        leaa7LDao9if+o/LS5rBECgEF7untur04XWYDFDPttgWUTUat9CIxs564E0jPJyp
        /yrP88K6aBE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1978F572BD;
        Fri, 24 Apr 2020 17:43:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B020572BC;
        Fri, 24 Apr 2020 17:43:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <xmqqv9lod85m.fsf@gitster.c.googlers.com>
        <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
Date:   Fri, 24 Apr 2020 14:43:45 -0700
In-Reply-To: <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
        (Sibi Siddharthan's message of "Sat, 25 Apr 2020 01:20:27 +0530")
Message-ID: <xmqq8sikblv2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC7E3112-8674-11EA-921B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

> The goal would be to maintain a CMake build for Git keeping it in sync
> with the Makefile.
> The Makefile is not going to be replaced at all. The CMake script for
> now only supports Linux and Windows.
> It does not support BSD, Solaris and others, whereas the Makefile does
> support them.

So you are doing (1).  I already said that I feel that engineering
burden to divert resources for CMake support would be unacceptably
high.

Whenever any of our developers need to add source files, Makefile
configuration knobs that people can add to config.mak, etc., you are
forcing them to figure out where in the CMakefile to add them or
devise ways to allow builders who do not use config.mak (because
they use CMake) to do similar tweaks.

Any patch that is acceptable to the current project would become
unacceptable because they lack updates to CMake part, but I suspect
we do not have enough people who are so much devoted to give a good
review if updates to CMake part are added.  And it is unclear why it
would be beneficial to slow our existing developers down by forcing
them to become familiar with CMake.

So..., I am not just "still not convinced", but I am even more
convinced that we do not want this series, after thinking about it
longer.

Thanks.

