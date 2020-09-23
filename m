Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A76C4727F
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 16:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA2121D92
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 16:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kZRU2vuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgIWQPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 12:15:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62026 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgIWQPB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 12:15:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 146FA83CB2;
        Wed, 23 Sep 2020 12:14:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Km114rWdOsRPKkT4uLuZ1T4Rwis=; b=kZRU2v
        uk/cI0Ias60oAwMl8/9NyCVJ6djB7ZJ1WKaRsawu/k9BJDRLu1WWCYPVM5JfoGE3
        0ldK1IGXV76jiESmjmDfu1VP9gBsspDqn6e3cp17hz4l64/BVPI/VP0VxWn5hAg7
        NghfJbVJNaDX47eT8ofy7hLa7lbAGEr2/XLiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RV5XkbNPiF6ZaK7n6Z2+IqNEaM8n6Wrv
        XMM/6jISQWmTPXvyk1zX5mRaI4ztR6Vhud45K58Vun4G0lO2FdoXhzSjzetUno/P
        wGD+bMKoljzNgAOMFUP6wNyi8p2wh3igee033cJA8Bmi5V/0roGjnzCRTwxSAfOs
        7496cB7cVHs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0913B83CB1;
        Wed, 23 Sep 2020 12:14:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B06D83CB0;
        Wed, 23 Sep 2020 12:14:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 0/6] Finish converting git bisect to C part 2 subset 1
References: <20200923072740.20772-1-mirucam@gmail.com>
Date:   Wed, 23 Sep 2020 09:14:57 -0700
In-Reply-To: <20200923072740.20772-1-mirucam@gmail.com> (Miriam Rubio's
        message of "Wed, 23 Sep 2020 09:27:34 +0200")
Message-ID: <xmqqmu1gjwqm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECF57FE2-FDB7-11EA-995D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> These patches correspond to a second part of patch series 
> of Outreachy project "Finish converting `git bisect` from shell to C" 
> started by Pranit Bauva and Tanushree Tumane
> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> continued by me.
>
> This patch series version is composed by the first six patches of the
> previous version due to a bug discovered during the test stage, that 
> affects the rest of the patches and that needs to be fixed before 
> sending them.

Thanks for being careful.

> * Rebased on 385c171a01, (Fifteenth batch, 2020-09-18) to update command
> help messages.

Personally I find this rebase unwarranted.  What ef4d9f8a (bisect:
swap command-line options in documentation, 2020-08-28) on the
'master' did does not overlap with this series in any meaningful
way.  Since it is also trivial to adjust these patches back on
e9b77c84 (Tenth batch, 2020-08-24) on which the previous round was
based, I won't complain ;-)

> [4/6] bisect--helper: reimplement `bisect_autostart` shell function in C
>
> * Amend commit message.
> * Change to `return -1` when we cannot autostart.
> * Add `|| exit` to bisect-autostart call in shell script.

Sounds good.

> [6/6] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
>  functions in C
>  
> * Amend commit message.
> * Amend new modes order in cmdmode enum.

Meaning that the two new ones can just be at the end and there
wasn't a reason for them to come before autostart?  OK.

> * Add `|| exit` to bisect-auto-next call in shell script.

OK.

Thanks.
