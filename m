Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9A8C2BA2B
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 10:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD992072D
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 10:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgDLKMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 06:12:14 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:65166 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgDLKMO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 06:12:14 -0400
Received: from [92.30.123.115] (helo=[192.168.1.38])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jNZb2-00068z-4S; Sun, 12 Apr 2020 11:12:12 +0100
Subject: Re: configure remote/local as mine/theirs
To:     Johannes Sixt <j6t@kdbg.org>,
        rupert THURNER <rupert.thurner@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CAJs9aZ-iXUtZoumnMzTFPrc=mtz2+s4EDUKhxw_KQp42h3mxBw@mail.gmail.com>
 <facf8152-00ce-4878-a13b-3fe72c13fa25@kdbg.org>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <0360e896-73b9-3585-54a2-5427bfafaae1@iee.email>
Date:   Sun, 12 Apr 2020 11:12:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <facf8152-00ce-4878-a13b-3fe72c13fa25@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert, Johannes

On 11/04/2020 22:40, Johannes Sixt wrote:
> Am 11.04.20 um 14:51 schrieb rupert THURNER:
>> the git documentation is so clear withcalling changes "mine" or
>> "theirs". when configuring a mergetool e.g. kdiff3, and doing a
>> rebase, these names are not used. instead it is "local", which
>> is theirs in the rebase case, and remote, which is mine. not
>> that this is rocket science, and i understand the technical
>> reason why the names are like this. but anyway i get a nod in
>> my brain about it sometimes. can i somehow configure git so it
>> would use "mine" and "theirs" only?
> The words "mine" (actually "ours") and "theirs" have a very precise
> meaning in Git. If you were to use these meanings during a rebase, you
> would not like the result: it would call "ours" what you intend to call
> "theirs", and vice versa.
>
> Consider this history:
>
>
> --a--b--c--d   <-- upstream ("theirs" from your point of view)
>    \
>     x--y--z    <-- branch to rebase ("mine/ours" from your POV)
>
> During a rebase, Git is "positioned" on the history following commit d,
> i.e. on "their" branch. Then it cherry-picks commits x, y, and z. In
> that situation, the change that you consider "theirs" is actually "ours"
> from Git's point of view, and your own change (those introduced by x, y,
> and z) are "theirs" from Git's point of view.
>
> I suggest you live with "local" and "remote" for a bit less confusion.
Robert,
given the way Git is using it's terminology, would you have any
suggestions as to how the man page(s) could now be _clarified_ so as to
avoid these potential misunderstandings? Even perhaps
    "theirs", "ours", "local" and "remote" are distinct terms in Git
with different meanings as detailed in gitreference/glossary.   (or some
such - though 3/4 are not in the glossary!)

I suggest this as a way of flagging to the reader that they should 'stop
and think' (which we never do if we already have the wrong mental model)
and perhaps go and review the distinctions.

--
Philip
