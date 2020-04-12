Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8DEC2BB85
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 22:25:15 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032C3206C3
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 22:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="raF27YJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032C3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgDLWZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 18:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgDLWZN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 18:25:13 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7703BC0A88B5
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 15:25:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C217C5A543;
        Sun, 12 Apr 2020 18:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6kT+EZ0QxQlxG5WNj2jJ9HgFGyI=; b=raF27Y
        JUWzeA+ZgF6GvoM6+KOta+pVSINgWr338DOmqcE+cigG4+GhCGoANaYyIEwl6tJY
        AK3UXB+d3BPqwjHMETg02mxBHsZ5Sd+NXtkDx3MBmbHxT95hXRm0cldujF1BfQgM
        ZG2F//tZs+RqLq9lWUi+NBJzN3hxGC02gjGoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BmJdvYdW+rj+SkkzDOIUEkKRRtXQktS9
        WcirRYIVta8AUwAG6jlD/DOb7Wul8vcdOGjTNDibHp6ohGSpYrASuuCDkMre2goP
        m2ZMH+PcmcbEhjXFpiLrj/AjQjWUzGaiIhRYfv6UdmKVrbGd2jLAhx7OnmNOUG3S
        RUtECJEhY/s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B95D55A542;
        Sun, 12 Apr 2020 18:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 451C15A541;
        Sun, 12 Apr 2020 18:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] ci/lib: allow running in GitHub Actions
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <d9227c87a7bb2872f6a69f48f6a4988f08545d8a.1585658913.git.gitgitgadget@gmail.com>
        <20200403084654.GK2224@szeder.dev>
        <nycvar.QRO.7.76.6.2004042207410.46@tvgsbejvaqbjf.bet>
        <20200410153131.GM2224@szeder.dev>
        <xmqq7dynjgx7.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004122339290.46@tvgsbejvaqbjf.bet>
        <xmqqimi4cq0v.fsf@gitster.c.googlers.com>
Date:   Sun, 12 Apr 2020 15:25:11 -0700
In-Reply-To: <xmqqimi4cq0v.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 12 Apr 2020 15:12:16 -0700")
Message-ID: <xmqqeesscpfc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79B1F118-7D0C-11EA-955B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  Two 'test' before && may yield
> success or failure and they may control whether the assignment to
> CI_OS_NAME is done or skipped, but I expect that they do not affect
> how "set -e" behaves.

Heh, I should just have quoted from

  https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09

Look for "set -e" where three bullet points are there.  The relevant
is the second one.

2. The -e setting shall be ignored when executing the compound list
   following the while, until, if, or elif reserved word, a pipeline
   beginning with the ! reserved word, or any command of an AND-OR
   list other than the last.

The test to see what the current value of CI_OS_NAME is is a command
of an AND list that is not the last one (the last one being the
assignment), so its failure does not allow "set -e" to abort the
shell.
