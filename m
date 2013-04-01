From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Composing git repositories
Date: Mon, 01 Apr 2013 14:14:47 +0200
Message-ID: <51597A37.1010301@web.de>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com> <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com> <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com> <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com> <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com> <CABURp0q9mV+-tEtHGpE4mh9cdbhkA8fr4i7XpBtK0fpfSYg-+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 14:15:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMdeL-0003Ov-1g
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 14:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756444Ab3DAMPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 08:15:12 -0400
Received: from mout.web.de ([212.227.15.4]:59517 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466Ab3DAMPL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 08:15:11 -0400
Received: from [192.168.178.41] ([91.3.147.157]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MWirL-1U7NtM3Ft5-00Xtd8; Mon, 01 Apr 2013 14:14:48
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CABURp0q9mV+-tEtHGpE4mh9cdbhkA8fr4i7XpBtK0fpfSYg-+A@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:GpuqX0AxbRzfHCH3utjYNTI0ivoqwNWfqPVklhYNkEs
 NUuHhYosqaQv7qnAi0TW3fm1oeiiyfzsUnDPqJlOcbzTB1+FUP
 GxFb4UbuUasZu4iCnoAsOhQ7OKdWmc9l+VXAH5OpH9tv96fXuE
 kzCbxMgcyhBPXdn9TuDg4Sm2/SfTaGjaJyj3stbKZ13Zg10oC+
 kDvfrOYhPEPV0a2OIjFEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219683>

Am 01.04.2013 01:50, schrieb Phil Hord:
> On Sun, Mar 31, 2013 at 4:34 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Jens Lehmann wrote:
>>> Guess what: submodules are the solution for a certain set of use
>>> cases, and tools like subtree are a solution for another set of
>>> use cases. There is no silver bullet.
>>
>> That's the core of your argument: submodules already solve what it
>> was meant to, and we can't get it to solve a larger class of problems.
>>  In other words, you're implying that it's impossible to build a tool
>> that will be able to compose git repositories in a way that solves a
>> very large class of problems.  I don't see conclusive proof for this,
>> so I have to disagree.
> 
> I think it is possible to solve larger classes of problems with
> submodules, but it is a harder problem than you seem to think.  In any
> case I do not think you need to re-engineer submodules to improve
> them.
> 
> Sumodules are good for preserving history.  When properly managed,
> they answer the question git always answers, "Where was my code in the
> past?"  I would like proper management to be easier, but I understand
> why it is difficult; and I see it getting easier.

Exactly.

> Some users also want submodules to handle other tasks, like "Import
> branch-tracked upstream changes (i.e. git pull origin master)."  This
> too is useful, but it is a different problem than submodules'
> primarily try to solve.  But they do already solve _part_ of that
> problem ("Show me how these modules are related"), so it seems a
> trivial thing to ask them also to handle the "floating branch" task.
> The trick is to handle this task in a way that does not break the task
> they are designed and used for already.

But I think we recently learned to support that use case with
submodules. I think there are two floating models:

- Tracked:
  Follow a branch in the submodule and let git help you to advance
  the submodule to the tip of that branch at certain times, but
  still record a certain SHA-1 in the superproject to maintain
  reproducibility. We support this since 1.8.2 (see 06b1abb5 by
  Trevor).

- Untracked:
  Some people just want "the newest" tip of a branch checked out in
  the submodule and update that from time to time (I suspect this
  is because they are used to SVN externals, which I believe work
  that way). You throw away reproducibility, which I think is not
  good and not the way I expect Git to work. But that use case is
  achieved with a simple script and some config settings telling
  Git to don't even look for changes in the submodule anymore, and
  submodule infrastructure will set up everything for you after
  cloning the superproject. You run your custom script from time
  to time and have a truly floating submodule.

So to me it looks we support both floating models with current Git's
submodule infrastructure.

> Some other users want submodules to solve the problem of composition,
> like "Show me the combined log of all these submodules."  (Replace
> "show log" with "diff", "merge", "bisect" or even "rebase" if you
> like.)  I think this is where Jens is leaning when working to improve
> the user experience.  But this direction does not require
> re-architecting the fundamentals of submodules.

Correct. The only major change needed for that was to move the .git
directories into the .git directory of the superproject to prepare
for recursive update. But that is done under the hood and didn't
touch the fundamentals of using gitlinks and .gitmodules, it is just
a change in the layout of the local clone.
