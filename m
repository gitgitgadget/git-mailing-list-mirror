Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112C11F462
	for <e@80x24.org>; Mon, 20 May 2019 22:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfETW2D (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 18:28:03 -0400
Received: from e2i236.smtp2go.com ([103.2.140.236]:40749 "EHLO
        e2i236.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfETW2D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 18:28:03 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 May 2019 18:28:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=m1fbw0.a1-4.dyn; x=1558392182; h=Feedback-ID:
        X-Smtpcorp-Track:Date:Message-ID:From:To:Subject:Reply-To:Sender:
        List-Unsubscribe; bh=XhMlZ45BeThP6CDh60r5D72AMgTqhklPUTGCw7mJgq0=; b=0+DwEyvt
        l1Ygd8SBa7LEet5U7wlhGV0P9VUYTXUxqGlfRu21SsUNMzDcbcwE/PdvsLZ6NnMSrz0z58oKaHB2s
        xUrtkJxTvXlep3FdALK1rKQOGtm4icENnCBlT9ySB+WZDY8UWxewax1AkWIL/8YzhndrgcHJrTzfk
        D/v3ZHvd0UrCf0ydaWk7r7e6vnxe0yGEljCDp2eOJ83i/RZCrnbqeQI5omMrxQgOCrQ6gmOjdgASr
        RLovh8+t0IfjEtjICi+2scnIUFKaXTx/j8/Fbgmtj/j7Jrb7pr4+AlSxgV4RYIX8LvIRQ4m7hOK3J
        6YEEwCDRLigXfHWmoYWLFMH7jQ==;
Received: from [10.176.58.103] (helo=SmtpCorp)
        by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <philipoakley@iee.org>)
        id 1hSqcQ-cp4Wbs-Vl; Mon, 20 May 2019 22:18:54 +0000
Received: from [10.86.143.26] (helo=[10.192.168.1])
        by smtpcorp.com with esmtp (Exim 4.91)
        (envelope-from <philipoakley@iee.org>)
        id 1hSqcQ-9EFR0E-Lb; Mon, 20 May 2019 22:18:54 +0000
Subject: Re: Finer timestamps and serialization in git
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        "Eric S. Raymond" <esr@thyrsus.com>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <20190515233230.GA124956@thyrsus.com> <87woiqvic4.fsf@evledraar.gmail.com>
 <86woimox24.fsf@gmail.com> <20190520004559.GA41412@thyrsus.com>
 <86r28tpikt.fsf@gmail.com> <20190520141417.GA83559@thyrsus.com>
 <20190520164134.6b35b9f9@kitsune.suse.cz>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <2f0ab8c9-adf4-416d-519a-a313de89d5e1@iee.org>
Date:   Mon, 20 May 2019 23:18:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520164134.6b35b9f9@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Smtpcorp-Track: 1hSqcQ9EFR0ELP.45feIah-o
Feedback-ID: 66524m:66524aMf6O2Y:66524sYYiWBYbgo
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 20/05/2019 15:41, Michal Suchánek wrote:
>>   But you were talking as though all those commits
>> have to be modified*after they're in the DAG*, and that's not the case.
>> If any timestamp has to be modified, it only has to happen*once*, at the
>> time its commit enters the repo.
> And that's where you get it wrong. Git is*distributed*. There is more
> than one repository. Each repository has its own DAG
So far so good. In fact it the change to 'distributed' that has ruined 
Eric's Acton stamps that assume that the 'time' came from a single 
central server.
>   that is completely
> unrelated to the other repositories and their DAGs.
This bit will confuse. It is only the new commits in the different 
repositories that are 'unrelated'. Their common history commits are 
identical sha1 values, and the DAG links back to their common root commit(s)
> So when you take
> your history and push it to another repository and the timestamps
> change as the result what ends up in the other repository is not the
> history you pushed. So the repositories diverge and you no longer know
> what is what.
>
If the sender tweaks their timestamps at commit time, then no one 
'knows'. It's just a minor bit of clock drift/slop. But once they have a 
cascaded history which has been published (and used) you are locked into 
that.


As noted previously. The significant change is the loss of the central 
server and the referential nature of it's clock time stamp.


If the action stamp is just a useful temporary intermediary in a 
transfer then cheats are possible (e.g. some randomising hash of a 
definative partr of the commit).


But if the action stamps are meant to be permanent and re-generatable 
for a round trip between a central server change set based server to 
Git, and then back again, repeatably, without divergence, loss, or 
change, then it is not going to happen reliably. To do so requires the 
creation of fixed total order (by design - single clock) from commits 
that are only partially ordered (by design! - DAG rather than multiple 
unsynchronized user clocks).


For backward compatibility Git only has (and only needs 1 second 
resolution).


The multi-decade/century VCS idea of a master artifact and then near 
copies (since koalin and linen drawings, blue prints, ..) with central 
_control_ is being replaced by zero cost perfect replication, 
authentication by hash, with its distribution of control (of artifact 
entry into the VCS) to _users_, from managers. Managers simply select 
and decide on the artifact quality and authorize the use of a hash.


Most folks haven't really looked below the surface of what it is that 
makes GIT and DVCS so successful, and it's not just the Linus effect. 
The previous certainties (e.g. the idea of a total order to allow 
logging by change-set) have gone.

--

Philip

