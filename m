From: Patrick Donnelly <batrick@batbytes.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 11 Dec 2012 00:44:48 -0500
Message-ID: <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 06:45:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiIeS-0008JH-K0
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 06:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab2LKFou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 00:44:50 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:55711 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab2LKFot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 00:44:49 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3244057oag.19
        for <git@vger.kernel.org>; Mon, 10 Dec 2012 21:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=WyzWRTOeAH385/6/BC2XBYn+0hTvBYJBfQkHS25tIwI=;
        b=DI+fUkuf8qjeP2sA6Lh7Sfq/zq6AByP0zDpHb0v1NC1axdU/6RzF63WFZ9aVErmJ3U
         ExDrZ1tjpaTGLHLD9EHe2R45cKxz0CcxxDjkoYHO+N7ZVfWH7onhgSaCqNTSkU0tDAiC
         070EeShHx3xGKi9uPanU6V1iizwY/w5JbwsTsTkVxcYl4Cj5+N3IA1nFEiWQOrO9kYrC
         NNwbAMti3M/Fi0dFyNTZcNMJSWvzLNBztMzr1qJwy4lnLdLx3T/YvLwD9XYn58w6jsQU
         a4RSeH0i5uucSp3qviEZH0i1atjKB7OMxcnJSxPKBTBFM92wTYaq7MW/qxVK45uhIirn
         u2YQ==
Received: by 10.182.194.2 with SMTP id hs2mr8634162obc.97.1355204688776; Mon,
 10 Dec 2012 21:44:48 -0800 (PST)
Received: by 10.76.28.101 with HTTP; Mon, 10 Dec 2012 21:44:48 -0800 (PST)
In-Reply-To: <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
X-Gm-Message-State: ALoCoQm+wIlfKqq8JYqIxND1qXJgC0PozeVSxAoSUlSgJE/dRWYD3g80gOg8LG2fjxJfdYkIltgm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211279>

Sorry I'm late to this party...

I'm an Nmap developer that is casually interested in git development.
I've been lurking for a while and thought I'd post my thoughts on this
thread.

On Sun, Nov 25, 2012 at 6:25 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> The most important issues to consider when imagining a future with a
>> hybrid of code in C and some scripting language "X" are:
>>
>> * Portability: is "X" available on all platforms targeted by git, in
>>   usable and mutually-compatible versions?
>>
>> * Startup time: Is the time to start the "X" interpreter prohibitive?
>>   (On my computer, "python -c pass", which starts the Python
>>   interpreter and does nothing, takes about 24ms.)  This overhead would
>>   be incurred by every command that is not pure C.
>>
>> * Should the scripting language access the C functionality only by
>>   calling pure-C executables or by dynamically or statically linking to
>>   a binary module interface?  If the former, then the granularity of
>>   interactions between "X" and C is necessarily coarse, and "X" cannot
>>   be used to implement anything but the outermost layer of
>>   functionality.  If the latter, then the way would be clear to
>>   implement much more of git in "X" (and lua would also be worth
>>   considering).
>>
>> * Learning curve for developers: how difficult is it for a typical git
>>   developer to become conversant with "X", considering both (1) how
>>   likely is it that the typical git developer already knows "X" and
>>   (2) how straightforward and predictable is the language "X"?
>>   In this category I think that Python has a huge advantage over
>>   Perl, though certainly opinions will differ and Ruby would also be
>>   a contender.
>
> * We might also need an embedded language variant, like Jeff's lua
> experiment. I'd be nice if "X" can also take this role.

Lua has been an incredible success for Nmap [2](and other projects).
As an embedded scripting language, it's unrivaled in terms of ease of
embedding, ease of use for users, and performance. I would strongly
recommend the git developers to seriously consider it.

Addressing the points listed above:

>> * Portability: is "X" available on all platforms targeted by git, in
>>   usable and mutually-compatible versions?

Lua is written in ANSI C and so compiles basically anywhere (certainly
anywhere git does).

>> * Startup time: Is the time to start the "X" interpreter prohibitive?
>>   (On my computer, "python -c pass", which starts the Python
>>   interpreter and does nothing, takes about 24ms.)  This overhead would
>>   be incurred by every command that is not pure C.

As mentioned elsewhere in this thread by Joshua:

"Because Lua was mentioned in another message of this thread, I'll
provide the following:

* A cold run of 'lua5.1 -e ""' takes 0.4 seconds.  The second run
takes 0.03 seconds.
* A cold run of LuaJIT takes the same."

The runtime figures would probably be much lower if git modules (e.g.
pull) were capable of calling other modules without forking, all
within the same Lua environment.

>> * Should the scripting language access the C functionality only by
>>   calling pure-C executables or by dynamically or statically linking to
>>   a binary module interface?  If the former, then the granularity of
>>   interactions between "X" and C is necessarily coarse, and "X" cannot
>>   be used to implement anything but the outermost layer of
>>   functionality.  If the latter, then the way would be clear to
>>   implement much more of git in "X" (and lua would also be worth
>>   considering).

Using Lua as a glue between a proper git C API and modules would be
optimal in my opinion and experience.

>> * Learning curve for developers: how difficult is it for a typical git
>>   developer to become conversant with "X", considering both (1) how
>>   likely is it that the typical git developer already knows "X" and
>>   (2) how straightforward and predictable is the language "X"?
>>   In this category I think that Python has a huge advantage over
>>   Perl, though certainly opinions will differ and Ruby would also be
>>   a contender.

Lua is remarkably easy to learn and is engineered so it's approachable
by novice (or non-) programmers. Still, it offers all the features you
expect from a modern scripting language including GC, real lexical
scoping and closure, tables/arrays, and *coroutines*. While Nmap
occasionally gets questions about why we didn't use Python, no one
complains about Lua itself.


As for version considerations, Lua changes at a glacial pace compared
to other popular languages like Python or Ruby. Lua 5.2 was released
last year and 5.1 was released 5 years before that [1]. Still, while
users (people who bind Lua to applications) are certainly encouraged
to upgrade Lua, there is no real need to. Binding Lua to an
application statically is not a significant cost as it compiles to
less than 200 KB including base libraries; so, it's simple and cheap
to remain independent of the system git runs on. It isn't unreasonable
-- indeed, it is common -- to select one version of Lua and keep it
for a significant lifetime of the project.

[I'd be happy to answer any questions concerning Lua and/or scripting
Git. I'd also be happy to assist in embedding Lua in Git.]

[1] http://www.lua.org/versions.html
[2] http://nmap.org/book/nse.html

--
- Patrick Donnelly
