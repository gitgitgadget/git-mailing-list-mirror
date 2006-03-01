From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Wed, 01 Mar 2006 10:40:01 +0100
Message-ID: <44056BF1.6000109@op5.se>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <20060227184641.GA21684@hand.yhbt.net> <20060227185557.GA32142@delft.aura.cs.cmu.edu> <20060227192422.GB9518@hand.yhbt.net> <46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com> <Pine.LNX.4.64.0602271634410.22647@g5.osdl.org> <20060301065138.GC21684@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 10:40:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FENob-0002TB-2q
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 10:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWCAJkE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 04:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWCAJkE
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 04:40:04 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:26822 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932665AbWCAJkC
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 04:40:02 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id C64336BD00; Wed,  1 Mar 2006 10:40:01 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060301065138.GC21684@hand.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16969>

Eric Wong wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>>
>>On Tue, 28 Feb 2006, Martin Langhoff wrote:
>>
>>>git-svn-HEAD "moves" so it's really a bad idea to have it as a tag.
>>>Nothing within core git prevents it from moving, but I think that
>>>porcelains will start breaking. Tags and heads are the same thing,
>>>except that heads are expected to change (specifically, to move
>>>forward), and tags are expected to stand still.
>>
>><snipped>
>>Using a "refs/remotes" subdirectory makes tons of sense for something like 
>>this. Or something even more specific, like "refs/svn-tracking/". Git 
>>shouldn't care - all the tools _should_ work fine with any subdirectory 
>>structure.
> 
> 
> Git tools only work as long as the 'refs/{remotes,svn-tracking,...}/'
> prefix is specified.  git-svn-HEAD (or any $GIT_SVN_ID-HEAD) does get
> specified from the command-line quite often:
> 	
> 	git checkout -b mine git-svn-HEAD
> 	git-log git-svn-HEAD..head
> 	git-svn commit git-svn-HEAD..mine
> 	git-log mine..git-svn-HEAD
> 
> Should rev-parse be taught to be less strict and look for basenames
> that can't be found in heads/ and tags/ in other directories?
> 

It already does. The search order is this, for a ref named 'foo':
	$GIT_DIR/foo
	$GIT_DIR/refs/foo
	$GIT_DIR/refs/tags/foo
	$GIT_DIR/refs/heads/foo

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
