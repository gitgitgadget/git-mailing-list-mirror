From: bugs@innuce.ch
Subject: Re: Possible Bug in git-http-push
Date: Sun, 12 Apr 2015 12:24:42 +0200
Message-ID: <552A47EA.2060909@innuce.ch>
References: <5527B0D6.3010608@innuce.ch> <55280064.5070909@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 12 12:25:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhF4x-0001BM-Nm
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 12:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbbDLKZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 06:25:10 -0400
Received: from mail.innuce.ch ([80.254.167.118]:43927 "EHLO mail.innuce.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbbDLKZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 06:25:09 -0400
Received: from [192.168.0.17] ([217.162.197.169]:5683)
	by mail.innuce.ch ([10.13.0.2]:25) with [XMail 1.27 SSLtag 0.2 ESMTP Server] (using TLSv1/SSLv3 with cipher=DHE-RSA-AES128-SHA 128 bits)
	id <SA4E76> for <git@vger.kernel.org> from <bugs@innuce.ch>;
	Sun, 12 Apr 2015 12:24:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <55280064.5070909@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267048>

Am 10.04.2015 um 18:55 schrieb Thomas Braun:
> Am 10.04.2015 um 13:15 schrieb Stefan:
>> Hello List
>>
>> I possibly found a bug in git-http-push:
>>
>> When I push my local repo via http secured with basic authorization,
>> then i get:
>>
>> error: Cannot access URL https://example.ch/example_repo/, return code 22
>> fatal: git-http-push failed
>> Pushing to https://example.ch/example_repo/
>>
>> My server log gives PROPPFIND 401, so i seems that the PROPPFIND-sent
>> by git-http-push does not use supplied username/pw via prompt
>>
>> Pulling works without problems.
>>
>> When I change remote URL to
>> https://user:password@example.ch/example_repo, pushing works.
>>
>> I'm using git version 1.9.5.msysgit.1
> Hi Stefan (CC'ing the msysgit list as this might be windows specific),
>
> can you determine the last version which worked?
>
> And can you create a minimal working example for us to reproduce the
> problem?
>
> We already have a couple of problems with the new curl version together
> with our ancient openssl.
>
> Thomas
>
>
Hi Thomas

I stuck on this problem because i moved my git-server and did some
reconfiguring.

Here an working config

[core]
    repositoryformatversion = 0
    filemode = false
    bare = false
    logallrefupdates = true
    symlinks = false
    ignorecase = true
    hideDotFiles = dotGitOnly
[remote "origin"]
    url = https://user:passwort@git.example.ch/project
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
    remote = origin
    merge = refs/heads/master

And here an non-working one:

[core]
    repositoryformatversion = 0
    filemode = false
    bare = false
    logallrefupdates = true
    symlinks = false
    ignorecase = true
    hideDotFiles = dotGitOnly
[remote "origin"]
    url = https://git.example.ch/project
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
    remote = origin
    merge = refs/heads/master

Hope this helps

Greetz
Stefan
