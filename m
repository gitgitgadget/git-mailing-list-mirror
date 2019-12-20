Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96080C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F40E206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OGiqfTtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLTSei (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:34:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50056 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTSei (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:34:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68C4299509;
        Fri, 20 Dec 2019 13:34:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JwdGJD2ucwrzUYsE/kGgc4TWSPo=; b=OGiqfT
        tKTqB7IbpzVEhdtvGMak8hkEB9R37CdDamR6vvHxYOsyMXG1wGDGzm1IaGxTp0Ka
        tTJatjsBxsJ9nM/L3qlEOvYS19W58kMuXsCgHDATUnMJQzFgQ+EvcrQa4tuOIqh7
        hZh5SrzXUynrIsPOLzD3psPRfA+pGjRwMik60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oHjVZPYZZl/VHpB7Z41RwLuAL0be03cB
        JOk8D+5UEEo5PUvWYSptFg7GEL+AVpYZOe4VXN+zJXoGAhFNQVTBnDuS0NUuavQ+
        bRm+RDYnpJ1eb4984Esn0nNNGYkcf/YwvJX7EbQw2eusLqzAu0m6ZVw0wNugb8TQ
        ZK05ZZkl/qY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A92999508;
        Fri, 20 Dec 2019 13:34:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8443E99507;
        Fri, 20 Dec 2019 13:34:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 1/1] commit: display advice hints when commit fails
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
        <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
        <ebec2379207681152c6e5196a1418aca03da113a.1576746982.git.gitgitgadget@gmail.com>
        <xmqqfthgb01m.fsf@gitster-ct.c.googlers.com>
        <xmqqbls4aznl.fsf@gitster-ct.c.googlers.com>
        <20191220023125.GD227872@google.com>
Date:   Fri, 20 Dec 2019 10:34:28 -0800
In-Reply-To: <20191220023125.GD227872@google.com> (Emily Shaffer's message of
        "Thu, 19 Dec 2019 18:31:25 -0800")
Message-ID: <xmqqbls2alsb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C47E592-2357-11EA-B9DB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Hm. I'm surprised to see this feedback come in the form of a local
> change when making the topic branch, rather than in a reply to the v1
> patch. What's the reasoning? (Or is this scissors patch intended to be
> the feedback?)

You haven't seen a suggestion in the form of counter-proposal?

> I ask because out of all of us, it seems the Outreachy interns can
> benefit the most from advice on how and why to write their commit
> messages - that is, part of the point of an internship is to learn best
> practices and cultural norms in addition to coding practice. (Plus, I
> find being asked to rewrite a commit message tends to force me to
> understand my own change even better than before.)

It's something Mentors can help doing (I do not necessarily have
time for that myself), and you're welcome to use the "tenatively
queued" version as an example.

> I'll go ahead and look through the changes to the commit message so I
> can learn what you're looking for too :)

Nice.

One thing you missed in your review of the "tentatively queued"
version is the reversal of the order of presentation.  Instead of
starting with "I decided to do this" without explanation, give the
picture of status quo to set the stage, explain what issue exists in
the current behaviour, and then describe what approach was chosen to
solve the issue.

> For me, I don't particularly see why we'd want to be rid of it - it sort
> of feels like "a picture is worth a thousand words" to include the
> actual use case in the commit message.

Output coming from commands and/or options that are used only in a
bit more advanced workflow and the ones that are rarely seen, I do
agree that showing example is a good way to illustrate exactly what
you are talking about.

On the other hand, for behaviour of basic local commands like "git
add", "git commit", "git diff", ..., I do not necessarily agree, as
these should be obvious and clear to all the intended audiences,
which would be "anybody who has used Git for say more than two
weeks.
