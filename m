From: Thomas Pasch <thomas.pasch@jentro.com>
Subject: Re: git-http-push / webDAV
Date: Tue, 02 Oct 2007 13:15:35 +0200
Organization: Jentro Technologies GmbH
Message-ID: <47022857.806@jentro.com>
References: <4700F6BC.2070701@jentro.com> <20071001155454.GU975@void.codelabs.ru> <47020603.3080000@jentro.com> <20071002085416.GW975@void.codelabs.ru> <470215F6.2060105@jentro.com> <20071002104646.GY975@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Tue Oct 02 13:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcfjC-0006qz-Au
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 13:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbXJBLPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 07:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbXJBLPm
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 07:15:42 -0400
Received: from mail2.infra.net ([212.89.96.7]:1972 "EHLO gamma.m.infra.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752532AbXJBLPl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 07:15:41 -0400
Received: from epsilon.m.infra.net (epsilon.m.infra.net [212.89.96.8])
	by gamma.m.infra.net (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l92BFb57015757;
	Tue, 2 Oct 2007 13:15:37 +0200
Received: from [192.1.1.184] (u19-17.dsl.vianetworks.de [194.231.42.17])
	(authenticated bits=0)
	by epsilon.m.infra.net (8.13.4/8.13.4/Debian-3) with ESMTP id l92BFZwj028687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Oct 2007 13:15:35 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <20071002104646.GY975@void.codelabs.ru>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59684>

Dear Eygene,

I used a rather small test repo with only 2 or 3
commits.

The last tests I did with the a (current) git repo clone:

> git clone --bare git://git.kernel.org/pub/scm/git/git.git

e147e54b14828fa2e88e88907e0ca4dc3d694448 has indeed *not*
found its way into the http push repo. For me it looks
like that the push *first* updates refs/heads/master
(successfully) but fails to transfer the object itself.

Perhaps it would be more graceful that the object is
transfered *first* and then the remote tip is updated...

What version of git do you use?

Cheers,

Thomas

Eygene Ryabinkin wrote:
> Thomas,
> 
> Tue, Oct 02, 2007 at 11:57:10AM +0200, Thomas Pasch wrote:
>> well, *somewhat* better with the trailing slash:
>>
>>> echo "modified" >>grep.c
>>> git commit -a
>> Created commit e147e54: mod
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>> git push -v
>> Pushing to http://test@x.x.x.x/git/git.git/
>> Fetching remote heads...
>>   refs/
>>   refs/heads/
>>   refs/tags/
>> updating 'refs/heads/master'
>>   from 34c6dbdef439f7cd93d3fe22493a3c1496ce96f7
>>   to   e147e54b14828fa2e88e88907e0ca4dc3d694448
>>     sending 3 objects
>>     done
>> Updating remote server info
>>
>> There's no more error message.
> 
> OK, that's fine: the previous error was tied to the fact that
> when you're getting /git/git.git from the Web-server, it notices
> that it is a directory and redirects you to the /git/git.git/.
> But (IIRC) curl does not follow such redirections.
> 
>> However, push has still
>> not worked. If I try to check out the new HEAD:
>>
>>> git clone http://test@x.x.x.x/git/git.git/
>> Initialized empty Git repository in /home/tpasch/tmp/git/.git/
>> Getting alternates list for http://test@x.x.x.x/git/git.git
>> Getting pack list for http://test@x.x.x.x/git/git.git
>> Getting index for pack 563e2090185692c7d765775569a0ce986840fd17
>> Getting pack 563e2090185692c7d765775569a0ce986840fd17
>>  which contains 3af9d3e08da868c3a7687ab38d72f4296a99005d
>> [...]
>> walk 24778e335a6450e34257a311d0bf4a12bdb3006c
>> walk 19b2860cba5742ab31fd682b80fefefac19be141
>> walk bf0c6e839c692142784caf07b523cd69442e57a5
>> walk e497ea2a9b6c378f01d092c210af20cbee762475
>> walk 8bc9a0c769ac1df7820f2dbf8f7b7d64835e3c68
>> walk e83c5163316f89bfbde7d9ab23ca2e25604af290
>> Getting alternates list for http://test@x.x.x.x/git/git.git
>> Getting pack list for http://test@x.x.x.x/git/git.git
>> error: Unable to find e147e54b14828fa2e88e88907e0ca4dc3d694448 under
>> http://test@x.x.x.x/git/git.git
>> Cannot obtain needed object e147e54b14828fa2e88e88907e0ca4dc3d694448
> 
> OK, I will try to do this on my server with 2.2.6.  How big
> is your repository?  Both size and commit number.
> 
> Thanks.
