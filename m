Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53FD61FAE3
	for <e@80x24.org>; Tue, 20 Feb 2018 16:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeBTQXM (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 11:23:12 -0500
Received: from mail.javad.com ([54.86.164.124]:35502 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752702AbeBTQXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 11:23:11 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 5B61941769;
        Tue, 20 Feb 2018 16:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519143790;
        bh=kUA7veVmHEvjJSQJpzZGbFU2MfUurbQPAL47gAjR2wE=; l=3477;
        h=Received:From:To:Subject;
        b=Ya5Xhq11c0av2qY3HLx6K0M6xZnYGkoK+HgxNzsAkB0XcXmW75Wyg9RbjpA6POmbm
         bDt/YTvnjlyGntEyRcyVy3H0U3hyl/0QR0v5LDIexj8MLrCqyE97oPRGlDfNxoIM0P
         z4VfzOyvJdwen87MbaVsfjLggJ5PEiT6Ic2idXic=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519143790;
        bh=kUA7veVmHEvjJSQJpzZGbFU2MfUurbQPAL47gAjR2wE=; l=3477;
        h=Received:From:To:Subject;
        b=Ya5Xhq11c0av2qY3HLx6K0M6xZnYGkoK+HgxNzsAkB0XcXmW75Wyg9RbjpA6POmbm
         bDt/YTvnjlyGntEyRcyVy3H0U3hyl/0QR0v5LDIexj8MLrCqyE97oPRGlDfNxoIM0P
         z4VfzOyvJdwen87MbaVsfjLggJ5PEiT6Ic2idXic=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1eoAhA-00061L-Oo; Tue, 20 Feb 2018 19:23:08 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     "G. Sylvie Davies" <sylvie@bit-booster.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: cherry-pick '-m' curiosity
References: <87wozry7z4.fsf@javad.com>
        <CAAj3zPxiLxqgnKXth2EZZWwgYhW_cHEcxbM6_BqpzpHR_ipqyQ@mail.gmail.com>
Date:   Tue, 20 Feb 2018 19:23:08 +0300
In-Reply-To: <CAAj3zPxiLxqgnKXth2EZZWwgYhW_cHEcxbM6_BqpzpHR_ipqyQ@mail.gmail.com>
        (G. Sylvie Davies's message of "Mon, 19 Feb 2018 13:39:59 -0800")
Message-ID: <87606rk4ur.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"G. Sylvie Davies" <sylvie@bit-booster.com> writes:

> On Mon, Feb 5, 2018 at 3:46 AM, Sergey Organov <sorganov@gmail.com> wrote:
>> Hello,
>>
>> $ git help cherry-pick
>>
>> -m parent-number, --mainline parent-number
>>            Usually you cannot cherry-pick a merge because you do not
>>            know which side of the merge should be considered the
>>            mainline.
>>
>> Isn't it always the case that "mainline" is the first parent, as that's
>> how "git merge" happens to work?
>>
>
> First-parent will be whatever commit you were sitting on when you
> typed "git merge".

Right, but I believe it's also "mainline", see below.

> If you're sitting on your branch and you type "git fetch; git merge
> origin/master", then "mainline" will be 2nd parent.

No. If you ever want to cherry-pick this commit, it'd still be -m1 side
of it that likely makes sense, and it's exactly the side that makes
sense to be picked that is called "mainline" in the manual page we are
discussing, and there is no any other definition of "mainline" as far as
I can tell.

There is nothing about 'origin/master' that makes it "mainline" from the
POV of future cherry-picks, if any, of this merge commit. I was also
unable to find any git documentation that calls 'origin/master'
"mainline". It's called "remote-tracking branch", or maybe sometimes
"upstream".

OTOH, when one merges something, he often merges "side branch" onto
"mainline", so in the context of this particular merge, your local
"master" happens to be "mainline" and "origin/master" happens to be
"side branch".

> "git revert -m" also has the same problem.

Yes, as it's essentially just "git cherry-pick --reverse -m", provided
cherry-pick has had the "--reverse" from regular "patch" utility [*].

It's also interesting to notice that manual page for "git revert" refers
to the revert-a-faulty-merge How-To, that in turn again uses only "git
revert -m 1".

Overall, it's still a mystery to me why "-m 1" is not the default
behavior for both "git revert" and "git cherry-pick".

The only suspicion I have is that actual intention is to deny picking
merge commits by default. Then, the usual git way would be to use
--force or --enable-merges to overcome the denial, but if we still do
need "-m 2" etc. even rarely, then rather re-using "-m 1" as "I mean it"
indication is only logical.

If my suspicion is true, how about something like this:

-m parent-number, --mainline parent-number
	This option specifies the parent number (starting from 1) of a
	commit and instructs cherry-pick to replay the change relative
	to the specified parent. Cherry-pick will refuse to handle merge
	commits unless this option is given.

Damn, it now has no "mainline" in the description at all, so it's
unclear why it has been called --mainline in the first place, not that
it was somehow clear to me before.

And while we are at it, I just stumbled over "git cherry-pick -m 1"
refusing to handle non-merge commits:

$ git cherry-pick -m1 dd5c320
error: Mainline was specified but commit dd5c320a300520a044cfa73d17f6cbffbbef60ef is not a merge.
fatal: cherry-pick failed
$ 

I wonder whether this is intentional? What's the rationale then? It
seems it could be useful to be able to cherry-pick multiple commits,
some of which are merges, no?

Footnote:

[*] rebase, revert, and cherry-pick all look rather similar in git and
could be calling for some unification.

-- Sergey
