From: Ferry Huberts <mailings@hupie.com>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 16:01:16 +0200
Message-ID: <4E32BD2C.4090508@hupie.com>
References: <1311934832699-6632987.post@n2.nabble.com> <4E329EDB.6040007@hupie.com> <1311940877783-6633274.post@n2.nabble.com> <4E32A2D2.9060007@hupie.com> <1311941774976-6633332.post@n2.nabble.com> <m3y5zhqnlv.fsf@localhost.localdomain> <1311943481799-6633412.post@n2.nabble.com> <m3tya5qm86.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
Content-Transfer-Encoding: 7bit
Cc: llucianf <llucianf@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 16:01:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmncx-0001SQ-DM
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 16:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab1G2OBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 10:01:18 -0400
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:52503 "EHLO
	mail.hupie.dyndns.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753098Ab1G2OBS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 10:01:18 -0400
Received: from stinkpad.internal.hupie.com (82-197-206-98.dsl.cambrium.nl [82.197.206.98])
	by mail.hupie.dyndns.org (Postfix) with ESMTP id BA88958BD75;
	Fri, 29 Jul 2011 16:01:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <m3tya5qm86.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178152>

On 07/29/2011 02:57 PM, Jakub Narebski wrote:
> llucianf <llucianf@gmail.com> writes:
> 
>> im sure cvs doesnt require you to remove files from repo in order to ignore
>> them. i used cvs for years and its ingonre policy is simple and effective.
>> you just put the files/patterns into ignore file and things happen aka they
>> are ignored.
> 
> _Untracked_ files are ignored.  Tracked files are not, even with CVS.


yeah llucianf, you could have checked this yourself...


the way it works now is safer: if someone by accident puts a tracked
file in an ignore file then the file is still not ignored.
you actually _want_ to see the file changes since you are after all
tracking the file.

git takes a safe route here.

having the file ignored while it is still in the repo can lead to very
very strange situation.

suppose someone puts a complicated ignore pattern in an ignore file that
has a mistake in it. then 'real' files might be ignored by the pattern
by git will still see the changes.

but to come back to cvs: cvs appears to do the same as git does so your
complaint is unfounded.

> 
>   $ echo file2.txt >>.cvsignore
>   $ echo "3 line"  >>file2.txt
> 
> Now 'cvs status' shows file as 
> 
>   File: file2.txt         Status: Locally Modified
> 
> and 'cvs diff' shows changes.
> 
> CVS 1.11.19
> 
> [And damn, how hard it was to check this in CVS as compared to
>  checking similar things with Git].
> 
>> with this very intelligent git this simple thing is not so simple. of course
>> there are workarounds (like the template example you gave) but they are
>> clumsy.
> 
> They are correct and better solutions than ignoring changes.
> 
> Ignoring changes to tracked files is much more rare than having broad
> ignore file, and tracking some files that match ignore patterns (but
> note that you must use "git add --force" to add/track ignored file).
> 
>> im just trying to understand why git ignore mechanism cant just read the
>> .gitignore file and obey to those ignore rules without asking you to do
>> fancy voodoo operations such removing those files from repo.
> 
> Please read carefully: I mentioned 'ASSUME-UNCHANGED' mechanism in
> both of my posts, haven't I?
> 


-- 
Ferry Huberts
