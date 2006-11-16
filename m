X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: multi-project repos (was Re: Cleaning up git user-interface warts)
Date: Thu, 16 Nov 2006 18:40:56 +0100
Message-ID: <455CA2A8.5010700@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org> <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 17:41:43 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 57
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31604>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GklEu-0003HK-RL for gcvg-git@gmane.org; Thu, 16 Nov
 2006 18:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162057AbWKPRlY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 12:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162060AbWKPRlY
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 12:41:24 -0500
Received: from main.gmane.org ([80.91.229.2]:3255 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162057AbWKPRlX (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 12:41:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GklEk-0003Ee-MH for git@vger.kernel.org; Thu, 16 Nov 2006 18:41:18 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 16 Nov 2006 18:41:18 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 16 Nov 2006 18:41:18
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds escreveu:
> 
> On Thu, 16 Nov 2006, Han-Wen Nienhuys wrote:
>> Actually, only a 2 weeks ago, you suggested that I share the website
>> and main source code for my project in a single repository for reasons
>> of organization.
>>
>> In this setup I find it logical to do
>>
>>   git init-db
>>   git pull ..url.. website/master
> 
> I don't disagree per se. It should be easy to support, it's just that it's 
> not traditionally been something we've ever done.
> 
> So the way you'd normally set up a single repo that contains multiple 
> other existing repositories is to basically start with one ("git clone") 

You're misunderstanding me: the multi-repo is at git.sv.gnu.org is the
remote one. The example I gave was about locally creating a single
project repo from a remote multiproject repo. 

On a tangent: why is there no reverse-clone?  I have no shell access
to the machine, so when I created the remote repo, I had to push, and
ended up putting 1.2 Gb data on the server.

<looks at manpage>

is this send-pack? From UI perspective it would be nice if this could
also be done with clone,

  git clone . ssh+git://....

>And that "git pull" semantic actually means that if you want a _bare_ 
>repository, I think "git --bare init-db" + "git --bare fetch" actually

yes, this works. Two remarks:


* it needs

  website/master:master

otherwise you still don't have a branch.

* why are objects downloaded twice?  If I do

  git --bare fetch git://git.sv.gnu.org/lilypond.git web/master

it downloads stuff, but I don't get a branch. If I then do 

  git --bare fetch git://git.sv.gnu.org/lilypond.git web/master:master

it downloads the same stuff again. 

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
