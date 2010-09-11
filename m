From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] builtin/describe.c: ignore untracked changes in
 submodules
Date: Sat, 11 Sep 2010 20:11:39 +0200 (CEST)
Message-ID: <1529126586.2758911.1284228699341.JavaMail.fmail@mwmweb045>
References: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil>,
 <7vy6bajvnd.fsf@alter.siamese.dyndns.org>,
 <1464835923.7527323.1284144028047.JavaMail.fmail@mwmweb047>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 20:12:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuUYZ-0005ky-7w
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 20:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab0IKSL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 14:11:57 -0400
Received: from fmmailgate06.web.de ([217.72.192.247]:58017 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab0IKSLl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 14:11:41 -0400
Received: from mwmweb045  ( [172.20.18.54])
	by fmmailgate06.web.de (Postfix) with ESMTP id 58B0A561A5A;
	Sat, 11 Sep 2010 20:11:39 +0200 (CEST)
Received: from [92.104.70.131]  by  mwmweb045  with HTTP; Sat
 Sep 11 20:11:39 CEST 2010
In-Reply-To: <1464835923.7527323.1284144028047.JavaMail.fmail@mwmweb047>
X-UI-Message-Type: mail
X-UI-ATTACHMENT-ID-POSTFIX: 79d561ea-46c1-4c67-94f9-22b25429cd5f
X-Priority: 3
Importance: normal
Sensitivity: Normal
X-Provags-ID: V01U2FsdGVkX1/bMUQn0G3mA285pMH+5qmIo5ETHQI1sM3P/a9TBZCk5uyL4bZffOGT
 YiJaGQPy60/iKJhrgWY364Ny1oEEIA+pXaBK7fbhcUw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156003>

>>Brandon Casey <casey@nrlssc.navy.mil> writes:
>>
>>> From: Brandon Casey <drafnel@gmail.com>
>>>
>>> Since 'git describe' does not append -dirty to the version string it
>>> produces when untracked files exist in the working directory of the main
>>> repository, it should not do so for submodules either.
>>>
>>> Add --ignore-submodules=untracked to the call to diff-index which is used
>>> to decide whether or not the '-dirty' string is necessary.
>>>
>>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>>> ---
>>
>>Hmm, this changes the behaviour in a big way but it probably is for the
>>better.  At least it is consistent with the recent fixes to the
>>interaction between diff and submodules.
>
>Hmm, by default the diff family considers submodules with untracked files as
>dirty unless configured otherwise (and AFAICS the recent fixes to the interaction
>between diff and submodule were options to configure your own default).
>
>So when git status tells you the subodule is modified, e.g. because of an untracked
>file, I would expect git describe to add '-dirty' to its output when requested. To get rid
>of that I would expect you either fix the .gitignore of the submodule or configure that
>you don't care about untracked files in submodules at all (either only for this
>submodule or in the config).
>
>So if I didn't misunderstand something here I would rather vote against this change,
>git describe should append a '-dirty' when git status would show modifications, no?

And maybe we should teach "git describe" the "--ignore-submodules" option, then
you could tell describe what to pass to the diff-index command. Thoughts?
