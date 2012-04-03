From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: How to add folder NON RECURSIVELY ?
Date: Tue, 03 Apr 2012 15:12:32 +0200
Message-ID: <4F7AF740.9070906@dirk.my1.cc>
References: <20120403173111.5329d7ed@shiva.selfip.org> <vpqzkatc915.fsf@bauges.imag.fr> <201204031223.q33CMvQC004186@VM-MailSafe-02.soltecsis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: "J. Bakshi" <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Tue Apr 03 15:23:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF3hl-0007af-7n
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 15:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab2DCNXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 09:23:20 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:50559 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2DCNXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 09:23:20 -0400
X-Greylist: delayed 643 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Apr 2012 09:23:19 EDT
Received: from [84.176.59.38] (helo=[192.168.2.100])
	by smtprelay05.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1SF3XF-0007T7-85; Tue, 03 Apr 2012 15:12:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <201204031223.q33CMvQC004186@VM-MailSafe-02.soltecsis.com>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194621>

Am 03.04.2012 14:22 schrieb J. Bakshi:
> On Tue, 03 Apr 2012 14:08:38 +0200
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> 
>> "J. Bakshi" <joydeep.bakshi@infoservices.in> writes:
>>
>>> I like to add the folder structure in a way that only foo/dir1/file1 is added to
>>> the git. foo/dir2 and foo/dir3 should be added to the git also to show
>>> the directory
>>> structure and not the contents of those folder.
>>
>> Git doesn't record the existance of directories. For Git, a directory
>> exists if and only if it has some files in it. So, "foo/dir2 and
>> foo/dir3 should be added to the git" cannot be done in Git.
>>
>> A common workaround is to create a dummy file, typically .gitignore,
>> within the directories you want to add. Depending on the intended use of
>> the directory, you may want this file to be empty (to tell your
>> collaborators "there's nothing here for now, but there will be later"),
>> or to contain '*' to mean "there will never be any tracked files in this
>> directory".
>>
>> IOW,
>>
>> touch foo/dir2/.gitignore foo/dir3/.gitignore
>> git add foo/dir2/.gitignore foo/dir3/.gitignore
>>
> 
> Thanks for your suggestion.
> So .gitignore for foo/dir2/  and  foo/dir3/ should add those directories non recursively.
> 
> Could you please suggest how can I add foo/dir1/file1 ?
> 
> guess
> 
> touch foo/dir1/.gitignore
> git add foo/dir1/
> git add foo/dir1/file1
> 

Almost ;-)

Since foo/dir1 already contains file1 there's no need to add a
.gitignore in dir1 (except, of course, you really want to ignore sth. in
that directory).

If this is your directory structure:

foo/dir1/file1
foo/dir2
foo/dir3

foo/dir1/ is automatically added when you "git add foo/dir1/file1".
To add the (empty) directories dir2 and dir3 you need some placeholder
file in them because git does not track directories, only files
(together with their path).

Thus:

touch foo/dir2/.gitignore
touch foo/dir3/.gitignore
git add foo/dir2/.gitignore
git add foo/dir3/.gitignore

If you add a directory (like "git add foo/dir1/) git will add all files
in that directory (recursively), again, except for empty directories.


HTH,
	Dirk
