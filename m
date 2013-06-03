From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Mon, 03 Jun 2013 23:27:01 +0200
Message-ID: <51AD0A25.5080101@web.de>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org> <51A7A5F9.2030107@web.de> <7v61xwpct5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 23:27:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjcHZ-0005fS-74
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 23:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757635Ab3FCV1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 17:27:08 -0400
Received: from mout.web.de ([212.227.15.4]:61648 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756402Ab3FCV1H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 17:27:07 -0400
Received: from [192.168.178.41] ([91.3.151.162]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0MHdwC-1UgJQS2gYu-003Jiu; Mon, 03 Jun 2013 23:27:04
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7v61xwpct5.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:4ppq2fB+lbp0Xx65dHYQ4RZnQJqn/nxKOTNLoKmRre1o4Ey5C8U
 PY+FbjANLNV8nU+sPKwFh7P3jtj2BHUvVGQdSXTCNdf6Bb4nfOFb63qVsze4vaSqwa4vfFW
 pTHGl9MRJRROyqIE/RPqQUlGqGYYR6IJTt4FGCJFtf+hFmMNgqs509UT8JPVmC1sz08dx73
 w8nm7244SuKgjK8xOoC8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226294>

Am 02.06.2013 20:50, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 30.05.2013 01:58, schrieb Junio C Hamano:
>>> * jl/submodule-mv (2013-04-23) 5 commits
>>>   (merged to 'next' on 2013-04-23 at c04f574)
>>>  + submodule.c: duplicate real_path's return value
>>>   (merged to 'next' on 2013-04-19 at 45ae3c9)
>>>  + rm: delete .gitmodules entry of submodules removed from the work tree
>>>  + Teach mv to update the path entry in .gitmodules for moved submodules
>>>  + Teach mv to move submodules using a gitfile
>>>  + Teach mv to move submodules together with their work trees
>>>
>>>  "git mv A B" when moving a submodule A does "the right thing",
>>>  inclusing relocating its working tree and adjusting the paths in
>>>  the .gitmodules file.

<detailed discussion snipped>

> So my gut feeling of the "fix" at this point in the evolution of the
> program may be to error out with a message like "You have local
> changes to .gitmodules; please stash it before moving or removing".

Yeah, me too thinks that this is a sane short term solution (even
though a "git submodule add" currently happily stages any unstaged
modifications to the .gitmodules file too, that should not stop us
from doing better for rm and mv ;-).

And I also agree that in the long run the the git-config aware merge
driver together with the 3-way merge of a modified .gitmodules file
you described is the best solution. But I'd really like to complete
the recursive update before tackling that, so for now I just added
these two to the to-do list on my GitHub wiki page.

I'll resubmit this series with the strlen() fix and the erroring out
in case of unstaged modifications of the .gitmodules file as soon as
I find some time.
