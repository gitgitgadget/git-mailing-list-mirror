X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ben Greear <greearb@candelatech.com>
Subject: Re: Question on multi-level git repository heiarchy.
Date: Fri, 27 Oct 2006 07:05:02 -0700
Organization: Candela Technologies
Message-ID: <4542120E.1050903@candelatech.com>
References: <45419529.3010207@candelatech.com> <20061027052517.GB29057@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 14:05:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
In-Reply-To: <20061027052517.GB29057@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30327>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdSJP-0008Ll-Oz for gcvg-git@gmane.org; Fri, 27 Oct
 2006 16:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946471AbWJ0ODl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 10:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946473AbWJ0ODl
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 10:03:41 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:54972 "EHLO
 ns2.lanforge.com") by vger.kernel.org with ESMTP id S1946471AbWJ0ODk (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 10:03:40 -0400
Received: from [71.112.210.101] (pool-71-112-210-101.sttlwa.dsl-w.verizon.net
 [71.112.210.101]) (authenticated bits=0) by ns2.lanforge.com (8.13.4/8.13.4)
 with ESMTP id k9RE3cqf029464; Fri, 27 Oct 2006 07:03:38 -0700
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Ben Greear <greearb@candelatech.com> wrote:
>   
>> I want to create an intermediate level..something like:
>>
>> kernel.org git tree
>>       |
>> my git master tree
>> /                          \
>> work-station-1   work-station-2  ....
>>     
>  
>   
>> I then did a git  checkout -f master on the
>> pub server and did a pull from the upstream kernel.
>> This seemed to work fine.
>>     
>
> Ah, what you really want here is to make your "my git master tree"
> a bare repostiory and use fetch instead of pull.  This way you
> don't need to maintain a working directory of files associated
> with that repository.  So assuming you have "mygitmastertree"
> as the directory do:
>
> 	mv mygitmastertree/.git mygitmastertree.git
> 	rm -rf mygitmastertree
>
> and update your workstation .git/remotes/origin files such
> that the URL line reads ".../mygitmastertree.git" rather than
> ".../mygitmastertree/.git".
>
> Then to update "mygitmastertree" with recent changes you can use
> git fetch rather than git pull:
>
> 	git --git-dir mygitmastertree.git fetch
>   

Ok, I made those changes...
>  
>   
>> Then, on the work-station, I did a git checkout -f master, and also did 
>> a pull.
>> In this case, it seems that it is trying to merge with changes in the 
>> lf_v2.6.18 branch
>> instead of the the main 'master' tree (see below).
>>     
>
> When you use "git pull" with no additional arguments the first
> branch listed in a Pull: line of .git/remotes/origin will be the
> branch merged into the current branch.  I don't know what that
> branch is listed as in your workstation tree but from what you
> described it sounds like it may be that lf_v2.6.18 branch, which
> is why its trying to merge it.
>   
That is certainly not intuitive.

I want to synchronize the entire git repo, including all branches.  How 
would I go
about doing that?

Is there any way to recover my currently mangled tree on the 
workstation, or do I need
to start fresh there?  If I start fresh, do I re-clone, or is there some 
better way to get
the synchronization that I want?

Thanks,
Ben



-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com

