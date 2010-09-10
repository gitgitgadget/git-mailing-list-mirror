From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] builtin/describe.c: ignore untracked changes in
 submodules
Date: Fri, 10 Sep 2010 20:40:28 +0200 (CEST)
Message-ID: <1094265482.7527324.1284144028114.JavaMail.fmail@mwmweb047>
References: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil>,
 <7vy6bajvnd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 20:40:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou8We-0007jN-Ss
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 20:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216Ab0IJSka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 14:40:30 -0400
Received: from fmmailgate06.web.de ([217.72.192.247]:37418 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab0IJSk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 14:40:29 -0400
Received: from mwmweb047  ( [172.20.18.56])
	by fmmailgate06.web.de (Postfix) with ESMTP id 1D94A55E4B8;
	Fri, 10 Sep 2010 20:40:28 +0200 (CEST)
Received: from [92.104.70.131]  by  mwmweb047  with HTTP; Fri
 Sep 10 20:40:28 CEST 2010
In-Reply-To: <7vy6bajvnd.fsf@alter.siamese.dyndns.org>
X-UI-Message-Type: mail
X-UI-ATTACHMENT-ID-POSTFIX: 57c563cd-02dc-4dbc-8558-321cd6968b33
X-Priority: 3
Importance: normal
Sensitivity: Normal
X-Provags-ID: V01U2FsdGVkX1/ElAzTbRKsDX0z2qfNjN1faClEGVJrX5zzuctouauygTVsgi8tqScz
 xwfQ1lIx9WEqdiGLZ7cO9CoI6487Qn9xPTSmbWtkBgw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155951>

>Brandon Casey <casey@nrlssc.navy.mil> writes:
>
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> Since 'git describe' does not append -dirty to the version string it
>> produces when untracked files exist in the working directory of the main
>> repository, it should not do so for submodules either.
>>
>> Add --ignore-submodules=untracked to the call to diff-index which is used
>> to decide whether or not the '-dirty' string is necessary.
>>
>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>> ---
>
>Hmm, this changes the behaviour in a big way but it probably is for the
>better.  At least it is consistent with the recent fixes to the
>interaction between diff and submodules.

Hmm, by default the diff family considers submodules with untracked files as
dirty unless configured otherwise (and AFAICS the recent fixes to the interaction
between diff and submodule were options to configure your own default).

So when git status tells you the subodule is modified, e.g. because of an untracked
file, I would expect git describe to add '-dirty' to its output when requested. To get rid
of that I would expect you either fix the .gitignore of the submodule or configure that
you don't care about untracked files in submodules at all (either only for this
submodule or in the config).

So if I didn't misunderstand something here I would rather vote against this change,
git describe should append a '-dirty' when git status would show modifications, no?
