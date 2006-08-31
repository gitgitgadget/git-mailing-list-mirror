From: aonghus <thecolourblue@gmail.com>
Subject: Re: problem with git-cvsserver
Date: Thu, 31 Aug 2006 13:04:52 +0100
Message-ID: <44F6D064.9020002@gmail.com>
References: <44F5B2A7.8070501@gmail.com> <Pine.LNX.4.63.0608301904360.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F5D6F8.50307@gmail.com> <7vlkp6gh6e.fsf@assigned-by-dhcp.cox.net> <46a038f90608301329n14df4dd2tb1563cc48662cd14@mail.gmail.com> <20060831090333.GA28445@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 31 14:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIlI3-0004zA-Lm
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 14:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWHaME5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 08:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWHaME4
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 08:04:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:5446 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751560AbWHaME4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 08:04:56 -0400
Received: by ug-out-1314.google.com with SMTP id m3so524935ugc
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 05:04:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kYTT8zVye3D1ZVjVj+SAJqX+Ie3ynwx+0MTPXLTfjWVTTtxDh/eJyb8hwZ8LaesgO1L4KYDxnTChYAZFliGnsJqjK97BiC8EeQJ1MpQz+4O0+4ylUSRWTIK94fuFGkStcr7I/dq7DojPUl1lq2f4CPQ5vTlCXv+v/XIHXsmpgQU=
Received: by 10.67.103.7 with SMTP id f7mr465226ugm;
        Thu, 31 Aug 2006 05:04:54 -0700 (PDT)
Received: from ?192.168.0.100? ( [137.43.156.41])
        by mx.gmail.com with ESMTP id m1sm1169014uge.2006.08.31.05.04.53;
        Thu, 31 Aug 2006 05:04:54 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
To: Marco Roeland <marco.roeland@xs4all.nl>
In-Reply-To: <20060831090333.GA28445@fiberbit.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26252>

Marco Roeland wrote:
> On Thursday August 31st 2006 at 08:29 uur Martin Langhoff wrote:
>
>   
>> [git-cvsserver and trouble with Perl DBI and SQLite]
>>
>> Actually, just looking at my etch dev box, libdbd-sqlite-perl is
>> 0.29-1 and sqlite is 2.8.16-1. Not sure if the difference is
>> significant. Perhaps SQLite v3 has a different invocation / driver
>> name?
>>     
>
> Yes, SQLite v2 and SQLite v3 are different and binary incompatible.
>
> However, on Debian 'etch' you can install packages for both versions
> concurrently; most packages for SQLite have either a '2' or a '3' in the
> name. Packages without the number use the "best current choice" which is
> "3" in 'etch' at the moment but was "2" not too long ago.
>
> So at this moment in Debian 'etch' SQLite3 is the default version and
> calling
>
>         my $dsn = 'dbi:SQLite:dbname=foo';
>
> will use the SQLite3 driver internally, for which you must have
> installed the "libdbd-sqlite3-perl" package. Just for the record, if
> you'd wanted the older SQLite2 version you would install the
> "libdbd-sqlite2-perl" package and from Perl call "my $dsn =
> 'dbi:SQLite2:dbname=foo';".
>
> I'd guess that you were unfortunate enough to just install some packages
> during the transition and now some parts look for the "2" version
> and other parts for the "3" version. Probably just installing the
> "libdbd-sqlite3-perl" package and upgrading the other sqlite packages
> (from synaptic say to easily find them!) will probably cure your situation.
>
> Incidentally I'd guess that in itself SQLite2 (so version 2) would also
> function perfectly well for git-cvsserver (as would PostgreSQL or
> MySQL), it's probably in this case just a slight version skew between
> packages!
>   

Hi,

Thanks for all the help- I have it working now. It was not a fault with 
git-cvsserver at all- more like my own stupidity. The problem was that I 
had checked the versions on my client machine and forgotten to update 
the cvs/git server! Once I updated it and installed the 
libdbd-sqlite3-perl package (on the server) everything works as expected.
 
So, just to confirm, git-cvsserver is working on a debian 
testing/unstable machine (acting cvs/git server) with the following 
versions:

    libdbd-sqlite3-perl (1.12-1)
    libdbi-perl (1.51-2)
    libsqlite3-0 (3.3.7-1)
    perl (5.8.8-6.1)
    perl-base (5.8.8-6.1)


Apologies for wasting your time, looks like my caffeine levels are 
getting dangerously low...

a

 
