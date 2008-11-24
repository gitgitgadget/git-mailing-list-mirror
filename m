From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn and svnsync
Date: Mon, 24 Nov 2008 18:15:41 +0100
Message-ID: <492AE13D.5070102@drmicha.warpmail.net>
References: <48F6F631.90709@icyb.net.ua> <492AA464.5070404@icyb.net.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andriy Gapon <avg@icyb.net.ua>
X-From: git-owner@vger.kernel.org Mon Nov 24 18:17:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4f3Y-0006Qn-Ra
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 18:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbYKXRPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 12:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbYKXRPt
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 12:15:49 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53089 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753288AbYKXRPs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2008 12:15:48 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 4ECAB1668A6;
	Mon, 24 Nov 2008 12:15:45 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 24 Nov 2008 12:15:45 -0500
X-Sasl-enc: p5tsODtAoVb7ywuseAn2aCp/9zF/eZhc777knhDTKQL5 1227546944
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 917A72DC00;
	Mon, 24 Nov 2008 12:15:44 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <492AA464.5070404@icyb.net.ua>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101617>

Andriy Gapon venit, vidit, dixit 24.11.2008 13:56:
> on 16/10/2008 11:07 Andriy Gapon said the following:
>> I did the following:
>> 1. mirror svn repository using svnsync
>> 2. clone the mirror with git-svn --use-svnsync-props and some tweaking[*]
>> 3. run git svn info in the clone
>> 4. get error "Unable to determine upstream SVN information from working
>> tree history"
>>
>> git svn log and git svn rebase do not work either.
>> git log does work.
>>
>> I have git version 1.6.0.2 (from FreeBSD ports).
>> [*] About the tweaking - I manually massaged config file to get the
>> branches I was interested in, so .git/config is this:
>> [core]
>>         repositoryformatversion = 0
>>         filemode = true
>>         bare = false
>>         logallrefupdates = true
>> [svn-remote "svn"]
>>         useSvnsyncProps = 1
>>         url = file:///system/devel/svn/base
>>         fetch = head:refs/remotes/trunk
>>         fetch = stable/6:refs/remotes/stable_6
>>         fetch = stable/7:refs/remotes/stable_7
>>         fetch = releng/6.3:refs/remotes/releng_6_3
>>         fetch = releng/6.4:refs/remotes/releng_6_4
>>         fetch = releng/7.0:refs/remotes/releng_7_0
>>         fetch = release/6.3.0:refs/remotes/release_6_3_0
>>         fetch = release/7.0.0:refs/remotes/release_7_0_0
>>
>> This is .git/svn/.metadata:
>> ; This file is used internally by git-svn
>> ; You should not have to edit it
>> [svn-remote "svn"]
>>         reposRoot = file:///system/devel/svn/base
>>         uuid = ccf9f872-aa2e-dd11-9fc8-001c23d0bc1f
>>         svnsync-uuid = ccf9f872-aa2e-dd11-9fc8-001c23d0bc1f
>>         svnsync-url = svn://svn.freebsd.org/base
>>
>> So you can see the original svn repository URL.
>>
>> git log reports svn info like the following:
>> git-svn-id: svn://svn.freebsd.org/base/stable/7@183898
>> ccf9f872-aa2e-dd11-9fc8-001c23d0bc1f
>>
>> It seems that the problem is that the code in find_by_url() and/or
>> read_all_remotes() subroutines (in git-svn.perl) are not aware of
>> svnsync and do not realize an URL in logs and URL in svn-remote are
>> different.
>> BTW, I see that there is some special svm logic in read_all_remotes.
>>
>> Thank you very much for any help in advance.
>>
> 
> Anyone?
> I wonder if this is my local problem/misconfiguration or an issue with
> git-svn.

Same happens here, so it's a general issue ;)

I think I encountered that before and ended up experimenting with
git-svn cloning from a svnsync source until I found the final config,
with which I git-svn cloned directly from upstream, so that I had to
wait only twice.

Michael
