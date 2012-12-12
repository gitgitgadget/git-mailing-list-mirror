From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 05:39:43 +0530
Message-ID: <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
	<CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Patrick Donnelly <batrick@batbytes.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 01:10:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiZtk-00082L-6Z
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 01:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167Ab2LLAJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 19:09:46 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:47613 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392Ab2LLAJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 19:09:45 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so73590lbb.19
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 16:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Jrk5EftJsw4/qdstV/Wc19+cQY8uTy4gFp+MmGhxzxQ=;
        b=pzFpvq8r7RmO18+naSHGXtBgtaF22jzD7t0tgKM7zK/M+yeDlkB6JTgOCtz6lR7NJu
         Rah9X6nttpMUEcapbb+kZh2cpLq+mLwHg0z+AcbM65oNuXiTqgkmgJMXrRaCMxDitg5T
         zxy2UzIxkNfeOT+O0JufUmt7RDeij+KyUmqhVeCtZRX2Av7aa7xRmUIFRK/P81HLegjz
         YtGz7vkbXvWp9zSP7HPfBnzWifX6MIc+Kho3VX//PcMjGRGiyg7ZlYyefShE5OF9D5ru
         vxYwx3RbzzJFOhzPyhV4lfMASoClbTzMj4NzpZ3ZplGHFqw0Jnjou7uDAwNDZrIIFf8F
         7b4A==
Received: by 10.152.125.237 with SMTP id mt13mr18917056lab.45.1355270983903;
 Tue, 11 Dec 2012 16:09:43 -0800 (PST)
Received: by 10.112.31.137 with HTTP; Tue, 11 Dec 2012 16:09:43 -0800 (PST)
In-Reply-To: <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211319>

On Tue, Dec 11, 2012 at 11:14 AM, Patrick Donnelly <batrick@batbytes.com> wrote:
> Sorry I'm late to this party...
>
> I'm an Nmap developer that is casually interested in git development.
> I've been lurking for a while and thought I'd post my thoughts on this
> thread.
>
> On Sun, Nov 25, 2012 at 6:25 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>> The most important issues to consider when imagining a future with a
>>> hybrid of code in C and some scripting language "X" are:
>>>
>>> * Portability: is "X" available on all platforms targeted by git, in
>>>   usable and mutually-compatible versions?
>>>
>>> * Startup time: Is the time to start the "X" interpreter prohibitive?
>>>   (On my computer, "python -c pass", which starts the Python
>>>   interpreter and does nothing, takes about 24ms.)  This overhead would
>>>   be incurred by every command that is not pure C.
>>>
>>> * Should the scripting language access the C functionality only by
>>>   calling pure-C executables or by dynamically or statically linking to
>>>   a binary module interface?  If the former, then the granularity of
>>>   interactions between "X" and C is necessarily coarse, and "X" cannot
>>>   be used to implement anything but the outermost layer of
>>>   functionality.  If the latter, then the way would be clear to
>>>   implement much more of git in "X" (and lua would also be worth
>>>   considering).
>>>
>>> * Learning curve for developers: how difficult is it for a typical git
>>>   developer to become conversant with "X", considering both (1) how
>>>   likely is it that the typical git developer already knows "X" and
>>>   (2) how straightforward and predictable is the language "X"?
>>>   In this category I think that Python has a huge advantage over
>>>   Perl, though certainly opinions will differ and Ruby would also be
>>>   a contender.
>>
>> * We might also need an embedded language variant, like Jeff's lua
>> experiment. I'd be nice if "X" can also take this role.
>
> Lua has been an incredible success for Nmap [2](and other projects).
> As an embedded scripting language, it's unrivaled in terms of ease of
> embedding, ease of use for users, and performance. I would strongly
> recommend the git developers to seriously consider it.

[snipping the rest; all valid points no doubt]

Does lua have os.putenv() yet?  The inability to even *set* an env var
before calling something else was a killer for me when I last tried
it.

That may make it fine as an embedded language (called *by* something
else) but it is a bit too "frugal" to use as a glue language (calls
other things).
