Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D146C433C1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 18:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF7361954
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 18:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhCSSMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 14:12:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61610 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhCSSLt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 14:11:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C351312B379;
        Fri, 19 Mar 2021 14:11:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9LY4NyrSsyNB28L001OjQiKX7NI=; b=Bnjsdb
        8PwFs39i6Y8BkhqSfGFt/0tFZ5q9jOgP5yzeF3dhAFljvx2wCIq2IRuj7uUFUUpz
        eW8isJXU+0ruv7DY7EPH/NFlEl0fl9m3ihgOnFb7Km5PQL1Ec1tiJAFFRx34ofVg
        aPAhhz0EqOk9U9nJTaTf0XRv8DfrDCfIZgPAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nIpMQ2i4aClatfb+ZYM4SSfStbAvsBuN
        dXBI0c2QOTI6kwSgBfbnxu+CUedmoSqXNND71BClVxtG3Rb9gbYnYJG5GbZMXmIJ
        e3W1e44zYl9TaKFz3KEPYOCvbDJCjtH6VsX5CFnOhwraXX9qSvR94HkQQE+x0yjD
        PfFgzBp/380=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBEEC12B378;
        Fri, 19 Mar 2021 14:11:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EF1A012B377;
        Fri, 19 Mar 2021 14:11:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: GitGitGadget and `next`, was Re: [PATCH v5 3/3] ls-files.c: add
 --deduplicate option
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
        <e9c5318670658b032ba921129859f9fb3b2ca017.1611037846.git.gitgitgadget@gmail.com>
        <xmqq7do7fggn.fsf@gitster.c.googlers.com>
        <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com>
        <xmqq1reec943.fsf@gitster.c.googlers.com>
        <CAOLTT8Qp2NMpbk56U6PVEmFVyZYWN6gM83HD4z_nmPWV4Z_ruw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2101221702420.52@tvgsbejvaqbjf.bet>
        <xmqq8s8kalz3.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2103191451460.57@tvgsbejvaqbjf.bet>
Date:   Fri, 19 Mar 2021 11:11:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2103191451460.57@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 19 Mar 2021 14:54:47 +0100 (CET)")
Message-ID: <xmqqmtuzm2sf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90E48B0A-88DE-11EB-A415-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 22 Jan 2021, Junio C Hamano wrote:
>
>> Just being curious, but when a series hits 'next', would the way in
>> which the user interacts with GGG change?
>
> My hunch is that we should probably tell new users (for who GitGitGadget
> now uses the "new user" PR label) about the expectations of only adding
> patches on top (i.e. in a new PR), unless the branch gets kicked out of
> `next`.
>
>> With or without GGG, what is done on the local side is not all that
>> different---you build new commits on top without disturbing the commits
>> that are in 'next'. Then what?  Push it again (this time there is no
>> need to force) and submit the additional ones via `/submit`?
>
> GitGitGadget would send the entire patch series, which is probably not a
> good idea.

Thanks for a clarification.

While we are on the topic of GGG, if I may ask for a new feature or
two (or perhaps such a feature already exists), it would be nice if
contributors are allowed to tweak who are CC'ed in the outgoing
patch mail in various ways:

 - I may author a commit as <gitster@work.addre.ss> and make a pull
   request on GitHub, but the <gitster@pobox.com> is the address
   associated with the GitHub account making the pull request.  I
   think GGG sends CC to the author (at work) as well as me, but I
   may prefer to get correspondence on the patch at either one of my
   addresses not both.  "Mr GGG, please compute the CC list the
   normal way, and drop this address from the CC list" that I can
   say when I say "/submit" might be a good way to do so.

 - Also, at "/submit" time, being able to say "Also CC: these
   addresses" would be a good feature, without contaminating the
   commit log message with CC: trailer lines.

Thanks.
