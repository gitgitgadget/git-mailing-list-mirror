Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72D1620A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 11:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeLLLSQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 06:18:16 -0500
Received: from mail.javad.com ([54.86.164.124]:43918 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeLLLSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 06:18:16 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 9889C3EC2C;
        Wed, 12 Dec 2018 11:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1544613495;
        bh=qgCJRvkOYJZaOC1A5y1ImwERUvTiRcqf738oCsUUXxg=; l=1169;
        h=Received:From:To:Subject;
        b=aL9qSlfrJhfA7m2SA2NrS828WtGSLA+i+lnyea/9g1uPidqP5iPOwm0X7Fmsgh/jQ
         TKCEGwCADYS/wC49ccisFgo93ijjyNENvIHdthOk39NwmP0QTyKG3bu7fDxEP9/4/A
         2LG/lrz7Z9Yca0rJJerai/AWauKHWjODSm0GopCA=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1gX2Wr-00031L-RU; Wed, 12 Dec 2018 14:18:13 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Minor(?) usability issue with branch.<name>.pushRemote
References: <871s6n43ng.fsf@javad.com>
        <xmqqh8fjhy8k.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 12 Dec 2018 14:18:13 +0300
In-Reply-To: <xmqqh8fjhy8k.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 12 Dec 2018 18:48:27 +0900")
Message-ID: <87d0q72du2.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> So, finally, it's 'branch.linux.pushremote' that is the "offender".
>>
>> Looks like both 'git status' and 'git branch -vv' should somehow learn
>> about 'branch.<name>.pushremote' feature so that their
>> output/suggestions make more sense?
>
> Doesn't "ahead of X by N" mean "you forked from X and built N commits
> on top", not "you have N commits that is not in X which is where you
> would push to"?

Sure, but the problem is that 'git status' gives exact suggestion:

 (use "git push" to publish your local commits)

that is somewhat misleading in this particular case ('git push' is now a
no-op), and then 'git branch -vv', while tells me relationship to
"upstream", keeps silence about non-matching push destination.

To add even more complexity to the case, notice that the first time
after I committed locally, the invocation of 'git push' (exactly as
suggested by 'git status') did successfully push those two commits, so
the suggestion is exactly right before the commits are pushed, yet
is rather misleading afterwards.

-- 
Sergey
