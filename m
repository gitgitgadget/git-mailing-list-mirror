From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 4/5] diff: introduce diff.submoduleFormat configuration
 variable
Date: Tue, 30 Oct 2012 22:26:07 +0100
Message-ID: <509045EF.9030401@web.de>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com> <1349196670-2844-5-git-send-email-artagnon@gmail.com> <506B4418.2050700@web.de> <506C4161.3040201@web.de> <CALkWK0nPJ-8UvyYN800-Tj+mLQtv-vF3SJScb1O8EEiY238Z6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:26:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJKJ-00040X-1j
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab2J3V0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:26:10 -0400
Received: from mout.web.de ([212.227.15.3]:58055 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab2J3V0J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:26:09 -0400
Received: from [192.168.178.41] ([91.3.154.28]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MEEMy-1TZyDf1OrA-00FaJC; Tue, 30 Oct 2012 22:26:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <CALkWK0nPJ-8UvyYN800-Tj+mLQtv-vF3SJScb1O8EEiY238Z6w@mail.gmail.com>
X-Enigmail-Version: 1.4.5
X-Provags-ID: V02:K0:hBbjzEVqfC8/4kg6cSL8HfzhMTFgNE2rE86W5gItULt
 2KqR3eA5ZAqY5uHEAKrIX6Z/jOk4UiccpOm+BPutFvtKn8Kyl4
 ZhFay9J2SWb75tyZuSZiqODdK1sDot44zKIdRz5yyKrPHpHx16
 e/1EzO41vnZ72qCvgmUr44/sLY5CMFXzSghhV848AbEsqa35Q5
 ioRcOTnPVQ7ujTOt28Jpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208741>

Am 29.10.2012 11:30, schrieb Ramkumar Ramachandra:
> Jens Lehmann wrote:
>> Am 02.10.2012 21:44, schrieb Jens Lehmann:
>>> Am 02.10.2012 18:51, schrieb Ramkumar Ramachandra:
>>>> Introduce a diff.submoduleFormat configuration variable corresponding
>>>> to the '--submodule' command-line option of 'git diff'.
>>>
>>> Nice. Maybe a better name would be "diff.submodule", as this sets the
>>> default for the "--submodule" option of diff?
>>>
>>> And I think you should also test in t4041 that "--submodule=short"
>>> overrides the config setting.
>>
>> We also need tests which show that setting that config to "log" does
>> not break one of the many users of "git diff" ("stash", "rebase" and
>> "format-patch" come to mind, most probably I missed some others). I
>> suspect we'll have to add "--submodule=short" options to some call
>> sites to keep them working with submodule changes.
> 
> Um, why would "stash", "rebase" or "format-patch" be affected by this
> setting?  They don't operate on submodules at all.  To be sure, I ran
> all the tests with the following diff and nothing broke.

They do operate on the submodule commits too (while they don't touch
submodule work trees) and IIRC rebase applies diffs, so that could
break when the output of diff changes due to the new config option.
But it looks like your test did prove that nothing goes wrong there,
I assume they they use plumbing diff commands which aren't affected
by the new option.
