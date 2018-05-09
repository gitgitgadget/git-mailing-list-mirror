Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F291F424
	for <e@80x24.org>; Wed,  9 May 2018 19:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965317AbeEIT11 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 15:27:27 -0400
Received: from smtp74.ord1c.emailsrvr.com ([108.166.43.74]:37149 "EHLO
        smtp74.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964972AbeEIT10 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 May 2018 15:27:26 -0400
Received: from smtp18.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp18.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 56585E0238;
        Wed,  9 May 2018 15:27:25 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp18.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id DA5C1E0281;
        Wed,  9 May 2018 15:27:24 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 09 May 2018 15:27:25 -0400
Subject: Re: Is rebase --force-rebase any different from rebase --no-ff?
To:     Stefan Beller <sbeller@google.com>,
        Ilya Kantor <iliakan@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAFU8umjyrJc1m65hu6QMQUiNmsJtbV65tovcWjvmzFpsCr668A@mail.gmail.com>
 <CAGZ79kb05U91_Ku7DKuwQVCrtouYwGWTCPdJFQ=bgWo91inRGA@mail.gmail.com>
Cc:     git <git@vger.kernel.org>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <98279912-0f52-969d-44a6-22242039387f@xiplink.com>
Date:   Wed, 9 May 2018 15:27:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb05U91_Ku7DKuwQVCrtouYwGWTCPdJFQ=bgWo91inRGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-05-09 02:21 PM, Stefan Beller wrote:
> +cc Marc and Johannes who know more about rebase.
> 
> On Wed, May 9, 2018 at 9:01 AM, Ilya Kantor <iliakan@gmail.com> wrote:
>> Right now in "git help rebase" for --no-ff:
>> "Without --interactive, this is a synonym for --force-rebase."
>>
>> But *with* --interactive, is there any difference?
> 
> I found
> https://code.googlesource.com/git/+/b499549401cb2b1f6c30d09681380fd519938eb0
> from 2010-03-24

In the original discussion around this option [1], at one point I 
proposed teaching rebase--interactive to respect --force-rebase instead 
of adding a new option [2].  Ultimately --no-ff was chosen as the better 
user interface design [3], because an interactive rebase can't be 
"forced" to run.

At the time, I think rebase--interactive only recognized --no-ff.  That 
might have been muddled a bit in the migration to rebase--helper.c.

Looking at it now, I don't have a strong opinion about keeping both 
options or deprecating one of them.

		M.

[1] https://public-inbox.org/git/4B9FD9C1.9060200@xiplink.com/t/
[2] 
https://public-inbox.org/git/1269361187-31291-1-git-send-email-marcnarc@xiplink.com/
[3] https://public-inbox.org/git/7vzl1yd5j4.fsf@alter.siamese.dyndns.org/


>      Teach rebase the --no-ff option.
> 
>      For git-rebase.sh, --no-ff is a synonym for --force-rebase.
> 
>      For git-rebase--interactive.sh, --no-ff cherry-picks all the commits in
>      the rebased branch, instead of fast-forwarding over any unchanged commits.
> 
>      --no-ff offers an alternative way to deal with reverted merges.  Instead of
>      "reverting the revert" you can use "rebase --no-ff" to recreate the branch
>      with entirely new commits (they're new because at the very least the
>      committer time is different).  This obviates the need to revert the
>      reversion, as you can re-merge the new topic branch directly.  Added an
>      addendum to revert-a-faulty-merge.txt describing the situation and how to
>      use --no-ff to handle it.
> 
> which sounds as if there is?
> 
> Stefan
> 
