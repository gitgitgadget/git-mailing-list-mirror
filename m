Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151BCC4363D
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 00:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B112067C
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 00:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="owi/8Ic/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbgJAAF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 20:05:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60133 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731005AbgJAAF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 20:05:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D682010285E;
        Wed, 30 Sep 2020 20:05:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=RDVedmYslwuaRhVq3Zflju0I/hI=; b=owi/8I
        c/KDyTjzbHuTinrWnJwNmxX8z4DPwt8VA7Kb0HamWWfB02NoZxXEB0P2ttZm48GW
        J/gGz5kndYnezPzUoCC6O71/gLWuN8pW+a4RGFcRoaMfd+fPUmxZWi8tt1CyLYIj
        Lid+lxFKmyaaULRMTXVoasxWpY+Su6rfvXpyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NQDHrNcpzbbEQoThDapI4reSOy/lT4tM
        uHcmRpJmJn6TWotxR94PYhMzQhtPzYhLuFtgs4YLg1xXYLQKmVvAArW2UeYi4wY5
        FPdB9hHoX63F2myAMssmIdVOvNpamE2sKiuzHn2ABASaIxE0I01yMn3xPBtyvHbQ
        aFAvjxDA7oM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE8F810285D;
        Wed, 30 Sep 2020 20:05:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 21E7810285C;
        Wed, 30 Sep 2020 20:05:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
In-Reply-To: <20200930232138.3656304-2-shengfa@google.com> (Shengfa Lin's
        message of "Wed, 30 Sep 2020 23:21:38 +0000")
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20200930232138.3656304-1-shengfa@google.com>
        <20200930232138.3656304-2-shengfa@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 30 Sep 2020 17:05:51 -0700
Message-ID: <xmqqft6yerog.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEF65ED0-0379-11EB-BC06-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shengfa Lin <shengfa@google.com> writes:

I won't repeat what I said in the other review message, but since I
forgot to comment on the log message...

> Users requested hiding location in the world from source control
> trail. This is an implementation to read user.hideTimezone in
> cmd_commit and set timezone to UTC if it's true.
>
> Added a brief explanation of the new field in Documentation
> and added tests for true/false and reset-author

Not a very good proposed log message, that sounds as if "it is
what 'Users' requested, so it must be a worthwhile thing to do",
which is not the line of thinking to go by.

The convention we follow in the commit log messages is to:

 - first explain that the current system does not do X (in present
   tense, so we do NOT say "previously we did not do X"), then

 - explain why doing X would be a good thing, and finally

 - give an order to the codebase to start doing X.


Perhaps

    Many places in Git record the timezone of the actor when a
    timestamp is recorded, including the committer and author
    timestamps in a commit object and the tagger timestamp in a tag
    object.  Some people however prefer to "lie" about where they
    actually are.

    They _could_ just say "export TZ=UTC" and be done with it, but
    the method would not easily allow them to pretend to be in the
    UTC timezone only with Git, while revealing their true timezone
    to other activities (e.g. sending e-mail?).

    Introduce user.hideTimeZone configuration variable, which can be
    optionally set to 'true' to pretend to Git as if the user has
    exported environment variable TZ with the value UTC.

Thanks.

