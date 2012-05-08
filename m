From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git commit path vs rebase path
Date: Tue, 08 May 2012 08:22:40 +0200
Message-ID: <4FA8BBB0.1080406@viscovery.net>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com> <7vaa1j7vg1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 08:22:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRdox-0000n7-JB
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 08:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab2EHGWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 02:22:44 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38103 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab2EHGWn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 02:22:43 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SRdpO-0004Vg-M3; Tue, 08 May 2012 08:23:19 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id ACF4A1660F;
	Tue,  8 May 2012 08:22:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vaa1j7vg1.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197340>

Am 5/7/2012 19:27, schrieb Junio C Hamano:
> Steven Penny <svnpenn@gmail.com> writes:
> 
>> I have noticed
>>
>> git commit uses this path
>>
>> .git/COMMIT_EDITMSG
>>
>> git rebase uses this path
>>
>> /home/Steven/jquery/.git/rebase-merge/git-rebase-todo
>>
>> So git commit is using a relative path while git rebase is using absolute path.
>>
>> This causes problem in Windows if your editor does not understand linux paths,
>> e.g. notepad, Notepad2, Notepad++, etc.
> 
> ... the issue is _not_ that the path is
> absolute, it is that the path is given as a wrong kind of absolute path.
> 
> Which suggests that "$(cd "$GIT_DIR" && pwd)" must give a full path that
> is suitable for the platform, and your platform wants it to be something
> like "c:\home\steven\jquery\..."?

The problem should be mitigated by be39048a7 (git-sh-setup.sh: Add an
pwd() function for MinGW), where the above now returns a Windows-style
absolute path, albeit with forward slashes instead of the backslashes.

I don't know what "/home/..." is in Steven's case, because it should look
more like "/c/home/..." unless it is an MSYS mount point, but even then it
should be reported as Windows-style path with the new pwd function.

IOW, the problem should be fixed in the next release.

-- Hannes
