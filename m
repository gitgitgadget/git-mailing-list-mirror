Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4C61F461
	for <e@80x24.org>; Fri, 12 Jul 2019 14:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfGLORG (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 10:17:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53341 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfGLORG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 10:17:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 957F116947B;
        Fri, 12 Jul 2019 10:17:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wa0Mx4pNbGJZ4XRuka4whjassbA=; b=OLIvJx
        Bd4SKEUGk0F0631kO3l1uI1ONYHim/O9xtkDj8rOw+Jloe0tK/znmj3F42JmhYmx
        R+7eAP8inYKmqbK71Qn8iNEYw7Ove0e/tMlMXuCLd+fT7CU6Z13uBhw2OPssNtqh
        VFwUN0PmjpajtSfyeJXYa8Ttk6JtYsKw8q3F8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yV7pIjAm7V8CSFhMneU921787LZFoSi0
        71BPeItru+E9zxB+zVzY56ol7KMzejD6CHPKco+DWbTk4CQWRv9nOS7ZQpf1xfYN
        lZQRK9dp8kJ/+Ut1nwmE5kPDbhO89WS0rNB5+TMtzhkmk3tYfQDTmj6FxNg+ovW2
        p2q4Njalyjo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DF7E16947A;
        Fri, 12 Jul 2019 10:17:02 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAAE3169478;
        Fri, 12 Jul 2019 10:17:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] use mailmap by default in git log
References: <20190711183727.8058-1-ariadne@dereferenced.org>
        <xmqqy314qsgp.fsf@gitster-ct.c.googlers.com>
        <xmqqtvbsqs9x.fsf@gitster-ct.c.googlers.com>
        <CAAOiGNwGqtSoG8vsy+3gb0=tDVvA1YcA3FcDP0KQMa0=xp5j9w@mail.gmail.com>
Date:   Fri, 12 Jul 2019 07:17:00 -0700
In-Reply-To: <CAAOiGNwGqtSoG8vsy+3gb0=tDVvA1YcA3FcDP0KQMa0=xp5j9w@mail.gmail.com>
        (Ariadne Conill's message of "Fri, 12 Jul 2019 03:40:13 -0500")
Message-ID: <xmqqblxzqqw3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7B44FF0-A4AF-11E9-BFFF-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ariadne Conill <ariadne@dereferenced.org> writes:

>> What we need at this point is the "second release" phase, i.e.
>> additional warnings without yet changing the default behaviour.
>> After it is given to the end users and sufficient time passes, we
>> can flip the default.
>
> Do you have a proposed timetable for this?  I can add a warning
> message and we can proceed with the warning message for now and then
> flip the defaults later.  I just need to know what version you would
> like to do the flip in (3.0?) so that I can write the warning message.

I do not think we usually do this without having to say "at this
release" in such a warning.

A recent example of a behaviour change that was backward
incompatible was that we no longer allow

	$ git log -- ''

to mean the same thing as

	$ git log -- .

since Git 2.16.  This change was initially planned in Git 2.11 timeframe,
and we started warning when "git log" is used with an empty string
as one of the pathspec elements on the command line in that
release.  We kept warning for some releases and then at last at Git
2.16 we flipped the switch.

It was started at d426430e ("pathspec: warn on empty strings as
pathspec", 2016-06-22) and then flipped at 9e4e8a64 ("pathspec: die
on empty strings as pathspec", 2017-06-06).  Run "git show" on these
commits, with pathspec "pathspec.c", to see exact wording we used.

You should be able to find other examples by looking in the
Documentation/Relnotes directory and finding backward compatibility
notes in there.

> Warning: The `git log` command will default to using the mailmap file
> if present to map contributor names as of Git 3.0.  If you want to
> enable this behaviour now, use `git config --global log.mailmap true`
> to enable it.  If you want to explicitly disable this behaviour in the
> future, use `git config --global log.mailmap false` to disable it.

Other than (1) the explicit "as of ..." which we do not have to say,
and (2) use of "--global", as this is pretty much per-project
convention and is better handled by default per-repository basis,
nto per-user basis, I think the proposed text tries to convey the
right message.  But again, it is advisable to study how we phrased
these warning messages in past releases for different features and
mimic them.

Thanks.
