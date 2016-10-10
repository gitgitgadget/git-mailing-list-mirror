Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9BC20989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbcJJSgx (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:36:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58978 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751203AbcJJSgw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:36:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1031B4403E;
        Mon, 10 Oct 2016 14:36:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uPuQt9ffMFN9J9zEgZ+HuQW2jBQ=; b=Y3k5um
        vKJdcu+rSuuID9StRAeJitSMwrRKSReZL13OW/sm6E/cw+/9H8UeJn9/MTMjEH3d
        xxvynjpBpYWjJTKGBWhaAlkihQCv+Bi91OJpnCJvuJJZwokihgBQt1HtJ2tRs5w5
        GfyZcKv+rFmMYDK4Uqrk6Ij8puK5MxqDxh1JY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bx7UhThL7QSnvg26c5LU//XUq/864RAs
        HMTQps9Z+J204KJG+CiXsjMvH8iRmvAApKr94JKSxE6IhoWzYIxi7TeYB4NtmSfM
        EgL6hkxv5aRhhN//TefbLwynpboA92aWZlo1FXGnG7Itp5I6+kbkU0agnfcjytsI
        ijUCrVyLThM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0911C4403C;
        Mon, 10 Oct 2016 14:36:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 838BA4403B;
        Mon, 10 Oct 2016 14:36:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?Q?St=C3=A9phane?= Klein <contact@stephane-klein.info>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: use relative path in worktree config files
References: <CADKxhpe3S4L9CPV9yxh2yhrtJMa9wyZAPC45u_S=RiuzY1Xrkg@mail.gmail.com>
        <CACsJy8C0kyKor4gCLSJrreRCazazbexvaSdbBg+Cka=-beZU_g@mail.gmail.com>
        <CADKxhpd-gDczp05Ny6wP57RXafWWCimArfA9ki2phh+-gHez4A@mail.gmail.com>
        <CACsJy8DGvyWz2_VBsEfmDWOPGUGAUhKYhCa1qLEMcOdn83ocSQ@mail.gmail.com>
Date:   Mon, 10 Oct 2016 11:36:48 -0700
In-Reply-To: <CACsJy8DGvyWz2_VBsEfmDWOPGUGAUhKYhCa1qLEMcOdn83ocSQ@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 9 Oct 2016 18:37:27 +0700")
Message-ID: <xmqq60p0f3un.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8210AF60-8F18-11E6-887B-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> I think there are some pros and some cons for relative path and absolute path.
>> Maybe append a "--relative" option with `git worktree add` ?
>>
>> I've converted all path to relative and all work with success.
>>
>> What do you think to append this --relative option.
>
> Patches are welcome.

Hmm, are they really welcome? 

Is an invocation of "git worktree add" really the right point in the
workflow to decide if these references to other repositories should
be relative or absolute?  When you are moving referrer, it is more
convenient if the reference uses absolute path to name the
referrent.  When you are moving both referrer and referrent, it is
more convenient to use relative.  

I somehow doubt that users know which future move they would be
making when doing "git worktree add".

To me, this almost looks like a need for a new subcommand to "git
worktree" that lets you move existing worktree to elsewhere, or turn
absolute reference to relative and vice versa.
