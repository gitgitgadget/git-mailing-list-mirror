X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 13:16:37 +0100
Message-ID: <456ECBA5.7010409@op5.se>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 12:19:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200611292000.23778.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32728>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpksW-0001qu-N0 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 13:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936309AbWK3MQy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 07:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936314AbWK3MQx
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 07:16:53 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:19144 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S936310AbWK3MQj (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 07:16:39 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 393CB6BCC1; Thu, 30 Nov 2006 13:16:38 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> On Wednesday 2006, November 29 16:03, Martin Waitz wrote:
> 
  >>  - when updating the supermodule, you have to take care that your
>>    submodules are on the right branch.
>>    You might for example have some testing-throwawy branch in one
>>    submodule and don't want to merge it with other changes yet.
> 
> What is the "right" branch though?  As I said above, if you're tracking one 
> branch in the submodule then you've effectively locked that submodule to that 
> branch for all supermodule uses.  Or you've made yourself a big rod to beat 
> yourself with everytime you want to do some development on an "off" branch on 
> the submodule.
> 

Perhaps I'm just daft, but I fail to see how you can safely track a 
topic-branch that might get rewinded or rebased in the submodule without 
crippling the supermodule. Wasn't the intention that the supermodule has 
a new tree object (called "submodule") that points to a commit in the 
submodule from where it gets its tree and stuff? Is the intention that 
the supermodule pulls all of the submodules history into its own ODB? If 
so, what's the difference between just having one large repository. If 
not, how can you make it not break in case the commit it references in 
the submodule is pruned away?

One possible way would ofcourse be to add something like this to the 
supermodule commit:
submodule directory/commit-sha1
tree submodule-tree-sha1

but then you're in trouble because the supermodule will have the same 
files as all the submodules stored in its own tree. I'm confused. Could 
someone shed some light on how this sub-/super-module connection is 
supposed to work in the supermodule's commit objects?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
