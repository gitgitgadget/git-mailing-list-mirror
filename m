From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Jul 2013, #07; Sun, 21)
Date: Sun, 28 Jul 2013 19:23:23 +0200
Message-ID: <51F5538B.6080709@web.de>
References: <7vy58zozdk.fsf@alter.siamese.dyndns.org> <51ECDFFC.8000500@web.de> <CACsJy8BsiXL9P5Rd9QZzG5Rtyd=0ewBbFRLwbAyumgTWwjJd5A@mail.gmail.com> <51ED9A6A.8050502@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 28 19:23:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3UhA-00007O-TD
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 19:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904Ab3G1RX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jul 2013 13:23:27 -0400
Received: from mout.web.de ([212.227.17.12]:50702 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753848Ab3G1RX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jul 2013 13:23:27 -0400
Received: from [192.168.178.41] ([91.3.155.149]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LbIyo-1UOQNj0pBq-00kwQs for <git@vger.kernel.org>;
 Sun, 28 Jul 2013 19:23:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51ED9A6A.8050502@web.de>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:NbOMmo63Fe1cYuZ+xca5Xqm1ccSNYcG9w3joYStsJTrRl5YetRJ
 mAqkaO60uFS6dh8KG4e6pVkUkCxbjJeV5Oa4sAL57zqgr0DtHJ27/hf28wroQye/Eo+HM/u
 AD5eWCjUNL8Zpn03pH+BvnHnRwC/1zB7Pj8MCJFpNBuoo6vnjov/VEbt/Tv/Pq6YnwIIURn
 CsHXPQUjb6GPytfl/1ShA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231269>

Am 22.07.2013 22:47, schrieb Jens Lehmann:
> Am 22.07.2013 09:48, schrieb Duy Nguyen:
>> On Mon, Jul 22, 2013 at 2:32 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> Am 22.07.2013 08:57, schrieb Junio C Hamano:
>>>> * jl/submodule-mv (2013-04-23) 5 commits
>>>>  . submodule.c: duplicate real_path's return value
>>>>  . rm: delete .gitmodules entry of submodules removed from the work tree
>>>>  . Teach mv to update the path entry in .gitmodules for moved submodules
>>>>  . Teach mv to move submodules using a gitfile
>>>>  . Teach mv to move submodules together with their work trees
>>>>
>>>>  "git mv A B" when moving a submodule A does "the right thing",
>>>>  inclusing relocating its working tree and adjusting the paths in
>>>>  the .gitmodules file.
>>>>
>>>>  Ejected from 'pu', as it conflicts with nd/magic-pathspec.
>>>
>>> So I'll base my upcoming re-roll on pu, right?
>>
>> The conflicted part is the use of common_prefix. I think you might be
>> able to avoid the conflict by using quote.c:path_relative() instead of
>> common_prefix() and prepending "../" manually. Or not, I did not read
>> path_relative() carefully, nor your connect_work_tree_and_git_dir().
> 
> Thanks for the pointers, I'll look into that.

Yup, relative_path() seems to be the solution here (and makes the
connect_work_tree_and_git_dir() function much shorter :-).

What worries me is that even though t7001 breaks because of this
conflict (just like it should) when run inside the t directory by
itself, the prove and normal test runs did not report any failures.
I have no idea what is going on here ...
