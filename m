Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84099C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 09:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662DA20757
	for <git@archiver.kernel.org>; Fri, 22 May 2020 09:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgEVJ55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 05:57:57 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:14394 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgEVJ5z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 05:57:55 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jc4R6-00069B-7y; Fri, 22 May 2020 10:57:52 +0100
Subject: Re: How do Git on Linux users launch/read the user-manual?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <8142f64b-9b5e-3637-21a2-3671dd65a42e@iee.email>
 <xmqqtv0athz5.fsf@gitster.c.googlers.com>
 <6dd15666-1e3e-e9b2-d98b-396d58f241cd@iee.email>
 <xmqqpnaytb31.fsf@gitster.c.googlers.com>
 <ecac8516-e536-80e8-fc72-098406592fd5@iee.email>
 <xmqqzha1q6co.fsf@gitster.c.googlers.com>
 <xmqqv9korkg0.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <da31577b-88d2-9f72-0c76-9f6474dc4e83@iee.email>
Date:   Fri, 22 May 2020 10:57:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9korkg0.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 21/05/2020 23:29, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Or are you saying that nobody on Linux uses the html format?  I
>> should stop keeping the git-htmldocs.git repository up to date,
>> if that is the case, but I suspect it is not.
>> ...
>> Or are you volunteering to update the mark-up (if necessary) so that
>> user-manual would become part of "man" ("man git-user-manual",
>> perhaps) suite?  That would be an excellent suggestion.
No, I wasn't volunteering to update the user-manual to man format ;-)

I had previously suggested that an intermediate man page could provide
the user link to the user-manual proper [1] but it wasn't really accepted.

> Having said that, I am not sure the way the material covered by the
> user-manual is presented in is a good match for the manpage format
> in the first place. 
True. A man page has a different focus.

>  Don't modern manpage viewers, or generic pagers
> that can display textual contents (which may happen to be the "man 1
> git" output), or even a terminal enumrator that may happen to be
> showing the output of such a pager, notice a URL and allow users to
> activate on it (i.e. visit the HTML document the URL points at, by
> opening the URL in an already-running browser, or in a new instance
> of a browser)?
This was the same question I was asking at the beginning (given that I'm
97.7% on Windows). Would a modern man viewer, if given the none existent
user-manual man page path, try for the an html equivalent - I'm not
thinking it does:

root@Philip-Win10:~# git help git             #works!

root@Philip-Win10:~# git help user-manual
No manual entry for gituser-manual
root@Philip-Win10:~#

(WSL - Ubuntu - git v2.23.0)

>   So perhaps a better solution for those who live in a
> text terminal and view our documentation via "git help -m git" or
> even "man git" would be to write a full URL to reach a version of
> user manual available to the user, perhaps with file:/// URL "as
> text" in the man output?  Then you do not have to reformat the user
> manual in the manpage format or anything silly like that.
>
> Hmm?
Maybe the help code (when using the -m code path) should test for the
man file existence first, and revert to the -w code path as a fall back
(with warning/advice)?  Just a thought.

It could provide a fall through for lots of other potential html help
files, when stored in the correct path (if that's sensible for the
various OS usages).

--
Philip

[1]
https://lore.kernel.org/git/5561391C5EED4114A90C35518558A267@PhilipOakley/T/#u
