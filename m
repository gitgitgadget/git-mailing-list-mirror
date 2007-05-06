From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Sun, 06 May 2007 19:34:16 +0200
Message-ID: <vpqk5vlamav.fsf@bauges.imag.fr>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0705061851411.4015@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 19:34:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkkd5-0000oS-32
	for gcvg-git@gmane.org; Sun, 06 May 2007 19:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbXEFRe3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 13:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbXEFRe3
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 13:34:29 -0400
Received: from imag.imag.fr ([129.88.30.1]:62187 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbXEFRe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 13:34:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l46HYG1K020292
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 19:34:17 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hkkci-0007NB-Ql; Sun, 06 May 2007 19:34:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hkkci-0003dX-N6; Sun, 06 May 2007 19:34:16 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0705061851411.4015@racer.site> (Johannes Schindelin's message of "Sun\, 6 May 2007 18\:51\:48 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 06 May 2007 19:34:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46350>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 6 May 2007, Matthieu Moy wrote:
>
>> [...]
>>
>> % git satus -a
>> % git commit -a -m "..."
>> 
>> In the former case, I have more commands to type, and in the second
>> case, I loose part of the stat-cache benefit: If I run "git status -a"
>> twice, the second run will actually diff all the files touched since
>> the last run, since "git status -a" actually updated a temporary
>> index, and discarded it afterwards, so it doesn't update the stat
>> information in the index (while "git status" would have).
>
> Have you tried "git status" _without_ "-a"?

Reading my message (including the last 5 words of the sentence you're
quoting) would have told you that ;-).

>> In both cases, I can't really see the benefit.
>
> The benefit is a clear distinguishing between DWIM and low level. The 
> index contains _exactly_ what you told it to contain. 

In other systems, commit commits _exactly_ the content of files on
disk. And most people seem happy with that.

> By forcing users to use "-a" with "git commit",

Does this mean that the normal way to use "commit" is to use "-a"?

> you make it clear that a separate update steo is involved,

Well, with those kind of arguments, I could have my web browser not do
DNS resolution for me, because it would make it clear that a separate
step from HTTP request is involved. Still, this low-level thing brings
no benefit to the user, and I know no web browser forcing the user to
make this distinction.

> and if you made an error (which you see from the file list), you can
> abort, and start over with the original index.

You don't necessarily see your error from the file list:

% vi foo.c
% git add foo.c
% vi foo.c
% git commit -m foo
[...]
 create mode 100644 foo.c
%

This commited the old content of foo.c, while I hardly see any
scenario where this is the expected behavior.

Then, being able to repare the error if I made it is interesting, but
I don't get the reason why the error could not just be avoided.

Well, indeed, I just found a thread talking about this:

  http://lists-archives.org/git/196050-making-git-commit-to-mean-git-commit-a.html

I'll go through it, I might understand better after that ;-).

Thanks,

-- 
Matthieu
