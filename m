From: "Gennady Kushnir" <genkush@rujel.net>
Subject: Re: Removing some files from history
Date: Fri, 17 Oct 2008 15:51:15 +0400
Message-ID: <96ed5eac0810170451y69fd864jb44ef62bca468498@mail.gmail.com>
References: <96ed5eac0810170338s292fe858s1c092428a44a7ad2@mail.gmail.com>
	 <48F86E6A.7080102@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Oct 17 13:52:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqnsc-0003UB-Ax
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 13:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbYJQLvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 07:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253AbYJQLvR
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 07:51:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:46586 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbYJQLvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 07:51:16 -0400
Received: by rv-out-0506.google.com with SMTP id k40so519236rvb.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 04:51:15 -0700 (PDT)
Received: by 10.141.180.11 with SMTP id h11mr2450140rvp.158.1224244275558;
        Fri, 17 Oct 2008 04:51:15 -0700 (PDT)
Received: by 10.140.161.4 with HTTP; Fri, 17 Oct 2008 04:51:15 -0700 (PDT)
In-Reply-To: <48F86E6A.7080102@fastmail.fm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98474>

thank you for precise instructions.

however I did not completely understand the part about references and reflog
what are these? git tags?

and another question:
did I understand it right, that I can even make some changes to that
file in history - not just simply delete one?

Gennady

2008/10/17 Michael J Gruber <michaeljgruber+gmane@fastmail.fm>:
> Gennady Kushnir venit, vidit, dixit 17.10.2008 12:38:
>> Hello all
>> I'm not yet subscribed, but I wish I shall get reply anyway
>>
>> I'm going to make my repository public, but I have found that one of
>> my files contains some private data that I would not like to share.
>> Is it possible to remove that file from all commits in my local
>> repository history before publishing it?
>> Or it would be easier to start publishing with just my current state
>> (whith all private data cleaned up)?
>>
>> Thanks in advance.
>> Gennady
> Use
>
> git filter-branch --index-filter 'git rm --cached secret' -- --all
>
> or
>
> git filter-branch --tree-filter 'rm -f secret' -- --all
>
> where 'secret' is the name of the file to be removed.
>
> After that, make sure you clean up your repo before publishing:
> Clean out the original references (command on 1 line):
>
> git for-each-ref  --format='%(refname)' refs/original |while read ref;
> do git update-ref -d $ref;done
>
> Clean out the reflog:
>
> git reflog --expire=0 expire
>
> Remove the old objects and packs:
>
> git prune
> git repack -adf
>
> [Makes me feel this should be easier.]
>
> Michael
>
