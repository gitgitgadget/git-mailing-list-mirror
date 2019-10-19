Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5B41F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 15:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfJSPTI (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 11:19:08 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:29358 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfJSPTI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 11:19:08 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iLqVU-0003x1-C7; Sat, 19 Oct 2019 16:19:05 +0100
Subject: Re: [PATCH v1] config/branch: state that <name>.merge is the remote
 ref
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GitList <git@vger.kernel.org>
References: <20191016112822.1701-1-philipoakley@iee.email>
 <xmqqwod26dp7.fsf@gitster-ct.c.googlers.com>
 <c96f4dbd-ebc6-b743-716e-e1e17333c06b@iee.email>
 <xmqq8sphodi6.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <1060efbc-8776-b14c-a1a6-36c03c917059@iee.email>
Date:   Sat, 19 Oct 2019 16:19:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq8sphodi6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,
On 19/10/2019 00:11, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> branch.<name>.merge::
>>      Defines, for the local branch <name>, the upstream branch ref
>>      _on the remote_ (as given by branch.<name>.remote).
>>      The upstream ref may be different from the local branch ref.
>>
>> optionally s/different from/ same as/ ?
> That "optionally" part is exactly why I said "upstream and remote
> tracking names may or may not differ is irrelevant information".
I think we misunderstand each other again. That very potential 
difference, no matter which way described, was the point at hand - that 
is we are talking about refs at different places.

If we have (quite typically) that merge config indicating that we wish 
to merge refs/heads/master with refs/heads/master then it looks like a 
no-op. They are both the same ref (by name / character sequence). 
Without the extra knowledge that one is local and the other is remote 
then the mental model confusion in the reader continues. The 
'optionally' offer was about choosing the best way of coercing the 
reader into considering the alternate viewpoint. Sometime things  need 
to explained both ways, so that at least one will register.

It could be argued that the merge ref should have been 
`refs/remotes/origin/master` (for that typical following case), but it 
isn't (IIUC because of historic backward compatibility), which would 
have at least avoided the local  v remote conundrum.

All that said, I ended up going with your suggested text anyway ;-)
>>>       The name of the branch at the remote `branch.<name>.remote` that
>>>       is used as the upstream branch for the given branch.  It tells
>>>       `git fetch`, etc., which branch to merge and ...
>>>
>> If this, should we also say it (the key value) is that of the upstream
>> branch _ref_?
> Yeah, that makes it clear that readers should not write "master" and
> use "refs/heads/master" instead.  It may even be more (technically)
> correct to say just "ref" without branch (this ref does not have to
> be a branch at the remote repository at all).  I am not sure if we
> want to go that far to make it more correct and also make it hint
> that using a non-branch ref is a valid configuration to readers, but
> I agree it is a good idea to avoid saying "name" (which implies
> that "master" is OK, which is not).
I'd agree. I'll think about the simplified ref comment.

P.


