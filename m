From: Andreas Ericsson <ae@op5.se>
Subject: Re: question concerning branches
Date: Thu, 20 Aug 2009 09:33:24 +0200
Message-ID: <4A8CFC44.8050707@op5.se>
References: <4a8c4ece@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ingo Brueckl <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 09:33:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me29X-0000Dv-G8
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 09:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbZHTHdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 03:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbZHTHdb
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 03:33:31 -0400
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:35089 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753953AbZHTHd3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2009 03:33:29 -0400
Received: from source ([209.85.219.223]) by na3sys009aob110.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSoz8SJtNBYg1wn1eXK5FGmuu2Fgo6tfv@postini.com; Thu, 20 Aug 2009 00:33:31 PDT
Received: by ewy23 with SMTP id 23so5041991ewy.32
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 00:33:27 -0700 (PDT)
Received: by 10.210.136.15 with SMTP id j15mr6653988ebd.21.1250753607901;
        Thu, 20 Aug 2009 00:33:27 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 7sm1022792eyg.45.2009.08.20.00.33.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 00:33:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4a8c4ece@wupperonline.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126610>

Ingo Brueckl wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> This is one of the most useful features.
> 
> Wow. I'm sursprised to hear that, because I consider it at the moment as a
> very strange one.
> 
>> For example, it is an essential
>> part of supporting the workflow described here:
>>     http://gitster.livejournal.com/25892.html
> 
> Here is what I'd expect to do with git (described with my own words, not in
> git commands):
> 
> 1. commit the quick fix to the release branch
> 2. push this single commit to origin and master
> 
> Now that all branches have the commit a later push and pull should notice
> this and "skip" it.
> 
> This leads to a second question I have. Assuming I have three patches in my
> repo (#1, #2 and #3), is it possible to push only #2 (because it is a
> quick fix) and later, maybe after I committed #4, the rest, i.e. #1, #2 and
> #4?
> 

If they're on different branches, yes. If they're on the same branch, no.
This is because a commit in git is named uniquely not only by its contents,
but also by its ancestry.

You can, however, run "git rebase --interactive" and re-order the commits
before you push them, so that #2 becomes #1 and vice versa. Then you can
push only #1 (the old #2) while leaving #2 (the old #1), #3 and #4 on
your machine only. This involves knowing the commit identifier of #1
though. Assuming it's "deadbeef", you can update the remote branch "foo"
to hold your new commit by running the following command:

  git push <remote> deadbeef:refs/heads/foo

HTH

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
