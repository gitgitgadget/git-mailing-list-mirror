Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AA02022A
	for <e@80x24.org>; Wed, 26 Oct 2016 17:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754981AbcJZRHD (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 13:07:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61690 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751271AbcJZRHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 13:07:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4ABE4759A;
        Wed, 26 Oct 2016 13:07:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+cbc2uO4mkqyrC/CqigWL3KM5hk=; b=WrFSet
        fCta+D2zyiAEsp3LUo38PaQR15TEmE1QzEWBJg/FW1/ckAahgxKcAu0xe5ZgmVv2
        ABot8vdTRp1HQE7jUsF3lI8USgRrkkV8VR+U2Yd4yEoI6T3wWH4VVXhVvIAMpTF8
        E7DETweKoPA2qnyijp3mS22kVdejRIevKm/cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cPIhtCRT0zU7ZccjOoyn5jrZYrfkhMNJ
        Z8BRDPS4modXMWroHnUd9pOyyH8HiD7P74+1EdRF9au0S5+OwSFdcggGBVixtkP0
        hu4sMfQTkoyy7WNvkchMrvmrfzitbDVGX6/oCe++TBVWe+sI87i+MuOVm6iRZFTc
        8VqyJZtqujQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B69947599;
        Wed, 26 Oct 2016 13:07:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E46A947596;
        Wed, 26 Oct 2016 13:06:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset: --unmerge
References: <xmqqa8dttkbw.fsf@gitster.mtv.corp.google.com>
        <CACsJy8B-GcMNv7pYYLpaUXc2kKnvyYEYm6w=fiaHy7rt4aug1Q@mail.gmail.com>
        <CACsJy8D4cT2EV_t6=+XTHxLmjV+NtAE+KgiN3ZiP7JQzvu29oQ@mail.gmail.com>
        <xmqqmvhsc8kn.fsf@gitster.mtv.corp.google.com>
        <CACsJy8Dn7m2axEFkkQtnZMs2yzFwivAJyZCWxODg-HQ=qLnVMA@mail.gmail.com>
Date:   Wed, 26 Oct 2016 10:06:57 -0700
In-Reply-To: <CACsJy8Dn7m2axEFkkQtnZMs2yzFwivAJyZCWxODg-HQ=qLnVMA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 26 Oct 2016 16:32:14 +0700")
Message-ID: <xmqq1sz3ca4u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BA09B92-9B9E-11E6-AD07-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Interestingly the thread/bug that resulted in that commit started with
> "report this bug to git" [2]. Something about git-stash. I quote the
> original mail here in case anyone wants to look into it (not sure if
> it's actually reported here before, I don't pay much attention to
> git-stash mails)
>
> -- 8< --
> Bad news, everyone!
>
> When a stash contains changes for several files, and "stash pop"
> encounters conflicts only in some of them, the rest of the files are
> stages automatically.

It indeed is curious.

That is the designed behaviour for _ANY_ mergy operation, and not
limited to "stash pop".

A clean application is added to the index so that you can find out
about them from "diff --cached", while conflicted ones keep their
unmerged stages so that the conflict can be resolved in the working
tree files.  There is no bad news here.

Once you resolve the conflict, you would add the final contents to
the working tree, but as anybody who knows how "git diff" after
resolving conflicts in the working tree files is useful would know,
"saving the editor buffer after removing conflict markers" is not a
valid signal that the user is confident that the contents is final.

> At least, that happens with Git 2.1.0 on my machine, and some
> commenters here: http://stackoverflow.com/a/1237337/615245
>
> So then when we unstage the files which had conflicts after resolving
> those, the result is mixed. Which doesn't look right.

Whoever wrote this does not understand how mergy operations in Git
works, I guess.

> What shall we do? Unstage the automatically-staged files? Revert the
> changes from this bug? It seems Git really wants the changes staged
> after the conflict resolution.

The first order of business is to learn how mergy operations in Git
is designed to work, and if they are in the business of building a
tool around Git to make the life of users better, avoid going against
the designed workflow.

If this "Bad news, everyone!" is why vc-git-resolve-conflicts was
added and defaults to true, I can feel safe in toggling it off
forever in my ~/.emacs, knowing that it is a totally broken option
that came from a desire to fix a problem that does not exist.

