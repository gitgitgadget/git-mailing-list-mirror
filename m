From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 08:28:44 -0500
Message-ID: <CAMP44s0EVESLfRUw7Aqz6VjXELcRG-6cETpcROTZXmPjU-Y8ig@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
	<1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
	<CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 15:28:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJCM-0006yP-GC
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 15:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab3FHN2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 09:28:46 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:48623 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab3FHN2p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 09:28:45 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so4511116lab.29
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4rpm0FaLpNkuVwOgydROnshQt4ANQVVLUaak500iE4k=;
        b=WJgquSAItSre2aH3MUikSH/x7PklEhmE4F5tA9x00/pNvU5VfWCpYd7KsCJ3F+0lH1
         AQfaujdvx/sEbIvKB5yVLyvdcr7nsutkMBk0+OlfABbyfzKyVfvXCiGlJbgLEwHmfCww
         CrTCD5N3iGnbJbXtzFPBn/lFU3GS7uGB+iDnrxqIbW27SSHMTSVw0cr3SreJQDtOhWV1
         uP8EH2nPmBYB3di+53t2sOmcxFRgY2OyMOrfdQpHNeqkyRTw3rdurdQSZeQcCb0xB41r
         gJbabEn9o56N5YCG4dABtq7Qe6CaE3+cqSRDGkCoNQRAfpQ9Jt9xxUEc9PuhFkGwXE9/
         5eCA==
X-Received: by 10.112.157.226 with SMTP id wp2mr3067733lbb.65.1370698124281;
 Sat, 08 Jun 2013 06:28:44 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 06:28:44 -0700 (PDT)
In-Reply-To: <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226819>

On Sat, Jun 8, 2013 at 7:34 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 8, 2013 at 7:25 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sat, Jun 8, 2013 at 6:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sat, Jun 8, 2013 at 5:14 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> On Fri, Jun 7, 2013 at 9:35 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>>> On Sat, Jun 8, 2013 at 5:16 AM, Felipe Contreras
>>>>> <felipe.contreras@gmail.com> wrote:
>>>>>> This code is only useful for cherry-pick and revert built-ins, nothing
>>>>>> else, so let's make it a builtin object, but make sure 'git-sequencer'
>>>>>> is not generated.
>>>>>
>>>>> As you can see, the convention is builtin/foo.c corresponds to git-foo
>>>>> (and maybe more). Why make an exception for sequencer?
>>>>
>>>> Why not?
>>>
>>> And while we are at "why not", why don't you fork git?
>>
>> That's not an answer.
>
> Neither is "Why not?"

The answer is the rest of the e-mail.

>>> and not meant to be. If you aim something more organized,
>>> please show at least a roadmap what to move where.
>>
>> I already did that; we move code from libgit.a to builtin/*.o
>
> what code besides sequencer.c?

A roadmap doesn't require code. If you truly think that there's
nothing else that is specific to builtins; alias.c.

>> until libgit.a == libgit2. Done.
>
> Read up about the introduction of libgit2, why it was created in the
> first place instead of moving a few files around renaming libgit.a to
> libgit2.a. Unless you have a different definition of "==" than I do.

Are you being obtuse on purpose? It doesn't matter how different
libgit.a and libgit2 currently are, there's always a path from one
code-base to another. Unless libgit2 has code for builtin commands,
the first step would invariably be to move the code that is specific
for builtins to builtin/*.o.

-- 
Felipe Contreras
