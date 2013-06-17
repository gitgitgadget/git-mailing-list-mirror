From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH V3 1/4] git-mw: Introduction of GitMediawiki.pm
Date: Mon, 17 Jun 2013 09:12:45 +0200
Message-ID: <vpq8v299pn6.fsf@anie.imag.fr>
References: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
	<1371349893-7789-2-git-send-email-benoit.person@ensimag.fr>
	<vpqobb5g679.fsf@anie.imag.fr>
	<CAETqRChcu+N-2uNzL9_J6abR5fnduT5UVRif5NTQYOoxPTiRTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: =?iso-8859-1?Q?Beno=EEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 17 09:12:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoTcS-0002wo-Ob
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 09:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140Ab3FQHMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 03:12:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46613 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880Ab3FQHMs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 03:12:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5H7CjR6011288
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 17 Jun 2013 09:12:45 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UoTcL-0001bK-Ur; Mon, 17 Jun 2013 09:12:46 +0200
In-Reply-To: <CAETqRChcu+N-2uNzL9_J6abR5fnduT5UVRif5NTQYOoxPTiRTw@mail.gmail.com>
	(=?iso-8859-1?Q?=22Beno=EEt?= Person"'s message of "Mon, 17 Jun 2013
 01:41:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 17 Jun 2013 09:12:45 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228048>

Beno=EEt Person <benoit.person@ensimag.fr> writes:

> On 16 June 2013 22:18, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wr=
ote:
>> benoit.person@ensimag.fr writes:
>>
>>> changes from the V2:
>>>   - Add a way to test, without installation, code that uses GitMedi=
awiki.pm.
>>
>> This still needs to be documented, even very quickly, somewhere in t=
he
>> code (e.g a comment in the Makefile).
> Well, I think I will have to re-read some docs (and some earlier
> reviews) about what to write in commit messages, in the emails, in th=
e
> code as comments and in the documentation ... I am just totally lost
> right now :/ .

Don't worry, reviews are meant to improve your code (present and
future), not to blame you ;-).

Just think about what you expect as a user or developer. Would you run
"git log Makefile" or "git blame Makefile" to know how to use the
Makefile? Commit messages are primarily meant for reviewers ("here's
some code, and here's why it's good and why you should merge it"), and
can be very useful when bisecting a regression or blaming a source file=
=2E

Right now, git-remote-mediawiki has only little doc, and the user manua=
l
is hosted on a GitHub wiki, not in the source. So there's no ideal plac=
e=20
to say how to use the tool as a developer, but a comment in the Makefil=
e
should be OK.

>> Also, it seems to be only part of the solution. With your change, fr=
om
>> contrib/mw-to-git/ and after running only "make",
>>
>> ./git-mw takes the installed version of GitMediawiki.pm in priority
>>
>> ../../bin-wrappers/git takes the installed version of git-mw only (i=
=2Ee.
>> does not know "git mw" if "make install" hasn't been ran).
> Same thing as the documentation point, I think I am a bit lost in tha=
t
> whole thing. I will re-look into it for the next version :/ .

In short, the include path should contain both the *.pm file and the
git-<foo> ones.

>>>  perlcritic:
>>> -     perlcritic -2 *.perl
>>> +     perlcritic -2 *.perl
>>> \ No newline at end of file
>>
>> Please, avoid these whitespace-only changes. They create noise durin=
g
>> review, and more potential conflicts.
> For that one, I don't know why git assumes there is a change in it :

I think you removed a newline from the end of the file. It's usually
considered good practice to have this trailing newline (e.g. so that
"cat file" in a terminal doesn't put your prompt after the last line).
IIRC, it's actually required to call the file a "text file" according t=
o
POSIX.

> I will look into that for the next version ...

In any case, using "git add -p" and if needed its "s" command avoids
introducing unwanted things in the commit.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
