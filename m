From: Jon Nelson <jnelson@jamponi.net>
Subject: Re: git gc / git repack not removing unused objects?
Date: Sat, 6 Feb 2010 07:53:13 -0600
Message-ID: <cccedfc61002060553w464d5d9drd582b3b3c3f35227@mail.gmail.com>
References: <cccedfc61002051145q1ff673e7s3db3bd7290be25e1@mail.gmail.com> 
	<alpine.LFD.2.00.1002051539080.1681@xanadu.home> <cccedfc61002051304t6030d3f7if4bb14709ee6c918@mail.gmail.com> 
	<alpine.LFD.2.00.1002051634380.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Feb 06 14:53:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndl6T-0006yI-3e
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 14:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab0BFNxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 08:53:36 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:33489 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762Ab0BFNxf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 08:53:35 -0500
Received: by ewy28 with SMTP id 28so963477ewy.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 05:53:33 -0800 (PST)
Received: by 10.216.93.17 with SMTP id k17mr525485wef.31.1265464413151; Sat, 
	06 Feb 2010 05:53:33 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002051634380.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139167>

On Fri, Feb 5, 2010 at 3:45 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 5 Feb 2010, Jon Nelson wrote:
>
>> On Fri, Feb 5, 2010 at 2:51 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > On Fri, 5 Feb 2010, Jon Nelson wrote:
>> >
>> >> [Using git 1.6.4.2]
>> >>
>> >> In one repo I have (136G objects directory, fully packed) I'm having
>> >> some trouble.
>> >> I've run git-gc --prune=now, git repack -Adf, and so on a half-dozen
>> >> times and each time I do so it gets bigger, not smaller.
>> >
>> > Please tell us more.
>>
>> I'll tell you whatever I can -- as soon as I know what it is you want.
>
> I want to know what you did and what results you obtained to lead you to
> believe that 'git-gc --prune=now' makes your repository bigger.

Last night, the repo size was 153G after removing some commits and
objects by way of git filter-branch.
I'm using "du -sh" in the .git directory to determine the disk usage.

Before: 136G
git repack -dAl
After: 153G

Then, just to make sure of some things, I changed nothing and simply
re-ran "git repack -dAl".
After: 167G

Config:

[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
        logallrefupdates = true
        compression = 0
        loosecompression = 0
        packedGitLimit = 1500M
        #packedGitWindowSize = 32m
[pack]
        packsizelimit = 256m
        windowMemory = 128m
        deltaCacheSize = 1m
[gc]
    threads = 1
    packrefs = true

[repack]
        usedeltabaseoffset = true

Incorporating the system and global config (git config -l):

pack.packsizelimit=2M
pack.threads=1
gc.auto=0
gc.autopacklimit=0
core.repositoryformatversion=0
core.filemode=true
core.bare=true
core.logallrefupdates=true
core.compression=0
core.loosecompression=0
core.packedgitlimit=1500M
pack.packsizelimit=256m
pack.windowmemory=128m
pack.deltacachesize=1m
gc.threads=1
gc.packrefs=true
repack.usedeltabaseoffset=true

-- 
Jon
