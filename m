Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47AF31F954
	for <e@80x24.org>; Mon, 20 Aug 2018 10:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeHTNij (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 09:38:39 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:62564 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTNii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 09:38:38 -0400
Received: from [192.168.2.201] ([92.22.43.193])
        by smtp.talktalk.net with SMTP
        id rhLQf55zCoI6LrhLRf6QQz; Mon, 20 Aug 2018 11:23:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1534760614;
        bh=OzTUA9GSXRpkJYSU1UUogJpPz2x4bdU2NvbrFdMMlT4=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=AJ2NQgIGnottNZKN88EL+bGAAR8zIjoFY1/i+i2M3MDXaRi3INlvcH4kAS/xqzfzA
         Yd7DaTfoXYJhlEWJHyc2NVv4nC0KSqxus3WtTheMPIHzfdXXH2O/to2eefLhJYPpRM
         DFNgqpoOnjb6koXF3C/jglPh+qNQWA7zQ1kkR78Q=
X-Originating-IP: [92.22.43.193]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=0uAVYj1wOgJByxYeJIV+0Q==:117
 a=0uAVYj1wOgJByxYeJIV+0Q==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=nN7BH9HXAAAA:8 a=G-sI35Mni8sQ33JZkVUA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <7b340c01-f57d-1a71-e4d5-0346bb042d0c@talktalk.net>
Date:   Mon, 20 Aug 2018 11:23:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHe8QuCHqyJ/MpkCItK+85c0N+jWM9yislvt8JR97qNNw0LoV6UAxBEELqv5dv28mXljpRDpybWF53vt5LNL8llvt7c9357Hlpp7UNFuniRqKDDYTtvS
 XxT26sEXipekY+kEkWmYDJLMQANRRk24TKyCFPvapUbjwAGuSXIzPwjNKFbVg/zzledwSj8LsFOleBczjgDvJvWleYjisq8OtILPIMFlP/BU15KxoXk3SNjG
 d0q5VsOt4hWe9XfE1j9e0vi9ndX3DlsFHMbLoeC75pTw/ehQtIg10DznebppBzDD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/2018 23:44, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.

> * pw/rebase-i-author-script-fix (2018-08-07) 2 commits
>  - sequencer: fix quoting in write_author_script
>  - sequencer: handle errors from read_author_ident()
> 
>  Recent "git rebase -i" update started to write bogusly formatted
>  author-script, with a matching broken reading code.  These are
>  being fixed.
> 
>  Undecided.
>  Is it the list consensus to favor this "with extra code, read the
>  script written by bad writer" approach?

I think there was agreement between myself and Eric on the last version,
I'm not sure anyone else has expressed an opinion. The problem with
fixing the quoting without any backwards compatibility is that if git is
upgraded while a rebase is stopped read_author_script() will happily use
the broken quoting to create a corrupted author name in the new commit
if the name contains "'".

The compatibility code in the latest version relies on the missing "'"
at the end of the GIT_AUTHOR_DATE line which is fixed by
es/rebase-i-author-script-fix which is now in master. If there is a
release with es/rebase-i-author-script-fix but not
pw/rebase-i-author-script-fix we'll have to rethink as the detection
wont be reliable. I have a branch that fixes read_author_script() to use
sq_dequote() at
https://github.com/phillipwood/git/commits/wip/fix-author-script. At the
moment it has compatibility with broken quoting, but I could strip that
out and then sq_dequote() will return an error with the broken quoting
and the user would have to restart the rebase. So one option is to drop
this series and wait for me to finish the improved solution next month.

> 
> * pw/add-p-select (2018-07-26) 4 commits
>  - add -p: optimize line selection for short hunks
>  - add -p: allow line selection to be inverted
>  - add -p: select modified lines correctly
>  - add -p: select individual hunk lines
> 
>  "git add -p" interactive interface learned to let users choose
>  individual added/removed lines to be used in the operation, instead
>  of accepting or rejecting a whole hunk.
> 
>  Will hold.
>  cf. <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
>  I found the feature to be hard to explain, and may result in more
>  end-user complaints, but let's see.

Thanks, I'll send some follow up patches to improve the help and
documentation next month.

Best Wishes

Phillip
