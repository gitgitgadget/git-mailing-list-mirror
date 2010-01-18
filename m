From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: Unmodified submodules shows up as dirty with 1.6.6.443.gd7346
Date: Mon, 18 Jan 2010 17:54:44 +0100
Message-ID: <4B549254.5090206@isy.liu.se>
References: <4B547EA6.5070203@isy.liu.se> <8c9a061001180802t5ec0d389j2cae9f1771130c36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 17:54:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWus4-0004cV-Sf
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 17:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab0ARQy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 11:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380Ab0ARQy3
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 11:54:29 -0500
Received: from mailgw1.uni-kl.de ([131.246.120.220]:50925 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab0ARQy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 11:54:28 -0500
Received: from dfki.uni-kl.de (dfki-1002.dfki.uni-kl.de [131.246.195.2])
	by mailgw1.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id o0IGsO9O008095;
	Mon, 18 Jan 2010 17:54:24 +0100
Received: from serv-2100.kl.dfki.de (serv-2100.kl.dfki.de [192.168.21.180])
	by dfki.uni-kl.de (8.13.8+Sun/8.11.4) with ESMTP id o0IGsNnZ003019;
	Mon, 18 Jan 2010 17:54:23 +0100 (CET)
Received: from [192.168.21.153] (pc-2163.kl.dfki.de [192.168.21.153])
	by serv-2100.kl.dfki.de (8.13.8+Sun/8.13.8) with ESMTP id o0IGsNBA010842;
	Mon, 18 Jan 2010 17:54:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <8c9a061001180802t5ec0d389j2cae9f1771130c36@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137389>

Jacob Helwig wrote:
> On Mon, Jan 18, 2010 at 07:30, Gustaf Hendeby <hendeby@isy.liu.se> wrote:
>> Hi!
>>
>> I have been using submodules for a while, and been quite happy with
>> them.  Just updating to the latest next (1.6.6.443.gd7346), a strange
>> problem has occurred.  All my submodules (which are in fact unmodified)
>> show as modified and dirty
>>
>> diff --git a/extern/utils b/extern/utils
>> --- a/extern/utils
>> +++ b/extern/utils
>> @@ -1 +1 @@
>> -Subproject commit 6bad20e1419f1ca61bd5a6eef9b5937122e006f1
>> +Subproject commit 6bad20e1419f1ca61bd5a6eef9b5937122e006f1-dirty
>>
>>
> Do you have any untracked files in the submodule?  git status is
> working as I would expect with the same version (1.6.6.443.gd7346).

Yes, I do.

> 
> If there is no output from git status in the submodule, then git
> status in the superproject shows the submodule as being clean.
> However, if there is _any_ output from git status (untracked files,
> modified files, deleted files, new files), then the superproject shows
> the submodule as being dirty.
> 

Then the behavior of this feature differs from the one provided by
GIT-VERSION-GEN that is used as part of the git build process.  This is
not an argument itself, but personally, I don't like this behavior, and
think it should be reconsidered before inclusion into master.

I have the following use case, which is affected.  I have with in a
submodule some code that needs to be compiled, and hence generate some
object files and other files in the process.  I don't want to include
these files in a .gitignore as they are named differently on different
systems.  Hence, I include them in my .git/info/exclude file, where I am
developing the module.  So now, unless I do the same thing for all
places I checkout the repo as submodule, I end up with the module
indicated as dirty after I compile it.  This is a bit inconvenient.

Am I the only one who uses submodules this way?  Is there a better way
to solve my problem that would provide a better work pattern in this case?

/Gustaf
