From: Justin Frankel <justin@cockos.com>
Subject: Re: RFC: checkout/temporary branch switch restoring modification
 times
Date: Mon, 04 Oct 2010 10:20:52 -0400
Organization: Cockos Incorporated
Message-ID: <4CA9E2C4.2040500@cockos.com>
References: <4CA95B18.5090008@cockos.com> <20101004051148.GG24884@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 16:21:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2luZ-0005rR-1F
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 16:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175Ab0JDOU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 10:20:57 -0400
Received: from mail.cockos.com ([204.11.104.234]:60416 "EHLO mail.cockos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756146Ab0JDOU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 10:20:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.cockos.com (Postfix) with ESMTP id BDA65EC48A;
	Mon,  4 Oct 2010 07:22:05 -0700 (PDT)
X-Virus-Scanned: amavisd-new at mail.cockos.com
Received: from mail.cockos.com ([127.0.0.1])
	by localhost (mail.cockos.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dOPgDSNgAz9p; Mon,  4 Oct 2010 07:22:05 -0700 (PDT)
Received: from [192.168.2.42] (cpe-74-66-229-188.nyc.res.rr.com [74.66.229.188])
	by mail.cockos.com (Postfix) with ESMTPSA id E2327EC490;
	Mon,  4 Oct 2010 07:22:04 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20101004051148.GG24884@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158055>

Jonathan Nieder wrote:
> Hi,
> 
> Justin Frankel wrote:
> 
>> git cop master
>> ; build
>> git cop some-branch-that-affects-lots-of-files
>> ; edit some things, commit
>> git cop master
>> ; build (fast, nothing changed)
> 
> Interesting.  I guess the intended use is that you only ever build
> on the master branch?
> 

The idea is that you're often building on a particular branch, but want 
to switch to another branch temporarily to either do a quick edit or to 
browse some code.

> Have you ever tried the contrib/workdir/git-new-workdir script?
> I find it fits the use case well for me:
> 
>  git clone $repo
>  cd repo
>  make
>  # oh, shoot! I need to try something out real quick.
>  cd ..
>  git new-workdir repo repo2 origin/master
>  cd repo2
>  git am patch-to-test
>  make
>  # okay, back to what I was doing...
>  cd ../repo
> 
> Maybe it could be helpful for you, too?
> 
> Limitations:
> 
>  - requires a file system with support for symbolic links
>    (I think Pierre Habouzit and Junio discussed changing
>    that);
> 
>  - workdirs share refs.  If you update master in one
>    workdir and another workdir also has master checked
>    out, the new changes will appear as staged changes.
> 
>  - workdirs do not share HEAD.  "git gc" from one
>    workdir can completely trash another if it has a
>    detached HEAD pointing to a commit that is not part
>    of any local or remote branch.


Ahh, that would be great.  Unfortunately my filesystem often doesn't 
support symlinks...

-Justin
